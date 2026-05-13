# frozen_string_literal: true

require_relative "looks_like/version"
require_relative "looks_like/patterns"

module LooksLike
  # includes?(text, format: nil) will replace all methods with "_only?()"
  #all methods will be group based, old pattern based methods will be removed
  # ENCODINGs
  LooksLike::GROUPS.each do |group_name, subsets|
    define_singleton_method("#{group_name}?") do |text, format: nil|
      keys = expand_format(group_name, format)
      raise NoMethodError, "#{format} not registered or doesn't exist" if keys.nil?
      keys.any? do |key| 
        raise NoMethodError, "#{format} not registered or doesn't exist" if key.nil?
        /\A#{LooksLike::PATTERNS[key].source}\z/.match?(text) 
      end
    end
  end


  def self.includes?(text, format:)
    case format
    when Symbol
      keys = expand_format(format, nil)
      keys.any? {|key| LooksLike::PATTERNS[key] =~ text}
    when Hash
      group, subset = format.first
      keys = expand_format(group, subset)
      keys.any? { |key| LooksLike::PATTERNS[key] =~ text }

    when Array
      format.any? do |f|
        group = f.is_a?(Hash) ? f.keys.first : f
        subset = f.is_a?(Hash) ? f.values.first : nil
        keys = expand_format(group, subset)
        keys.any? { |key| LooksLike::PATTERNS[key] =~ text }
      end
    end
  end


  def self.groups(format = nil)
    return LooksLike::GROUPS.keys if format.nil?
    LooksLike::GROUPS[format].keys
  end

  def self.what(text)
    LooksLike::GROUPS.each_with_object({}) do |(group_name, subsets), results|
      matching_subsets = subsets.select do |subset_name, keys|
        
        keys.any?  { |key| LooksLike::PATTERNS[key].match?(text) }
      end.keys
      results[group_name] = matching_subsets unless matching_subsets.empty?
    end
  end

  def self.register(name, pattern)
    # Must be a symbol
    raise ArgumentError, "name must be a Symbol, got #{name.class}" unless name.is_a?(Symbol)
    # Pattern must be a regexp
    raise ArgumentError, "pattern must be a Regexp got #{pattern.class}" unless pattern.is_a?(Regexp)

    #Must follow group conventions
    parts = name.to_s.split("_", 2)
    raise ArgumentError, "name must follow 'group_subset' convention, got #{name}" unless parts.length == 2
    group, subset = parts.map(&:to_sym)
    # group and subset must not be empty
    raise ArgumentError, "group cannot be empty in #{name}" if group.to_s.empty?
    raise ArgumentError, "subset cannot be empty in #{name}" if subset.to_s.empty?
    # Warn if overwriting existing pattern
    warn "LooksLike: overwriting existing pattern #{name}" if LooksLike::PATTERNS.key?(name)
    LooksLike::PATTERNS[name] = pattern
    (LooksLike::GROUPS[group] ||= {})[subset] = [name]

    # dynamically define new group method if it doesn't exists
    unless respond_to?("#{group}?")
      define_singleton_method("#{group}?") do |text, format: nil|
        keys = expand_format(group, format)
        keys.any? { |key| /\A#{LooksLike::PATTERNS[key].source}\z/.match?(text) }
      end
    end
  end


  def self.scan(text, format:)
    case format
    when Symbol
      keys = expand_format(format, nil)
      keys.flat_map {|key| text.scan(LooksLike::PATTERNS[key]) }.uniq
    when Hash
      group, subset = format.first
      keys = expand_format(group, subset)
      keys.flat_map { |key| text.scan(LooksLike::PATTERNS[key]) }.uniq

    when Array
      format.each_with_object({}) do |f, results|
        group = f.is_a?(Hash) ? f.keys.first : f
        keys = expand_format(group, f.is_a?(Hash) ? f.values.first : nil)
        results[group] = keys.flat_map { |key| text.scan(LooksLike::PATTERNS[key]) }.uniq
      end
    end
  end

  def self.expand_format(group, format)
    case format
    when nil
      LooksLike::GROUPS[group].values.flatten
    when Symbol
      LooksLike::GROUPS[group][format]#.values.flatten.uniq #[:all]
    #when Hash
    #  group, subset = format.first
    #  subset ? LooksLike::GROUPS[group][subset] : LooksLike::GROUPS[group].values.flatten
    when Array
      format.flat_map { |f| LooksLike::GROUPS[group][f] }
    end
  end
end

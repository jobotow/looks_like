# frozen_string_literal: true

require_relative "looks_like/version"
require_relative "looks_like/patterns"
require_relative 'looks_like/blocks' #For users who wanna use blocks

module LooksLike

  LooksLike::GROUPS.each do |group_name, subsets|
    define_singleton_method("#{group_name}?") do |text, subset: nil|
      keys = expand_format(group_name, subset)
      raise NoMethodError, "#{subset} not registered or doesn't exist" if keys.nil?
      keys.any? do |key| 
        raise NoMethodError, "#{subset} not registered or doesn't exist" if key.nil?
        /\A(#{LooksLike::PATTERNS[key].source})\z/.match?(text) 
      end
    end
  end


  def self.contains?(text, match:)
    case match
    when Symbol
      keys = expand_format(match, nil)
      keys.any? {|key| LooksLike::PATTERNS[key] =~ text}
    when Hash
      group, subset = match.first
      keys = expand_format(group, subset)
      keys.any? { |key| LooksLike::PATTERNS[key] =~ text }

    when Array
      match.any? do |f|
        group = f.is_a?(Hash) ? f.keys.first : f
        subset = f.is_a?(Hash) ? f.values.first : nil
        keys = expand_format(group, subset)
        keys.any? { |key| LooksLike::PATTERNS[key] =~ text }
      end
    end
  end


  def self.groups(match = nil)
    return LooksLike::GROUPS.keys if match.nil?
    LooksLike::GROUPS[match].keys
  end

  def self.what(text)
    LooksLike::GROUPS.each_with_object({}) do |(group_name, subsets), results|
      matching_subsets = subsets.select do |subset_name, keys|
        
        keys.any?  { |key| /\A(#{LooksLike::PATTERNS[key].source})\z/.match?(text)  }
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
      define_singleton_method("#{group}?") do |text, match: nil|
        keys = expand_format(group, match)
        keys.any? { |key| /\A#{LooksLike::PATTERNS[key].source}\z/.match?(text) }
      end
    end
  end


  def self.extract(text, match:nil, by: :word)
    case match
    when nil
      LooksLike::GROUPS.each_with_object({}) do |(group_name, _), results|
        matches = extract(text, match: group_name, by: by)
        results[group_name] = matches unless matches.empty?
      end
    when Symbol
      keys = expand_format(match, nil)
      keys.flat_map {|key| text.scan(get_anchors(LooksLike::PATTERNS[key].source, by: by)) }.uniq
        #text.scan(/(?<!\S)#{LooksLike::PATTERNS[key].source}(?!\S)/) }.uniq
    when Hash
      group, subset = match.first
      keys = expand_format(group, subset)
      #keys.flat_map { |key| text.scan(/\b#{LooksLike::PATTERNS[key].source}\b/) }.uniq
      keys.flat_map {|key| text.scan(get_anchors(LooksLike::PATTERNS[key].source, by: by)) }.uniq

    when Array
      match.each_with_object({}) do |f, results|
        group = f.is_a?(Hash) ? f.keys.first : f
        keys = expand_format(group, f.is_a?(Hash) ? f.values.first : nil)
        #results[group] = keys.flat_map { |key| text.scan(/\b#{LooksLike::PATTERNS[key].source}\b/) }.uniq
        results[group] = keys.flat_map {|key| text.scan(get_anchors(LooksLike::PATTERNS[key].source, by: by)) }.uniq
      end
    end
  end

  def self.get_anchors(pattern, by:)
    case by
    when :word
      /(?<!\S)(#{pattern})(?!\S)/
    when :line
      /^(#{pattern})$/
    when :exact
      /\A(#{pattern})\z/
    when :free
      /#{pattern}/
    else
      raise ArgumentError, "Unknown boundary: #{by}"
    end
  end


  def self.expand_format(group, match)
    case match
    when nil
      LooksLike::GROUPS[group].values.flatten
    when Symbol
      LooksLike::GROUPS[group][match]
    #when Hash
    #  group, subset = match.first
    #  subset ? LooksLike::GROUPS[group][subset] : LooksLike::GROUPS[group].values.flatten
    when Array
      match.flat_map { |f| LooksLike::GROUPS[group][f] }
    end
  end
end

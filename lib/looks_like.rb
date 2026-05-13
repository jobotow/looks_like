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
      keys.any? { |key| /\A#{LooksLike::PATTERNS[key].source}\z/.match?(text) }
    end
  end

=begin
  def self.ascii?(text, format: nil)
    unless format.nil?
      # handle if not nil
    else
      #handle if nil
    end
  end

  def self.unicode?(text, format: nil)
    unless format.nil?
      # handle if not nil
    else
      #handle if nil
    end
  end


  def self.numeric?(text, format: nil)
    unless format.nil?
      # handle if not nil
    else
      #handle if nil
    end
  end

  def self.time?(text, format: nil)
    unless format.nil?
      # handle if not nil
    else
      #handle if nil
    end
  end

  def self.date?(text, format: nil)
    unless format.nil?
      # handle if not nil
    else
      #handle if nil
    end
  end


  def self.ip?(text, format: nil)
    unless format.nil?
      # handle if not nil
    else
      #handle if nil
    end
  end

  def self.email?(text, format: nil)
    unless format.nil?
      # handle if not nil
    else
      #handle if nil
    end
  end

  def self.url?(text, format: nil)
    unless format.nil?
      # handle if not nil
    else
      #handle if nil
    end
  end

  def self.encode?(text, format: nil)
    unless format.nil?
      # handle if not nil
    else
      #handle if nil
    end
  end

  def self.flag?(text, format: nil)
    unless format.nil?
      # handle if not nil
    else
      #handle if nil
    end
  end
=end

#  def self.



  def self.includes?(text, format:)
    keys = expand_format(format)
    keys.any? {|key| LooksLike::PATTERNS[key] =~ text }
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


  def scan(text, format:)
    key = expand_format(format)
    case format
    when Symbol, Hash
      keys.flat_map {|key| text.scan(LooksLike::PATTERNS[key]) }.uniq

    when Array
      format.each_with_object({}) do |f, results|
        group = f.is_a?(Hash) ? f.keys.first : f
        group_keys = expand_format(f)
        matches = group_keys.flat_map {|key| text.scan(LooksLike::PATTERNS[key])}.uniq
        results[group] = matches
      end
    end
  end

  # ======== HELPERS =======
  def self.ascii(subset=nil)
    subset ? {ascii: subset} : { ascii: nil}
  end

  def self.unicode(subset=nil)
    subset ? {unicode: subset} : { unicode: nil}
  end

  def self.numeric(subset=nil)
    subset ? {numeric: subset} : { numeric: nil}
  end

  def self.time(subset=nil)
    subset ? {time: subset} : { time: nil}
  end

  def self.date(subset=nil)
    subset ? {date: subset} : { date: nil}
  end

  def self.ip(subset=nil)
    subset ? {ip: subset} : { ip: nil}
  end

  def self.email(subset=nil)
    subset ? {email: subset} : { email: nil}
  end

  def self.url(subset=nil)
    subset ? {url: subset} : { url: nil}
  end

  def self.encoded(subset=nil)
    subset ? {encode: subset} : { encode: nil}
  end

  def self.flag(subset=nil)
    subset ? {flag: subset} : { flag: nil}
  end

  def self.expand_format(group, format)
    case format
    when nil
      LooksLike::GROUPS[group].values.flatten
    when Symbol
      LooksLike::GROUPS[group][format]#.values.flatten.uniq #[:all]
    when Hash
      group, subset = format.first
      subset ? LooksLike::GROUPS[group][subset] : LooksLike::GROUPS[group].values.flatten
    when Array
      format.flat_map { |f| LooksLike::GROUPS[group][f] }
    end
  end
end

# frozen_string_literal: true

require "anybase/version"
require "securerandom"

class Anybase
  UnrecognizedCharacterError = Class.new(StandardError)
  NegativeSignListedAsDigitError = Class.new(StandardError)
  NegativeSignTooLongError = Class.new(StandardError)
  UnknownNegativeSignError = Class.new(StandardError)

  attr_reader :digits, :char_map, :num_map, :regexp, :negative_sign

  def initialize(digit_string, ignore_case: false, negative_sign: nil, synonyms: {})
    raise NegativeSignTooLongError if negative_sign && negative_sign.size > 1
    raise NegativeSignListedAsDigitError if negative_sign && digit_string.index(negative_sign)

    self.digits = digit_string.dup
    self.ignore_case = ignore_case
    self.negative_sign = negative_sign
    self.synonyms = synonyms
    self.synonyms_tr = [String.new, String.new]
    self.char_map = Hash.new { |_h,k| raise UnrecognizedCharacterError, "the character `#{k}' is not included in #{digits}" }
    self.num_map = {}

    digits.downcase! if ignore_case?

    regexp_str = String.new("[")
    digits.each_char.with_index do |char, i|
      regexp_str << Regexp.quote(char)
      char_map[char] = i
      num_map[i] = char

      next unless synonyms[char]

      synonyms[char].each_char do |synonym|
        regexp_str << Regexp.quote(synonym)
        synonyms_tr[0] << synonym
        synonyms_tr[1] << char
      end
    end
    regexp_str << "]+"
    self.regexp = ignore_case? ? Regexp.new(regexp_str, Regexp::IGNORECASE) : Regexp.new(regexp_str)
  end

  def match(str)
    if (match = regexp.match(str)) && match.begin(0).zero?
      match[0]
    else
      nil
    end
  end

  def ignore_case?
    ignore_case
  end

  def size(length)
    digits.length**length
  end

  def normalize(val)
    val = ignore_case? ? val.downcase : val.dup
    synonyms.empty? ? val : val.tr(*synonyms_tr)
  end

  def random(length, trim_leading_zeros: false)
    number = String.new
    length.times { number << digits[SecureRandom.random_number(digits.size)] }

    if trim_leading_zeros
      number.sub!(/\A#{Regexp.quote(digits[0])}+/, "")
      number = digits[0] if number.empty?
    end

    number
  end

  def to_i(val)
    val = normalize(val)
    num = 0
    op = if negative_sign && (val[0] == negative_sign[0])
      val.slice!(0, 1)
      :-
    else
      :+
    end

    (0...val.size).each do |i|
      num = num.send(op, (digits.size**(val.size - i - 1)) * char_map[val[i]])
    end

    num
  end

  def to_native(val, zero_pad: 1)
    zero_pad = 1 if zero_pad < 1
    negative = if val < 0
      raise UnknownNegativeSignError unless negative_sign

      val = val.abs
      true
    else
      false
    end

    str = String.new
    until val.zero?
      digit = val % digits.size
      val /= digits.size
      str[0, 0] = num_map[digit]
    end

    str[0, 0] = num_map[0] * (zero_pad - str.size) if str.size < zero_pad
    str[0, 0] = negative_sign if negative

    str
  end

  private

  attr_writer :digits, :char_map, :num_map, :regexp, :negative_sign
  attr_accessor :ignore_case, :synonyms, :synonyms_tr
end

class Anybase
  Hex          = Anybase.new("0123456789abcdef", ignore_case: true)
  Base62       = Anybase.new("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")
  Base64       = Anybase.new("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/")
  Base64ForURL = Anybase.new("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_")
  Base73ForURL = Anybase.new("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789$-_.+!*'(),")
end

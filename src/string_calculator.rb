# Responsible for performing addition on groups of positive integers less than 1000
require './src/roman'

class StringCalculator
  attr_reader :str

  def add(str)
    @str = str
    # ints.sum { |x| x.to_i }
    return 0 if str.empty?
    return str.to_i unless str.include?(',') || str.include?('\n')

    valid_ints.sum { |x| x.to_i }
  end

  def ints
    Parser.splitByDelimiter(str).getInts
  end

  def valid_ints
    integers = convert_to_decimal
    filter_negatives(integers)
    filter_out_large_ints(integers)
  end

  def convert_to_decimal
    ints.map do |x|
      if RomanToInteger.is_roman?(x)
        RomanToInteger.calc(x)
      else
        x
      end
    end
  end

  def filter_negatives(integers)
    negatives = integers.filter { |i| i.to_i < 0 }
    raise StandardError, "negatives not allowed: #{negatives.join(',')}" if negatives.length > 0
  end

  def filter_out_large_ints(integers)
    integers.filter { |i| i.to_i <= 1000 }
  end
end

class Parser
  def initialize(str)
    @str = str
  end

  def getInts
    @str.split(/[\\n,]/)
  end

  def self.splitByDelimiter(str)
    if str.include?('//')
      CustomDelimiterParser.new(str)
    else
      Parser.new(str)
    end
  end
end

class CustomDelimiterParser < Parser
  def getInts
    head, tail = @str.split('\n')
    delimiter = head.sub('//', '')
    tail.split(delimiter)
  end
end

interface Convertable {
  public int to_i(String(str))

  public String to_string(Integer(x))
}

class RomanConvert implements Convertable {

}

class DecimalConverter implements Convertable {

}

class StringCalculator
  def initialize(str, input_converter = DecimalConverter.new, output_converter = DecimalConverter.new)
  end

  def convert_to_decimal
    ints.map { |x| input_converter.to_i(x) }
  end
end

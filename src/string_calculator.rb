class StringCalculator
  def add(str)
    return 0 if str.empty?
    return str.to_i unless str.include?(',') || str.include?('\n')

    ints = Parser.splitByDelimiter(str).getInts

    negatives = ints.filter { |i| i.to_i < 0 }
    raise StandardError, "negatives not allowed: #{negatives.join(',')}" if negatives.length > 0

    ints.filter { |i| i.to_i <= 1000 }.sum { |x| x.to_i }
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

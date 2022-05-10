class IntegerToRoman
  CONVERSION = [
    [1000, 'M'],
    [500, 'D'],
    [100, 'C'],
    [50, 'L'],
    [10, 'X'],
    [5, 'V'],
    [1, 'I']
  ]

  def self.checkInversion (remainder, decimal_key, index, j)
    next_decimal_key = CONVERSION[index + j][0]
    next_remainder = remainder % next_decimal_key
    ((remainder - next_remainder) == (decimal_key - next_decimal_key))
  end

  def self.calc(input)
    remainder = input
    result = ''
    index = 0
    
    while index < CONVERSION.size
      decimal_key = CONVERSION[index][0]
      roman_value = CONVERSION[index][1]
      # figure out how many V's
      # i.e. figure out how many times 5 divides into input
      number_of_numerals = remainder / decimal_key
      remainder = remainder % decimal_key

      result = result + roman_value * number_of_numerals

      # check if we are done
      if (remainder == 0)
        index = CONVERSION.size
        break
      end

      # there must be more elements in conversion, since remainder is not 0
      next_decimal_key = CONVERSION[index + 1][0]
      if (decimal_key / next_decimal_key == 5) 
        next_remainder = remainder % next_decimal_key
        # if remainder is 4, which is 5(key) - 1(next key), then we want IV instead of IIII
        if (checkInversion(remainder, decimal_key, index, 1))
          result = result + CONVERSION[index + 1][1] + roman_value
          remainder = next_remainder
        end
      # there must be another element (+2) in conversion if the ratio for (+1) wasn't 5
      else
        next_decimal_key = CONVERSION[index + 2][0]
        next_remainder = remainder % next_decimal_key
          # if remainder is 9, then we want IX instead of VIIII
        if (checkInversion(remainder, decimal_key, index, 2))
          result = result + CONVERSION[index + 2][1] + roman_value
          remainder = next_remainder
          index = index + 1
        end
      end
      index = index + 1
    end
    
    return result
  end
end

class RomanToInteger
  CONVERSION = {
    'I' => 1,
    'V' => 5,
    'X' => 10,
    'L' => 50,
    'C' => 100,
    'D' => 500,
    'M' => 1000
  }

  def self.calc (n)
    acc = 0
    prev = 0 # starts new chuck
    n.chars.reverse.each do |x|
      if (prev == 0)
        # move on to the next digit
        prev = CONVERSION[x] 
      elsif (CONVERSION[x] >= prev )
        # continuing aggregating the chunk
        acc = acc + prev 
        prev = CONVERSION[x]
      else
        # finish the chunk, start a new one when
        # lower numeral is before higher (e.g IX = 9)
        acc = acc + prev - CONVERSION[x]
        prev = 0
      end
    end
    return acc + prev
  end
end
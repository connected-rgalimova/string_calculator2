require './src/roman'

RSpec.describe IntegerToRoman do
  subject(:itor) { described_class }

  CONVERSION = [
    [1000, 'M'],
    [500, 'D'],
    [100, 'C'],
    [50, 'L'],
    [10, 'X'],
    [5, 'V'],
    [1, 'I']
  ]

  CONVERSION.each do |(given_integer, expected_numeral)|
    it "should return #{expected_numeral} given #{given_integer}" do
      res = itor.calc(given_integer)

      expect(res).to eq expected_numeral
    end
  end

  it 'generates consecutive numerals, e.g. return MDCCCLXXXVII given 1887' do
    res = itor.calc(1887)

    expect(res).to eq 'MDCCCLXXXVII'
  end

  it 'generates non-consecutive numerals, e.g. return MCXXXVII given 1137' do
    res = itor.calc(1137)

    expect(res).to eq 'MCXXXVII'
  end

  it 'should terminates execution when a remainder of zero is encountered, e.g. return MDCCCLXXXV given 1885' do
    res = itor.calc(1885)

    expect(res).to eq 'MDCCCLXXXV'
  end

  it 'should return XXIX given 29' do
    res = itor.calc(29)

    expect(res).to eq 'XXIX'
  end

  it 'should return CMXCIX given 999' do
    res = itor.calc(999)

    expect(res).to eq 'CMXCIX'
  end

  it 'should return LIV given 54' do
    res = itor.calc(54)

    expect(res).to eq 'LIV'
  end

  it 'should return MMMMCDXLIV given 4444' do
    res = itor.calc(4444)

    expect(res).to eq 'MMMMCDXLIV'
  end

  it 'should return MMMMXLIV given 4044' do
    res = itor.calc(4044)

    expect(res).to eq 'MMMMXLIV'
  end
end

RSpec.describe RomanToInteger do
  subject(:roman_to_integer_calculator) { described_class }

  it "Given a RomanNumeral, return as an Integer 3" do 
    input = 'III'

    result = roman_to_integer_calculator.calc(input)

    expect(result).to eq 3
  end

  it "Given a RomanNumeral IV , return as an Integer 4" do
    input = 'IV'

    result = roman_to_integer_calculator.calc(input)

    expect(result).to eq 4
  end

  it "Given a RomanNumeral XIV , return as an Integer 14" do 
    input = 'XIV'

    result = roman_to_integer_calculator.calc(input)

    expect(result).to eq 14
  end

  it "Given a RomanNumeral XXXIX, return as an Integer 39" do 
    input = 'XXXIX'

    result = roman_to_integer_calculator.calc(input)

    expect(result).to eq 39
  end

  it "Given a RomanNumeral CCXLVI, return as an Integer 246" do
    input = 'CCXLVI'

    result = roman_to_integer_calculator.calc(input)

    expect(result).to eq 246
  end

  it "Given a RomanNumeral DCCLXXXIX, return as an Integer 789 " do
    input = 'DCCLXXXIX'

    result = roman_to_integer_calculator.calc(input)

    expect(result).to eq 789
  end

  it "Given a RomanNumeral MMCDXXI, return as an Integer 2,421 " do
    input = 'MMCDXXI'

    result = roman_to_integer_calculator.calc(input)

    expect(result).to eq 2421
  end
  it "Given a RomanNumeral MLXVI, return as an Integer 1,066 " do 
    input = 'MLXVI'

    result = roman_to_integer_calculator.calc(input)

    expect(result).to eq 1066
  end

  it "Given a RomanNumeral CLX, return as an Integer 160 " do
    input = 'CLX'

    result = roman_to_integer_calculator.calc(input)

    expect(result).to eq 160
  end
  it "Given a RomanNumeral  CCVII, return as an Integer 207" do
    input = 'CCVII'

    result = roman_to_integer_calculator.calc(input)

    expect(result).to eq 207
  end
  it "Given a RomanNumeral  MIX, return as an Integer 1,009" do 
    input = 'MIX'

    result = roman_to_integer_calculator.calc(input)

    expect(result).to eq 1009
  end
end

# logic cases:

# additve, one numeral type: 1-3 => I, II, III
# additive multiple type 6-8 => VI, VII, VIII
# subtractive, multiple numeral types 4, 9 => IV, IX
# chunking logic => 11 => 10 + 1 => X + I => XI

# traverse from right to left:
# if greater than the prior one, then add
# otherwise subtract and mark end of chunk


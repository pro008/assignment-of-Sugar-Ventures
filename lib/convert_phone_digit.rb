class ConvertPhoneDigit

  def initialize
    get_character
    get_input
  end

  def get_input
    puts "Please Enter your Number, it must contain exact 8 digits"
    number = gets.chomp
    get_key_combinations(number)
  end

  def get_character
    @keypad = {
      "0" => ["0"],
      "1" => ["1"],
      "2" => ['A','B','C'],
      "3" => ['D','E','F'],
      "4" => ['G','H','I'],
      "5" => ['J','K','L'],
      "6" => ['M','N','O'],
      "7" => ['P','Q','R','S'],
      "8" => ['T','U','V'],
      "9" => ['W','X','Y','Z']
    }
  end

  def validate_number(number)
    unless (number.length == 8 && number.match(/^[0-9]*$/))
      puts "The given number is not valid. Please try again"
      get_input
    end

    puts "---------------------------------------------------"
  end

  def mapping_value(a,b)
    r = []
    a.each do |a_e|
      r += b.map{|b_e| "#{a_e}#{b_e}" }
    end

    r
  end

  def loop_data(key_characters)
    results = key_characters.shift

    begin
      while key_characters.length != 0
        results = mapping_value(results, key_characters[0])
        key_characters.shift
      end
    rescue TypeError
      return "The number you have entered is not a valid number. Please try again."
    end

    results.uniq

    puts(results)
    puts "---------------------------------------------------"
    puts("Total: #{results.count}")
  end

  def get_key_combinations(number)
    validate_number(number)
    number_array = number.split("")

    key_characters = number_array.map{|n| @keypad[n]}

    loop_data(key_characters)
  end
end

ConvertPhoneDigit.new
class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def guess(letter)
    if letter =~ /[[:alpha:]]/
      letter.downcase!
      if @word.include?(letter) && !@guesses.include?(letter)
        @guesses += letter
        return true
      elsif !@word.include?(letter) && !@wrong_guesses.include?(letter)
        @wrong_guesses += letter
        return true
      else
        return false
      end
    else
      raise ArgumentError
    end
  end

  def word_with_guesses
    displayed_word = ""
    @word.each_char do |letter|
      if @guesses.include?(letter)
        displayed_word += letter
      else
        displayed_word += "-"
      end
    end
    puts displayed_word
    return displayed_word
  end

  def check_win_or_lose
    i = 0
    if @wrong_guesses.length == 7
      return :lose
    end
    @word.each_char do |letter|
      if @guesses.include?(letter)
        i += 1
      end
    end
    if i == @word.length
      return :win
    else
      return :play
    end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end

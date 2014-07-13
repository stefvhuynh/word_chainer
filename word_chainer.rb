require "set"

class WordChainer
  
  def initialize(dictionary_file_name)
    # We use set to take advantage of the instant lookup for the Set#include?
    # method. Set is able to do this because it is actually a hash.
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp).to_set
  end
  
  def adjacent_words(word)
    # Generate every variation of the word and check to see if it's 
    # in the dictionary. This is better than filtering the dictionary,
    # itself.
    possible_words = []
    word.each_char.with_index do |char, index|
      ("a".."z").each do |letter|
        possible_word = word.dup
        possible_word[index] = letter
        possible_words << possible_word
      end
    end
    
    adjacent_words = possible_words.select { |word| @dictionary.include?(word) }
    adjacent_words.delete(word)
    adjacent_words
  end
  
end


w = WordChainer.new("dictionary.txt")
p w.adjacent_words("puppy")



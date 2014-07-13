require "set"

class WordChainer
  
  def initialize(dictionary_file_name)
    # We use set to take advantage of the instant lookup for the Set#include?
    # method. Set is able to do this because it is actually a hash.
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp).to_set
  end
  
  def run(source, target)
    @current_words = [source]
    # The key is the modified word and the value is the previous word.
    @all_seen_words = { source => nil }
    
    until @current_words.empty?
      @current_words = explore_current_words
    end
    
    puts build_path(target)
  end
  
  def explore_current_words
    new_current_words = []
    
    @current_words.each do |cur_word|
      adjacent_words(cur_word).each do |adj_word|
        next if @all_seen_words.include?(adj_word)
        @all_seen_words[adj_word] = cur_word
        new_current_words << adj_word
      end
    end
    
    new_current_words
  end
  
  def build_path(target)
    # Recursively get from the target to the source
    return [] if target.nil?
    build_path(@all_seen_words[target]) + [target]
  end
  
  private
  
  def adjacent_words(word)
    adjacent_words = possible_words(word).select do |word| 
      @dictionary.include?(word) 
    end
    adjacent_words.delete(word)
    adjacent_words
  end
  
  def possible_words(word)
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
    
    possible_words
  end
  
end

if __FILE__ == $PROGRAM_NAME
  w = WordChainer.new("dictionary.txt")
  if ARGV.empty?
    w.run("puppy", "kitty")
  elsif ARGV.length == 1
    raise "Need two arguments"
  else
    w.run(ARGV.shift, ARGV.shift)
  end
end



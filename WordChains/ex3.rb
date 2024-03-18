require "set"

class WordChainer
    attr_reader :dictionary
    
    def initialize(dictionary_file_name) 
        @dictionary = File.read(dictionary_file_name).split.to_set
    end

    def adjacent_words(word)
        adjacent_words = []
        
        word.each_char.with_index do |char, i|    
            ('a'..'z').each do |letter|
                next if letter == char
                new_word = word.dup
                new_word[i] = letter
                adjacent_words << new_word if @dictionary.include?(new_word)
            end
        end

        adjacent_words
    end

    def run(source, target)
        @current_words, @all_seen_words = [source], { source => nil } 
        explore_current_words until @current_words.empty? || @all_seen_words.include?(target)
        build_path(target)
    end

    def explore_current_words
        new_current_words = []

        @current_words.each do |current_word| 
            adjacent_words(current_word).each do |adjacent_word| 
                next if @all_seen_words.include?(adjacent_word)
                new_current_words << adjacent_word
                @all_seen_words[adjacent_word] = current_word
            end
        end

        @current_words = new_current_words
    end

    def build_path(target)
        return "no path" if !@all_seen_words.include?(target)
        path = [target]
        path << @all_seen_words[path.last] until path.last.nil?
        path.reverse[1..-1]
    end
end

t1 = Time.now

if $PROGRAM_NAME == __FILE__
    # print "Enter file name: "
    # p WordChainer.new(gets.chomp).run("duck", "ruby")
    p WordChainer.new("dictionary.txt").run("duck", "ruby")
end

p "#{Time.now - t1} seconds"
def all_words_capitalized?(arr)
    arr.all? { |word| word.capitalize == word }
end

def no_valid_url?(arr)
    urls = ['.com', '.net', '.io', '.org']
    arr.none? do |word|
        urls.any? { |url| word.end_with?(url) }
    end
end

def any_passing_students?(arr)
    arr.any? { |student| student[:grades].sum / student[:grades].length >= 75 }
end

def all_words_capitalized?(arr)
    arr.all? { |word| word.capitalize == word }
end

def no_valid_url?(arr)
    url = ['.com', '.net', '.io', '.org']
    arr.none? do |word|                         # none? return true when all conditions are false
        url.any? { |url| word.end_with?(url) }  # any? return true if at least one condition is true
    end                                         # any? is inside none?, so none? immediately return false if any? return true
end

def any_passing_students?(arr)
    arr.any? { |hash| hash[:grades].sum / hash[:grades].length >= 75 }
end

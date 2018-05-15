# Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
# Способ один:
alphabet = Hash[*(('a'..'z').to_a.zip((1..26).to_a).flatten)]
vowels = alphabet.select { |key| %w[a e o u i].include?(key) }

p vowels

#Способ два:
alphabet = ('a'..'z').to_a
vowels = {}
alphabet.each_with_index do |key, index|
  vowels[key] = index + 1 if %w[a e o u i].include?(key)
end

p vowels

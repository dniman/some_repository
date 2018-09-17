#
# Заполнить хеш гласными буквами, где значением будет являться порядковый номер # буквы в алфавите (а - 1).
#

alphabets = *('а'..'я')
vowels = %w{а е ё и о у ы э ю я} 

alphabets.each_with_index do |item,index|
  Hash[item, index] if vowels.include?(item)
end

#
# Заполнить массив числами от 10 до 100 с шагом 5
#

some_array = []

(10..100).step(5) do |i|
  some_array << i
end


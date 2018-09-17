#
# Сумма покупок. Пользователь вводит поочередно название товара, 
# цену за единицу и кол-во купленного товара (может быть нецелым числом). 
# Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" 
# в качестве названия товара. На основе введенных данных требуетеся:
# Заполнить и вывести на экран хеш, ключами которого являются названия товаров, 
# а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара. 
# Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
#

puts "Input sequently product name, price per item and count: "
outer_hash = {}

while (product = gets.chomp) != "stop" do
  inner_hash = Hash[gets.chomp.to_f, gets.chomp.to_f]
  outer_hash[product] = inner_hash
  puts "Input sequently product name, price per item and count: "
end

puts "Total hash: #{outer_hash}"
puts "Total sum for each product: "
outer_hash.each do |key, value|
  value.each do |k, v|
    puts "#{key} - #{k * v}"
  end
end

all = 0

outer_hash.each_value do |val|
  val.each do |k, v|
    all += (k * v)
  end
end
puts "Summary sum of all products: #{all}"



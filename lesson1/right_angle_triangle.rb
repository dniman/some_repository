# Прямоугольный треугольник. 
# Программа запрашивает у пользователя 3 стороны треугольника и определяет, является ли треугольник прямоугольным, 
# используя теорему Пифагора (www-formula.ru) и выводит результат на экран. 
# Также, если треугольник является при этом равнобедренным (т.е. у него равны любые 2 стороны), 
# то дополнительно выводится информация о том, что треугольник еще и равнобедренный. 
# Подсказка: чтобы воспользоваться теоремой Пифагора, нужно сначала найти самую длинную сторону (гипотенуза) 
# и сравнить ее значение в квадрате с суммой квадратов двух остальных сторон. 
# Если все 3 стороны равны, то треугольник равнобедренный и равносторонний, но не прямоугольный.

triangle = []
print "Input first side of trianlge: "
triangle << gets.chomp.to_f

print "Input second side of triangle: "
triangle << gets.chomp.to_f

print "Input third side of triangle: "
triangle << gets.chomp.to_f

sides_meta = triangle.inject({}) do |h,v| 
  if h.keys.include?(v) 
    h[v] += 1 
  else 
    h[v] = 1
  end 
  h 
end

if sides_meta.count == 1
  #Треугольник равнообедренный и равносторонний, но не прямоугольный
  puts "triange is isosceles and equal-sided, but is not right angled"
elsif sides_meta.count == 2
  #Треугольник не является прямоугольным, но является равнобедренным
  puts "triangle is not right angled, but is isosceles"
else
  c = sides_meta.keys.max
  a, b = sides_meta.keys.min(2)
    
  if a**2 + b**2 == c**2
    #Треугольник - прямоугольный
    puts "trianle is right angled" 
  else
    puts "triangle is not right angled"
  end
end

puts "Enter day: "
day = gets.chomp

puts "Enter month: "
month = gets.chomp

puts "Enter year: "
year = gets.chomp

leap_year = year % 4 == 0 && (year % 100 == 0 && year % 400 == 0)
month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
month_days[1] = 29 if leap_year

days = []
(1..month.to_i).each_with_index do |item, index|
  (1..month_days[index]).each do |d| 
    days << "#{d.to_s.rjust(2, '0')}.#{item.to_s.rjust(2, '0')}.#{year}"
  end
end

puts days.index("#{day.rjust(2, '0')}.#{month.rjust(2, '0')}.#{year}")

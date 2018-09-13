print "Input your name: "
name = gets.chomp.capitalize!

print "and input your height now: "
height = Integer(gets.chomp)

if (optimal_height = (height - 110)).negative?
  print "#{name}, your have an optimal weight already!\n"
else
  print "#{name}, #{optimal_height}\n"
end
#
# Заполнить массив числами фибоначчи до 100
#

def fib(n)
  return 0 if n == 0
  n <= 2 ? 1 : fib(n - 1) + fib(n - 2)
end

fib_array = []
n = 0
while (val = fib(n)) <= 100
  fib_array << val
  n += 1
end


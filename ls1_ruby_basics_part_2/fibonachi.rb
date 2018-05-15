# Заполнить массив числами фибоначчи до 100
fib_nums = [0, 1]
next_number = 1

while next_number < 100
  fib_nums << next_number
  next_number = fib_nums[-1] + fib_nums[-2]
end

p fib_nums
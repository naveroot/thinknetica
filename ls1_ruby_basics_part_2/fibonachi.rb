# Заполнить массив числами фибоначчи до 100
fib_nums = [0, 1]
fib_nums << fib_nums[-1] + fib_nums[-2] while fib_nums[-1] + fib_nums[-2] < 100

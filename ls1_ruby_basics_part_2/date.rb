# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным.
months_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

print  'Введите год: '
year = gets.chomp.to_i
if (year % 400).zero? || (year % 4).zero? && !(year % 100).zero?
  months_days[1] = 29
  puts 'Год високосный'
else
  puts 'Год НЕ високосный'
end

month = 0
until month.between?(1, months_days.size)
  print 'Введите месяц: '
  month = gets.chomp.to_i
end

day = 0
until day.between?(1, months_days[month - 1])
  print 'Введите день: '
  day = gets.chomp.to_i
end
day_count = if month > 1
              months_days[0..month - 2].reduce(:+) + day
            else
              day
            end

puts "Количество дней от начала года #{day_count}"

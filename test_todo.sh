#!/bin/bash

echo "Запущен тест скрипта управления списком дел"

if [[ -f todo.txt ]]
then
    rm todo.txt
fi

# тест 1
value=""
result=$(echo $value | ./main.sh add)
expected="Задача не может быть пустой, попробуйте еще раз"

if [[ $result == $expected ]]
then
    echo "Тест 1 пройден"
else
    echo "Тест 1 не пройден"
    exit 1
fi

# тест 2
value="Помыть посуду"
result=$(echo $value | ./main.sh add)
expected="Задача успешно добавлена"

if [[ $result == $expected ]]
then
    echo "Тест 2 пройден"
else
    echo "Тест 2 не пройден"
    exit 1
fi

# тест 3
task="Сделать уроки"
res=$(echo $task | ./main.sh add)
task="Прибраться в комнате"
res=$(echo $task | ./main.sh add)

result=$(./main.sh show)
expected="Список ваших задач:
1 Помыть посуду
2 Сделать уроки
3 Прибраться в комнате"

if [[ $result == $expected ]]
then
    echo "Тест 3 пройден"
else
    echo "Тест 3 не пройден"
    exit 1
fi

# тест 4
value=10
result=$(echo $value | ./main.sh remove)
expected="Список ваших задач:
1 Помыть посуду
2 Сделать уроки
3 Прибраться в комнате
Индекс неверный, попробуйте еще раз"

if [[ $result == $expected ]]
then
    echo "Тест 4 пройден"
else
    echo "Тест 4 не пройден"
    exit 1
fi

# тест 5
value=1
result1=$(echo $value | ./main.sh remove)
result2=$(./main.sh show)
expected="Список ваших задач:
1 Сделать уроки
2 Прибраться в комнате"

if [[ $result2 == $expected ]]
then
    echo "Тест 5 пройден"
else
    echo "Тест 5 не пройден"
    exit 1
fi

rm todo.txt
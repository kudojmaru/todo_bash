#!/bin/bash
# скрипт для управления списком дел
# usage:
# 1. Добавить задачу в список: add
# 2. Удалить задачу из списка: remove
# 3. Показать весь список: show

DATA_BASE="todo.txt"

if [[ ! -n $1 ]]
then
    echo "Аргумент не найден"
    echo "Использование:"
    echo "1. Добавить задачу в список: add"
    echo "2. Удалить задачу из списка: remove"
    echo "3. Показать весь список: show"
    exit 0
fi

command=$1

if [[ $command == "add" ]]
then
    read -p "Введите новую задачу: " new_todo
    if [[ ! -n $new_todo ]]
    then
        echo "Задача не может быть пустой, попробуйте еще раз"
        exit 0
    fi

    if [[ ! -f $DATA_BASE ]]
    then
        touch $DATA_BASE
    fi

    echo $new_todo >> $DATA_BASE
    echo "Задача успешно добавлена"
    exit 0
fi

if [[ $command == "remove" ]]
then
    if [[ ! -f $DATA_BASE ]]
    then
        echo "Добавьте хотя бы одну задачу для удаления"
        exit 0
    fi

    # вывод списка задач
    echo "Список ваших задач:"
    count=1
    while read line
    do
        echo "$count $line"
        count=$(($count+1))
    done < $DATA_BASE

    read -p "Введите номер задачи для удаления: " id_remove

    if [[ ! -n $id_remove ]]
    then
        echo "Индекс не может быть пустым, попробуйте еще раз"
        exit 0
    fi

    # нахождения задачи для удаления по индексу
    count=1
    while read line
    do
        if [[ $count -eq $id_remove ]]
        then
            delete_line=$line
        fi
        count=$(($count+1))
    done < $DATA_BASE

    if [[ ! -n $delete_line ]]
    then
        echo "Индекс неверный, попробуйте еще раз"
        exit 0
    fi

    grep -v "$delete_line" $DATA_BASE > newfile.txt
    rm $DATA_BASE
    mv newfile.txt $DATA_BASE

    if [[ ! -s $DATA_BASE ]]
    then
        rm $DATA_BASE
    fi

    echo "Задача успешно удалена"
    exit 0
fi

if [[ $command == "show" ]]
then
    if [[ ! -f $DATA_BASE ]]
    then
        echo "Добавьте хотя бы одну задачу для просмотра"
        exit 0
    fi

    echo "Список ваших задач:"
    count=1
    while read line
    do
        echo "$count $line"
        count=$(($count+1))
    done < $DATA_BASE
    exit 0
fi

#!/bin/bash
#########################################################################################################################
#                                                                                                                       #
#          Скрипт проверки состояния сертификатов в хранилище java v0.0.1 2017                                          #
#          Использует утилиту keytool, принимает три параметра -                                                        #
#          количество дней перед истечением срока действия, путь к хранилищу сертификатов и путь к файлу с паролем      #
#          возвращает 0 в случае отсутсвия проблемных сертификатов и 1 при наличии                                      #                                                                       #
#                                                                                                                       #
#########################################################################################################################
   
   # Проверяем количество аргументов переданных скрипту. Как минимум нужно передать путь к keystore путь к фалу system.propertes и число дней 
    if [ $# -lt 2 ]; then
        echo "Usage: check_cert_keytools.sh <days> <path_to_keystore> <path_to_keystore_password_file>"
    exit
    fi
    
    file_check()
    {
	# Проверяем существование файла keystore
	if [ ! -f $1 ]; 
	    then 
	    echo "keystore file not exist";
	    exit 1;
	fi
    }
    file_check $2;
    file_check $3;
    
    password=`cat<$3|grep trustStorePassword|cut -c 36-55`
    IFS=`
    `
    arr=(`keytool -list -v -keystore $2 -storepass $password|egrep "Valid"|grep until|cut -c 53-80`)
    
#    for ix in ${!arr[*]}
#    do
#        printf "%s\n" "${arr[$ix]}"
#    done
    
    current_date=`date +"%b %d %H:%M%:%S %Y %Z" --utc`			# Получаем текующую адту в "сыром виде"
    current_date_y=`echo $current_date|cut -c 17-21`			# Получаем текущий год !Один символ убрать
    current_date_m=`echo $current_date|cut -c -4`			# Получаем текущий месяц
    current_date_d=`echo $current_day|cut -c 5-6`			# Получаем текущий день
    
    for iy in ${!arr[*]}
    do
	cert_date_y=`echo ${arr[$iy]}|cut -c 21-25`
	cert_date_m=`echo ${arr[$iy]}|cut -c 1-3`
	cert_date_d=`echo ${arr[$iy]}|cut -c 5-7`
#	if [ $cert_date_y -eq $current_date_y ]				# Сравниваем год до которого валиден сертификато с текущим
#	then if [ $cert_date_m -eq $current_date_m]			# Сравниваем месяц до которого валиден текущий сертификат с текущим
#		then 
#		if [ $cert_date_d+$1 -gt $current_date_d]		# Сравниваем дни. Из даты когда сертифкат протух вычитаем заданное первым аргументом значение
#			then echo 1 && exit 1
#			fi
#		fi
#	fi
#	
#	echo 0
#	exit 0
    done
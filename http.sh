#################################################################
#   Простой http сервер на bash с задержкой ответа              #
#   Оригинальная версия взята по адресу:                        #
#   https://habrahabr.ru/post/37245/  автор  Alexey Sveshnikov  #
#                                                               #
#################################################################

# Проверяем количество аргументов переданных скрипту. Как минимум нужно передать задержку ответа 
    if [ $# -lt 1 ]; then
        echo "Usage: http.sh <задержка в секундах>"
    exit
fi


:;while [ $? -eq 0 ];do
        nc -vlp 8080 -c'(
                r=read;
                e=echo;
                $r a b c;
                z=$r;

                while [ ${#z} -gt 2 ]; do
                        $r z;
                done;
                sleep $i

                f=`$e $b|sed 's/[^a-z0-9_.-]//gi'`;
                h="HTTP/1.0";
                o="$h 200 OK\r\n";
                c="Content";
                if [ -z "$f" ];then (
                        $e $o;
                        (for n in *;do
                                if [ -f "$n" ]; then
                                        $e "<a href=\"/$n\">`ls -gh \"$n\"`</a><br>";
                                fi;
                        done);
                );
                elif [ -f "$f" ];then
                        $e "$o$c-Type: `file -ib \"$f\"`\n$c-Length: `stat -c%s \"$f\"`";
                        $e;
                        $e $f>&2;
                        cat "$f";
                else
                        $e -e "$h 404 Not Found\n\n404\n";
                fi)';
done


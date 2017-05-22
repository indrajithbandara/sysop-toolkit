#!/bin/bash

pid="$1"
[ -z "$pid" ] && { echo "Usage: $0 [PID]"; exit 1; }
smaps="$( cat /proc/"$pid"/smaps )" || exit 1
addr_and_swap="$( grep -E "^Swap:|^[0-9a-f]{4,16}-[0-9a-f]{4,16} " <<< "$smaps" )"

LIMIT_DEC=$(( 1024*1024*1024 ))
LIMIT_HEX="$( printf "%X\n" "$LIMIT_DEC" )"
dump_mem() {
	begin="$1"
	end="$2"
	begin_tmp="$begin"
	end_tmp="$end"
	delta_dec="0"
	echo "block: $begin-$end"
	while true
	do
		delta_dec=$(( 0x$end-0x$begin_tmp ))
		[ "$delta_dec" -eq "0" ] && break
		if [ "$delta_dec" -ge "$LIMIT_DEC" ]
		then
			end_tmp="$( printf "%X\n" $(( 0x$begin_tmp+0x$LIMIT_HEX )) )"
		else
			end_tmp="$end"
		fi
		echo "subblock: $begin_tmp-$end_tmp"
		gdb -q --batch --pid "$pid" -ex "dump memory /dev/null 0x${begin_tmp} 0x${end_tmp}"
		begin_tmp="$end_tmp"
	done
}

echo  "$addr_and_swap" | while IFS=$'\n' read addr_line ; read swap_line
do
	read -a swap_arr <<< "$swap_line"
	swap="${swap_arr[1]}"
	[ "$swap" == "0" ] && continue
	addr="${addr_line%% *}"
	addr_begin="${addr%%-*}"
	addr_end="${addr##*-}"
	dump_mem "$addr_begin" "$addr_end"
done


#! /bin/bash

DEV=eth0
LOCAL_IP=X.X.X.X								# на нём поднимаем туннель

OFFSET=40

ip tunnel del qrtun

if ip link sh qrtun &>/dev/null; then
echo 'Tunnel is set up already, nothing to do.' >&2
exit -1
fi

if [ -z "$DEV" ]; then
echo '$DEV unset'
exit -1
fi

if [ -z "$LOCAL_IP" ]; then
echo '$LOCAL_IP unset'
exit -1
fi

#if ! modprobe ipip; then			# MAY and likely to NOT WORK
#echo 'Failed to load ipip module'		# BECAUSE OpenVZ/docker containers
#exit -1					# better left commented out
#fi						#

if ! grep -q qrtun_route /etc/iproute2/rt_tables; then
if egrep -q '^[[:space:]]*'$OFFSET'[[:space:]]' /etc/iproute2/rt_tables;	# POSIX stuff
then
echo Cannot append appropriate lines to /etc/iproute2/rt_tables. >&2
echo You need to set up qrtun_route table yourself. >&2
exit
else
echo ' '$OFFSET' qrtun_route' >> /etc/iproute2/rt_tables
fi
fi

echo -n Setting up tunnel... >&2

src=Y.Y.Y.Y
dst=Z.Z.Z.Z

ip tunnel add qrtun mode ipip remote Q.Q.Q.Q local $LOCAL_IP ttl 64 dev $DEV
ip address add $src peer $dst/32 dev qrtun
ip link set qrtun up
ip rule add from $src table qrtun_route						# ipr2
ip route add default dev qrtun table qrtun_route				# ipr2

echo ' done'. >&2

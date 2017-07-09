#!/bin/sh

if [ -z $3 ]; then
  echo "usage: $0 <remote host> <remote port> <remote user>"
  exit 1
fi

REMOTE_HOST=$1
REMOTE_PORT=$2
REMOTE_USER=$3

sudo apt-get -y install autossh

if ! sudo grep autossh /etc/ppp/ip-up.d/10ssh-tunnel; then
cat << "EOS" | sudo tee /etc/ppp/ip-up.d/10ssh-tunnel
#!/bin/sh

# This script is called with the following arguments:
#    Arg  Name                          Example
#    $1   Interface name                ppp0
#    $2   The tty                       /dev/ttyS1
#    $3   The link speed                38400
#    $4   Local IP number               12.34.56.78
#    $5   Peer  IP number               12.34.56.99
#    $6   Optional ``ipparam'' value    foo

if [ "$2" = "/dev/ttyL05A" \
  -o "$2" = "/dev/ttyAK020" \
  -o "$2" = "/dev/ttyE1750" \
]; then

    # ppp0 の txqueuelen が 3 なので、大きくする
    /sbin/ifconfig $1 txqueuelen 128

    # root権限で動いているため、ほかのユーザで実行したい場合は
    # su <user> -c "echo hoge" 的なことをする
    #
    # autossh でトンネルを掘る場合は、トンネルの出口の sshd の
    # 設定で、ClientAliveInterval 10/ ClientAliveCountMax 3
    # などの 回線が死んだらsshも自然に死ぬようにしておく必要が
    # あります（送り側のautosshでsshのセッションを張りなおしても、
    # 受け側の古いsshdが死なずに居座るとListen出来ないので）。

    su pi -c \
        '/usr/bin/autossh \
        -N -f -M 0 \
        -o ServerAliveInterval=60 \
        -o ServerAliveCountMax=3 \
        -o ExitOnForwardFailure=yes \
        -o StrictHostKeyChecking=no \
        -R 10022:localhost:22 \
        -i /home/pi/.ssh/id_rsa \
	-p ${REMOTE_PORT} \
        -l ${REMOTE_USER} \
        ${REMOTE_HOST}'
fi

exit
EOS
fi

sudo chmod 755 /etc/ppp/ip-up.d/10ssh-tunnel

output=$(ifconfig -a)
adapters=($(echo $output | grep -Po 'enx\w+'))

for i in "${adapters[@]}"; do
    adapter_blocks=$(echo $output | grep -Po "${i}.*?collisions")
    is_connected=$(echo $adapter_blocks | grep -Po 'inet[^\d]')
    if [ $is_connected ]; then
        echo $i is connected
    else
        echo $i is not connected
        sudo ifconfig $i down
        echo $1 brought down
        sudo ifconfig $i up
        echo $1 brought up
    # sudo ifconfig $i 192.168.0.2 netmask 255.255.255.0
    fi
done


for i in "${adapters[@]}"; do
    adapter_blocks=$(echo $output | grep -Po "${i}.*?collisions")
    is_connected=$(echo $adapter_blocks | grep -Po 'inet[^\d]')
    if [ $is_connected ]; then
        echo $i no need to reset static IP
    else
        echo $i reseting static IP to 192.168.0.2 netmask 255.255.255.0 
        sudo ifconfig $i 192.168.0.2 netmask 255.255.255.0
    fi
done

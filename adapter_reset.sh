output=$(ifconfig -a)
adapters=($(echo $output | grep -Po 'en\w+'))

for i in "${adapters[@]}"; do
    adapter_blocks=$(echo $output | grep -Po "${i}.*?collisions")
    is_connected=$(echo $adapter_blocks | grep -Po 'inet[^\d]')
    if [ $is_connected ]; then
        echo $i is connected
    else
        echo $i is not connected
        sudo ifconfig $i down
        sudo ifconfig $i up
    # sudo ifconfig $i 192.168.0.2 netmask 255.255.255.0
    fi
    adapter_blocks=$(echo $output | grep -Po "${i}.*?collisions")
    is_connected=$(echo $adapter_blocks | grep -Po 'inet[^\d]')
    if [ $is_connected ]; then
        echo $i is connected
    else
        echo $i is not connected
        sudo ifconfig $i 192.168.0.2 netmask 255.255.255.0
    fi
done

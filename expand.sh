(
echo d # Delete partition 
echo 1 # Delete first
echo n # New partition
echo p # Primary
echo 1 # 1 Partition
echo   # First sector (Accept default: 1)
echo   # Last sector (Accept default: varies)
echo w # Write changes
) | sudo fdisk /dev/sda

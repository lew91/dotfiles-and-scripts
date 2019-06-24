#!/bin/sh

FS_COLUMN=1
MP_COLUMN=9
USER_MOUNT_POINT=$1
DEFAULT_MOUNT_POINT=/Volumes

# Eject disk, arg1: disk
function eject_disk()
{
	if [ -b "$1" ];	then
		sudo umount $1	
		ret=`df | grep $1 | awk '{print $'$MP_COLUMN'}'`
		if [ -d "$ret" ]; then
			echo "Umount disk error!"
			exit
		fi
	else
		echo "$1 is not a disk!"
		exit
	fi
}

# Get mount point, arg1: disk, arg2: mount point
function get_mount_point()
{
	local mp

	# Mount point is specified by user
	if [ "$USER_MOUNT_POINT" ]; then
		mp=$USER_MOUNT_POINT
	# User do not specified use disk basename
	else
		if [ "$2" ]; then
			mp=$2
		else
			mp=`basename $1`
			mp="$DEFAULT_MOUNT_POINT/$mp"
		fi
	fi

	echo $mp
}

# Mount as NTFS arg1: disk, arg2: mount point
function mount_as_ntfs_rw()
{
	# Create mount point if it's not exist
	if [ ! -d "$2" ]; then
		sudo mkdir -p $mp
	fi

	# Mount disk as NTFS
	sudo mount_ntfs -o rw,nobrowse $1 $2
	ret=`df | grep $1 | awk '{print $'$MP_COLUMN'}'`
	if [ -d "$ret" ]; then
		echo "Success, disk [$1] is mount as NTFS r/w mode to [$2]"
	else
		echo "Failed, disk [$1] mount to [$2] failed!"
		exit
	fi
}

# First get all external disks
external_disks=`ls /dev/disk[2-9]s[1-9]`

# Check if disk is already mounted
for disk in $external_disks; do

	# Get disk mount point
	mp=`df | grep $disk | awk '{print $'$MP_COLUMN'}'`

	# Eject disk
	if [ -d "$mp" ]; then
		while true; do
			read -p "Disk [$disk] is already mounted on [$mp], do you want to eject it? (Y/N)" option
			case $option in
				[Yy]*) eject_disk $disk; break;;
				[Nn]*) echo "Mount as NTFS r/w mode must ejecd it first"; exit;;
				*) echo "Unknown option $option";
			esac
		done
	fi

	# Re-mount as NTFS
	while true; do
		mp=$(get_mount_point $disk $mp)
		read -p "Disk [$disk] is ejected, do you want to re-mount as r/w mode to [$mp]? (Y/N)" option
		case $option in
			[Yy]*) mount_as_ntfs_rw $disk $mp; break;;
			[Nn]*) echo "exit!"; exit;;
			*) echo "Unknown option $option";
		esac
	done
done

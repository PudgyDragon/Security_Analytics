#!/bin/bash
# Transfer a Live image so that it's bootable off of a USB/SD device.
# Copyright 2007-2012  Red Hat, Inc.
#
# Jeremy Katz <katzj@redhat.com>
# Brian C. Lane <bcl@redhat.com>
#
# overlay/persistence enhancements by Douglas McClendon <dmc@viros.org>
# GPT+MBR hybrid enhancements by Stewart Adam <s.adam@diffingo.com>
# 
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Library General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.

# Typical usage, from outside of schroot environment:
#
# sudo ./solera-iso-to-usb.sh --force [path-to-iso] [path-to-device], i.e.
# sudo ./solera-iso-to-usb.sh --force ./_build/atpsa-7.3.2-50107-x86_64-DVD.iso /dev/sdb
# 
# Note: Don't eject the usb beforehand


export PATH=/sbin:/usr/sbin:$PATH

shortusage() {
    echo "
    SYNTAX

    solera-iso-to-usb.sh [--help] [--no-format] [--no-reset-mbr]
                       [--skipcopy] [--force] [--extra-kernel-args <args>]
                       [--compress] [--skipcompress]
                       <source> <target device>

    (Enter solera-iso-to-usb.sh --help on the command line for more information.)"
}

usage() {
    echo "
    "
    shortusage
    echo "
    solera-iso-to-usb.sh  -  Transfer a LiveOS image so that it's bootable off of
                             a USB/SD device.

    The script may be run in simplest form with just the two arguments:

             <source>
                 This may be the filesystem path to a LiveOS .iso image file,
                 such as from a CD-ROM, DVD, or download.  It could also be the
                 device node reference for the mount point of another LiveOS
                 filesystem, including the currently-running one (such as a
                 booted Live CD/DVD/USB, where /dev/live references the running
                 image device).

             <target device>
                 This should be the device partition name for the attached,
                 target device, such as /dev/sdb1 or /dev/sdc1.  (Issue the
                 df -Th command to get a listing of the mounted partitions,
                 where you can confirm the filesystem types, available space,
                 and device names.)  Be careful to specify the correct device,
                 or you may overwrite important data on another disk!

    To execute the script to completion, you will need to run it with root user
    permissions.
    SYSLINUX must be installed on the computer running the installation script.

    DESCRIPTION

    livecd-iso-to-disk installs a Live CD/DVD/USB image (LiveOS) onto a USB/SD
    storage device (or any storage partition that will boot with a SYSLINUX
    bootloader).  The target storage device can then boot the installed
    operating system on systems that support booting via the USB or the SD
    interface.  The script requires a LiveOS source image and a target storage
    device.  The source image may be either a LiveOS .iso file, the currently-
    running LiveOS image, the device node reference for an attached device with
    an installed LiveOS image, or a file backed by a block device with an
    installed LiveOS image.  If the operating system supports persistent
    overlays for saving system changes, a pre-sized overlay may be included with
    the installation.

    Unless you request the --format option, the installation does not destroy
    data outside of the LiveOS, syslinux, & EFI folders on your target device.
    This allows one to maintain other files on the target disk outside of the
    LiveOS filesystem.

    LiveOS images provide embedded filesystems through the Device-mapper
    component of the Linux kernel.  The embedded filesystems exist within files
    such as /LiveOS/squashfs.img (the default compressed storage) or
    /LiveOS/ext3fs.img (an uncompressed version) on the primary volume partition
    of the storage device.  In use, these are read-only filesystems. Optionally,
    one may specify a persistent LiveOS overlay to hold image-change snapshots
    (that use write-once, difference-tracking storage) in the
    /LiveOS/overlay-<device_id> file, which, *one should note*, always grows in
    size due to the storage mechanism.  (The fraction of allocated space that
    has been consumed by system activity and changes may be displayed by issuing
    the 'dmsetup status' command in a terminal session of a running LiveOS
    image.)  One way to conserve the unrecoverable, overlay file space, is to
    specify a persistent home folder for user files, which will be saved in a
    /LiveOS/home.img filesystem image file.  This file space is encrypted by
    default, but is not compressed.  (One may bypass encryption with the
    --unencrypted-home installation option.)  Files in this home folder may be
    erased to recover and reuse their storage space.  The home.img file is also
    convenient for backing up or swapping user account files.

    OPTIONS

    --help
        Displays usage information and exits.

    --format
        Formats the target device and creates an MS-DOS partition table

    --reset-mbr
        Sets the Master Boot Record (MBR) of the target storage device to the
        mbr.bin file from the installation system's syslinux directory.  This
        may be helpful in recovering a damaged or corrupted device.

    --skipcopy
        Skips the copying of the live image to the target device, bypassing the
        actions of the --format
        options, if present on the command line. (The --skipcopy
        option may be used while testing the script, in order to avoid repeated
        and lengthy copy commands, or to repair boot configuration files on a
        previously installed device.)

    --force
        This option allows the installation script to bypass a delete
        confirmation dialog in the event that a pre-existing LiveOS directory
        is found on the target device.

    --extra-kernel-args <args>
        Specifies additional kernel arguments, <args>, that will be inserted
        into the syslinux and EFI boot configurations.  Multiple arguments
        should be specified in one string, i.e.,
            --extra-kernel-args \"arg1 arg2 ...\"

    --compress   (default state for the operating system files)
        The default, compressed SquashFS filesystem image is copied on
        installation.  This option has no effect when the source filesystem is
        already expanded.

    --skipcompress
        Expands the source SquashFS image on installation into the read-only
        /LiveOS/ext3fs.img filesystem image file.

    CONTRIBUTORS

    livecd-iso-to-disk: David Zeuthen, Jeremy Katz, Douglas McClendon,
                        Chris Curran and other contributors.
                        (See the AUTHORS file in the source distribution for
                        the complete list of credits.)

    BUGS

    Report bugs to the mailing list
    http://admin.fedoraproject.org/mailman/listinfo/livecd or directly to
    Bugzilla http://bugzilla.redhat.com/bugzilla/ against the Fedora product,
    and the livecd-tools component.

    COPYRIGHT

    Copyright (C) Fedora Project 2008, 2009, 2010 and various contributors.
    This is free software. You may redistribute copies of it under the terms of
    the GNU General Public License http://www.gnu.org/licenses/gpl.html.
    There is NO WARRANTY, to the extent permitted by law.

    SEE ALSO

    livecd-creator, project website http://fedoraproject.org/wiki/FedoraLiveCD
    "
    exit 1
}

cleanup() {
    sleep 2
    [ -d "$SRCMNT" ] && umount $SRCMNT && rmdir $SRCMNT
    [ -d "$TGTMNT" ] && umount $TGTMNT && rmdir $TGTMNT
}

exitclean() {
    RETVAL=$?
    if [ -d "$SRCMNT" ] || [ -d "$TGTMNT" ];
    then
        [ "$RETVAL" = 0 ] || echo "Cleaning up to exit..."
        cleanup
    fi
    exit $RETVAL
}

isdevloop() {
    [ x"${1#/dev/loop}" != x"$1" ]
}

# Return the matching file ignoring case or 1 if no match
nocase_path() {
    local ret=0
    shopt -s nocaseglob
    [ -e "$1" ] || ret=1
    echo $1
    shopt -u nocaseglob
    return $ret
}

getdisk() {
    DEV=$1

    if isdevloop "$DEV"; then
        device="$DEV"
        return
    fi

    p=$(udevadm info -q path -n $DEV)
    if [ $? -gt 0 ]; then
        echo "Error getting udev path to $DEV"
        exitclean
    fi
    if [ -e /sys/$p/device ]; then
        device=$(basename /sys/$p)
    else
        device=$(basename $(readlink -f /sys/$p/../))
    fi
    if [ ! -e /sys/block/$device -o ! -e /dev/$device ]; then
        echo "Error finding block device of $DEV.  Aborting!"
        exitclean
    fi

    device="/dev/$device"
    # FIXME: weird dev names could mess this up I guess
    p=/dev/$(basename $p)
    partnum=${p##$device}
}

resetMBR() {
    if isdevloop "$DEV"; then
        return
    fi
    getdisk $1
    if [ -f /usr/lib/syslinux/mbr.bin ]; then
        cat /usr/lib/syslinux/mbr.bin > $device
    elif [ -f /usr/share/syslinux/mbr.bin ]; then
        cat /usr/share/syslinux/mbr.bin > $device
    elif [ -f /usr/lib/syslinux/mbr/mbr.bin ]; then
        cat /usr/lib/syslinux/mbr/mbr.bin > $device
    else
        echo "Could not find mbr.bin (syslinux)"
        exitclean
    fi
    echo "Waiting for device to settle"
    /sbin/udevadm settle -E $device
}

checkMBR() {
    if isdevloop "$DEV"; then
        return 0
    fi
    getdisk $1

    bs=$(mktemp /tmp/bs.XXXXXX)
    dd if=$device of=$bs bs=512 count=1 2>/dev/null || exit 2

    mbrword=$(hexdump -n 2 $bs |head -n 1|awk {'print $2;'})
    rm -f $bs
    if [ "$mbrword" = "0000" ]; then
        if [ -z "$format" ]; then
            echo "MBR appears to be blank."
            echo "Press Enter to replace the MBR and continue or ctrl-c to abort"
            read
        fi
        resetMBR $1
    fi

    return 0
}

checkPartActive() {
    dev=$1
    getdisk $dev

    # if we're installing to whole-disk and not a partition, then we
    # don't need to worry about being active
    if [ "$dev" = "$device" ]; then
        return
    fi
    if isdevloop "$DEV"; then
        return
    fi

    if [ "$(/sbin/fdisk -l $device 2>/dev/null |grep -m1 $dev |awk {'print $2;'})" != "*" ]; then
        echo "Partition isn't marked bootable!"
        echo "You can mark the partition as bootable with "
        echo "    # /sbin/parted $device"
        echo "    (parted) toggle N boot"
        echo "    (parted) quit"
        exitclean
    fi
}

checkLVM() {
    dev=$1

    if [ -x /sbin/pvs -a \
        "$(/sbin/pvs -o vg_name --noheadings $dev* 2>/dev/null || :)" ]; then
        echo "Device, $dev, contains a volume group and cannot be formated!"
        echo "You can remove the volume group using vgremove."
        exitclean
    fi
    return 0
}

createMSDOSLayout() {
    dev=$1
    getdisk $dev

    echo "WARNING: THIS WILL DESTROY ANY DATA ON $device!!!"
    echo "Press Enter to continue or ctrl-c to abort"
    read
    umount ${device}* &> /dev/null || :
    wipefs -a ${device}
    /sbin/parted --script $device mklabel msdos
    partinfo=$(LC_ALL=C /sbin/parted --script -m $device "unit MB print" |grep ^$device:)
    dev_size=$(echo $partinfo |cut -d : -f 2 |sed -e 's/MB$//')
    p1_size=$(($dev_size - 3))

    if [ $p1_size -le 0 ]; then
        echo "Your device isn't big enough to hold $SRC"
        echo "It is $(($p1_size * -1)) MB too small"
        exitclean
    fi
    p1_start=1
    p1_end=$(($p1_size + 1))
    /sbin/parted -s $device u MB mkpart primary fat32 $p1_start $p1_end set 1 boot on
    # Sometimes automount can be _really_ annoying.
    echo "Waiting for devices to settle..."
    /sbin/udevadm settle -E $device
    sleep 5
    if ! isdevloop "$DEV"; then
        TGTDEV=${device}1
    else
        TGTDEV=${device}
    fi
    umount $TGTDEV &> /dev/null || :
    /sbin/mkdosfs -n LIVE $TGTDEV
    TGTLABEL="UUID=$(/sbin/blkid -s UUID -o value $TGTDEV)"
}

checkFilesystem() {
    dev=$1

    TGTFS=$(/sbin/blkid -s TYPE -o value $dev || :)
    if [ "$TGTFS" != "vfat" ] && [ "$TGTFS" != "msdos" ]; then
        if [ "$TGTFS" != "ext2" ] && [ "$TGTFS" != "ext3" ] && [ "$TGTFS" != "ext4" ] && [ "$TGTFS" != "btrfs" ]; then
            echo "Target filesystem ($dev:$TGTFS) must be vfat, ext[234] or btrfs"
            exitclean
        fi
    fi

    if [ "$TGTFS" = "ext2" -o "$TGTFS" = "ext3" -o "$TGTFS" = "ext4" ] && [ ! -x /usr/sbin/extlinux ]; then
        echo "Target filesystem ($TGTFS) requires syslinux-extlinux to be installed."
        exitclean
    fi

    TGTLABEL=$(/sbin/blkid -s LABEL -o value $dev)
    if [ "$TGTLABEL" != "LIVE" ]; then
        if [ "$TGTFS" = "vfat" -o "$TGTFS" = "msdos" ]; then
            /sbin/dosfslabel $dev LIVE
            if [ $? -gt 0 ]; then
                echo "dosfslabel failed on $dev, device not setup"
                exitclean
            fi
        elif [ "$TGTFS" = "ext2" -o "$TGTFS" = "ext3" -o "$TGTFS" = "ext4" ]; then
            /sbin/e2label $dev LIVE
            if [ $? -gt 0 ]; then
                echo "e2label failed on $dev, device not setup"
                exitclean
            fi
        else
            echo "Unknown filesystem type. Try setting its label to LIVE and re-running"
            exitclean
        fi
    fi

    # Use UUID if available
    TGTUUID=$(/sbin/blkid -s UUID -o value $dev)
    if [ -n "$TGTUUID" ]; then
        TGTLABEL="UUID=$TGTUUID"
    else
        TGTLABEL="LABEL=LIVE"
    fi

    if [ "$TGTFS" = "vfat" -o "$TGTFS" = "msdos" ]; then
        mountopts="-o shortname=winnt,umask=0077"
    fi
}

checkSyslinuxVersion() {
    if [ ! -x /usr/bin/syslinux ]; then
        echo "You need to have syslinux installed to run this script"
        exit 1
    fi
    check=($(syslinux --version 2>&1)) || :
    if [[ 'syslinux' != $check ]]; then
        SYSLINUXPATH=""
    elif [ -n "$multi" ]; then
        SYSLINUXPATH="$LIVEOS/syslinux"
    else
        SYSLINUXPATH="syslinux"
    fi
}

checkMounted() {
    dev=$1
    if grep -q "^$dev " /proc/mounts ; then
        echo "$dev is mounted, please unmount for safety"
        exitclean
    fi
    if grep -q "^$dev " /proc/swaps; then
        echo "$dev is in use as a swap device, please disable swap"
        exitclean
    fi
}

checkint() {
    if ! test $1 -gt 0 2>/dev/null ; then
        shortusage
        exit 1
    fi
}

if [ $(id -u) != 0 ]; then
    echo "You need to be root to run this script"
    exit 1
fi

detectsrctype() {
    if [[ -e "$SRCMNT/Packages" ]]; then
        echo "/Packages found, will copy source packages to target"
        packages=1
    fi
    if [[ -e "$SRCMNT/LiveOS/squashfs.img" ]]; then
        # LiveOS style boot image
        echo "Source Type is live"
        srctype=live
        return
    fi
    if [ -e $SRCMNT/images/install.img -o -e $SRCMNT/isolinux/initrd.img ]; then
        if [ -n "$packages" ]; then
            srctype=installer
        else
            srctype=netinst
        fi
        imgtype=install
        if [ ! -e $SRCMNT/images/install.img ]; then
            echo "$SRC uses initrd.img w/o install.img"
            imgtype=initrd
        fi
        return
    fi
    echo "ERROR: $SRC does not appear to be a Live image or DVD installer."
    exitclean
}

cp_p() {
    strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
        | awk '{
        count += $NF
        if (count % 10 == 0) {
            percent = count / total_size * 100
            printf "%3d%% [", percent
            for (i=0;i<=percent;i++)
                printf "="
                printf ">"
            for (i=percent;i<100;i++)
                printf " "
                printf "]\r"
            }
        }
        END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

copyFile() {
    if [ -x /usr/bin/rsync ]; then
        rsync --inplace -P "$1" "$2"
        return
    fi
    if [ -x /usr/bin/gvfs-copy ]; then
        gvfs-copy -p "$1" "$2"
        return
    fi
    if [ -x /usr/bin/strace -a -x /bin/awk ]; then
        cp_p "$1" "$2"
        return
    fi
    cp "$1" "$2"
}

set -e
set -o pipefail
trap exitclean EXIT
shopt -s extglob

# Make these default
format=1
resetmbr=1

srctype=
imgtype=
packages=
LIVEOS=LiveOS

if [[ "$*" =~ "--help" ]]; then
    usage
fi
while [ $# -gt 2 ]; do
    case $1 in
        --help)
            usage
            ;;
       --no-format)
            format=""
            ;;
        --no-reset-mbr|--noresetmbr)
            resetmbr=""
            ;;
        --skipcopy)
            skipcopy=1
            ;;
        --force)
            force=1
            ;;
       --extra-kernel-args)
            kernelargs=$2
            shift
            ;;
        --compress)
            skipcompress=""
            ;;
        --skipcompress)
            skipcompress=1
            ;;
        *)
            echo "invalid arg -- $1"
            shortusage
            exit 1
            ;;
    esac
    shift
done

SRC=$(readlink -f "$1")
TGTDEV=$(readlink -f "$2")

if [ -z "$SRC" ]; then
    echo "Missing source"
    shortusage
    exit 1
fi

if [ ! -b "$SRC" -a ! -f "$SRC" ]; then
    echo "$SRC is not a file or block device"
    shortusage
    exit 1
fi

if [ -z "$TGTDEV" ]; then
    echo "Missing target device"
    shortusage
    exit 1
fi

if [ ! -b "$TGTDEV" ]; then
    echo "$TGTDEV is not a block device"
    shortusage
    exit 1
fi

# do some basic sanity checks.
checkMounted $TGTDEV

# FIXME: would be better if we had better mountpoints
SRCMNT=$(mktemp -d /media/srctmp.XXXXXX)
if [ -b "$SRC" ]; then
    mount -o ro "$SRC" $SRCMNT || exitclean
elif [ -f "$SRC" ]; then
    mount -o loop,ro "$SRC" $SRCMNT || exitclean
else
    echo "$SRC is not a file or block device."
    exitclean
fi
# Figure out what needs to be done based on the source image
detectsrctype

# Format the device
if [ -n "$format" -a -z "$skipcopy" ]; then
    checkLVM $TGTDEV
    createMSDOSLayout $TGTDEV
fi

checkFilesystem $TGTDEV

checkSyslinuxVersion
checkPartActive $TGTDEV
[ -n "$resetmbr" ] && resetMBR $TGTDEV
checkMBR $TGTDEV

TGTMNT=$(mktemp -d /media/tgttmp.XXXXXX)
mount $mountopts $TGTDEV $TGTMNT || exitclean

trap exitclean SIGINT SIGTERM

# let's try to make sure there's enough room on the target device
if [[ -d $TGTMNT/$LIVEOS ]]; then
    tbd=($(du -B 1M $TGTMNT/$LIVEOS))
else
    tbd=0
fi

if [[ live == $srctype ]]; then
   targets="$TGTMNT/$SYSLINUXPATH"
   target_size=$(du -s -c -B 1M $targets 2> /dev/null | awk '/total$/ {print $1;}') || :
   tbd=$((tbd + target_size))
fi

if [[ -n $skipcompress ]] && [[ -s $SRCMNT/LiveOS/squashfs.img ]]; then
    if mount -o loop $SRCMNT/LiveOS/squashfs.img $SRCMNT; then
        livesize=($(du -B 1M --apparent-size $SRCMNT/LiveOS/ext3fs.img))
        umount $SRCMNT
        if ((livesize > 4095)) &&  [[ vfat == $TGTFS ]]; then
            echo "
            An uncompressed image size greater than 4095 MB is not suitable
            for a VFAT-formatted device.  The compressed SquashFS will be
            copied to the target device.
            "
            skipcompress=""
            livesize=0
        fi
    else
        echo "WARNING: --skipcompress was specified but the
        currently-running kernel can not mount the SquashFS from the source
        file to extract it. Instead, the compressed SquashFS will be copied
        to the target device."
        skipcompress=""
    fi
fi
if [[ live == $srctype ]]; then
    thisScriptpath=$(readlink -f "$0")
    sources="$SRCMNT/LiveOS/ext3fs.img $SRCMNT/LiveOS/osmin.img"
    [[ -z $skipcompress ]] && sources+=" $SRCMNT/LiveOS/squashfs.img"
    sources+=" $SRCMNT/isolinux $SRCMNT/syslinux"
    source_size=$(du -s -c -B 1M "$thisScriptpath" $sources 2> /dev/null | awk '/total$/ {print $1;}') || :
    livesize=$((livesize + source_size))
fi

freespace=$(df -B 1M --total $TGTDEV | awk '/^total/ {print $4;}')

if [ -z "$skipcopy" ] && [ "$srctype" = "live" ]; then
    if [ -d $TGTMNT/$LIVEOS -a -z "$force" ]; then
        echo "Already set up as live image."
        rm -rf $TGTMNT/$LIVEOS
    fi
fi

# Bootloader is always reconfigured, so keep these out of the if skipcopy stuff.
[ ! -d $TGTMNT/$SYSLINUXPATH ] && mkdir -p $TGTMNT/$SYSLINUXPATH

# Live image copy
if [ "$srctype" = "live" -a -z "$skipcopy" ]; then
    echo "Copying live image to target device."
    [ ! -d $TGTMNT/$LIVEOS ] && mkdir $TGTMNT/$LIVEOS
    if [ -n "$skipcompress" -a -f $SRCMNT/LiveOS/squashfs.img ]; then
        mount -o loop $SRCMNT/LiveOS/squashfs.img $SRCMNT || exitclean
        copyFile $SRCMNT/LiveOS/ext3fs.img $TGTMNT/$LIVEOS/ext3fs.img || {
            umount $SRCMNT ; exitclean ; }
        umount $SRCMNT
    elif [ -f $SRCMNT/LiveOS/squashfs.img ]; then
        copyFile $SRCMNT/LiveOS/squashfs.img $TGTMNT/$LIVEOS/squashfs.img || exitclean
    elif [ -f $SRCMNT/LiveOS/ext3fs.img ]; then
        copyFile $SRCMNT/LiveOS/ext3fs.img $TGTMNT/$LIVEOS/ext3fs.img || exitclean
    fi
    if [ -f $SRCMNT/LiveOS/osmin.img ]; then
        copyFile $SRCMNT/LiveOS/osmin.img $TGTMNT/$LIVEOS/osmin.img || exitclean
    fi
    sync
fi

# Adjust syslinux sources for replication of installed images
# between filesystem types.
if [[ -d $SRCMNT/isolinux/ ]]; then
    cp $SRCMNT/isolinux/* $TGTMNT/$SYSLINUXPATH
elif [[ -d $SRCMNT/syslinux/ ]]; then
    cp $SRCMNT/syslinux/* $TGTMNT/$SYSLINUXPATH
    if [[ -f $SRCMNT/syslinux/extlinux.conf ]]; then
        mv $TGTMNT/$SYSLINUXPATH/extlinux.conf \
            $TGTMNT/$SYSLINUXPATH/isolinux.cfg
    elif [[ -f $SRCMNT/syslinux/syslinux.cfg ]]; then
        mv $TGTMNT/$SYSLINUXPATH/syslinux.cfg $TGTMNT/$SYSLINUXPATH/isolinux.cfg
    fi
fi
BOOTCONFIG=$TGTMNT/$SYSLINUXPATH/isolinux.cfg
# Copy packages over.
# Before Fedora17 we could copy the .iso and setup a repo=
# F17 and later look for repodata on the source media.
# The presence of packages and LiveOS indicates F17 or later.
if [ -n "$packages" -a -z "$skipcopy" ]; then
    echo "Copying package data from $SRC to device"
    rsync --inplace -rLDP --exclude EFI/ --exclude images/ --exclude isolinux/ \
        --exclude TRANS.TBL --exclude LiveOS/ "$SRCMNT/" "$TGTMNT/"
    echo "Waiting for device to finish writing"
    sync
fi

if [ "$srctype" = "live" ]; then
    # When the source is an installed Live USB/SD image, restore the boot config
    # file to a base state before updating.
    if [[ -d $SRCMNT/syslinux/ ]]; then
        echo "Preparing boot config file."
        sed -i -e "s/root=live:[^ ]*/root=live:CDLABEL=name/"\
               -e "s/\(r*d*.*live.*ima*ge*\) .* quiet/\1 quiet/"\
                    $BOOTCONFIG
    fi
fi

echo "Updating boot config file"
# adjust label and fstype
sed -i -e "s/CDLABEL=[^ ]*/$TGTLABEL/" -e "s/rootfstype=[^ ]*/rootfstype=$TGTFS/" -e "s/LABEL=[^ ]*/$TGTLABEL/" $BOOTCONFIG 
sed -i -e "s/inst.repo=cdrom//g" $BOOTCONFIG
sed -i -e "s/solera-cd/solera-flash/g" $BOOTCONFIG
sed -i -e "s;inst.ks=cdrom:/dev/cdrom:;inst.ks=hd:$TGTLABEL:;g" $BOOTCONFIG
sed -i -e "s;vmlinuz ;vmlinuz inst.stage2=hd:$TGTLABEL:/ ;g" $BOOTCONFIG
if [ -n "$kernelargs" ]; then
    sed -i -e "s;initrd.\?\.img;& ${kernelargs};" $BOOTCONFIG
fi
if [ "$LIVEOS" != "LiveOS" ]; then
    sed -i -e "s;r*d*.*live.*ima*ge*;& live_dir=$LIVEOS;"\
              $BOOTCONFIG
fi

echo "Installing boot loader"
# this is a bit of a kludge, but syslinux doesn't guarantee the API for its com32 modules :/
if [ -f $TGTMNT/$SYSLINUXPATH/vesamenu.c32 -a -f /usr/share/syslinux/vesamenu.c32 ]; then
    cp /usr/share/syslinux/vesamenu.c32 $TGTMNT/$SYSLINUXPATH/vesamenu.c32
elif [ -f $TGTMNT/$SYSLINUXPATH/vesamenu.c32 -a -f /usr/lib/syslinux/vesamenu.c32 ]; then
    cp /usr/lib/syslinux/vesamenu.c32 $TGTMNT/$SYSLINUXPATH/vesamenu.c32
elif [ -f $TGTMNT/$SYSLINUXPATH/vesamenu.c32 -a -f /usr/lib/syslinux/modules/bios/vesamenu.c32 ]; then
    # This takes into account an unbuntu 16.04 system
    cp /usr/lib/syslinux/modules/bios/vesamenu.c32 $TGTMNT/$SYSLINUXPATH/vesamenu.c32
    cp /usr/lib/syslinux/modules/bios/libutil.c32 $TGTMNT/$SYSLINUXPATH/libutil.c32
    cp /usr/lib/syslinux/modules/bios/libcom32.c32 $TGTMNT/$SYSLINUXPATH/libcom32.c32
elif [ -f $TGTMNT/$SYSLINUXPATH/menu.c32 -a -f /usr/share/syslinux/menu.c32 ]; then
    cp /usr/share/syslinux/menu.c32 $TGTMNT/$SYSLINUXPATH/menu.c32
elif [ -f $TGTMNT/$SYSLINUXPATH/menu.c32 -a -f /usr/lib/syslinux/menu.c32 ]; then
    cp /usr/lib/syslinux/menu.c32 $TGTMNT/$SYSLINUXPATH/menu.c32
fi

if [ "$TGTFS" == "vfat" -o "$TGTFS" == "msdos" ]; then
    # syslinux expects the config to be named syslinux.cfg
    # and has to run with the file system unmounted
    mv $TGTMNT/$SYSLINUXPATH/isolinux.cfg $TGTMNT/$SYSLINUXPATH/syslinux.cfg
    # deal with mtools complaining about ldlinux.sys
    if [ -f $TGTMNT/$SYSLINUXPATH/ldlinux.sys ]; then
        rm -f $TGTMNT/$SYSLINUXPATH/ldlinux.sys
    fi
    cleanup
    if [ -n "$SYSLINUXPATH" ]; then
        syslinux -d $SYSLINUXPATH $TGTDEV
    else
        syslinux $TGTDEV
    fi
elif [ "$TGTFS" == "ext2" -o "$TGTFS" == "ext3" -o "$TGTFS" == "ext4" -o "$TGTFS" == "btrfs" ]; then
    # extlinux expects the config to be named extlinux.conf
    # and has to be run with the file system mounted
    mv $TGTMNT/$SYSLINUXPATH/isolinux.cfg $TGTMNT/$SYSLINUXPATH/extlinux.conf
    extlinux -i $TGTMNT/$SYSLINUXPATH
    # Starting with syslinux 4 ldlinux.sys is used on all file systems.
    if [ -f "$TGTMNT/$SYSLINUXPATH/extlinux.sys" ]; then
        chattr -i $TGTMNT/$SYSLINUXPATH/extlinux.sys
    elif [ -f "$TGTMNT/$SYSLINUXPATH/ldlinux.sys" ]; then
        chattr -i $TGTMNT/$SYSLINUXPATH/ldlinux.sys
    fi
    cleanup
fi

echo "Target device is now set up with a Live image!"

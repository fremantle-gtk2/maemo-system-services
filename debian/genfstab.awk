#!/usr/bin/awk

BEGIN {
	# states so that we don't end up having more than one
	# of home or MyDocs; we can have as many swaps as we find
	__home = 0
	__fat = 0

	print "# autogenerated"
	print "rootfs / rootfs defaults,errors=remount-ro,noatime 0 0"
}

/^\/dev\/mmc/ { start=1 }
start == 1 && $6 == 82 {
	printf "%s none swap sw 0 0\n", $1
}

start == 1 && $6 == 83 && !__home {
	printf "%s /home ext3 %s 0 0\n", $1, home_opts
	__home++
}

start == 1 && $6 == "c" && !__fat {
	printf "%s /home/user/MyDocs vfat %s 0 0\n", $1, fat_opts
	__fat++
}

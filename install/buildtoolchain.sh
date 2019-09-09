#!/bin/sh
#
# script to build lm32 GCC toolchain
# https://ohwr.org/project/soft-cpu-toolchains/wikis/home


TOPDIR=`pwd`
GCC="5.3.0"
BINUTILS="2.26"
rm -rf src build

mkdir $TOPDIR/tarballs
cd $TOPDIR/tarballs

#curl ftp://sources.redhat.com/pub/newlib/newlib-1.19.0.tar.gz -o newlib-1.19.0.tar.gz
# curl http://ftp.gnu.org/gnu/gcc/gcc-${GCC}/gcc-${GCC}.tar.bz2 -o gcc-${GCC}.tar.bz2
#curl http://ftp.gnu.org/gnu/gcc/gcc-${GCC}/gcc-${GCC}.tar.gz -o gcc-${GCC}.tar.gz
#curl http://ftp.gnu.org/gnu/gdb/gdb-7.2a.tar.bz2 -o gdb-7.2a.tar.bz2
#curl http://ftp.gnu.org/gnu/binutils/binutils-2.21.1.tar.bz2 -o binutils-2.21.1.tar.bz2
#curl http://repository.timesys.com/buildsources/m/mpc/mpc-0.9/mpc-0.9.tar.gz -o mpc-0.9.tar.gz
#curl http://ftp.gnu.org/gnu/mpfr/mpfr-3.1.1.tar.bz2 -o mpfr-3.1.1.tar.bz2
#curl ftp://ftp.gmplib.org/pub/gmp-5.0.2/gmp-5.0.2.tar.bz2 -o gmp-5.0.2.tar.bz2

UNTAR () {
	echo $1
	tar xf $1
}

DTAR () {
	URL=$2
	echo
	echo "$1 $2"
	curl -SL $2 | tar $3
}

mkdir $TOPDIR/src
cd $TOPDIR/src
# UNTAR ../tarballs/newlib-1.19.0.tar.gz
# UNTAR ../tarballs/gdb-7.2a.tar.bz2
# UNTAR ../tarballs/binutils-2.21.1.tar.bz2
# UNTAR ../tarballs/mpc-0.9.tar.gz
# UNTAR ../tarballs/mpfr-3.1.1.tar.bz2
# UNTAR ../tarballs/gmp-5.0.2.tar.bz2
# UNTAR ../tarballs/gcc-${GCC}.tar.gz

DTAR gcc 				http://ftp.gnu.org/gnu/gcc/gcc-${GCC}/gcc-${GCC}.tar.gz 	xz
DTAR gdb 				http://ftp.gnu.org/gnu/gdb/gdb-7.10.1.tar.gz 				xz
DTAR binutils 			http://ftp.gnu.org/gnu/binutils/binutils-${BINUTILS}.tar.gz		xz
DTAR mpc 				http://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz					xz
DTAR mpfr 				http://ftp.gnu.org/gnu/mpfr/mpfr-3.1.3.tar.gz				xz	
DTAR gmp 				http://ftp.gnu.org/gnu/gmp/gmp-6.1.0.tar.xz					xJ
DTAR newlib				http://sourceware.org/pub/newlib/newlib-2.2.0-1.tar.gz		xz

# exit

cd $TOPDIR/src/gcc-${GCC}

rm -rf bfd binutils gas gold gprof opcodes newlib libgloss gdb mpc mpfr gmp
ln -s ../binutils-${BINUTILS}/bfd bfd
ln -s ../binutils-${BINUTILS}/binutils binutils
ln -s ../binutils-${BINUTILS}/gas gas
ln -s ../binutils-${BINUTILS}/gold gold
ln -s ../binutils-${BINUTILS}/gprof gprof
ln -s ../binutils-${BINUTILS}/opcodes opcodes
ln -s ../binutils-${BINUTILS}/ld ld

ln -s ../newlib-*/newlib newlib
ln -s ../newlib-*/libgloss libgloss

ln -s ../gdb-* gdb
ln -s ../mpc-* mpc
ln -s ../mpfr-* mpfr
ln -s ../gmp-* gmp

mkdir $TOPDIR/build
cd $TOPDIR/build

../src/gcc-${GCC}/configure  --prefix=/usr/mico32 --enable-languages=c --target=lm32-elf --disable-libssp --disable-libgcc
 cd build
 make -j8
 make install
 

#!/bin/bash

# based on freshly installed vmware player debian 8.1 amd64 (64bit user-space)
# ------------------
# needed packages for cross build
# ------------------
# apt-get install ncurses-dev sudo tree g++ git bison gawk
# ------------------
#
# (should) build qemu linux images for:
#   qemu-alpha default: cpu: Alpha, cpu model: EV67, system type: Tsunami, system variation: Clipper
#   qemu-sparc64 default: cpu: TI UltraSparc IIi (Sabre), fpu: UltraSparc IIi integrated FPU, pmu: ultra12, type: sun4u, cpucaps: flush,stbar,swap,muldiv,v9,mul32,div32,v8plus,vis
#   qemu-mips64 default: system type: MIPS Malta, cpu model: MIPS 20kc V10.0 FPU V0.0

# =============================================================
# possible targets
readonly TARGET_SYSTEM_ALPHA=alpha
readonly TARGET_SYSTEM_SPARC64_64=sparc64-64
readonly TARGET_SYSTEM_MIPS64_64=mips64-64
# =============================================================

# =============================================================
# choose target to build !!!
# =============================================================

TARGET_SYSTEM=$1
# TARGET_SYSTEM=${TARGET_SYSTEM_SPARC64_64}

BEGIN_STEP=$2
END_STEP=$3

# BEGIN_STEP=0
# END_STEP=20

# =============================================================
# set configuration for target
# =============================================================
GLIBC_STEP_16_FLAGS="libc_cv_forced_unwind=yes libc_cv_c_cleanup=yes libc_cv_gnu89_inline=yes libc_cv_ssp=no"

case ${TARGET_SYSTEM} in
  ${TARGET_SYSTEM_ALPHA})
    CLFS_TARGET="alphaev67-unknown-linux-gnu"
    LINUX_ARCH=alpha
    GCC_BUILD_FLAGS=""
    GLIBC_STEP_16_FLAGS="${GLIBC_STEP_16_FLAGS} libc_cv_alpha_tls=yes"
    GCCTARGET="-mcpu=ev67 -mtune=ev67"
    BUILD64="${GCCTARGET}"
  ;;
  ${TARGET_SYSTEM_SPARC64_64})
    CLFS_TARGET="sparc64-unknown-linux-gnu"
    LINUX_ARCH=sparc64
    GCC_BUILD_FLAGS=""
    GLIBC_STEP_16_FLAGS="${GLIBC_STEP_16_FLAGS} libc_cv_sparc64_tls=yes"
    GCCTARGET="-mcpu=ultrasparc -mtune=ultrasparc"
    BUILD64="${GCCTARGET} -m64"
  ;;
  ${TARGET_SYSTEM_MIPS64_64})
    CLFS_TARGET="mips64el-unknown-linux-gnu" # little endian
    # CLFS_TARGET="mips64-unknown-linux-gnu" # big endian
    LINUX_ARCH=mips
    GCC_BUILD_FLAGS="--with-abi=64"
    GLIBC_STEP_16_FLAGS="${GLIBC_STEP_16_FLAGS} libc_cv_mips_tls=yes"
    GCCTARGET="-march=5kc -mtune=5kc" # or 20kc
    BUILD64="${GCCTARGET} -mabi=64"
  ;;
  *)
    echo "unknown target-system: arg1"
    exit 1
  ;;
esac

# =============================================================
# configure pathes
# =============================================================
SCRIPT_PATH=$(dirname $(readlink -f $0))
BUILD_ROOT=${SCRIPT_PATH}/clfs_cross_tools
FILES=${BUILD_ROOT}/files
CLFS=${BUILD_ROOT}/system/${TARGET_SYSTEM}
CLFS_LOG="${CLFS}/build_log"
CLFS_SOURCES=${CLFS}/sources
CLFS_TOOLS=${CLFS}/tools
CLFS_CROSS_TOOLS=${CLFS}/cross-tools
BUILD_CONFIG_LOG=${CLFS_LOG}/build.config

# =============================================================
# log script configuration
# =============================================================
set +h
PATH=/cross-tools/bin:$PATH
LC_ALL=POSIX
unset CFLAGS CXXFLAGS
export PATH LC_ALL

function die {
  echo "!!!ERROR!!! STEP=${STEP} sub-step=$1"
  exit $1
}

# die on laste error != 0
function die_on_error {
  if [ $? != 0 ]; then
    die $1 
  fi
}

function die_on_any_error {
  last_pipe_status=("${PIPESTATUS[@]}") # do not forget ()
  last_error=$?

  # echo "last_pipe_status: ${last_pipe_status[*]} "
  # echo "last_error: ${last_error} "
  # echo "last_pipe_status size: ${#last_pipe_status[@]}"

  for IX in ${!last_pipe_status[*]}
  do
    STATUS=${last_pipe_status[$IX]}
    # echo "last_pipe_status[$IX]: $STATUS"
    if [ "$STATUS" != "0" ]; then
      # echo ${last_pipe_status[*]}
      die $1 
    fi 
  done
}

# file not found die
function die_on_missing_file {
  if [ ! -f "$2" ]; then
    die $1
  fi
}

# directory not found die
function die_on_missing_directory {
  if [ ! -d "$2" ]; then
    die $1
  fi
}

function die_on_empty_var {
  if [ -z "$2" ]; then
    die $1
  fi
}

# extract package from files directory into build-source and change into the extracted directory
function prepare_source_package {
  PACKAGE=$1
  echo "PACKAGE: ${PACKAGE}"

  PACKAGE_FILE=$(find ${FILES} -name "${PACKAGE}")
  die_on_any_error 0
  die_on_missing_file 1 "${PACKAGE_FILE}"
  echo "PACKAGE_FILE: ${PACKAGE_FILE}"

  PACKAGE_DIR="$(tar tpf ${PACKAGE_FILE} | head -1 | sed -e 's/\/.*//')"
  die_on_any_error 2
  echo "PACKAGE_DIR: ${PACKAGE_DIR}"
  rm -rf ${PACKAGE_DIR}
  die_on_any_error 3
  die_on_empty_var 4 "${PACKAGE_DIR}"

  tar -xpf ${PACKAGE_FILE} -C ${CLFS_SOURCES}
  die_on_any_error 5
  
  PACKAGE_SOURCE=${CLFS_SOURCES}/${PACKAGE_DIR}
  cd ${PACKAGE_SOURCE}
  die_on_any_error 6

  STEP_PACKAGE_NAME="step_${STEP}_${PACKAGE_DIR}"
  echo "STEP_PACKAGE_NAME: ${STEP_PACKAGE_NAME}"

  STEP_LOG_DIR="${CLFS_LOG}/${STEP_PACKAGE_NAME}"
  echo "STEP_LOG_DIR: ${STEP_LOG_DIR}"

  mkdir -vp ${STEP_LOG_DIR}
  die_on_any_error 7
}

# deletes current build-source package
function remove_source_package {
  die_on_missing_directory 0 "${PACKAGE_SOURCE}"
  rm -rf ${PACKAGE_SOURCE}
  die_on_any_error 1
  unset PACKAGE
  unset PACKAGE_FILE
  unset PACKAGE_DIR
  unset PACKAGE_SOURCE
}

if [ -d "${CLFS_TOOLS}" ]; then
(sudo ln -svf ${CLFS_TOOLS} /)
fi

if [ -d "${CLFS_CROSS_TOOLS}" ]; then
(sudo ln -svf ${CLFS_CROSS_TOOLS} /)
fi

# =============================================================
# build steps
# =============================================================
for STEP in `seq $BEGIN_STEP $END_STEP`;
do
  case ${STEP} in
    0)
# -------------------------------------------
# download files
# -------------------------------------------
FILE_URLS=(
"http://ftp.clfs.org/pub/clfs/conglomeration/file/file-5.19.tar.gz"
"http://www.kernel.org/pub/linux/kernel/v3.0/linux-3.14.tar.xz"
"http://patches.clfs.org/3.0.0/SYSTEMD/patch-3.14.21.xz"
"http://ftp.gnu.org/gnu/m4/m4-1.4.17.tar.xz"
"http://ftp.gnu.org/gnu/ncurses/ncurses-5.9.tar.gz"
"http://patches.clfs.org/3.0.0/SYSTEMD/ncurses-5.9-bash_fix-1.patch"
"http://sourceforge.net/projects/pkgconfiglite/files/0.28-1/pkg-config-lite-0.28-1.tar.gz"
"http://ftp.gnu.org/gnu/gmp/gmp-6.0.0a.tar.xz"
"http://www.mpfr.org/mpfr-3.1.2/mpfr-3.1.2.tar.xz"
"http://patches.clfs.org/3.0.0/SYSTEMD/mpfr-3.1.2-fixes-4.patch"
"http://www.multiprecision.org/mpc/download/mpc-1.0.2.tar.gz"
"http://isl.gforge.inria.fr/isl-0.12.2.tar.lzma"
"http://www.bastoul.net/cloog/pages/download/cloog-0.18.2.tar.gz"
"http://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.bz2"
"ftp://gcc.gnu.org/pub/gcc/releases/gcc-4.8.3/gcc-4.8.3.tar.bz2"
"http://patches.clfs.org/3.0.0/SYSTEMD/gcc-4.8.3-branch_update-1.patch"
"http://patches.clfs.org/3.0.0/SYSTEMD/gcc-4.8.3-pure64_specs-1.patch"
"http://ftp.gnu.org/gnu/glibc/glibc-2.19.tar.xz"
)

for IX in ${!FILE_URLS[*]}
do
  FILE_URL=${FILE_URLS[$IX]}
  wget -N ${FILE_URL} -P ${FILES}/
  die_on_any_error ${IX}
done
#--------------------------------------------
    ;;
    1)
# -------------------------------------------
# create base directories
# -------------------------------------------
mkdir -pv ${BUILD_ROOT}
die_on_any_error 0
mkdir -pv ${FILES}
die_on_any_error 1
mkdir -pv ${CLFS}
die_on_any_error 2
mkdir -pv ${CLFS_LOG}
die_on_any_error 3

cat > ${BUILD_CONFIG_LOG} << EOF
# pathes
SCRIPT_PATH=${SCRIPT_PATH}
BUILD_ROOT=${BUILD_ROOT}
FILES=${FILES}
CLFS=${CLFS}
CLFS_SOURCES=${CLFS_SOURCES}
CLFS_TOOLS=${CLFS_TOOLS}
CLFS_CROSS_TOOLS=${CLFS_CROSS_TOOLS}
PATH=${PATH}
LC_ALL=${LC_ALL}
CFLAGS=${CFLAGS}
CXXFLAGS=${CXXFLAGS}
# target
TARGET_SYSTEM=${TARGET_SYSTEM}
CLFS_TARGET=${CLFS_TARGET}
LINUX_ARCH=${LINUX_ARCH}
BUILD64=${BUILD64}
GCCTARGET=${GCCTARGET}
EOF
# -------------------------------------------
    ;;
    2)
# -------------------------------------------
# 3.1. Introduction -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/materials/introduction.html
# -------------------------------------------
rm -vfr ${CLFS_SOURCES}
mkdir -v ${CLFS_SOURCES}
die_on_any_error 0
chmod -v a+wt ${CLFS_SOURCES}
die_on_any_error 1
# -------------------------------------------
    ;;
    3)
# -------------------------------------------
# 4.2. Creating the ${CLFS}/tools Directory -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/final-preps/creatingtoolsdir.html
# 4.3. Creating the ${CLFS}/tools Directory -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/final-preps/creatingtoolsdir.html
# -------------------------------------------
install -dv ${CLFS_TOOLS}
die_on_any_error 0
(sudo ln -svf ${CLFS_TOOLS} /)
die_on_any_error 1

install -dv ${CLFS_CROSS_TOOLS}
die_on_any_error 2
(sudo ln -svf ${CLFS_CROSS_TOOLS} /)
die_on_any_error 3
# -------------------------------------------
    ;;
    4)
# -------------------------------------------
# 5.2. File-5.19 -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/cross-tools/file.html
# -------------------------------------------
prepare_source_package file-5.19.tar.gz

BUILD_DIR="../${STEP_PACKAGE_NAME}-build"
rm -rf ${BUILD_DIR}
die_on_any_error 0
mkdir -vp ${BUILD_DIR}
die_on_any_error 1

cd ${BUILD_DIR}
die_on_any_error 2

../${PACKAGE_DIR}/configure --prefix=/cross-tools --disable-static 2>&1 | tee "${STEP_LOG_DIR}/configure.out"
die_on_any_error 3

cp -r ${BUILD_DIR} ${STEP_LOG_DIR}
die_on_any_error 4

make 2>&1 | tee "${STEP_LOG_DIR}/make.out"
die_on_any_error 5

make install 2>&1 | tee "${STEP_LOG_DIR}/make_install.out"
die_on_any_error 6

rm -rf ${BUILD_DIR}
die_on_any_error 7
 
remove_source_package
# -------------------------------------------
    ;;
    5)
# -------------------------------------------
# 5.3. Linux-3.14.21 Headers -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/cross-tools/linux-headers.html
# -------------------------------------------
prepare_source_package linux-3.14.tar.xz

xzcat "${FILES}/patch-3.14.21.xz" | patch -Np1 -i -
die_on_any_error 0

make mrproper 2>&1 | tee "${STEP_LOG_DIR}/make_mrproper.out"
die_on_any_error 1

make ARCH=${LINUX_ARCH} headers_check 2>&1 | tee "${STEP_LOG_DIR}/make_headers_check.out"
die_on_any_error 2

make ARCH=${LINUX_ARCH} INSTALL_HDR_PATH=/tools headers_install 2>&1 | tee "${STEP_LOG_DIR}/make_headers_install.out"
die_on_any_error 3

remove_source_package
# -------------------------------------------
    ;;
    6)
# -------------------------------------------
# 5.4. M4-1.4.17 -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/cross-tools/m4.html
# -------------------------------------------
prepare_source_package m4-1.4.17.tar.xz

BUILD_DIR="../${STEP_PACKAGE_NAME}-build"
rm -rf ${BUILD_DIR}
die_on_any_error 0
mkdir -vp ${BUILD_DIR}
die_on_any_error 1

cd ${BUILD_DIR}
die_on_any_error 2

../${PACKAGE_DIR}/configure --prefix=/cross-tools --disable-static 2>&1 | tee "${STEP_LOG_DIR}/configure.out"
die_on_any_error 3

cp -r ${BUILD_DIR} ${STEP_LOG_DIR}
die_on_any_error 4

make 2>&1 | tee "${STEP_LOG_DIR}/make.out"
die_on_any_error 5

make install 2>&1 | tee "${STEP_LOG_DIR}/make_install.out"
die_on_any_error 6

rm -rf ${BUILD_DIR}
die_on_any_error 7
 
remove_source_package
# -------------------------------------------
    ;;
    7)
# -------------------------------------------
# 5.5. Ncurses-5.9 -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/cross-tools/ncurses.html
# -------------------------------------------
prepare_source_package ncurses-5.9.tar.gz

patch -Np1 -i "${FILES}/ncurses-5.9-bash_fix-1.patch"
die_on_any_error 3

BUILD_DIR="../${STEP_PACKAGE_NAME}-build"
rm -rf ${BUILD_DIR}
die_on_any_error 0
mkdir -vp ${BUILD_DIR}
die_on_any_error 1

cd ${BUILD_DIR}
die_on_any_error 2

../${PACKAGE_DIR}/configure --prefix=/cross-tools --without-debug --without-shared 2>&1 | tee "${STEP_LOG_DIR}/configure.out"
die_on_any_error 4

cp -r ${BUILD_DIR} ${STEP_LOG_DIR}
die_on_any_error 5

make -C include 2>&1 | tee "${STEP_LOG_DIR}/make_c_include.out"
die_on_any_error 6

make -C progs tic 2>&1 | tee "${STEP_LOG_DIR}/make_c_progs_tic.out"
die_on_any_error 7

install -v -m755 progs/tic /cross-tools/bin
die_on_any_error 8

rm -rf ${BUILD_DIR}
die_on_any_error 9
 
remove_source_package
# -------------------------------------------
    ;;
    8)
# -------------------------------------------
# 5.6. Pkg-config-lite-0.28-1 -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/cross-tools/pkg-config-lite.html
# -------------------------------------------
prepare_source_package pkg-config-lite-0.28-1.tar.gz

BUILD_DIR="../${STEP_PACKAGE_NAME}-build"
rm -rf ${BUILD_DIR}
die_on_any_error 0
mkdir -vp ${BUILD_DIR}
die_on_any_error 1

cd ${BUILD_DIR}
die_on_any_error 2

../${PACKAGE_DIR}/configure --prefix=/cross-tools --host=${CLFS_TARGET} --with-pc-path=/tools/lib/pkgconfig:/tools/share/pkgconfig 2>&1 | tee "${STEP_LOG_DIR}/configure.out"
die_on_any_error 3

cp -r ${BUILD_DIR} ${STEP_LOG_DIR}
die_on_any_error 4

make 2>&1 | tee "${STEP_LOG_DIR}/make.out"
die_on_any_error 5

make install 2>&1 | tee "${STEP_LOG_DIR}/make_install.out"
die_on_any_error 6

rm -rf ${BUILD_DIR}
die_on_any_error 7
 
remove_source_package
# -------------------------------------------
    ;;
    9)
# -------------------------------------------
# 5.7. GMP-6.0.0 -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/cross-tools/gmp.html
# -------------------------------------------
prepare_source_package gmp-6.0.0a.tar.xz

BUILD_DIR="../${STEP_PACKAGE_NAME}-build"
rm -rf ${BUILD_DIR}
die_on_any_error 0
mkdir -vp ${BUILD_DIR}
die_on_any_error 1

cd ${BUILD_DIR}
die_on_any_error 2

../${PACKAGE_DIR}/configure --prefix=/cross-tools --enable-cxx ABI=64 --disable-static 2>&1 | tee "${STEP_LOG_DIR}/configure.out"
die_on_any_error 3

cp -r ${BUILD_DIR} ${STEP_LOG_DIR}
die_on_any_error 4

make 2>&1 | tee "${STEP_LOG_DIR}/make.out"
die_on_any_error 5

make install 2>&1 | tee "${STEP_LOG_DIR}/make_install.out"
die_on_any_error 6

rm -rf ${BUILD_DIR}
die_on_any_error 7
 
remove_source_package
# -------------------------------------------
    ;;
    10)
# -------------------------------------------
# 5.8. MPFR-3.1.2 -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/cross-tools/mpfr.html
# -------------------------------------------
prepare_source_package mpfr-3.1.2.tar.xz

patch -Np1 -i "${FILES}/mpfr-3.1.2-fixes-4.patch"
die_on_any_error 0

BUILD_DIR="../${STEP_PACKAGE_NAME}-build"
rm -rf ${BUILD_DIR}
die_on_any_error 1
mkdir -vp ${BUILD_DIR}
die_on_any_error 2

cd ${BUILD_DIR}
die_on_any_error 3

LDFLAGS="-Wl,-rpath,/cross-tools/lib" ../${PACKAGE_DIR}/configure --prefix=/cross-tools --disable-static --with-gmp=/cross-tools 2>&1 | tee "${STEP_LOG_DIR}/configure.out"
die_on_any_error 4

cp -r ${BUILD_DIR} ${STEP_LOG_DIR}
die_on_any_error 5

make 2>&1 | tee "${STEP_LOG_DIR}/make.out"
die_on_any_error 6

make install 2>&1 | tee "${STEP_LOG_DIR}/make_install.out"
die_on_any_error 7

rm -rf ${BUILD_DIR}
die_on_any_error 8
 
remove_source_package
# -------------------------------------------
    ;;
    11)
# -------------------------------------------
# 5.9. MPC-1.0.2 -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/cross-tools/mpc.html
# -------------------------------------------
prepare_source_package mpc-1.0.2.tar.gz

BUILD_DIR="../${STEP_PACKAGE_NAME}-build"
rm -rf ${BUILD_DIR}
die_on_any_error 0
mkdir -vp ${BUILD_DIR}
die_on_any_error 1

cd ${BUILD_DIR}
die_on_any_error 2

LDFLAGS="-Wl,-rpath,/cross-tools/lib" ../${PACKAGE_DIR}/configure --prefix=/cross-tools --disable-static --with-gmp=/cross-tools --with-mpfr=/cross-tools 2>&1 | tee "${STEP_LOG_DIR}/configure.out"
die_on_any_error 3

cp -r ${BUILD_DIR} ${STEP_LOG_DIR}
die_on_any_error 4

make 2>&1 | tee "${STEP_LOG_DIR}/make.out"
die_on_any_error 5

make install 2>&1 | tee "${STEP_LOG_DIR}/make_install.out"
die_on_any_error 6

rm -rf ${BUILD_DIR}
die_on_any_error 7
 
remove_source_package
# -------------------------------------------
    ;;
    12)
# -------------------------------------------
# 5.10. ISL-0.12.2 -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/cross-tools/isl.html
# -------------------------------------------
prepare_source_package isl-0.12.2.tar.lzma

BUILD_DIR="../${STEP_PACKAGE_NAME}-build"
rm -rf ${BUILD_DIR}
die_on_any_error 0
mkdir -vp ${BUILD_DIR}
die_on_any_error 1

cd ${BUILD_DIR}
die_on_any_error 2

LDFLAGS="-Wl,-rpath,/cross-tools/lib" ../${PACKAGE_DIR}/configure --prefix=/cross-tools --disable-static --with-gmp-prefix=/cross-tools 2>&1 | tee "${STEP_LOG_DIR}/configure.out"
die_on_any_error 3

cp -r ${BUILD_DIR} ${STEP_LOG_DIR}
die_on_any_error 4

make 2>&1 | tee "${STEP_LOG_DIR}/make.out"
die_on_any_error 5

make install 2>&1 | tee "${STEP_LOG_DIR}/make_install.out"
die_on_any_error 6

rm -rf ${BUILD_DIR}
die_on_any_error 7
 
remove_source_package
# -------------------------------------------
    ;;
    13)
# -------------------------------------------
# 5.11. CLooG-0.18.2 -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/cross-tools/cloog.html
# -------------------------------------------
prepare_source_package cloog-0.18.2.tar.gz

BUILD_DIR="../${STEP_PACKAGE_NAME}-build"
rm -rf ${BUILD_DIR}
die_on_any_error 0
mkdir -vp ${BUILD_DIR}
die_on_any_error 1

cd ${BUILD_DIR}
die_on_any_error 2

LDFLAGS="-Wl,-rpath,/cross-tools/lib" ../${PACKAGE_DIR}/configure --prefix=/cross-tools --disable-static --with-gmp-prefix=/cross-tools --with-isl-prefix=/cross-tools 2>&1 | tee "${STEP_LOG_DIR}/configure.out"
die_on_any_error 3

cp -v Makefile{,.orig}
die_on_any_error 4

sed '/cmake/d' Makefile.orig > Makefile
die_on_any_error 5 

cp -r ${BUILD_DIR} ${STEP_LOG_DIR}
die_on_any_error 6

make 2>&1 | tee "${STEP_LOG_DIR}/make.out"
die_on_any_error 7

make install 2>&1 | tee "${STEP_LOG_DIR}/make_install.out"
die_on_any_error 8

rm -rf ${BUILD_DIR}
die_on_any_error 9
 
remove_source_package
# -------------------------------------------
    ;;
    14)
# -------------------------------------------
# 5.12. Cross Binutils-2.24 -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/cross-tools/binutils.html
# -------------------------------------------
prepare_source_package binutils-2.24.tar.bz2

BUILD_DIR="../${STEP_PACKAGE_NAME}-build"
rm -rf ${BUILD_DIR}
die_on_any_error 0
mkdir -vp ${BUILD_DIR}
die_on_any_error 1

cd ${BUILD_DIR}
die_on_any_error 2

AR=ar AS=as ../${PACKAGE_DIR}/configure \
--prefix=/cross-tools --host=${CLFS_HOST} --target=${CLFS_TARGET} \
--with-sysroot=${CLFS} --with-lib-path=/tools/lib --disable-nls \
--disable-static --enable-64-bit-bfd --disable-multilib --disable-werror 2>&1 | tee "${STEP_LOG_DIR}/configure.out"
die_on_any_error 3

cp -r ${BUILD_DIR} ${STEP_LOG_DIR}
die_on_any_error 4

make 2>&1 | tee "${STEP_LOG_DIR}/make.out"
die_on_any_error 5

make install 2>&1 | tee "${STEP_LOG_DIR}/make_install.out"
die_on_any_error 6

"${CLFS_CROSS_TOOLS}/bin/${CLFS_TARGET}-ld" --verbose | grep SEARCH_DIR | tr -s ' ;' \\012 > "${STEP_LOG_DIR}/ld_SEARCHDIR.out"
die_on_any_error 7

rm -rf ${BUILD_DIR}
die_on_any_error 8
 
remove_source_package
# -------------------------------------------
    ;;
    15)
# -------------------------------------------
# 5.13. Cross GCC-4.8.3 - Static -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/cross-tools/gcc-static.html
# -------------------------------------------
prepare_source_package gcc-4.8.3.tar.bz2

patch -Np1 -i "${FILES}/gcc-4.8.3-branch_update-1.patch"
die_on_any_error 0

patch -Np1 -i "${FILES}/gcc-4.8.3-pure64_specs-1.patch"
die_on_any_error 1

echo -en '\n#undef STANDARD_STARTFILE_PREFIX_1\n#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"\n' >> gcc/config/linux.h
die_on_any_error 2
echo -en '\n#undef STANDARD_STARTFILE_PREFIX_2\n#define STANDARD_STARTFILE_PREFIX_2 ""\n' >> gcc/config/linux.h
die_on_any_error 3

touch /tools/include/limits.h
die_on_any_error 4

BUILD_DIR="../${STEP_PACKAGE_NAME}-build"
rm -rf ${BUILD_DIR}
die_on_any_error 5
mkdir -vp ${BUILD_DIR}
die_on_any_error 6

cd ${BUILD_DIR}
die_on_any_error 7

AR=ar LDFLAGS="-Wl,-rpath,/cross-tools/lib" \
../${PACKAGE_DIR}/configure --prefix=/cross-tools \
--build=${CLFS_HOST} --host=${CLFS_HOST} --target=${CLFS_TARGET} \
--with-sysroot=${CLFS} --with-local-prefix=/tools \
--with-native-system-header-dir=/tools/include --disable-nls \
--disable-shared --with-mpfr=/cross-tools --with-gmp=/cross-tools \
--with-isl=/cross-tools --with-cloog=/cross-tools --with-mpc=/cross-tools \
--without-headers --with-newlib --disable-decimal-float --disable-libgomp \
--disable-libmudflap --disable-libssp --disable-libatomic --disable-libitm \
--disable-libsanitizer --disable-libquadmath --disable-threads \
--disable-multilib --disable-target-zlib --with-system-zlib "${GCC_BUILD_FLAGS}" \
--enable-languages=c --enable-checking=release 2>&1 | tee "${STEP_LOG_DIR}/configure.out"
die_on_any_error 8

cp -r ${BUILD_DIR} ${STEP_LOG_DIR}
die_on_any_error 9

make all-gcc all-target-libgcc 2>&1 | tee "${STEP_LOG_DIR}/make_all_gcc_all_target_libgcc.out"
die_on_any_error 10

make install-gcc install-target-libgcc 2>&1 | tee "${STEP_LOG_DIR}/make_install_gcc_install_libgcc.out"
die_on_any_error 11

"${CLFS_CROSS_TOOLS}/bin/${CLFS_TARGET}-gcc" -print-search-dirs | sed '/^lib/b 1;d;:1;s,/[^/.][^/]*/\.\./,/,;t 1;s,:[^=]*=,:;,;s,;,;  ,g' | tr \; \\012 > "${STEP_LOG_DIR}/gcc_search_dirs.out"
die_on_any_error 12

cat "${STEP_LOG_DIR}/gcc_search_dirs.out" | sed -e $'s/:/\\\n/g' | sed 's/\/'"$TARGET_SYSTEM"'\//\/'{TARGET_SYSTEM}'\//g' | sed 's/'"$CLFS_TARGET"'/'{CLFS_TARGET}'/g'  > "${STEP_LOG_DIR}/gcc_search_dirs.diffable.out"

rm -rf ${BUILD_DIR}
die_on_any_error 13
 
remove_source_package
# -------------------------------------------
    ;;
    16)
# -------------------------------------------
# 5.14. Glibc-2.19 -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/cross-tools/glibc.html
# -------------------------------------------
prepare_source_package glibc-2.19.tar.xz

cp -v timezone/Makefile{,.orig}
die_on_any_error 0

sed 's/\\$$(pwd)/`pwd`/' timezone/Makefile.orig > timezone/Makefile
die_on_any_error 1

BUILD_DIR="../${STEP_PACKAGE_NAME}-build"
rm -rf ${BUILD_DIR}
die_on_any_error 2
mkdir -vp ${BUILD_DIR}
die_on_any_error 3

cd ${BUILD_DIR}
die_on_any_error 4

echo ${GLIBC_STEP_16_FLAGS} > "config.cache"
die_on_any_error 5

BUILD_CC="gcc" CC="${CLFS_TARGET}-gcc ${BUILD64}" \
AR="${CLFS_TARGET}-ar" RANLIB="${CLFS_TARGET}-ranlib" \
../${PACKAGE_DIR}/configure --prefix=/tools \
--host=${CLFS_TARGET} --build=${CLFS_HOST} \
--disable-profile --enable-kernel=2.6.32 \
--with-binutils=/cross-tools/bin --with-headers=/tools/include \
--enable-obsolete-rpc  --cache-file=config.cache 2>&1 | tee "${STEP_LOG_DIR}/configure.out"
die_on_any_error 6

cp -r ${BUILD_DIR} ${STEP_LOG_DIR}
die_on_any_error 7

make 2>&1 | tee "${STEP_LOG_DIR}/make.out"
die_on_any_error 8

make install 2>&1 | tee "${STEP_LOG_DIR}/make_install.out"
die_on_any_error 9

find "${CLFS}/tools/lib" -name "crt*.o" > "${STEP_LOG_DIR}/crt-path.out"

rm -rf ${BUILD_DIR}
die_on_any_error 10
 
remove_source_package
# -------------------------------------------
    ;;
    17)
# -------------------------------------------
# 5.15. Cross GCC-4.8.3 - Final -> http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/cross-tools/gcc-final.html
# -------------------------------------------
prepare_source_package gcc-4.8.3.tar.bz2

patch -Np1 -i "${FILES}/gcc-4.8.3-branch_update-1.patch"
die_on_any_error 0

patch -Np1 -i "${FILES}/gcc-4.8.3-pure64_specs-1.patch"
die_on_any_error 1

echo -en '\n#undef STANDARD_STARTFILE_PREFIX_1\n#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"\n' >> gcc/config/linux.h
die_on_any_error 2
echo -en '\n#undef STANDARD_STARTFILE_PREFIX_2\n#define STANDARD_STARTFILE_PREFIX_2 ""\n' >> gcc/config/linux.h
die_on_any_error 3

touch /tools/include/limits.h
die_on_any_error 4

BUILD_DIR="../${STEP_PACKAGE_NAME}-build"
rm -rf ${BUILD_DIR}
die_on_any_error 5
mkdir -vp ${BUILD_DIR}
die_on_any_error 6

cd ${BUILD_DIR}
die_on_any_error 7

AR=ar LDFLAGS="-Wl,-rpath,/cross-tools/lib" \
../${PACKAGE_DIR}/configure --prefix=/cross-tools \
--build=${CLFS_HOST} --target=${CLFS_TARGET} --host=${CLFS_HOST} \
--with-sysroot=${CLFS} --with-local-prefix=/tools \
--with-native-system-header-dir=/tools/include --disable-nls \
--disable-static --enable-languages=c,c++ \
--enable-__cxa_atexit --enable-threads=posix \
--disable-multilib --with-mpc=/cross-tools --with-mpfr=/cross-tools \
--with-gmp=/cross-tools --with-cloog=/cross-tools \
--with-isl=/cross-tools --with-system-zlib --enable-checking=release "${GCC_BUILD_FLAGS}" \
--enable-libstdcxx-time 2>&1 | tee "${STEP_LOG_DIR}/configure.out"
die_on_any_error 8

cp -r ${BUILD_DIR} ${STEP_LOG_DIR}
die_on_any_error 9

make AS_FOR_TARGET="${CLFS_TARGET}-as" \
LD_FOR_TARGET="${CLFS_TARGET}-ld" 2>&1 | tee "${STEP_LOG_DIR}/make.out"
die_on_any_error 10
make install 2>&1 | tee "${STEP_LOG_DIR}/make_install.out"
die_on_any_error 11

# make all-target-libstdc++-v3 2>&1 | tee "${STEP_LOG_DIR}/make_all_target_libstdc++-v3.out"
# die_on_error 12
# make install-target-libstdc++-v3 2>&1 | tee "${STEP_LOG_DIR}/make_install_libstdc++-v3.out"
# die_on_error 13

"${CLFS_CROSS_TOOLS}/bin/${CLFS_TARGET}-gcc" -print-search-dirs | sed '/^lib/b 1;d;:1;s,/[^/.][^/]*/\.\./,/,;t 1;s,:[^=]*=,:;,;s,;,;  ,g' | tr \; \\012 > "${STEP_LOG_DIR}/gcc_search_dirs.out"
die_on_any_error 14

cat "${STEP_LOG_DIR}/gcc_search_dirs.out" | sed -e $'s/:/\\\n/g' | sed 's/\/'"$TARGET_SYSTEM"'\//\/'{TARGET_SYSTEM}'\//g' | sed 's/'"$CLFS_TARGET"'/'{CLFS_TARGET}'/g'  > "${STEP_LOG_DIR}/gcc_search_dirs.diffable.out"

rm -rf ${BUILD_DIR}
die_on_any_error 15
 
remove_source_package
# -------------------------------------------
    ;;
  esac
done


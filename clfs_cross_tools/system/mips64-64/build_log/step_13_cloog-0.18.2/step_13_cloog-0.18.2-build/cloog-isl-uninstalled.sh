# generated by configure / remove this line to disable regeneration
prefix="/cross-tools"
exec_prefix="${prefix}"
bindir="${exec_prefix}/bin"
libdir="/home/bert/build_qemu_images/clfs_cross_tools/system/mips64-64/sources/step_13_cloog-0.18.2-build/.libs"
datarootdir="${prefix}/share"
datadir="${datarootdir}"
sysconfdir="${prefix}/etc"
includedir="/home/bert/build_qemu_images/clfs_cross_tools/system/mips64-64/sources/step_13_cloog-0.18.2-build/../cloog-0.18.2/include"
package="cloog-isl"
suffix=""

for option; do case "$option" in --list-all|--name) echo  "cloog-isl"
;; --help) pkg-config --help ; echo Buildscript Of "cloog-isl Library"
;; --modversion|--version) echo "0.18.2"
;; --requires) echo : ""
;; --libs) echo -L${libdir} "-L/cross-tools/lib -Wl,-rpath,/cross-tools/lib" "-lcloog-isl -lgmp"
       :
;; --cflags) echo -I${includedir} "-I/cross-tools/include -DCLOOG_INT_GMP=1"
       :
;; --variable=*) eval echo '$'`echo $option | sed -e 's/.*=//'`
;; --uninstalled) exit 0 
;; *) ;; esac done
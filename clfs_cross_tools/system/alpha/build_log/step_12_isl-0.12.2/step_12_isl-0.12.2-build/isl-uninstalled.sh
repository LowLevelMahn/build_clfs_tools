# generated by configure / remove this line to disable regeneration
prefix="/cross-tools"
exec_prefix="${prefix}"
bindir="${exec_prefix}/bin"
libdir="/home/bert/build_qemu_images/clfs_cross_tools/system/alpha/sources/step_12_isl-0.12.2-build/.libs"
datarootdir="${prefix}/share"
datadir="${datarootdir}"
sysconfdir="${prefix}/etc"
includedir="/home/bert/build_qemu_images/clfs_cross_tools/system/alpha/sources/step_12_isl-0.12.2-build/../isl-0.12.2/include"
package="isl"
suffix=""

for option; do case "$option" in --list-all|--name) echo  "isl"
;; --help) pkg-config --help ; echo Buildscript Of "isl Library"
;; --modversion|--version) echo "0.12.2"
;; --requires) echo : ""
;; --libs) echo -L${libdir} "-L/cross-tools/lib" "-lisl -lgmp"
       :
;; --cflags) echo -I${includedir} "-I/cross-tools/include"
       :
;; --variable=*) eval echo '$'`echo $option | sed -e 's/.*=//'`
;; --uninstalled) exit 0 
;; *) ;; esac done

This github-repo https://github.com/LowLevelMahn/build_clfs_tools contains the scripts, files AND complete build-logs (so no need to run the script yourself) 
separated for each step that i will use here as a "walkable" reference. I’ll try to keep the 
github readme.md up to date if somethings changes.

===================
Goal
===================

I want to add alpha dec support to the current stable Cross Linux From Scratch (CLFS clfs.org) 3.0 (which uses gcc 4.8.3 as source base)
CLFS 3.0 currently only supports x86/mips/sparc/arm/powerpc.
Using a ready-for-use-cross-development-toolkit is not an option for being CLFS conform.

===================
Work so far - the build-script
===================

I’ve written a bash script https://github.com/LowLevelMahn/build_clfs_tools/build_clfs_cross_tools.sh (for being homogen in building for the different targets) 
that is doing the CLFS "5. Constructing Cross-Compile Tools" chapter.

Its based on http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/sparc64-64/cross-tools/introduction.html and 
http://www.clfs.org/view/CLFS-3.0.0-SYSTEMD/mips64-64/cross-tools/introduction.html

I’ve got extra follow up scripts for building kernel, bash, hello world etc. but I haven’t included them here to keep the problem report smaller.

The script needs sudo to add /tools and /cross-tools symbolic links to the root - the CLFS gcc patches are directing to them - but thats all

The script checks for every possible error and exits with current step/substep info on any fail, it logs every ./configure, make, make install run
and creates some extra info files for searchdirs, paths etc.

Every package is built out of Source-Tree and freshly extracted/removed in every step.

The target configuration (build script line 35-70) is the only part of the script which is target specific.
The rest of the script only uses these variables, no target related ifs/switch-cases while configuring/building are present.

This is the essence of the script:

step( 4): 5.2.  File-5.19 
step( 5): 5.3.  Linux-3.14.21 Headers
step( 6): 5.4.  M4-1.4.17
step( 7): 5.5.  Ncurses-5.9
step( 8): 5.6.  Pkg-config-lite-0.28-1
step( 9): 5.7.  GMP-6.0.0
step(10): 5.8.  MPFR-3.1.2
step(11): 5.9.  MPC-1.0.2
step(12): 5.10. ISL-0.12.2
step(13): 5.11. CLooG-0.18.2
step(14): 5.12. Cross Binutils-2.24
step(15): 5.13. Cross GCC-4.8.3
step(16): 5.14. Glibc-2.19
step(17): 5.15. Cross GCC-4.8.3 <-- alpha fails here

build-logs: 
https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/system/alpha/build_log
https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/system/mips64-64/build_log
https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/system/sparc64-64/build_log

===================
what is working:
===================

Sparc64-64 and mips64-64 are working perfectly - I’m able to compile and run a linux kernel + bash + hello-world in sparc64/mips64-qemu
based on the built cross-tools.

===================
the problem:
===================

If building for alpha target the script fails in step(17) with linking crti.o
https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/system/alpha/build_log/step_17_gcc-4.8.3/make.out in line 3776

===================
My findings so far:
===================

The reason for the fail in step(17) is that the built gcc in step(15) got the wrong gcc search-dirs, whereas
sparc64-64/mips64-64 got the correct and equal gcc-search-dirs, but the alpha target differs in the last 4 paths.

Logged gcc search-dirs:

gcc_search_dirs.(diffable).out is generated in step(15) Cross GCC-4.8.3, build_clfs_cross_tools.sh, line: 723/726

better readable search-dirs
https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/system/alpha/build_log/step_15_gcc-4.8.3/gcc_search_dirs.out
https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/system/mips64-64/build_log/step_15_gcc-4.8.3/gcc_search_dirs.out
https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/system/sparc64-64/build_log/step_15_gcc-4.8.3/gcc_search_dirs.out

for being better diffable target replaced by {TARGET}, clfs_target replace by [CLFS_TARGET} etc.
https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/system/alpha/build_log/step_15_gcc-4.8.3/gcc_search_dirs.diffable.out
https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/system/mips64-64/build_log/step_15_gcc-4.8.3/gcc_search_dirs.diffable.out
https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/system/sparc64-64/build_log/step_15_gcc-4.8.3/gcc_search_dirs.diffable.out

logged c-runtime location:

-the crti.o is the same in all target-folders - that seems correct

crt-path.out is generated in step(16) Glibc-2.19, build_clfs_cross_tools.sh, line: 776
https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/system/alpha/build_log/step_16_glibc-2.19/crt-path.out
https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/system/mips64-64/build_log/step_16_glibc-2.19/crt-path.out
https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/system/sparc64-64/build_log/step_16_glibc-2.19/crt-path.out

logged ld SEARCHDIR:

the ld searchpath is the same "/tools/lib" for all targets - that seems correct

ld_SEARCHDIR.out is generated in step(14) Cross Binutils-2.24, build_clfs_cross_tools.sh, line: 626
https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/system/alpha/build_log/step_14_binutils-2.24/ld_SEARCHDIR.out
https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/system/mips64-64/build_log/step_14_binutils-2.24/ld_SEARCHDIR.out
https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/system/sparc64-64/build_log/step_14_binutils-2.24/ld_SEARCHDIR.out

the configure/make differences between the targets:

the mips64/sparc64/alpha Makefile/config.(status|log) for step(15) Cross GCC-4.8.3 are nearly equal for the targets
and it doesn't seem that the gcc-search-dirs difference comes from here

see folder https://github.com/LowLevelMahn/build_clfs_tools/step15_build_configure_logs_diffable
for being better diffable the target replaced by {TARGET}, the clfs_target replace by [CLFS_TARGET} etc. so its easier to diff localy with the prefered tool

===================
My suspicions so far : 
===================

First idea: The also alpha targeting (but not supported) CLFS gcc patching does not "change" enough for alpha

https://github.com/LowLevelMahn/build_clfs_tools/clfs_cross_tools/files/gcc-4.8.3-pure64_specs-1.patch

in step(15) Cross GCC-4.8.3, build_clfs_cross_tools.sh
line 680:
patch -Np1 -i "${FILES}/gcc-4.8.3-pure64_specs-1.patch" 
line 683:
echo -en '/n#undef STANDARD_STARTFILE_PREFIX_1/n#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"/n' >> gcc/config/linux.h
line 685:
echo -en '/n#undef STANDARD_STARTFILE_PREFIX_2/n#define STANDARD_STARTFILE_PREFIX_2 ""/n' >> gcc/config/linux.h

The patching only changes files in /gcc/config

I've copyied the original and patched /gcc/config tree into the https://github.com/LowLevelMahn/build_clfs_tools/gcc-4.8.3.patch.files folder - so its easier to diff localy with the prefered tool

Second and better idea: 

i think gcc ./configure does not treat the parameters --prefix=/cross-tools and --with-local-prefix=/tools in step(15) Cross GCC-4.8.3, the same way for alpha as for mips/sparc targets
because the CLFS gcc patch does not patch /cross-tools into the sources at all so /cross-tools from the gcc-search-dirs must come through gcc configure parameters - but are just partialy missing with target alpha

so mips/sparc respecting --prefix=/cross-tools, but alpha only partialy - seems to be a bug in gcc/configuration

===================

Any idea/hint where/how to find/correct the gcc-search-dirs differences for the alpha target to be CLFS conform and buildable?

Thanks,

Dennis


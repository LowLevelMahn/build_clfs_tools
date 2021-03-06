# $Id: Makefile.in,v 1.108 2010/11/28 16:39:40 tom Exp $
##############################################################################
# Copyright (c) 1998-2008,2010 Free Software Foundation, Inc.                #
#                                                                            #
# Permission is hereby granted, free of charge, to any person obtaining a    #
# copy of this software and associated documentation files (the "Software"), #
# to deal in the Software without restriction, including without limitation  #
# the rights to use, copy, modify, merge, publish, distribute, distribute    #
# with modifications, sublicense, and/or sell copies of the Software, and to #
# permit persons to whom the Software is furnished to do so, subject to the  #
# following conditions:                                                      #
#                                                                            #
# The above copyright notice and this permission notice shall be included in #
# all copies or substantial portions of the Software.                        #
#                                                                            #
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR #
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,   #
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL    #
# THE ABOVE COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      #
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING    #
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER        #
# DEALINGS IN THE SOFTWARE.                                                  #
#                                                                            #
# Except as contained in this notice, the name(s) of the above copyright     #
# holders shall not be used in advertising or otherwise to promote the sale, #
# use or other dealings in this Software without prior written               #
# authorization.                                                             #
##############################################################################
#
# Author: Thomas E. Dickey 1996-on
#
# Makefile for ncurses tests.

# turn off _all_ suffix rules; we'll generate our own
.SUFFIXES:

SHELL		= /bin/sh
VPATH		= ../../ncurses-5.9/test



destdir		=
x		= 
o		= .o

MODEL		= ../objects
srcdir		= ../../ncurses-5.9/test
prefix		= /cross-tools
exec_prefix	= ${prefix}
bindir		= ${exec_prefix}/bin
libdir		= ${exec_prefix}/lib
includedir	= ${prefix}/include/ncurses

BINDIR		= $(DESTDIR)$(bindir)
LIBDIR		= $(DESTDIR)$(libdir)
INCLUDEDIR	= $(DESTDIR)$(includedir)

LIBTOOL		= 
LIBTOOL_CLEAN	= 
LIBTOOL_COMPILE	= 
LIBTOOL_LINK	= ${CC}

INSTALL		= /usr/bin/install -c
INSTALL_PROG	= ${INSTALL}
transform	= s,x,x,
TRANSFORM	= sed 's/$x$$//'|sed '$(transform)'|sed 's/$$/$x/'

CTAGS		= 
ETAGS		= 

CC		= gcc
CPP		= gcc -E

CFLAGS		= -O2 --param max-inline-insns-single=1200 
CPPFLAGS	= -I. -I$(srcdir) -I../test -DHAVE_CONFIG_H  -D_GNU_SOURCE -DNDEBUG -I. -I../include -I${srcdir}/../include -I${includedir}

CCFLAGS		= $(CPPFLAGS) $(CFLAGS)

CFLAGS_LIBTOOL	= $(CCFLAGS)
CFLAGS_NORMAL	= $(CCFLAGS)
CFLAGS_DEBUG	= $(CCFLAGS) -g -DTRACE
CFLAGS_PROFILE	= $(CCFLAGS) -pg
CFLAGS_SHARED	= $(CCFLAGS) -fPIC

CFLAGS_DEFAULT	= $(CFLAGS_NORMAL)

REL_VERSION	= 5.9
ABI_VERSION	= 5
LOCAL_LIBDIR	= /home/bert/build_qemu_images/clfs_cross_tools/system/sparc64-64/sources/step_7_ncurses-5.9-build/lib
LOCAL_LIBS	= ../lib/libform.a ../lib/libmenu.a ../lib/libpanel.a ../lib/libncurses.a 
MATH_LIB	= -lm
TEST_LIBS	= -lutil 

LD		= ld
LINK		=  $(LIBTOOL_LINK) $(CFLAGS)

LDFLAGS		=   

LDFLAGS_LIBTOOL	= $(LDFLAGS) $(CFLAGS_LIBTOOL)
LDFLAGS_NORMAL	= $(LDFLAGS) $(CFLAGS_NORMAL)
LDFLAGS_DEBUG	= $(LDFLAGS) $(CFLAGS_DEBUG)
LDFLAGS_PROFILE	= $(LDFLAGS) $(CFLAGS_PROFILE)
LDFLAGS_SHARED	= $(LDFLAGS) $(CFLAGS_SHARED) 

TEST_ARGS	= -static -L../lib -lform -lmenu -lpanel -lncurses  -dynamic 

# use these for linking with all of the libraries
LIBS_DEFAULT	= $(TEST_ARGS)  $(TEST_LIBS) $(MATH_LIB)
LDFLAGS_DEFAULT	= $(LDFLAGS_NORMAL) $(LIBS_DEFAULT)

# use these for linking with the (n)curses library and possibly pthreads
LIBS_THREADS	= `echo "$(TEST_ARGS) " | sed -e 's/-lform.*-lpanel[^ ]*//'` $(TEST_LIBS) $(MATH_LIB) 
LDFLAGS_THREADS	= $(LDFLAGS_NORMAL) $(LIBS_THREADS)

# use these for linking with the (n)curses library
LIBS_CURSES	= `echo "$(TEST_ARGS) " | sed -e 's/-lform.*-lpanel[^ ]*//'` $(TEST_LIBS) $(MATH_LIB)
LDFLAGS_CURSES	= $(LDFLAGS_NORMAL) $(LIBS_CURSES)

# use these for linking with the tinfo library if we have it, or curses library if not
LIBS_TINFO	= -static -L../lib -lncurses -dynamic  $(TEST_LIBS) $(MATH_LIB)
LDFLAGS_TINFO	= $(LDFLAGS_NORMAL) $(LIBS_TINFO)

LINT		= 
LINT_OPTS	= 
LINT_LIBS	= -lform -lmenu -lpanel -lncurses 

HEADER_DEPS	= \
	../include/curses.h \
	../include/term.h

# The rest is generated from the "programs" and "modules" files...
# generated by mk-test.awk

TESTS	= $(destdir)background$x \
	  $(destdir)blue$x \
	  $(destdir)bs$x \
	  $(destdir)cardfile$x \
	  $(destdir)chgat$x \
	  $(destdir)clip_printw$x \
	  $(destdir)color_set$x \
	  $(destdir)demo_altkeys$x \
	  $(destdir)demo_defkey$x \
	  $(destdir)demo_forms$x \
	  $(destdir)demo_keyok$x \
	  $(destdir)demo_menus$x \
	  $(destdir)demo_panels$x \
	  $(destdir)demo_termcap$x \
	  $(destdir)demo_terminfo$x \
	  $(destdir)ditto$x \
	  $(destdir)dots$x \
	  $(destdir)dots_mvcur$x \
	  $(destdir)echochar$x \
	  $(destdir)filter$x \
	  $(destdir)firework$x \
	  $(destdir)firstlast$x \
	  $(destdir)foldkeys$x \
	  $(destdir)gdc$x \
	  $(destdir)hanoi$x \
	  $(destdir)hashtest$x \
	  $(destdir)inch_wide$x \
	  $(destdir)inchs$x \
	  $(destdir)ins_wide$x \
	  $(destdir)insdelln$x \
	  $(destdir)inserts$x \
	  $(destdir)key_names$x \
	  $(destdir)keynames$x \
	  $(destdir)knight$x \
	  $(destdir)lrtest$x \
	  $(destdir)movewindow$x \
	  $(destdir)ncurses$x \
	  $(destdir)newdemo$x \
	  $(destdir)railroad$x \
	  $(destdir)rain$x \
	  $(destdir)redraw$x \
	  $(destdir)savescreen$x \
	  $(destdir)tclock$x \
	  $(destdir)test_add_wchstr$x \
	  $(destdir)test_addchstr$x \
	  $(destdir)test_addstr$x \
	  $(destdir)test_addwstr$x \
	  $(destdir)test_arrays$x \
	  $(destdir)test_get_wstr$x \
	  $(destdir)test_getstr$x \
	  $(destdir)test_instr$x \
	  $(destdir)test_inwstr$x \
	  $(destdir)test_opaque$x \
	  $(destdir)testaddch$x \
	  $(destdir)testcurs$x \
	  $(destdir)testscanw$x \
	  $(destdir)view$x \
	  $(destdir)worm$x \
	  $(destdir)xmas$x

all: $(TESTS)

sources:

tags:
	$(CTAGS) *.[ch]

# no libraries here
libs \
install.libs \
uninstall.libs:

install \
install.test \
uninstall \
uninstall.test:

mostlyclean ::
	-rm -f core tags TAGS *~ *.bak *.i *.ln *.atac trace

clean :: mostlyclean
	-$(SHELL) -c "if test -n '$x' ; then $(MAKE) clean x=''; fi"
	-rm -rf *$o screendump *.lis $(TESTS) .libs

distclean :: clean
	-rm -f Makefile ncurses_cfg.h config.status config.log

realclean :: distclean

lint:
	$(SHELL) -c 'for N in $(TESTS); do echo LINT:$$N; $(LINT) $(LINT_OPTS) $(CPPFLAGS) $(srcdir)/$$N.c $(LINT_LIBS); done'
$(BINDIR) :
	mkdir -p $@

$(destdir)background$x: $(MODEL)/background$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/background$o $(LDFLAGS_CURSES)

$(destdir)blue$x: $(MODEL)/blue$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/blue$o $(LDFLAGS_CURSES)

$(destdir)bs$x: $(MODEL)/bs$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/bs$o $(LDFLAGS_CURSES)

$(destdir)cardfile$x: $(MODEL)/cardfile$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/cardfile$o $(LDFLAGS_DEFAULT)

$(destdir)chgat$x: $(MODEL)/chgat$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/chgat$o $(LDFLAGS_CURSES)

$(destdir)clip_printw$x: $(MODEL)/clip_printw$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/clip_printw$o $(LDFLAGS_CURSES)

$(destdir)color_set$x: $(MODEL)/color_set$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/color_set$o $(LDFLAGS_CURSES)

$(destdir)demo_altkeys$x: $(MODEL)/demo_altkeys$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/demo_altkeys$o $(LDFLAGS_CURSES)

$(destdir)demo_defkey$x: $(MODEL)/demo_defkey$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/demo_defkey$o $(LDFLAGS_CURSES)

$(destdir)demo_forms$x: $(MODEL)/demo_forms$o $(MODEL)/edit_field$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/demo_forms$o $(MODEL)/edit_field$o $(LDFLAGS_DEFAULT)

$(destdir)demo_keyok$x: $(MODEL)/demo_keyok$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/demo_keyok$o $(LDFLAGS_CURSES)

$(destdir)demo_menus$x: $(MODEL)/demo_menus$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/demo_menus$o $(LDFLAGS_DEFAULT)

$(destdir)demo_panels$x: $(MODEL)/demo_panels$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/demo_panels$o $(LDFLAGS_DEFAULT)

$(destdir)demo_termcap$x: $(MODEL)/demo_termcap$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/demo_termcap$o $(LDFLAGS_TINFO)

$(destdir)demo_terminfo$x: $(MODEL)/demo_terminfo$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/demo_terminfo$o $(LDFLAGS_TINFO)

$(destdir)ditto$x: $(MODEL)/ditto$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/ditto$o $(LDFLAGS_THREADS)

$(destdir)dots$x: $(MODEL)/dots$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/dots$o $(LDFLAGS_TINFO)

$(destdir)dots_mvcur$x: $(MODEL)/dots_mvcur$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/dots_mvcur$o $(LDFLAGS_CURSES)

$(destdir)echochar$x: $(MODEL)/echochar$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/echochar$o $(LDFLAGS_CURSES)

$(destdir)filter$x: $(MODEL)/filter$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/filter$o $(LDFLAGS_CURSES)

$(destdir)firework$x: $(MODEL)/firework$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/firework$o $(LDFLAGS_CURSES)

$(destdir)firstlast$x: $(MODEL)/firstlast$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/firstlast$o $(LDFLAGS_DEFAULT)

$(destdir)foldkeys$x: $(MODEL)/foldkeys$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/foldkeys$o $(LDFLAGS_CURSES)

$(destdir)gdc$x: $(MODEL)/gdc$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/gdc$o $(LDFLAGS_CURSES)

$(destdir)hanoi$x: $(MODEL)/hanoi$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/hanoi$o $(LDFLAGS_CURSES)

$(destdir)hashtest$x: $(MODEL)/hashtest$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/hashtest$o $(LDFLAGS_CURSES)

$(destdir)inch_wide$x: $(MODEL)/inch_wide$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/inch_wide$o $(LDFLAGS_CURSES)

$(destdir)inchs$x: $(MODEL)/inchs$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/inchs$o $(LDFLAGS_CURSES)

$(destdir)ins_wide$x: $(MODEL)/ins_wide$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/ins_wide$o $(LDFLAGS_CURSES)

$(destdir)insdelln$x: $(MODEL)/insdelln$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/insdelln$o $(LDFLAGS_CURSES)

$(destdir)inserts$x: $(MODEL)/inserts$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/inserts$o $(LDFLAGS_CURSES)

$(destdir)key_names$x: $(MODEL)/key_names$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/key_names$o $(LDFLAGS_CURSES)

$(destdir)keynames$x: $(MODEL)/keynames$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/keynames$o $(LDFLAGS_CURSES)

$(destdir)knight$x: $(MODEL)/knight$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/knight$o $(LDFLAGS_CURSES)

$(destdir)lrtest$x: $(MODEL)/lrtest$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/lrtest$o $(LDFLAGS_CURSES)

$(destdir)movewindow$x: $(MODEL)/movewindow$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/movewindow$o $(LDFLAGS_CURSES)

$(destdir)ncurses$x: $(MODEL)/ncurses$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/ncurses$o $(LDFLAGS_DEFAULT)

$(destdir)newdemo$x: $(MODEL)/newdemo$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/newdemo$o $(LDFLAGS_CURSES)

$(destdir)railroad$x: $(MODEL)/railroad$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/railroad$o $(LDFLAGS_TINFO)

$(destdir)rain$x: $(MODEL)/rain$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/rain$o $(LDFLAGS_THREADS)

$(destdir)redraw$x: $(MODEL)/redraw$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/redraw$o $(LDFLAGS_CURSES)

$(destdir)savescreen$x: $(MODEL)/savescreen$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/savescreen$o $(LDFLAGS_CURSES)

$(destdir)tclock$x: $(MODEL)/tclock$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/tclock$o $(LDFLAGS_CURSES)

$(destdir)test_add_wchstr$x: $(MODEL)/test_add_wchstr$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/test_add_wchstr$o $(LDFLAGS_CURSES)

$(destdir)test_addchstr$x: $(MODEL)/test_addchstr$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/test_addchstr$o $(LDFLAGS_CURSES)

$(destdir)test_addstr$x: $(MODEL)/test_addstr$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/test_addstr$o $(LDFLAGS_CURSES)

$(destdir)test_addwstr$x: $(MODEL)/test_addwstr$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/test_addwstr$o $(LDFLAGS_CURSES)

$(destdir)test_arrays$x: $(MODEL)/test_arrays$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/test_arrays$o $(LDFLAGS_TINFO)

$(destdir)test_get_wstr$x: $(MODEL)/test_get_wstr$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/test_get_wstr$o $(LDFLAGS_CURSES)

$(destdir)test_getstr$x: $(MODEL)/test_getstr$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/test_getstr$o $(LDFLAGS_CURSES)

$(destdir)test_instr$x: $(MODEL)/test_instr$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/test_instr$o $(LDFLAGS_CURSES)

$(destdir)test_inwstr$x: $(MODEL)/test_inwstr$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/test_inwstr$o $(LDFLAGS_CURSES)

$(destdir)test_opaque$x: $(MODEL)/test_opaque$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/test_opaque$o $(LDFLAGS_CURSES)

$(destdir)testaddch$x: $(MODEL)/testaddch$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/testaddch$o $(LDFLAGS_CURSES)

$(destdir)testcurs$x: $(MODEL)/testcurs$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/testcurs$o $(LDFLAGS_CURSES)

$(destdir)testscanw$x: $(MODEL)/testscanw$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/testscanw$o $(LDFLAGS_CURSES)

$(destdir)view$x: $(MODEL)/view$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/view$o $(LDFLAGS_CURSES)

$(destdir)worm$x: $(MODEL)/worm$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/worm$o $(LDFLAGS_THREADS)

$(destdir)xmas$x: $(MODEL)/xmas$o $(LOCAL_LIBS)
	$(LINK) -o $@ $(MODEL)/xmas$o $(LDFLAGS_CURSES)

# generated by mk-0th.awk
#   libname:    test
#   subsets:    ticlib+termlib+ext_tinfo+base+ext_funcs

.SUFFIXES: .c .cc .h .i .ii
.c.i :
	$(CPP) $(CPPFLAGS) $< >$@
.cc.ii :
	$(CPP) $(CPPFLAGS) $< >$@
.h.i :
	$(CPP) $(CPPFLAGS) $< >$@

C_SRC = \
	$(srcdir)/background.c \
	$(srcdir)/blue.c \
	$(srcdir)/bs.c \
	$(srcdir)/cardfile.c \
	$(srcdir)/chgat.c \
	$(srcdir)/clip_printw.c \
	$(srcdir)/color_set.c \
	$(srcdir)/demo_altkeys.c \
	$(srcdir)/demo_defkey.c \
	$(srcdir)/demo_forms.c \
	$(srcdir)/demo_keyok.c \
	$(srcdir)/demo_menus.c \
	$(srcdir)/demo_panels.c \
	$(srcdir)/demo_termcap.c \
	$(srcdir)/demo_terminfo.c \
	$(srcdir)/ditto.c \
	$(srcdir)/dots.c \
	$(srcdir)/dots_mvcur.c \
	$(srcdir)/echochar.c \
	$(srcdir)/edit_field.c \
	$(srcdir)/filter.c \
	$(srcdir)/firework.c \
	$(srcdir)/firstlast.c \
	$(srcdir)/foldkeys.c \
	$(srcdir)/gdc.c \
	$(srcdir)/hanoi.c \
	$(srcdir)/hashtest.c \
	$(srcdir)/inch_wide.c \
	$(srcdir)/inchs.c \
	$(srcdir)/ins_wide.c \
	$(srcdir)/insdelln.c \
	$(srcdir)/inserts.c \
	$(srcdir)/key_names.c \
	$(srcdir)/keynames.c \
	$(srcdir)/knight.c \
	$(srcdir)/lrtest.c \
	$(srcdir)/movewindow.c \
	$(srcdir)/ncurses.c \
	$(srcdir)/newdemo.c \
	$(srcdir)/railroad.c \
	$(srcdir)/rain.c \
	$(srcdir)/redraw.c \
	$(srcdir)/savescreen.c \
	$(srcdir)/tclock.c \
	$(srcdir)/test_add_wchstr.c \
	$(srcdir)/test_addchstr.c \
	$(srcdir)/test_addstr.c \
	$(srcdir)/test_addwstr.c \
	$(srcdir)/test_arrays.c \
	$(srcdir)/test_get_wstr.c \
	$(srcdir)/test_getstr.c \
	$(srcdir)/test_instr.c \
	$(srcdir)/test_inwstr.c \
	$(srcdir)/test_opaque.c \
	$(srcdir)/testaddch.c \
	$(srcdir)/testcurs.c \
	$(srcdir)/testscanw.c \
	$(srcdir)/view.c \
	$(srcdir)/worm.c \
	$(srcdir)/xmas.c

lintlib :
	@echo no action needed

# generated by mk-1st.awk (subset=ticlib+termlib+ext_tinfo+base+ext_funcs)
#  name:          test
#  traces:        DEBUG
#  MODEL:         NORMAL
#  model:         objects
#  prefix:        lib
#  suffix:        .a
#  subset:        ticlib+termlib+ext_tinfo+base+ext_funcs
#  ShlibVer:      rel
#  ShlibVerInfix: no
#  SymLink:       ln -s -f
#  TermlibRoot:   ncurses
#  TermlibSuffix: .a
#  ReLink:        no
#  DoLinks:       yes
#  rmSoLocs:      no
#  ldconfig:      /sbin/ldconfig
#  overwrite:     no
#  depend:        ../include/ncurses_cfg.h ${srcdir}/test.priv.h
#  host:          x86_64-unknown-linux-gnu

NORMAL_OBJS = \
	../objects/background$o \
	../objects/blue$o \
	../objects/bs$o \
	../objects/cardfile$o \
	../objects/chgat$o \
	../objects/clip_printw$o \
	../objects/color_set$o \
	../objects/demo_altkeys$o \
	../objects/demo_defkey$o \
	../objects/demo_forms$o \
	../objects/demo_keyok$o \
	../objects/demo_menus$o \
	../objects/demo_panels$o \
	../objects/demo_termcap$o \
	../objects/demo_terminfo$o \
	../objects/ditto$o \
	../objects/dots$o \
	../objects/dots_mvcur$o \
	../objects/echochar$o \
	../objects/edit_field$o \
	../objects/filter$o \
	../objects/firework$o \
	../objects/firstlast$o \
	../objects/foldkeys$o \
	../objects/gdc$o \
	../objects/hanoi$o \
	../objects/hashtest$o \
	../objects/inch_wide$o \
	../objects/inchs$o \
	../objects/ins_wide$o \
	../objects/insdelln$o \
	../objects/inserts$o \
	../objects/key_names$o \
	../objects/keynames$o \
	../objects/knight$o \
	../objects/lrtest$o \
	../objects/movewindow$o \
	../objects/ncurses$o \
	../objects/newdemo$o \
	../objects/railroad$o \
	../objects/rain$o \
	../objects/redraw$o \
	../objects/savescreen$o \
	../objects/tclock$o \
	../objects/test_add_wchstr$o \
	../objects/test_addchstr$o \
	../objects/test_addstr$o \
	../objects/test_addwstr$o \
	../objects/test_arrays$o \
	../objects/test_get_wstr$o \
	../objects/test_getstr$o \
	../objects/test_instr$o \
	../objects/test_inwstr$o \
	../objects/test_opaque$o \
	../objects/testaddch$o \
	../objects/testcurs$o \
	../objects/testscanw$o \
	../objects/view$o \
	../objects/worm$o \
	../objects/xmas$o

$(NORMAL_OBJS) : ../include/ncurses_cfg.h ${srcdir}/test.priv.h

mostlyclean::
	-rm -f $(NORMAL_OBJS)

clean ::
	-rm -f $(NORMAL_OBJS)

# generated by mk-2nd.awk
#   model:      objects
#   MODEL:      NORMAL
#   echo:       yes
#   subset:     ticlib+termlib+ext_tinfo+base+ext_funcs
#   crenames:   yes
#   cxxrenames: yes
#   traces:     DEBUG
#   srcdir:     ../ncurses-5.9

../objects/background$o :	$(srcdir)/background.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/background.c -o ../objects/background$o

../objects/blue$o :	$(srcdir)/blue.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/blue.c -o ../objects/blue$o

../objects/bs$o :	$(srcdir)/bs.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/bs.c -o ../objects/bs$o

../objects/cardfile$o :	$(srcdir)/cardfile.c \
			$(HEADER_DEPS) \
			../include/panel.h \
			../include/form.h
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/cardfile.c -o ../objects/cardfile$o

../objects/chgat$o :	$(srcdir)/chgat.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/chgat.c -o ../objects/chgat$o

../objects/clip_printw$o :	$(srcdir)/clip_printw.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/clip_printw.c -o ../objects/clip_printw$o

../objects/color_set$o :	$(srcdir)/color_set.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/color_set.c -o ../objects/color_set$o

../objects/demo_altkeys$o :	$(srcdir)/demo_altkeys.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/demo_altkeys.c -o ../objects/demo_altkeys$o

../objects/demo_defkey$o :	$(srcdir)/demo_defkey.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/demo_defkey.c -o ../objects/demo_defkey$o

../objects/demo_forms$o :	$(srcdir)/demo_forms.c \
			$(HEADER_DEPS) \
			$(srcdir)/edit_field.h
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/demo_forms.c -o ../objects/demo_forms$o

../objects/demo_keyok$o :	$(srcdir)/demo_keyok.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/demo_keyok.c -o ../objects/demo_keyok$o

../objects/demo_menus$o :	$(srcdir)/demo_menus.c \
			$(HEADER_DEPS) \
			../include/menu.h
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/demo_menus.c -o ../objects/demo_menus$o

../objects/demo_panels$o :	$(srcdir)/demo_panels.c \
			$(HEADER_DEPS) \
			../include/panel.h
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/demo_panels.c -o ../objects/demo_panels$o

../objects/demo_termcap$o :	$(srcdir)/demo_termcap.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/demo_termcap.c -o ../objects/demo_termcap$o

../objects/demo_terminfo$o :	$(srcdir)/demo_terminfo.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/demo_terminfo.c -o ../objects/demo_terminfo$o

../objects/ditto$o :	$(srcdir)/ditto.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/ditto.c -o ../objects/ditto$o

../objects/dots$o :	$(srcdir)/dots.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/dots.c -o ../objects/dots$o

../objects/dots_mvcur$o :	$(srcdir)/dots_mvcur.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/dots_mvcur.c -o ../objects/dots_mvcur$o

../objects/echochar$o :	$(srcdir)/echochar.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/echochar.c -o ../objects/echochar$o

../objects/edit_field$o :	$(srcdir)/edit_field.c \
			$(HEADER_DEPS) \
			$(srcdir)/edit_field.h
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/edit_field.c -o ../objects/edit_field$o

../objects/filter$o :	$(srcdir)/filter.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/filter.c -o ../objects/filter$o

../objects/firework$o :	$(srcdir)/firework.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/firework.c -o ../objects/firework$o

../objects/firstlast$o :	$(srcdir)/firstlast.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/firstlast.c -o ../objects/firstlast$o

../objects/foldkeys$o :	$(srcdir)/foldkeys.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/foldkeys.c -o ../objects/foldkeys$o

../objects/gdc$o :	$(srcdir)/gdc.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/gdc.c -o ../objects/gdc$o

../objects/hanoi$o :	$(srcdir)/hanoi.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/hanoi.c -o ../objects/hanoi$o

../objects/hashtest$o :	$(srcdir)/hashtest.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/hashtest.c -o ../objects/hashtest$o

../objects/inch_wide$o :	$(srcdir)/inch_wide.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/inch_wide.c -o ../objects/inch_wide$o

../objects/inchs$o :	$(srcdir)/inchs.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/inchs.c -o ../objects/inchs$o

../objects/ins_wide$o :	$(srcdir)/ins_wide.c \
			$(HEADER_DEPS) \
			$(srcdir)/linedata.h
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/ins_wide.c -o ../objects/ins_wide$o

../objects/insdelln$o :	$(srcdir)/insdelln.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/insdelln.c -o ../objects/insdelln$o

../objects/inserts$o :	$(srcdir)/inserts.c \
			$(HEADER_DEPS) \
			$(srcdir)/linedata.h
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/inserts.c -o ../objects/inserts$o

../objects/key_names$o :	$(srcdir)/key_names.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/key_names.c -o ../objects/key_names$o

../objects/keynames$o :	$(srcdir)/keynames.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/keynames.c -o ../objects/keynames$o

../objects/knight$o :	$(srcdir)/knight.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/knight.c -o ../objects/knight$o

../objects/lrtest$o :	$(srcdir)/lrtest.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/lrtest.c -o ../objects/lrtest$o

../objects/movewindow$o :	$(srcdir)/movewindow.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/movewindow.c -o ../objects/movewindow$o

../objects/ncurses$o :	$(srcdir)/ncurses.c \
			$(HEADER_DEPS) \
			../include/panel.h \
			../include/menu.h \
			../include/form.h
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/ncurses.c -o ../objects/ncurses$o

../objects/newdemo$o :	$(srcdir)/newdemo.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/newdemo.c -o ../objects/newdemo$o

../objects/railroad$o :	$(srcdir)/railroad.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/railroad.c -o ../objects/railroad$o

../objects/rain$o :	$(srcdir)/rain.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/rain.c -o ../objects/rain$o

../objects/redraw$o :	$(srcdir)/redraw.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/redraw.c -o ../objects/redraw$o

../objects/savescreen$o :	$(srcdir)/savescreen.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/savescreen.c -o ../objects/savescreen$o

../objects/tclock$o :	$(srcdir)/tclock.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/tclock.c -o ../objects/tclock$o

../objects/test_add_wchstr$o :	$(srcdir)/test_add_wchstr.c \
			$(HEADER_DEPS) \
			$(srcdir)/linedata.h
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/test_add_wchstr.c -o ../objects/test_add_wchstr$o

../objects/test_addchstr$o :	$(srcdir)/test_addchstr.c \
			$(HEADER_DEPS) \
			$(srcdir)/linedata.h
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/test_addchstr.c -o ../objects/test_addchstr$o

../objects/test_addstr$o :	$(srcdir)/test_addstr.c \
			$(HEADER_DEPS) \
			$(srcdir)/linedata.h
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/test_addstr.c -o ../objects/test_addstr$o

../objects/test_addwstr$o :	$(srcdir)/test_addwstr.c \
			$(HEADER_DEPS) \
			$(srcdir)/linedata.h
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/test_addwstr.c -o ../objects/test_addwstr$o

../objects/test_arrays$o :	$(srcdir)/test_arrays.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/test_arrays.c -o ../objects/test_arrays$o

../objects/test_get_wstr$o :	$(srcdir)/test_get_wstr.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/test_get_wstr.c -o ../objects/test_get_wstr$o

../objects/test_getstr$o :	$(srcdir)/test_getstr.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/test_getstr.c -o ../objects/test_getstr$o

../objects/test_instr$o :	$(srcdir)/test_instr.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/test_instr.c -o ../objects/test_instr$o

../objects/test_inwstr$o :	$(srcdir)/test_inwstr.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/test_inwstr.c -o ../objects/test_inwstr$o

../objects/test_opaque$o :	$(srcdir)/test_opaque.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/test_opaque.c -o ../objects/test_opaque$o

../objects/testaddch$o :	$(srcdir)/testaddch.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/testaddch.c -o ../objects/testaddch$o

../objects/testcurs$o :	$(srcdir)/testcurs.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/testcurs.c -o ../objects/testcurs$o

../objects/testscanw$o :	$(srcdir)/testscanw.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/testscanw.c -o ../objects/testscanw$o

../objects/view$o :	$(srcdir)/view.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/view.c -o ../objects/view$o

../objects/worm$o :	$(srcdir)/worm.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/worm.c -o ../objects/worm$o

../objects/xmas$o :	$(srcdir)/xmas.c \
			$(HEADER_DEPS)
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS_NORMAL) -c $(srcdir)/xmas.c -o ../objects/xmas$o

depend : ${AUTO_SRC}
	makedepend -- ${CPPFLAGS} -- ${C_SRC}

# DO NOT DELETE THIS LINE -- make depend depends on it.

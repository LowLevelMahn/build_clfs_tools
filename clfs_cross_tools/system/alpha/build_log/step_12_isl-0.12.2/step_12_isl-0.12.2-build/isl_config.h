/* isl_config.h.  Generated from isl_config.h.in by configure.  */
/* isl_config.h.in.  Generated from configure.ac by autoheader.  */

/* Define if HeaderSearchOptions::AddPath takes 4 arguments */
/* #undef ADDPATH_TAKES_4_ARGUMENTS */

/* Clang installation prefix */
/* #undef CLANG_PREFIX */

/* Define if CompilerInstance::createDiagnostics takes argc and argv */
/* #undef CREATEDIAGNOSTICS_TAKES_ARG */

/* Define if TargetInfo::CreateTargetInfo takes pointer */
/* #undef CREATETARGETINFO_TAKES_POINTER */

/* Define to Diagnostic for older versions of clang */
/* #undef DiagnosticsEngine */

/* most gcc compilers know a function __attribute__((__warn_unused_result__))
   */
#define GCC_WARN_UNUSED_RESULT __attribute__((__warn_unused_result__))

/* result of mpz_gcdext needs to be normalized */
/* #undef GMP_NORMALIZE_GCDEXT */

/* Define if clang/Basic/DiagnosticOptions.h exists */
/* #undef HAVE_BASIC_DIAGNOSTICOPTIONS_H */

/* Define if Driver constructor takes CXXIsProduction argument */
/* #undef HAVE_CXXISPRODUCTION */

/* Define to 1 if you have the declaration of `ffs', and to 0 if you don't. */
#define HAVE_DECL_FFS 1

/* Define to 1 if you have the declaration of `mp_get_memory_functions', and
   to 0 if you don't. */
#define HAVE_DECL_MP_GET_MEMORY_FUNCTIONS 1

/* Define to 1 if you have the declaration of `__builtin_ffs', and to 0 if you
   don't. */
#define HAVE_DECL___BUILTIN_FFS 1

/* Define to 1 if you have the <dlfcn.h> header file. */
#define HAVE_DLFCN_H 1

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define if Driver constructor takes IsProduction argument */
/* #undef HAVE_ISPRODUCTION */

/* Define to 1 if you have the `gmp' library (-lgmp). */
#define HAVE_LIBGMP 1

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* define if your compiler has __attribute__ */
#define HAVE___ATTRIBUTE__ 1

/* Return type of HandleTopLevelDeclReturn */
/* #undef HandleTopLevelDeclContinue */

/* Return type of HandleTopLevelDeclReturn */
/* #undef HandleTopLevelDeclReturn */

/* piplib is available */
/* #undef ISL_PIPLIB */

/* Define to the sub-directory where libtool stores uninstalled libraries. */
#define LT_OBJDIR ".libs/"

/* Name of package */
#define PACKAGE "isl"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "isl-development@googlegroups.com"

/* Define to the full name of this package. */
#define PACKAGE_NAME "isl"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "isl 0.12.2"

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "isl"

/* Define to the home page for this package. */
#define PACKAGE_URL ""

/* Define to the version of this package. */
#define PACKAGE_VERSION "0.12.2"

/* The size of `char', as computed by sizeof. */
/* #undef SIZEOF_CHAR */

/* The size of `int', as computed by sizeof. */
/* #undef SIZEOF_INT */

/* The size of `long', as computed by sizeof. */
/* #undef SIZEOF_LONG */

/* The size of `short', as computed by sizeof. */
/* #undef SIZEOF_SHORT */

/* The size of `void*', as computed by sizeof. */
/* #undef SIZEOF_VOIDP */

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* Define if Driver::BuildCompilation takes ArrayRef */
/* #undef USE_ARRAYREF */

/* Version number of package */
#define VERSION "0.12.2"

/* Define to getHostTriple for older versions of clang */
/* #undef getDefaultTargetTriple */

/* Define to getInstantiationLineNumber for older versions of clang */
/* #undef getExpansionLineNumber */

#include <isl_config_post.h>

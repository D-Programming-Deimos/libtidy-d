module libtidy.platform;

public:

/* platform.h -- Platform specifics

  (c) 1998-2008 (W3C) MIT, ERCIM, Keio University
  See tidy.h for the copyright notice.

  CVS Info :

    $Author: arnaud02 $
    $Date: 2008/03/17 12:57:01 $
    $Revision: 1.66 $

*/

extern(C):

/*
  Uncomment and edit one of the following #defines if you
  want to specify the config file at compile-time.
*/

/* #define TIDY_CONFIG_FILE "/etc/tidy_config.txt" */ /* original */
/* #define TIDY_CONFIG_FILE "/etc/tidyrc" */
/* #define TIDY_CONFIG_FILE "/etc/tidy.conf" */

/*
  Uncomment the following #define if you are on a system
  supporting the HOME environment variable.
  It enables tidy to find config files named ~/.tidyrc if
  the HTML_TIDY environment variable is not set.
*/
/* #define TIDY_USER_CONFIG_FILE "~/.tidyrc" */

/*
  Uncomment the following #define if your
  system supports the call getpwnam().
  E.g. Unix and Linux.

  It enables tidy to find files named
  ~your/foo for use in the HTML_TIDY environment
  variable or CONFIG_FILE or USER_CONFIGFILE or
  on the command line: -config ~joebob/tidy.cfg

  Contributed by Todd Lewis.
*/

/* #define SUPPORT_GETPWNAM */


/* Enable/disable support for Big5 and Shift_JIS character encodings */
enum SUPPORT_ASIAN_ENCODINGS = 1;

/* Enable/disable support for UTF-16 character encodings */
enum SUPPORT_UTF16_ENCODINGS = 1;

/* Enable/disable support for additional accessibility checks */
enum SUPPORT_ACCESSIBILITY_CHECKS = 1;

alias tchar = dchar;                 /* single, full character */
alias tmbchar = char;                /* single, possibly partial character */
alias tmbstr = tmbchar*;             /* pointer to buffer of possibly partial chars */
alias ctmbstr = const(tmbchar)*; /* Ditto, but const */
enum NULLSTR = "";

/* HAS_VSNPRINTF triggers the use of "vsnprintf", which is safe related to
   buffer overflow. Therefore, we make it the default unless HAS_VSNPRINTF
   has been defined. */
enum HAS_VSNPRINTF = 1;

enum SUPPORT_POSIX_MAPPED_FILES = 1;

/*
  bool is a reserved word in some but
  not all C++ compilers depending on age
  work around is to avoid bool altogether
  by introducing a new enum called Bool
*/
/* We could use the C99 definition where supported
typedef _Bool Bool;
#define no (_Bool)0
#define yes (_Bool)1
*/
enum Bool
{
   no,
   yes
}

/* Opaque data structure used to pass back
** and forth to keep current position in a
** list or other collection.
*/
struct _TidyIterator {}
alias TidyIterator = _TidyIterator*;

/*
 * local variables:
 * mode: c
 * indent-tabs-mode: nil
 * c-basic-offset: 4
 * eval: (c-set-offset 'substatement-open 0)
 * end:
 */

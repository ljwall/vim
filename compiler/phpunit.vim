
" Vim compiler file
" Compiler:	    PHPUnit
" Maintainer:	  Ben Godfrey <ben@ben2.com>
" URL:		      https://github.com/afternoon/vim-phpunit
" Last Change:	2013 Dec 3

if exists("current_compiler")
  finish
endif
let current_compiler = "phpunit"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

if exists("g:msw")
  CompilerSet makeprg=vagrant\ ssh\ web\ --\ \"phpunit\ $*\ --bootstrap\ /var/www/magicseaweed.local/md/application/src/lib/refraction/prerequisites.php\ /var/www/magicseaweed.local/%\"
  CompilerSet errorformat=%E%n)\ %.%#,%Z/var/www/magicseaweed.local/%f:%l,%C%m,%C,%-G%.%#
else
  CompilerSet makeprg=phpunit\ $*
  CompilerSet errorformat=%E%n)\ %.%#,%Z%f:%l,%C%m,%C,%-G%.%#
endif


# word-compat

[![Hackage](https://img.shields.io/hackage/v/word-compat.svg)](https://hackage.haskell.org/package/word-compat)
![Haskell CI](https://github.com/fumieval/word-compat/workflows/Haskell%20CI/badge.svg)

Since GHC 9.2, [Small Word and Int types are now defined in terms of the new primitives with corresponding sizes, not Word# Int#](https://github.com/ghc-proposals/ghc-proposals/blob/master/proposals/0074-small-primitives.rst).
This broke a (somewhat surprising) number of code, leaving a bunch of packages still behind GHC 9.2.

This package provides pattern synonyms that resemble the old constructors of small Int/Word types, and you can save a lot of work of explicitly writing `wordXXToWord` and `wordToWordXX` for each use site.

Most likely you'll be able to get your code buildable just by replacing `GHC.Word` by `GHC.Word.Compat`.

{-# LANGUAGE PatternSynonyms #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE ViewPatterns #-}
{-# LANGUAGE CPP #-}
module GHC.Int.Compat (Int8, pattern GHC.Int.Compat.I8#,
    Int16, pattern GHC.Int.Compat.I16#,
    Int32, pattern GHC.Int.Compat.I32#,
    Int64(..),
    Int(..),

    uncheckedIShiftL64#, uncheckedIShiftRA64#,
    -- * Equality operators
    -- | See GHC.Classes#matching_overloaded_methods_in_rules
    eqInt, neInt, gtInt, geInt, ltInt, leInt,
    eqInt8, neInt8, gtInt8, geInt8, ltInt8, leInt8,
    eqInt16, neInt16, gtInt16, geInt16, ltInt16, leInt16,
    eqInt32, neInt32, gtInt32, geInt32, ltInt32, leInt32,
    eqInt64, neInt64, gtInt64, geInt64, ltInt64, leInt64) where

import GHC.Prim
import GHC.Int as W

pattern I8# :: Int# -> Int8
#if MIN_VERSION_ghc_prim(0,8,0)
pattern I8# x <- (W.I8# (int8ToInt# -> x)) where
  I8# x = W.I8# (intToInt8# x)
#else
pattern I8# = I8#
#endif

pattern I16# :: Int# -> Int16
#if MIN_VERSION_ghc_prim(0,8,0)
pattern I16# x <- (W.I16# (int16ToInt# -> x)) where
  I16# x = W.I16# (intToInt16# x)
#else
pattern I16# = I16#
#endif

pattern I32# :: Int# -> Int32
#if MIN_VERSION_ghc_prim(0,8,0)
pattern I32# x <- (W.I32# (int32ToInt# -> x)) where
  I32# x = W.I32# (intToInt32# x)
#else
pattern I32# = I32#
#endif

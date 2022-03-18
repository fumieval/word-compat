{-# LANGUAGE PatternSynonyms #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE ViewPatterns #-}
{-# LANGUAGE CPP #-}
module GHC.Word.Compat (Word8, pattern GHC.Word.Compat.W8#,
    Word16, pattern GHC.Word.Compat.W16#,
    Word32, pattern GHC.Word.Compat.W32#,
    Word64(..),
    Word(..),
    
        -- * Shifts
    uncheckedShiftL64#,
    uncheckedShiftRL64#,

    -- * Byte swapping
    byteSwap16,
    byteSwap32,
    byteSwap64,

    -- * Bit reversal
    bitReverse8,
    bitReverse16,
    bitReverse32,
    bitReverse64,

    -- * Equality operators
    -- | See GHC.Classes#matching_overloaded_methods_in_rules
    eqWord, neWord, gtWord, geWord, ltWord, leWord,
    eqWord8, neWord8, gtWord8, geWord8, ltWord8, leWord8,
    eqWord16, neWord16, gtWord16, geWord16, ltWord16, leWord16,
    eqWord32, neWord32, gtWord32, geWord32, ltWord32, leWord32,
    eqWord64, neWord64, gtWord64, geWord64, ltWord64, leWord64) where

import GHC.Prim
import GHC.Word as W

pattern W8# :: Word# -> Word8
#if MIN_VERSION_ghc_prim(0,8,0)
pattern W8# x <- (W.W8# (word8ToWord# -> x)) where
  W8# x = W.W8# (wordToWord8# x)
#else
pattern W8# = W8#
#endif

pattern W16# :: Word# -> Word16
#if MIN_VERSION_ghc_prim(0,8,0)
pattern W16# x <- (W.W16# (word16ToWord# -> x)) where
  W16# x = W.W16# (wordToWord16# x)
#else
pattern W16# = W16#
#endif

pattern W32# :: Word# -> Word32
#if MIN_VERSION_ghc_prim(0,8,0)
pattern W32# x <- (W.W32# (word32ToWord# -> x)) where
  W32# x = W.W32# (wordToWord32# x)
#else
pattern W32# = W32#
#endif

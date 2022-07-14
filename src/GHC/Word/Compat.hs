{-# LANGUAGE PatternSynonyms #-}
{-# LANGUAGE MagicHash #-}
{-# LANGUAGE ViewPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE UnboxedTuples #-}

module GHC.Word.Compat (W.Word8,
    W.Word16,
    W.Word32,
    W.Word64(..),
    W.Word(..),
#if MIN_VERSION_ghc_prim(0,8,0)
    pattern GHC.Word.Compat.W8#,
    pattern GHC.Word.Compat.W16#,
    pattern GHC.Word.Compat.W32#,
#else
    pattern W.W8#,
    pattern W.W16#,
    pattern W.W32#,
#endif
        -- * Shifts
    uncheckedShiftL64#,
    uncheckedShiftRL64#,

    -- * Byte swapping
    byteSwap16,
    byteSwap32,
    byteSwap64,

    -- * Bit reversal
#if MIN_VERSION_base(4,14,0)
    bitReverse8,
    bitReverse16,
    bitReverse32,
    bitReverse64,
#endif

    -- * Equality operators
    -- | See GHC.Classes#matching_overloaded_methods_in_rules
    eqWord, neWord, gtWord, geWord, ltWord, leWord,
    eqWord8, neWord8, gtWord8, geWord8, ltWord8, leWord8,
    eqWord16, neWord16, gtWord16, geWord16, ltWord16, leWord16,
    eqWord32, neWord32, gtWord32, geWord32, ltWord32, leWord32,
    eqWord64, neWord64, gtWord64, geWord64, ltWord64, leWord64,

    -- * Indexing Functions
    indexWord8OffAddr#,indexWord16OffAddr#,indexWord32OffAddr#,indexWord64OffAddr#,
    readWord8OffAddr#,readWord16OffAddr#,readWord32OffAddr#,readWord64OffAddr#,
    writeWord8OffAddr#,writeWord16OffAddr#,writeWord32OffAddr#,writeWord64OffAddr#) where

import GHC.Word hiding (Word8(..), Word16(..), Word32(..))
import qualified GHC.Word as W

#if MIN_VERSION_ghc_prim(0,8,0)
import GHC.Prim (
    Addr#,Int#,State#,Word#,
    wordToWord8#,wordToWord16#,wordToWord32#,
    word8ToWord#,word16ToWord#,word32ToWord#)
import qualified GHC.Prim as Prim
#else
import GHC.Prim (
    indexWord8OffAddr#,indexWord16OffAddr#,indexWord32OffAddr#,indexWord64OffAddr#,
    readWord8OffAddr#,readWord16OffAddr#,readWord32OffAddr#,readWord64OffAddr#,
    writeWord8OffAddr#,writeWord16OffAddr#,writeWord32OffAddr#,writeWord64OffAddr#)
#endif


#if MIN_VERSION_ghc_prim(0,8,0)

pattern W8# :: Word# -> W.Word8
pattern W8# x <- (W.W8# (word8ToWord# -> x)) where
  W8# x = W.W8# (wordToWord8# x)
{-# COMPLETE W8# #-}

pattern W16# :: Word# -> W.Word16
pattern W16# x <- (W.W16# (word16ToWord# -> x)) where
  W16# x = W.W16# (wordToWord16# x)
{-# COMPLETE W16# #-}

pattern W32# :: Word# -> W.Word32
pattern W32# x <- (W.W32# (word32ToWord# -> x)) where
  W32# x = W.W32# (wordToWord32# x)
{-# COMPLETE W32# #-}


indexWord8OffAddr# :: Addr# -> Int# -> Word#
indexWord8OffAddr# addr off = word8ToWord# (Prim.indexWord8OffAddr# addr off)
{-# INLINE indexWord8OffAddr# #-}

indexWord16OffAddr# :: Addr# -> Int# -> Word#
indexWord16OffAddr# addr off = word16ToWord# (Prim.indexWord16OffAddr# addr off)
{-# INLINE indexWord16OffAddr# #-}

indexWord32OffAddr# :: Addr# -> Int# -> Word#
indexWord32OffAddr# addr off = word32ToWord# (Prim.indexWord32OffAddr# addr off)
{-# INLINE indexWord32OffAddr# #-}

indexWord64OffAddr# :: Addr# -> Int# -> Word#
indexWord64OffAddr# addr off = Prim.indexWord64OffAddr# addr off
{-# INLINE indexWord64OffAddr# #-}

readWord8OffAddr# :: Addr# -> Int# -> State# d -> (# State# d, Word# #)
readWord8OffAddr# addr off st =
  let !(# st', v #) = Prim.readWord8OffAddr# addr off st
   in (# st', word8ToWord# v #)
{-# INLINE readWord8OffAddr# #-}

readWord16OffAddr# :: Addr# -> Int# -> State# d -> (# State# d, Word# #)
readWord16OffAddr# addr off st =
  let !(# st', v #) = Prim.readWord16OffAddr# addr off st
   in (# st', word16ToWord# v #)
{-# INLINE readWord16OffAddr# #-}

readWord32OffAddr# :: Addr# -> Int# -> State# d -> (# State# d, Word# #)
readWord32OffAddr# addr off st =
  let !(# st', v #) = Prim.readWord32OffAddr# addr off st
   in (# st', word32ToWord# v #)
{-# INLINE readWord32OffAddr# #-}

readWord64OffAddr# :: Addr# -> Int# -> State# d -> (# State# d, Word# #)
readWord64OffAddr# = Prim.readWord64OffAddr#
{-# INLINE readWord64OffAddr# #-}

writeWord8OffAddr# :: Addr# -> Int# -> Word# -> State# d -> State# d
writeWord8OffAddr# addr off v st =
  Prim.writeWord8OffAddr# addr off (wordToWord8# v) st
{-# INLINE writeWord8OffAddr# #-}

writeWord16OffAddr# :: Addr# -> Int# -> Word# -> State# d -> State# d
writeWord16OffAddr# addr off v st =
  Prim.writeWord16OffAddr# addr off (wordToWord16# v) st
{-# INLINE writeWord16OffAddr# #-}

writeWord32OffAddr# :: Addr# -> Int# -> Word# -> State# d -> State# d
writeWord32OffAddr# addr off v st =
  Prim.writeWord32OffAddr# addr off (wordToWord32# v) st
{-# INLINE writeWord32OffAddr# #-}

writeWord64OffAddr# :: Addr# -> Int# -> Word# -> State# d -> State# d
writeWord64OffAddr# = Prim.writeWord64OffAddr#
{-# INLINE writeWord64OffAddr# #-}

#endif
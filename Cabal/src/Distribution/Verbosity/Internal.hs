{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}

module Distribution.Verbosity.Internal
  ( VerbosityLevel (..)
  , VerbosityFlag (..)
  ) where

import Distribution.Compat.Prelude
import Prelude ()

data VerbosityLevel = Silent | Normal | Verbose | Deafening
  deriving stock (Generic, Show, Read, Eq, Ord, Enum, Bounded)
  deriving anyclass (Binary, NFData, Structured)

data VerbosityFlag
  = VCallStack
  | VCallSite
  | VNoWrap
  | VMarkOutput
  | VTimestamp
  | -- | @since 3.4.0.0
    VStderr
  | VNoWarn
  deriving stock (Generic, Show, Read, Eq, Ord, Enum, Bounded)
  deriving anyclass (Binary, NFData, Structured)

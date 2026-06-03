{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE DeriveAnyClass #-}

module Distribution.Solver.Types.Settings
    ( ReorderGoals(..)
    , IndependentGoals(..)
    , PreferOldest(..)
    , MinimizeConflictSet(..)
    , AvoidReinstalls(..)
    , ShadowPkgs(..)
    , StrongFlags(..)
    , AllowBootLibInstalls(..)
    , OnlyConstrained(..)
    , EnableBackjumping(..)
    , CountConflicts(..)
    , FineGrainedConflicts(..)
    , SolveExecutables(..)
    ) where

import Distribution.Solver.Compat.Prelude
import Prelude ()

import Distribution.Simple.Setup ( BooleanFlag(..) )
import Distribution.Pretty ( Pretty(pretty) )
import Distribution.Parsec ( Parsec(parsec) )

import qualified Distribution.Compat.CharParsing as P
import qualified Text.PrettyPrint as PP

newtype ReorderGoals = ReorderGoals Bool
  deriving newtype (BooleanFlag, Eq, Show)
  deriving stock Generic
  deriving anyclass (Binary, NFData, Structured)

newtype CountConflicts = CountConflicts Bool
  deriving newtype (BooleanFlag, Eq, Show)
  deriving stock Generic
  deriving anyclass (Binary, NFData, Structured)

newtype FineGrainedConflicts = FineGrainedConflicts Bool
  deriving newtype (BooleanFlag, Eq, Show)
  deriving stock Generic
  deriving anyclass (Binary, NFData, Structured)

newtype MinimizeConflictSet = MinimizeConflictSet Bool
  deriving newtype (BooleanFlag, Eq, Show)
  deriving stock Generic
  deriving anyclass (Binary, NFData, Structured)

newtype IndependentGoals = IndependentGoals Bool
  deriving newtype (BooleanFlag, Eq, Show)
  deriving stock Generic
  deriving anyclass (Binary, NFData, Structured)

newtype PreferOldest = PreferOldest Bool
  deriving newtype (BooleanFlag, Eq, Show)
  deriving stock Generic
  deriving anyclass (Binary, NFData, Structured)

newtype AvoidReinstalls = AvoidReinstalls Bool
  deriving newtype (BooleanFlag, Eq, Show)
  deriving stock Generic
  deriving anyclass (Binary, NFData, Structured)

newtype ShadowPkgs = ShadowPkgs Bool
  deriving newtype (BooleanFlag, Eq, Show)
  deriving stock Generic
  deriving anyclass (Binary, NFData, Structured)

newtype StrongFlags = StrongFlags Bool
  deriving newtype (BooleanFlag, Eq, Show)
  deriving stock Generic
  deriving anyclass (Binary, NFData, Structured)

newtype AllowBootLibInstalls = AllowBootLibInstalls Bool
  deriving newtype (BooleanFlag, Eq, Show)
  deriving stock Generic
  deriving anyclass (Binary, NFData, Structured)

-- | Should we consider all packages we know about, or only those that
-- have constraints explicitly placed on them or which are goals?
data OnlyConstrained
  = OnlyConstrainedNone
  | OnlyConstrainedAll
  deriving stock (Eq, Generic, Show)
  deriving anyclass (Binary, NFData, Structured)

newtype EnableBackjumping = EnableBackjumping Bool
  deriving newtype (BooleanFlag, Eq, Show)
  deriving stock Generic
  deriving anyclass (Binary, NFData, Structured)


newtype SolveExecutables = SolveExecutables Bool
  deriving newtype (BooleanFlag, Eq, Show)
  deriving stock Generic
  deriving anyclass (Binary, NFData, Structured)

instance Pretty OnlyConstrained where
  pretty OnlyConstrainedAll  = PP.text "all"
  pretty OnlyConstrainedNone = PP.text "none"

instance Parsec OnlyConstrained where
  parsec = P.choice
    [ P.string "all"  >> return OnlyConstrainedAll
    , P.string "none" >> return OnlyConstrainedNone
    ]

instance Parsec ReorderGoals where
  parsec = ReorderGoals <$> parsec

instance Parsec CountConflicts where
  parsec = CountConflicts <$> parsec

instance Parsec FineGrainedConflicts where
  parsec = FineGrainedConflicts <$> parsec

instance Parsec MinimizeConflictSet where
  parsec = MinimizeConflictSet <$> parsec

instance Parsec StrongFlags where
  parsec = StrongFlags <$> parsec

instance Parsec AllowBootLibInstalls where
  parsec = AllowBootLibInstalls <$> parsec

instance Parsec PreferOldest where
  parsec = PreferOldest <$> parsec

instance Parsec IndependentGoals where
  parsec = IndependentGoals <$> parsec

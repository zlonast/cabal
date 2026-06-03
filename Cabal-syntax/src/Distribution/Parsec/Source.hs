{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Distribution.Parsec.Source
  ( PSource (..)
  , CabalFileSource (..)
  , InstalledPackageInfoSource (..)
  , renderCabalFileSource
  , renderInstalledPackageInfoSource
  ) where

import qualified Data.ByteString as BS
import Distribution.Compat.Prelude
import Prelude ()

-- | The source of a parse error
data PSource src
  = PKnownSource src
  | PUnknownSource
  deriving stock (Ord, Show, Generic, Functor)

newtype CabalFileSource
  = PCabalFile (FilePath, BS.ByteString)
  deriving newtype (Ord, Show)
  deriving stock (Generic)

data InstalledPackageInfoSource
  = PInstalledPackageInfo
  deriving stock (Eq, Ord, Show, Generic)

renderCabalFileSource :: CabalFileSource -> String
renderCabalFileSource (PCabalFile (path, _)) = path

renderInstalledPackageInfoSource :: InstalledPackageInfoSource -> String
renderInstalledPackageInfoSource PInstalledPackageInfo = ""

instance Eq CabalFileSource where
  PCabalFile (path, _) == PCabalFile (path', _) = path == path'

instance Eq src => Eq (PSource src) where
  PKnownSource src == PKnownSource src' = src == src'
  PUnknownSource == PUnknownSource = True
  _ == _ = False

instance Binary src => Binary (PSource src)
instance NFData src => NFData (PSource src) where rnf = genericRnf

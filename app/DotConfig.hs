{-# LANGUAGE OverloadedStrings #-}

module DotConfig where

import Data.Aeson
import Data.HashMap.Strict qualified as HM
import Data.Text (Text)

newtype DotProperties = DotProperties {colorscheme :: Text} deriving (Show, Eq)

data DotDeclarations = DotDeclarations
  { globalColorscheme :: Text,
    apps :: HM.HashMap Text DotProperties
  }
  deriving (Show, Eq)

instance FromJSON DotProperties where
  parseJSON = withObject "DotProperties" $ \v ->
    DotProperties <$> v .: "colorscheme"

instance FromJSON DotDeclarations where
  parseJSON = withObject "Config" $ \v ->
    DotDeclarations
      <$> v .: "colorscheme"
      <*> v .: "apps"

getConfig :: DotDeclarations -> (Text, [(Text, Text)])
getConfig config =
  let globalColorScheme = globalColorscheme config
      appsMap = apps config
      appConfigs = [(appName, colorscheme appConfig) | (appName, appConfig) <- HM.toList appsMap] in (globalColorScheme, appConfigs)

{-# LANGUAGE OverloadedStrings #-}

module AppConfig where

import Data.Aeson
import Data.HashMap.Strict qualified as HM
import Data.Aeson.KeyMap qualified as KM
import Data.Text (Text)
import Neovim

data AppProperties = AppProperties
  { baseConfigFilePath :: Text,
    templatePath :: Maybe Text
  }
  deriving (Show, Eq)

newtype Config =
   NeovimProps NeovimProperties
  deriving (Show, Eq)

type AppDecls = HM.HashMap Text Config

newtype AppDeclarations = AppDeclarations AppDecls deriving (Show, Eq)

instance FromJSON Config where
  parseJSON = withObject "Config" $ \obj ->
    case KM.toList obj of 
      [("neovim",v)] -> NeovimProps <$> parseJSON v
      _ -> fail "Expected a config key"

instance FromJSON AppProperties where
  parseJSON = withObject "AppProperties" $ \v ->
    AppProperties
      <$> v .: "baseConfigFilePath"
      <*> v .:? "templatePath"

instance FromJSON AppDeclarations where
  parseJSON = fmap AppDeclarations . parseJSON

unwarpAppDelcs :: AppDeclarations -> AppDecls
unwarpAppDelcs (AppDeclarations hm) = hm :: AppDecls

getAppConfig :: AppDeclarations -> [(Text, Config)]
getAppConfig  = HM.toList . unwarpAppDelcs

getAppProps :: Text -> AppDecls -> Maybe Config
getAppProps = HM.lookup 

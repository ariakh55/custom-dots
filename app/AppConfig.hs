{-# LANGUAGE OverloadedStrings #-}

module AppConfig where

import Data.Aeson
import Data.HashMap.Strict qualified as HM
import Data.Text (Text)

data Properties = Properties
  { baseConfigFilePath :: Text,
    configDirs :: HM.HashMap Text Text
  }
  deriving (Show, Eq)

newtype AppDeclarations = AppDeclarations (HM.HashMap Text Properties) deriving (Show, Eq)

instance FromJSON Properties where
  parseJSON = withObject "Properties" $ \v ->
    Properties
      <$> v .: "baseConfigFilePath"
      <*> v .: "configDirs"

instance FromJSON AppDeclarations where
  parseJSON = fmap AppDeclarations . parseJSON

{-# LANGUAGE OverloadedStrings #-}

module DotConfig where

import Data.Aeson
import Data.HashMap.Strict qualified as HM
import Data.Text (Text)

newtype Properties = Properties {colorscheme :: Text} deriving (Show, Eq)

data Declarations = Declarations
  { globalColorscheme :: Text,
    apps :: HM.HashMap Text Properties
  }
  deriving (Show, Eq)

instance FromJSON Properties where
  parseJSON = withObject "Properties" $ \v ->
    Properties <$> v .: "colorscheme"

instance FromJSON Declarations where
  parseJSON = withObject "Config" $ \v ->
    Declarations
      <$> v .: "colorscheme"
      <*> v .: "apps"

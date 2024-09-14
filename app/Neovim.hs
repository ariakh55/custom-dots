{-# LANGUAGE OverloadedStrings #-}

module Neovim where

import Data.Aeson
import Data.Text (Text)

data NeovimConfigDirs = NeovimConfigDirs
  { init :: Text,
    after :: Text,
    ftplugin :: Text
  }
  deriving (Show, Eq)

data NeovimProperties = NeovimProperties
  { baseConfigFilePath :: Text,
    configDirs :: NeovimConfigDirs,
    templatePath :: Maybe Text
  }
  deriving (Show, Eq)

instance FromJSON NeovimConfigDirs where
  parseJSON = withObject "NeovimConfigDirs" $ \v -> 
    NeovimConfigDirs
      <$> v .: "init"
      <*> v .: "after"
      <*> v .: "ftplugin"

instance FromJSON NeovimProperties where
  parseJSON = withObject "NeovimProperties" $ \v ->
    NeovimProperties
      <$> v .: "baseConfigFilePath"
      <*> v .: "configDirs"
      <*> v .:? "templatePath"

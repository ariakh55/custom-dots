module JSON
  ( readJSON,
    getConfig,
  )
where

import DotConfig

import Data.Aeson
import Data.ByteString.Lazy qualified as B
import Data.HashMap.Strict qualified as HM
import Data.Text (Text)


getJSON :: FilePath -> IO B.ByteString
getJSON = B.readFile

readJSON :: FilePath -> IO (Either String Declarations)
readJSON filePath = (eitherDecode <$> getJSON filePath) :: IO (Either String Declarations)

getConfig :: Declarations -> (Text, [(Text, Text)])
getConfig config =
  let globalColorScheme = globalColorscheme config
      appsMap = apps config
      appConfigs = [(appName, colorscheme appConfig) | (appName, appConfig) <- HM.toList appsMap] in (globalColorScheme, appConfigs)

-- let appsMap = apps config
-- forM_ (HM.toList appsMap) $ \(appName, appConfig) -> do
--   print appName
--   print appConfig

module JSON (readJSON) where

import Data.Aeson
import Data.ByteString.Lazy qualified as B

getJSON :: FilePath -> IO B.ByteString
getJSON = B.readFile

readJSON :: (FromJSON a) => FilePath -> IO (Either String a)
readJSON filePath = eitherDecode <$> getJSON filePath

-- let appsMap = apps config
-- forM_ (HM.toList appsMap) $ \(appName, appConfig) -> do
--   print appName
--   print appConfig

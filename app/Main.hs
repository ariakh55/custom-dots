module Main where

import JSON (readJSON, getConfig)

main :: IO ()
main = do
    results <- readJSON "app/config.json"
    case results of
      Left err -> putStrLn $ "Error parsing JSON config: " ++ err
      Right config -> do
        let (globalColorScheme, appConfigs) = getConfig config
        print appConfigs
        print globalColorScheme
        
        
      

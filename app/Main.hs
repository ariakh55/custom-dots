{-# LANGUAGE OverloadedStrings #-}

module Main where

import JSON (readJSON)
import DotConfig
import AppConfig

main :: IO ()
main = do
    results <- readJSON "app/config.json" :: IO (Either String DotDeclarations)
    case results of
      Left err -> putStrLn $ "Error parsing JSON config: " ++ err
      Right config -> do
        let (globalColorScheme, appConfigs) = getConfig config
        print appConfigs
        print globalColorScheme
        
    results <- readJSON "app/appConfig.json" :: IO (Either String Config)
    case results of
      Left err -> putStrLn $ "Error parsing JSON config: " ++ err
      Right config -> do
        print config

module Lib
    ( printIgnoreFile
    , vimify
    ) where

import Network.HTTP.Client
import Network.HTTP.Client.TLS
import Data.ByteString.Lazy.Char8 (unpack)

import Data.Char (toUpper)

capital :: String -> String
capital (x:xs) = toUpper x : xs

vimify :: String -> String
vimify xs = "*.swp\n" ++ xs

printIgnoreFile :: String -> (String -> String) -> IO ()
printIgnoreFile lang postprocessF = do
    manager <- newManager tlsManagerSettings
    req <- parseRequest $ "https://raw.githubusercontent.com/github/gitignore/master/" ++ capital lang ++ ".gitignore"
    response <- httpLbs req manager
    putStr $ postprocessF $ unpack $ responseBody response

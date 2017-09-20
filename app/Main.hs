module Main where

import Lib

import Options.Applicative
import Data.Semigroup ((<>))

data Language =  Language
    { language :: String
    , vimify :: Bool }

lang :: Parser Language
lang = Language
    <$> argument str (metavar "LANGUAGE")
        <*> switch
        ( long "vimify"
        <> short 'v'
        <> help "whether to add vim ignores as well" )

run :: Language -> IO ()
run (Language lang True) = printIgnoreFile lang Lib.vimify
run (Language lang False) = printIgnoreFile lang id

main :: IO ()
main = run =<< execParser opts
    where
        opts = info (lang <**> helper)
            ( fullDesc
            <> progDesc "Get gitignore files from github repository" )

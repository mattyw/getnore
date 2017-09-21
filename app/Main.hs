module Main where

import Lib

import Options.Applicative
import Data.Semigroup ((<>))

data Language =  Language
    { language :: String
    , append :: String
    , vimify :: Bool }

lang :: Parser Language
lang = Language
    <$> argument str (metavar "LANGUAGE")
        <*> strOption
        ( long "append"
        <> metavar "HELLO"
        <> help "rules to append to the downloaded file" )
        <*> switch
        ( long "vimify"
        <> short 'v'
        <> help "add vim ignore rules" )

run :: Language -> IO ()
run (Language lang append True) = printIgnoreFile lang $ Lib.appendRules append . Lib.vimify
run (Language lang append False) = printIgnoreFile lang $ Lib.appendRules append

main :: IO ()
main = run =<< execParser opts
    where
        opts = info (lang <**> helper)
            ( fullDesc
            <> progDesc "Get gitignore files from github repository" )

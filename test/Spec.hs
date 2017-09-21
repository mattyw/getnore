import Test.HUnit

import Lib
import System.Exit
import Control.Monad

testAppend = TestCase (assertEqual "Test appends" (Lib.appendRules "foo" "bar") ("bar\nfoo\n"))
testVimify = TestCase (assertEqual "Test vimify" (Lib.vimify "foo") ("foo\n*.swp\n"))
tests = TestList [
    TestLabel "append test" testAppend
    , TestLabel "vimify test" testVimify
    ]
main :: IO ()
main = do
    counts <- runTestTT tests
    when (failures counts > 0 || errors counts > 0)
        exitFailure

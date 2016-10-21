#! /usr/bin/env stack
-- stack --resolver=lts-7.4 runghc --package=shelly

{-# LANGUAGE ExtendedDefaultRules, OverloadedStrings #-}
{-# OPTIONS_GHC -fno-warn-type-defaults #-}
import Control.Monad
import Shelly
import qualified Data.Text as T

default (T.Text)

main :: IO ()
main = shelly $  cmd "ls" -|- cmd "cowsay"

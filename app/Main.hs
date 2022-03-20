{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import Discord
import Discord.Interactions
import qualified Discord.Requests as R
import Discord.Types
import Handlers (endHandler, eventHandler, startHandler)

{- Initialise and run bot -}
main :: IO ()
main = do
  botToken <- TIO.readFile "./auth-token.secret" :: IO T.Text
  err <-
    runDiscord $
      def
        { discordToken = botToken,
          discordOnStart = startHandler,
          discordOnEnd = endHandler,
          discordOnEvent = eventHandler,
          discordOnLog = TIO.putStrLn,
          discordForkThreadForEvents = False
        }
  TIO.putStrLn err

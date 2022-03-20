{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}

module Handlers
  ( startHandler,
    eventHandler,
    endHandler,
  )
where

import Commands
import Control.Monad (void, when)
import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import Discord
import Discord.Interactions
import qualified Discord.Requests as R
import Discord.Types
import UnliftIO (liftIO)
import UnliftIO.Concurrent

startHandler :: DiscordHandler ()
startHandler = do
  liftIO $ putStrLn "Started bot"

eventHandler :: Event -> DiscordHandler ()
eventHandler event = case event of
  Ready _ _ _ _ _ _ (PartialApplication i _) -> do
    mapM_ -- generate commands
      ( maybe
          (return (Left $ RestCallErrorCode 0 "" ""))
          (restCall . R.CreateGlobalApplicationCommand i)
      )
      [createApplicationCommandChatInput "mdata" "don't ask to ask macro"]
    acs <- restCall (R.GetGlobalApplicationCommands i)
    case acs of -- print each command available
      Left r -> liftIO $ print r
      Right ls -> do
        mapM_ (liftIO . print) ls
  InteractionCreate -- COMMAND mdata
    InteractionApplicationCommand
      { interactionDataApplicationCommand =
          InteractionDataApplicationCommandChatInput
            { interactionDataApplicationCommandName = "mdata",
              ..
            },
        ..
      } -> do
      void $ restCall $ R.CreateInteractionResponse interactionId interactionToken dontasktoaskInteraction
  _ -> return ()

endHandler :: IO ()
endHandler = do
  liftIO $ putStrLn "Shutting down"

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
import qualified Data.Map as M
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
      $ map createCommand globalCommandsList
    acs <- restCall (R.GetGlobalApplicationCommands i)
    case acs of -- print each command available
      Left r -> liftIO $ print r
      Right ls -> do
        mapM_ (liftIO . print) ls
  InteractionCreate -- chat input commands
    InteractionApplicationCommand
      { interactionDataApplicationCommand =
          InteractionDataApplicationCommandChatInput
            { interactionDataApplicationCommandName = cmdname,
              ..
            },
        ..
      } -> case M.lookup cmdname globalCommandsMap of
      Just cmd -> void $ restCall $ R.CreateInteractionResponse interactionId interactionToken $ interactionResponse cmd
      _ -> undefined -- discord should make this impossible?
  _ -> return ()

endHandler :: IO ()
endHandler = do
  liftIO $ putStrLn "Shutting down"

module Commands.Command (Command (..)) where

import qualified Data.Text as T
import Discord
import Discord.Interactions
import Discord.Internal.Rest.Channel
import qualified Discord.Requests as R
import Discord.Types

data Command = Command
  { createCommand :: Maybe CreateApplicationCommand,
    commandName :: T.Text,
    commandDesc :: T.Text,
    interactionResponse :: InteractionResponse
  }

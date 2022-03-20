{-# LANGUAGE OverloadedStrings #-}

module Commands
  ( Command,
    createCommand,
    interactionResponse,
    dontasktoask,
    help,
    whoami,
  )
where

import Control.Monad (void, when)
import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import Discord
import Discord.Interactions
import Discord.Internal.Rest.Channel (MessageDetailedOpts (messageDetailedComponents))
import qualified Discord.Requests as R
import Discord.Types
import UnliftIO (liftIO)
import UnliftIO.Concurrent

data Command = Command
  { createCommand :: Maybe CreateApplicationCommand,
    interactionResponse :: InteractionResponse
  }

dontasktoask :: Command
dontasktoask =
  Command
    { createCommand = dontasktoaskCreateCommand,
      interactionResponse = dontasktoaskInteractionResp
    }

help :: Command
help =
  Command
    { createCommand = helpCreateCommand,
      interactionResponse =
        helpInteractionResp
    }

whoami :: Command
whoami =
  Command
    { createCommand = whoamiCreateCommand,
      interactionResponse =
        whoamiInteractionResp
    }

dontasktoaskCreateCommand :: Maybe CreateApplicationCommand
dontasktoaskCreateCommand = createApplicationCommandChatInput "mdata" "don't ask to ask macro"

dontasktoaskEmbed :: CreateEmbed
dontasktoaskEmbed =
  def
    { createEmbedTitle = "Don't ask to ask.",
      createEmbedDescription = "Just ask. https://dontasktoask.com"
    }

dontasktoaskInteractionResp :: InteractionResponse
dontasktoaskInteractionResp =
  InteractionResponseChannelMessage $
    InteractionResponseMessage
      { interactionResponseMessageTTS = Nothing,
        interactionResponseMessageContent = Nothing,
        interactionResponseMessageEmbeds = Just [dontasktoaskEmbed],
        interactionResponseMessageAllowedMentions = Nothing,
        interactionResponseMessageFlags = Nothing,
        interactionResponseMessageComponents = Nothing,
        interactionResponseMessageAttachments = Nothing
      }

helpCreateCommand :: Maybe CreateApplicationCommand
helpCreateCommand = undefined

helpInteractionResp :: InteractionResponse
helpInteractionResp = undefined

whoamiCreateCommand :: Maybe CreateApplicationCommand
whoamiCreateCommand = undefined

whoamiInteractionResp :: InteractionResponse
whoamiInteractionResp = undefined

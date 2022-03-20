{-# LANGUAGE OverloadedStrings #-}

module Commands
  ( dontasktoaskInteraction,
    helpInteraction,
    whoamiInteraction,
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

dontasktoaskEmbed :: CreateEmbed
dontasktoaskEmbed =
  def
    { createEmbedTitle = "Don't ask to ask.",
      createEmbedDescription = "Just ask. https://dontasktoask.com"
    }

dontasktoaskInteraction :: InteractionResponse
dontasktoaskInteraction =
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

helpInteraction :: InteractionResponse
helpInteraction = undefined

whoamiInteraction :: InteractionResponse
whoamiInteraction = undefined

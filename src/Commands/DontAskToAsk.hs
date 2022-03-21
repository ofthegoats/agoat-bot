{-# LANGUAGE OverloadedStrings #-}

module Commands.DontAskToAsk (dontasktoask) where

import Commands.Command
import qualified Data.Text as T
import Discord
import Discord.Interactions
import Discord.Internal.Rest.Channel (MessageDetailedOpts (messageDetailedComponents))
import qualified Discord.Requests as R
import Discord.Types

name :: T.Text
name = "mdata"

desc :: T.Text
desc = "don't ask to ask macro"

dontasktoask :: Command
dontasktoask =
  Command
    { commandName = name,
      commandDesc = desc,
      createCommand = createApplicationCommandChatInput name desc,
      interactionResponse = dontasktoaskInteractionResp
    }

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

{-# LANGUAGE OverloadedStrings #-}

module Commands.Help (help) where

import Commands.Command
import Commands.DontAskToAsk
import Commands.WhoAmI
import qualified Data.Text as T
import Discord
import Discord.Interactions
import Discord.Internal.Rest.Channel (MessageDetailedOpts (messageDetailedComponents))
import qualified Discord.Requests as R
import Discord.Types

name :: T.Text
name = "help"

desc :: T.Text
desc = "list available commands"

help :: Command
help =
  Command
    { commandName = name,
      commandDesc = desc,
      createCommand = createApplicationCommandChatInput name desc,
      interactionResponse = helpInteractionResp
    }

helpEmbed :: CreateEmbed
helpEmbed =
  def
    { createEmbedTitle = "Help",
      createEmbedFields =
        [ EmbedField
            { embedFieldName = commandName cmd,
              embedFieldValue = commandDesc cmd,
              embedFieldInline = Just False
            }
          | cmd <-
              [ help,
                whoami,
                dontasktoask
              ]
        ]
    }

helpInteractionResp :: InteractionResponse
helpInteractionResp =
  InteractionResponseChannelMessage $
    InteractionResponseMessage
      { interactionResponseMessageTTS = Nothing,
        interactionResponseMessageContent = Nothing,
        interactionResponseMessageEmbeds = Just [helpEmbed],
        interactionResponseMessageAllowedMentions = Nothing,
        interactionResponseMessageFlags = Just (InteractionResponseMessageFlags [InteractionResponseMessageFlagEphermeral]),
        interactionResponseMessageComponents = Nothing,
        interactionResponseMessageAttachments = Nothing
      }

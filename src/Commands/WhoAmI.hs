{-# LANGUAGE OverloadedStrings #-}

module Commands.WhoAmI (whoami) where

import Commands.Command
import qualified Data.Text as T
import Discord
import Discord.Interactions
import Discord.Internal.Rest.Channel (MessageDetailedOpts (messageDetailedComponents))
import qualified Discord.Requests as R
import Discord.Types

name :: T.Text
name = "whoami"

desc :: T.Text
desc = "post information about this bot"

whoami :: Command
whoami =
  Command
    { commandName = name,
      commandDesc = desc,
      createCommand = createApplicationCommandChatInput name desc,
      interactionResponse = whoamiInteractionResp
    }

whoamiEmbed :: CreateEmbed
whoamiEmbed =
  def
    { createEmbedTitle = "agoat",
      createEmbedUrl = "https://github.com/ofthegoats/agoat-bot",
      createEmbedDescription =
        "I am a bot written by [ofthegoats#1275](https://github.com/ofthegoats).\n\
        \I provide access to useful macros and commands, \
        \particularly for programming and coding servers."
    }

whoamiInteractionResp :: InteractionResponse
whoamiInteractionResp =
  InteractionResponseChannelMessage $
    InteractionResponseMessage
      { interactionResponseMessageTTS = Nothing,
        interactionResponseMessageContent = Nothing,
        interactionResponseMessageEmbeds = Just [whoamiEmbed],
        interactionResponseMessageAllowedMentions = Nothing,
        interactionResponseMessageFlags = Just (InteractionResponseMessageFlags [InteractionResponseMessageFlagEphermeral]),
        interactionResponseMessageComponents = Nothing,
        interactionResponseMessageAttachments = Nothing
      }

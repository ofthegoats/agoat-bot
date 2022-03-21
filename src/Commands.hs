{-# LANGUAGE OverloadedStrings #-}

module Commands
  ( module Commands.Command,
    module Commands.Help,
    module Commands.WhoAmI,
    module Commands.DontAskToAsk,
    globalCommandsList,
    globalCommandsMap,
  )
where

import Commands.Command
import Commands.DontAskToAsk
import Commands.Help
import Commands.WhoAmI
import qualified Data.Map as M
import qualified Data.Text as T

globalCommandsList :: [Command]
globalCommandsList =
  [ help,
    whoami,
    dontasktoask
  ]

globalCommandsMap :: M.Map T.Text Command
globalCommandsMap =
  M.fromList $
    [(commandName cmd, cmd) | cmd <- globalCommandsList]

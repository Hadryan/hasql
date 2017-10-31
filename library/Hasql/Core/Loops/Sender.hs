module Hasql.Core.Loops.Sender where

import Hasql.Prelude
import qualified Hasql.Core.Socket as A
import qualified Data.ByteString as B


{-# INLINABLE loop #-}
loop :: A.Socket -> IO ByteString -> (Text -> IO ()) -> IO ()
loop socket getNextChunk reportError =
  {-# SCC "loop" #-} 
  forever $ do
    bytes <- getNextChunk
    resultOfSending <- A.send socket bytes
    case resultOfSending of
      Right () -> return ()
      Left msg -> reportError msg
{-# LANGUAGE LambdaCase #-}

module Main
  ( main,
  )
where

import Data.ByteString.Lazy as ByteString
  ( ByteString,
    readFile,
    writeFile,
  )
import Data.ByteString.Lazy.UTF8
  ( fromString,
    toString,
  )
import Data.Csv
  ( HasHeader (HasHeader, NoHeader),
    decode,
    encode,
  )
import Data.Maybe
  ( Maybe (Just, Nothing),
    fromMaybe,
  )
import Data.Vector
  ( Vector,
    toList,
  )
import Lib
  ( fromClockfyToCassi,
  )
import System.Environment
  ( getArgs,
  )

main :: IO ()
main = do
  [input, output, name] <-
    ( \case
        [input, output] -> [input, output, "LUIGI MINARDI FERREIRA MAIA"]
        [input] -> [input, "CassiRelatory.csv", "LUIGI MINARDI FERREIRA MAIA"]
        _ -> ["ClockfyRelatory.csv", "CassiRelatory.csv", "LUIGI MINARDI FERREIRA MAIA"]
      )
      <$> getArgs
  clockfyCsv <- ByteString.readFile (fromMaybe "ClockfyRelatory.csv" input)
  let decodedClockfy = toList <$> (decode HasHeader clockfyCsv :: Either String (Vector [String]))
  case decodedClockfy of
    Left error -> print $ "Error!!!" ++ error
    Right clockfyData -> ByteString.writeFile "CassiRelatory.csv" $ (encode . fromClockfyToCassi) clockfyData
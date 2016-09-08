{-# LANGUAGE FlexibleInstances #-}
module Data.Text.Zipper.Generic where

import qualified Prelude
import           Prelude hiding (drop, take, length, last, init, null, lines)
import qualified Data.Text as T
import qualified Data.Text.Zipper.Vector as V
import qualified Data.Vector as V

import           Data.Monoid ()

import           Data.Text.Zipper

class Monoid a => GenericTextZipper a where
  singleton :: Char -> a
  drop      :: Int -> a -> a
  take      :: Int -> a -> a
  length    :: a -> Int
  last      :: a -> Char
  init      :: a -> a
  null      :: a -> Bool
  lines     :: a -> [a]

instance GenericTextZipper [Char] where
  singleton = (:[])
  drop      = Prelude.drop
  take      = Prelude.take
  length    = Prelude.length
  last      = Prelude.last
  init      = Prelude.init
  null      = Prelude.null
  lines     = Prelude.lines

instance GenericTextZipper T.Text where
  singleton = T.singleton
  drop      = T.drop
  take      = T.take
  length    = T.length
  last      = T.last
  init      = T.init
  null      = T.null
  lines     = T.lines

instance GenericTextZipper (V.Vector Char) where
  singleton = V.singleton
  drop      = V.drop
  take      = V.take
  length    = V.length
  last      = V.last
  init      = V.init
  null      = V.null
  lines     = V.lines

textZipper :: GenericTextZipper a =>
              [a] -> Maybe Int -> TextZipper a
textZipper =
  mkZipper singleton drop take length last init null lines

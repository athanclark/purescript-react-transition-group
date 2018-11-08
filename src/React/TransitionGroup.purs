module React.TransitionGroup
  ( TransitionGroupProps, transitionGroup
  ) where

import Data.Nullable (Nullable)
import React (ReactClass, unsafeCreateElement, ReactElement)
import Type.Row (type (+))
import Row.Class (class SubRow)



foreign import transitionGroupImpl :: forall props. ReactClass props


type TransitionGroupProps componentProps r =
  ( component :: Nullable (ReactClass componentProps) -- ^ Default: `Just div'`
  , appear :: Boolean
  , enter :: Boolean
  , exit :: Boolean
  , childFactory :: ReactElement -> ReactElement
  | r)


transitionGroup :: forall o componentProps
               . SubRow o (TransitionGroupProps componentProps + ())
              => { | o } -> Array ReactElement -> ReactElement
transitionGroup = unsafeCreateElement transitionGroupImpl

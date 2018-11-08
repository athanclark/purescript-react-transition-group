module React.CSSTransition
  ( ClassNames, classNames
  , CSSTransitionProps, cssTransition
  ) where

import React.Transition (TransitionProps)

import React (ReactClass, unsafeCreateElement, ReactElement)
import Unsafe.Coerce (unsafeCoerce)
import Type.Row (type (+))
import Row.Class (class SubRow)

foreign import cssTransitionImpl :: forall props. ReactClass props


type ClassNames =
  { appear :: String
  , appearActive :: String
  , enter :: String
  , enterActive :: String
  , enterDone :: String
  , exit :: String
  , exitActive :: String
  , exitDone :: String
  }

-- | Automatically suffix names a 'la: https://reactcommunity.org/react-transition-group/css-transition#CSSTransition-prop-classNames
classNames :: String -> ClassNames
classNames = unsafeCoerce


type CSSTransitionProps r =
  ( classNames :: ClassNames
  | r)




cssTransition :: forall o
               . SubRow o (TransitionProps + CSSTransitionProps + ())
              => { | o } -> Array ReactElement -> ReactElement
cssTransition = unsafeCreateElement cssTransitionImpl

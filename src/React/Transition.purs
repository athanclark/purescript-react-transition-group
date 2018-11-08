module React.Transition
  ( TransitionProps
  , Timeout, timeoutAll
  , EnterEventHandler, enterEventHandler
  , ExitEventHandler, exitEventHandler
  , transition ) where

import Prelude (Unit)
import React (ReactClass, unsafeCreateElement, ReactElement)
import Data.Time.Duration (Milliseconds)
import Web.Event.EventTarget (EventTarget, EventListener)
import Web.HTML.HTMLElement (HTMLElement)
import Effect (Effect)
import Effect.Uncurried (EffectFn2, mkEffectFn2, EffectFn1, mkEffectFn1)
import Type.Row (type (+))
import Row.Class (class SubRow)



foreign import transitionImpl :: forall props. ReactClass props


type Timeout =
  { "enter?" :: Milliseconds
  , "exit?" :: Milliseconds
  }

timeoutAll :: Milliseconds -> Timeout
timeoutAll x = { "enter?": x, "exit?": x }

type EnterEventHandler = EffectFn2 HTMLElement Boolean Unit

-- ^ Builds an entering event handler - a function of the emitting node,
-- and whether or not the node "is appearing" -
-- see https://reactcommunity.org/react-transition-group/transition#Transition-prop-onEnter for more
-- details
enterEventHandler :: (HTMLElement -> Boolean -> Effect Unit) -> EnterEventHandler
enterEventHandler = mkEffectFn2

type ExitEventHandler = EffectFn1 HTMLElement Unit

-- ^ Builds an exiting event handler - a effectful function of the emitting node.
exitEventHandler :: (HTMLElement -> Effect Unit) -> ExitEventHandler
exitEventHandler = mkEffectFn1


type TransitionProps r =
  ( in :: Boolean -- ^ Default: `false`
  , mountOnEnter :: Boolean -- ^ Default: `false`
  , unmountOnExit :: Boolean -- ^ Default: `false`
  , appear :: Boolean -- ^ Default: `false`
  , enter :: Boolean -- ^ Default: `true`
  , exit :: Boolean -- ^ Default: `true`
  , timeout :: Timeout -- ^ Required if `addEndListener` isn't present
  , addEndListener :: EffectFn2 EventTarget EventListener Unit
  , onEnter :: EnterEventHandler
  , onEntering :: EnterEventHandler
  , onEntered :: EnterEventHandler
  , onExit :: ExitEventHandler
  , onExiting :: ExitEventHandler
  , onExited :: ExitEventHandler
  | r)


transition :: forall o
            . SubRow o (TransitionProps + ())
           => { | o } -> Array ReactElement -> ReactElement
transition = unsafeCreateElement transitionImpl

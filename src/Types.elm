module Types exposing (..)

type AppMode
    = ProfileMode
    | PlayMode

type alias Model =
    { appMode : AppMode
    }


type Msg
    = Play
    | Profile
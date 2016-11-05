module State exposing (..)

import Types exposing (..)

init : ( Model, Cmd Msg )
init =
    (Model ProfileMode, Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update action app =
    case action of
        Play ->
            ({app | appMode = PlayMode}, Cmd.none)


        Profile ->
            ({app | appMode = ProfileMode}, Cmd.none)

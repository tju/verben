module State exposing (..)

import Dom
import Task exposing (..)

import Types exposing (..)


init : ( Model, Cmd Msg )
init =
    (Model ProfileMode, Cmd.none)


subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update action app =
    case action of
        NoOp ->
            app ! []

        Play ->
            ({app | appMode = PlayMode}, Cmd.none)

        Profile ->
            ({app | appMode = ProfileMode}, Cmd.none)

        TestFocus ->
            (app, goFocus )


goFocus =
    Task.perform (\_ -> NoOp) (\_ -> NoOp) ( Dom.focus "field2")
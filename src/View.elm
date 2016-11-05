module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App as App
import Html.Attributes exposing (type', action, class, method, href, id, value)
import VirtualDom

import Types exposing (..)

rootView : Model -> VirtualDom.Node Msg
rootView app =
    case app.appMode of
        ProfileMode ->
            div []
                [ div [] [text "This is your profile" ]
                , div [] [ input [type' "button", value "Play", onClick Play] []]
                ]

        PlayMode ->
            div []
                [ div [] [text "Play Mode" ]
                , div [] [ input [type' "button", value "go to profile", onClick Profile] []]
                , div [] [ input [type' "button", value "test focus change", onClick TestFocus] []]
                , div []
                    [ input [type' "text", id "field1", value "aaa" ][]
                    , input [type' "text", id "field2", value "bbb" ][]
                    ]
                ]


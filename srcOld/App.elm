module App exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App as App
import Html.Attributes exposing (type', action, class, method, href, id, value)
import Form exposing (..)
import Profile
import VirtualDom




init : ( Model, Cmd Msg )
init =
    ( { dataStore = getDataStore
      , appMode = ShowProfile
      , profile = Profile.initialProfile
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Start
    | GoToProfile


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Start ->
            ( { model | appMode = PlayLevel }, Cmd.none )



-- VIEW


view : Model -> VirtualDom.Node Msg
view app =
    case app.appMode of
        ShowProfile ->
            div []
                [ Profile.view app.profile
                , div [ class "row" ]
                    [ button
                        [ class "button"
                        , type' "button"
                        , onClick Start
                        ]
                        [ text "Start" ]
                    ]
                ]

        PlayLevel ->
            div []
                [ Form.view app.form
                , div [ class "row" ]
                    [ button
                        [ class "button"
                        , type' "button"
                        , onClick GoToProfile
                        ]
                        [ text "Start" ]
                    ]
                , input [id "field1", value "aaa" ][]
                , input [id "field2", value "bbb" ][]
                ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main =
    App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }





module App exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App as App
import Html.Attributes exposing (type', action, class, method, href)
import DataStore exposing (..)
import Form
import Data exposing (..)
import Profile
import Level
import VirtualDom


type AppMode
    = ShowProfile
    | PlayLevel


type alias Model =
    { dataStore :
        List Data
        -- not sure!( should be something that gives dataStore)
    , level : Level.Model
    , appMode : AppMode
    , profile : Profile.Model
    }


init : ( Model, Cmd Msg )
init =
    ( { dataStore = getDataStore
      , level = Level.init
      , appMode = ShowProfile
      , profile = Profile.initialProfile
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = StartLevel
    | LevelMsg Level.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartLevel ->
            ( { model | appMode = PlayLevel }, Cmd.none )

        LevelMsg lmsg ->
            ( { model
                | level = Level.update lmsg model.level
              }
            , Cmd.none
            )



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
                        , onClick StartLevel
                        ]
                        [ text "Start" ]
                    ]
                ]

        PlayLevel ->
            div [] [ App.map LevelMsg (Level.view app.level) ]



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

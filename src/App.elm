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


main =
    App.beginnerProgram
        { model = initialAppModel
        , view = view
        , update = update
        }


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


initialAppModel : Model
initialAppModel =
    { dataStore = getDataStore
    , level = Level.init
    , appMode = ShowProfile
    , profile = Profile.initialProfile
    }



-- UPDATE


type Msg
    = StartLevel
    | LevelMsg Level.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        StartLevel ->
            { model | appMode = PlayLevel }

        LevelMsg lmsg ->
            { model
                | level = Level.update lmsg model.level
                }


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

module App exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App as App
import Html.Attributes exposing (type', action, class, method, href)
import DataStore exposing (..)
import Form exposing (..)
import Data exposing (..)
import Profile exposing (..)


main =
    App.beginnerProgram
        { model = initialAppModel
        , view = view
        , update = update
        }


type AppMode
    = ShowProfile
    | PlayLevel


type alias AppModel =
    { dataStore : List Data
    , form : Form.Form
    , appMode : AppMode
    , profile : Profile
    }


initialAppModel : AppModel
initialAppModel =
    { dataStore = getDataStore
    , form = Form.emptyForm
    , appMode = ShowProfile
    , profile = Profile.initialProfile
    }



-- UPDATE


type Msg
    = FormMsg Form.Msg
    | Next


update msg app =
    case msg of
        FormMsg fMsg ->
            { app | form = Form.update fMsg app.form }

        Next ->
            let
                ( newForm, ds ) =
                    getNextForm app
            in
                { app
                    | form = newForm
                    , dataStore = ds
                    , appMode = PlayLevel
                }


getNextForm : AppModel -> ( Form.Form, List Data )
getNextForm app =
    case app.dataStore of
        [] ->
            ( emptyForm, [] )

        h :: t ->
            case app.appMode of
                ShowProfile ->
                    ( initialForm h, t )

                PlayLevel ->
                    ( initialForm h, List.append t [ (Form.getData app.form) ] )



-- VIEW


view app =
    case app.appMode of
        ShowProfile ->
            div []
                [ Profile.view app.profile
                , div [ class "row" ]
                    [ button
                        [ class "button"
                        , type' "button"
                        , onClick Next
                        ]
                        [ text "Start" ]
                    ]
                ]

        PlayLevel ->
            div []
                [ div [] [ App.map FormMsg (Form.view app.form) ]
                , getNextButton app
                ]


getNextButton app =
    if app.form.checked then
        div [ class "row" ]
            [ button
                [ class "button"
                , type' "button"
                , onClick Next
                ]
                [ text "Next" ]
            ]
    else
        text ""
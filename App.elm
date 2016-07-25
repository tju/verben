module App exposing (..)

import DataStore exposing (..)
import Form exposing (..)
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.App as App
import Data exposing (..)


-- main =
--     App.beginnerProgram
--         { model = initialModel
--         , view = view
--         , update = update
--         }


type alias AppModel =
    { dataStore : List Data
    , form : Form.Form
    , initialState : Bool
    }


emptyForm =
    Form.initialForm (Data "" "" "" "" 0)


initialAppModel : AppModel
initialAppModel =
    { dataStore = getDataStore
    , form = emptyForm
    , initialState = True
    }


type Msg
    = FormMsg Form.Msg
    | Next



-- UPDATE


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
                    , initialState = False
                }


getNextForm : AppModel -> ( Form.Form, List Data )
getNextForm app =
    case app.dataStore of
        [] ->
            ( emptyForm, [] )

        h :: t ->
            if app.initialState then
                ( initialForm h, t )
            else
                ( initialForm h, List.append t [ (Form.getData app.form) ] )



-- VIEW


view model =
    div []
        [ h1 [] [ text "Verben ninja" ]
        , h2 [] [ text <| "Score:" ++ toString model.form.score ]
        , div []
            [ App.map FormMsg (Form.view model.form) ]
        , nextButton model
        , div [] [ text <| toString model ]
        ]


nextButton model =
    if model.initialState then
        button [ onClick Next ] [ text "Start" ]
    else if model.form.checked then
        button [ onClick Next ] [ text "Next" ]
    else
        text ""


main =
    App.beginnerProgram
        { model = initialAppModel
        , view = view
        , update = update
        }

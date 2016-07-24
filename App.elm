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
    , form : Form.Model
    , score : Int
    , isFormVisible : Bool
    }


emptyForm =
    Form.initialForm (Data "" "" "" "" 0)


initialAppModel : AppModel
initialAppModel =
    { dataStore = getDataStore
    , form = emptyForm
    , score = 0
    , isFormVisible = False
    }


type Msg
    = FormMsg Form.Msg
    | Next



-- UPDATE


update msg model =
    case msg of
        FormMsg fMsg ->
            { model | form = Form.update fMsg model.form }

        Next ->
            let
                ( newForm, ds ) =
                    getNextForm model
            in
                { model
                    | form = newForm
                    , dataStore = ds
                }


getNextForm : AppModel -> ( Form.Model, List Data )
getNextForm model =
    case model.dataStore of
        [] ->
            ( emptyForm, [] )

        h :: t ->
            ( initialForm h, t )



-- VIEW


view model =
    div []
        [ h1 [] [ text "Verben ninja" ]
        , h2 [] [ text <| "Score:" ++ toString model.score ]
        , div []
            [ App.map FormMsg (Form.view model.form) ]
        , button [ onClick Next ] [ text "Next" ]
        ]


main =
    App.beginnerProgram
        { model = initialAppModel
        , view = view
        , update = update
        }

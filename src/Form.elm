module Form exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Events exposing (onInput, onClick)
import Field
import Data exposing (..)
import Html.Attributes exposing (type', action, class, method, href)


-- main =
--     App.beginnerProgram
--         { model = initialModel
--         , view = view
--         , update = update
--         }
-- MODEL


type alias Form =
    { f1 : Field.Field
    , f2 : Field.Field
    , f3 : Field.Field
    , infinitiv : String
    , score : Int
    , checked : Bool
    }


initialForm : Data -> Form
initialForm data =
    { f1 = Field.Field "Präsens (3. Person Singular)" data.f1 "" Field.None
    , f2 = Field.Field "Präteritum (3. Person Singular)" data.f2 "" Field.None
    , f3 = Field.Field "Perfekt (3. Person Singular)" data.f3 "" Field.None
    , infinitiv = data.infinitiv
    , score = data.score
    , checked = False
    }


getData : Form -> Data
getData form =
    { f1 = form.f1.expected
    , f2 = form.f2.expected
    , f3 = form.f3.expected
    , infinitiv = form.infinitiv
    , score = form.score
    }



-- UPDATE


type Msg
    = Check
    | F1Msg Field.Msg
    | F2Msg Field.Msg
    | F3Msg Field.Msg


update msg model =
    case msg of
        Check ->
            let
                f1 =
                    Field.update Field.Check model.f1

                f2 =
                    Field.update Field.Check model.f2

                f3 =
                    Field.update Field.Check model.f3

                score =
                    if hasErrors model then
                        model.score - 1
                    else
                        model.score + 1
            in
                { model
                    | f1 = f1
                    , f2 = f2
                    , f3 = f3
                    , score = score
                    , checked = True
                }

        F1Msg msg ->
            { model | f1 = Field.update msg model.f1 }

        F2Msg msg ->
            { model | f2 = Field.update msg model.f2 }

        F3Msg msg ->
            { model | f3 = Field.update msg model.f3 }


hasErrors : Form -> Bool
hasErrors form =
    if (form.f1.status == Field.Success && form.f2.status == Field.Success && form.f3.status == Field.Success) then
        False
    else
        True



-- VIEW


view model =
    case model.infinitiv of
        "" ->
            div [] []

        str ->
            form [ action "", class "form", method "" ]
                [ div [ class "header header-primary text-center" ]
                    [ h4 []
                        [ text "Unregelmäßige Verben" ]
                    , h2 [] [ text str ]
                    ]
                    , div [ class "content" ]
                        [ App.map F1Msg (Field.view model.f1)
                        , App.map F2Msg (Field.view model.f2)
                        , App.map F3Msg (Field.view model.f3)
                        ]
                , div
                    [ class "footer text-center"
                    , type' "button"
                    , onClick Check
                    ]
                    [ a [ class "btn btn-primary btn-lg", href "#pablo" ]
                        [ text "Check" ]
                    ]
                ]
                    
                



-- case model.infinitiv of
--     "" ->
--         div [] []
--     str ->
--         div []
--             [ App.map F1Msg (Field.view model.f1)
--             , App.map F2Msg (Field.view model.f2)
--             , App.map F3Msg (Field.view model.f3)
--             , checkButton model.checked
--             ]


checkButton checked =
    if checked then
        text ""
    else
        button
            [ type' "button"
            , onClick Check
            ]
            [ text "Check" ]

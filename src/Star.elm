-- MVU Architecture (Elm Architecture)
-- Model, View, Update
-- Model / State

-- Model -> View -> Update (create a new model with the state changes)

module Star exposing (main)

import Html exposing (..)
import Html.Attributes exposing (class, src)
import Html.Events exposing (onClick)
import Browser

type Msg = 
    Like | Unlike

initialModel : { caption : String , liked : Bool }
initialModel = 
    {
        caption = "<--Click Me!"
        ,liked = False
    }

viewPhoto : { caption : String, liked : Bool } -> Html Msg
viewPhoto model = 
    let 
        buttonType = 
            if model.liked then "star" else "star_outline"
        msg = 
            if model.liked then Unlike else Like
    in

    div [ class "detailed-photo" ]
            [
                div [ class "photo-info" ]
                [ div [ class "star-button" ]
                    [ span 
                        [ class "material-icons md-60", onClick msg]
                        [ text buttonType ]
                        , h2 [ class "caption" ] [ text model.caption ] 
                    ]
                ]
            ]

view : { caption : String, liked : Bool } -> Html Msg
view model = 
    div []
    [
        div [class "header"]
        [h1 [] [ text "Enjoy with the star!" ] ]
        ,div [ class "content-flow" ]
        [
            viewPhoto model
        ]
    ]

update : Msg -> { caption : String, liked : Bool } -> { caption : String, liked : Bool }
update msg model = 
    case msg of 
        Like -> 
            { model | liked = True }
        Unlike ->
            { model | liked = False }
main : Program () { caption : String, liked : Bool } Msg
main = 
    Browser.sandbox 
    {
        init = initialModel
        ,view = view
        ,update = update
    }
module UI.Pages.Contact exposing (view)

import Types exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import UI.Common exposing (loremIpsum)


view : ServicesContent -> Html msg
view content =
    div []
        [ text content.caption
        , loremIpsum
        , loremIpsum
        , loremIpsum
        , loremIpsum
        , loremIpsum
        , loremIpsum
        ]

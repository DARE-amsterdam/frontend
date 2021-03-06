module Icons.Logo exposing (logo)

import Html.Styled exposing (Html, div)
import Svg.Styled exposing (..)
import Svg.Styled.Attributes exposing (..)
import Css exposing (..)
import Style exposing (..)


logo : String -> Html msg
logo color =
    let
        logoDesktop =
            styled svg
                [ Css.display none
                , bpMediumUp
                    [ Css.display block
                    ]
                ]

        logoMobile =
            styled svg
                [ Css.display block
                , Css.top (px 5)
                , position relative
                , bpMediumUp
                    [ Css.display none
                    ]
                ]


    in
    div []
        [ logoDesktop [ Svg.Styled.Attributes.height "22", version "1.1", Svg.Styled.Attributes.viewBox "0 0 120 22", Svg.Styled.Attributes.width "120" ]
            [ g [ id "logo", Svg.Styled.Attributes.transform "translate(3085 -8266)" ]
                [ g [ id "clutch" ]
                    [ node "use"
                        [ Svg.Styled.Attributes.transform "translate(-3085 8266)", xlinkHref "#logo_fill" ]
                        []
                    , text ""
                    ]
                ]
            , defs []
                [ Svg.Styled.path [ d "M 28.5 0L 23.5 0L 23.5 21.5L 28.5 21.5L 28.5 0ZM 8.5 22C 10.8472 22 12.9722 21.0488 14.5105 19.5107L 10.9749 15.9746C 10.3416 16.6084 9.46655 17 8.5 17C 6.56689 17 5 15.4326 5 13.5C 5 11.5674 6.56689 10 8.5 10C 9.46655 10 10.3416 10.3916 10.9749 11.0254L 14.5103 7.48926C 12.9722 5.95117 10.8472 5 8.5 5C 3.80566 5 0 8.80566 0 13.5C 0 18.1943 3.80566 22 8.5 22ZM 47.5 5.5L 52.5 5.5L 52.5 14.5C 52.5 18.6426 49.1421 22 45 22C 40.8579 22 37.5 18.6426 37.5 14.5L 37.5 5.5L 42.5 5.5L 42.5 14.5C 42.5 15.8809 43.6194 17 45 17C 46.3806 17 47.5 15.8809 47.5 14.5L 47.5 5.5ZM 65 0L 70 0L 70 5.5L 72.5 5.5L 72.5 10.5L 70 10.5L 70 22L 65 22L 65 10.5L 62.5 10.5L 62.5 5.5L 65 5.5L 65 0ZM 89.5 22C 91.8472 22 93.9722 21.0488 95.5103 19.5107L 91.9749 15.9746C 91.3416 16.6084 90.4666 17 89.5 17C 87.5669 17 86 15.4326 86 13.5C 86 11.5674 87.5669 10 89.5 10C 90.4666 10 91.3416 10.3916 91.9749 11.0254L 95.5103 7.48926C 93.9722 5.95117 91.8472 5 89.5 5C 84.8057 5 81 8.80566 81 13.5C 81 18.1943 84.8057 22 89.5 22ZM 113.75 5C 112.343 5 111.045 5.46484 110 6.24902L 110 0L 105 0L 105 21.5L 107.5 21.5L 110 21.5L 110 12.5C 110 11.1191 111.119 10 112.5 10C 113.881 10 115 11.1191 115 12.5L 115 21.5L 120 21.5L 120 11.25C 120 7.79785 117.202 5 113.75 5Z", fillRule "evenodd", id "logo_fill", Svg.Styled.Attributes.fill <| "#" ++ color ]
                    []
                , text ""
                ]
            ]
        , logoMobile [ Svg.Styled.Attributes.width "15", Svg.Styled.Attributes.height "17" ] [ Svg.Styled.path [ Svg.Styled.Attributes.fill <| "#" ++ color, fillRule "evenodd", d "M14.51 14.51a8.5 8.5 0 1 1 0-12.02l-3.54 3.54A3.49 3.49 0 0 0 5 8.5a3.5 3.5 0 0 0 5.97 2.47l3.54 3.54z", clipRule "evenodd" ] [] ]
        ]

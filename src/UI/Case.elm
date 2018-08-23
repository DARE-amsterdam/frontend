module UI.Case exposing (view)

import Types exposing (..)
import Html.Styled exposing (..)
import Css exposing (..)
import Html.Styled.Attributes exposing (class, href)
import UI.Common exposing (button, addLink, loremIpsum, backgroundImg)
import UI.Blocks
import Dict
import Style exposing (..)
import Wagtail


overlayZoom : { time : Float, delay : Float, transition : String }
overlayZoom =
    { time = 0.35
    , delay = 0
    , transition = "cubic-bezier(0.43, 0.15, 0.2, 1)"
    }


outerWrapper : Bool -> List (Attribute msg) -> List (Html msg) -> Html msg
outerWrapper active =
    let
        extraStyle =
            if active then
                []
            else
                [ zIndex (int 0)
                ]
    in
        styled div <|
            [ zIndex (int 80)
            , position fixed
            , top zero
            , left zero
            , width (vw 100)
            , height (vh 100)
            ]
                ++ extraStyle


overlayWrapper : Bool -> List (Attribute msg) -> List (Html msg) -> Html msg
overlayWrapper active =
    div


staticView : Model -> Html Msg
staticView model =
    div [] []
    -- model.activeCase
    --     |> Maybe.map
    --         (\content ->
    --             outerWrapper True
    --                 []
    --                 [ overlay model [ content ] True
    --                 ]
    --         )
    --     |> Maybe.withDefault (outerWrapper False [] [])


-- overlay : Model -> List CaseContent -> Bool -> Html Msg
-- overlay model cases active =
--     List.head cases
--         |> Maybe.map
--             (\content ->
--                 let
--                     className =
--                         class <|
--                             "overlay overlay-"
--                                 ++ (toString content.meta.id)
--                                 ++ if active then
--                                     " active"
--                                    else
--                                     ""
-- 
--                     attributes =
--                         if active || model.menuState /= Closed then
--                             [ className
--                             ]
--                         else
--                             [ className
--                             ]
--                                 ++ (addLink <| "/" ++ (toString content.meta.id) ++ "/lorem")
-- 
--                     caseViews =
--                         if False then
--                             [ view content Cover ]
--                         else
--                             renderCases model cases
--                 in
--                     overlayWrapper active
--                         attributes
--                         caseViews
--             )
--         |> Maybe.withDefault (text "")


-- renderCases : Model -> List CaseContent -> List (Html a)
-- renderCases model cases =
--     []
    -- let
    --     activeIndex =
    --         model.activeCase
    --             |> Maybe.andThen
    --                 (\activeCase ->
    --                     cases
    --                         |> List.indexedMap (,)
    --                         |> List.filterMap
    --                             (\( index, content ) ->
    --                                 if content.meta.id == activeCase.meta.id then
    --                                     Just index
    --                                 else
    --                                     Nothing
    --                             )
    --                         |> List.head
    --                 )
    --             |> Maybe.withDefault 0
    -- in
    --     cases
    --         |> List.map
    --             (\content ->
    --                 model.cases
    --                     |> Dict.get content.meta.id
    --                     |> Maybe.withDefault content
    --             )
    --         |> List.indexedMap
    --             (\index content ->
    --                 if index <= activeIndex then
    --                     caseView content Open
    --                 else if index == (activeIndex + 1) then
    --                     caseView content Preview
    --                 else
    --                     text ""
    --             )


view : Wagtail.CasePageContent -> Html msg
view content =
    let
        wrapper =
            styled div <|
                [ position relative
                ]
    in
        wrapper []
            [ header content
            ]


header : Wagtail.CasePageContent -> Html msg
header content =
    div [] [ text content.meta.seoTitle ]


-- header : CaseState -> CaseContent -> Html msg
-- header state content =
--     let
--         wrapperAttributes =
--             content.backgroundImage
--                 |> Maybe.map
--                     (\image ->
--                         [ backgroundImg image ]
--                     )
--                 |> Maybe.withDefault []
-- 
--         image =
--             content.image
--                 |> Maybe.map (layerImage state content.theme)
--                 |> Maybe.withDefault (text "")
-- 
--         outerWrapper =
--             styled div <|
--                 [ backgroundColor (hex "292A32")
--                 , height (pct 100)
--                 , width (pct 100)
--                 ]
-- 
--         wrapper =
--             styled div <|
--                 [ backgroundColor (hex content.theme.backgroundColor)
--                 , backgroundPosition center
--                 , backgroundSize cover
--                 , transition "all" overlayZoom.time overlayZoom.delay overlayZoom.transition
--                 , position relative
--                 , cursor <|
--                     if state == Open then
--                         default
--                     else
--                         pointer
--                 , height (pct 100)
--                 , width (pct 100)
--                 , maxHeight (pct 100)
--                 , maxWidth (pct 100)
--                 , top zero
--                 , left zero
--                 , overflow hidden
--                 ]
--                     ++ if state == Preview then
--                         [ bpMediumUp
--                             [ transform <|
--                                 translate2
--                                     (pct -50)
--                                     (pct -50)
--                             , top (pct 50)
--                             , left (pct 50)
--                             , boxShadow4 zero (px 20) (px 50) (rgba 0 0 0 0.5)
--                             ]
--                         , bpMedium
--                             [ maxWidth (px 400)
--                             , maxHeight (px 569)
--                             ]
--                         , bpLarge
--                             [ maxWidth (px 500)
--                             , maxHeight (px 712)
--                             ]
--                         , bpXLargeUp
--                             [ maxWidth (px 660)
--                             , maxHeight (px 940)
--                             ]
--                         ]
--                        else
--                         []
-- 
--         titleTransition =
--             transition "all" overlayZoom.time 0 overlayZoom.transition
-- 
--         buttonWrapper =
--             styled div
--                 [ position absolute
--                 , titleTransition
--                 , if state == Open then
--                     opacity zero
--                   else
--                     opacity (int 1)
--                 , right (px 25)
--                 , bottom (px 25)
--                 , bpMedium
--                     [ right (px 40)
--                     , bottom (px 50)
--                     ]
--                 , bpLarge
--                     [ right (px 50)
--                     , bottom (px 100)
--                     ]
--                 , bpXLargeUp
--                     [ right (px 50)
--                     , bottom (px 100)
--                     ]
--                 ]
-- 
--         titleWrapper =
--             styled div <|
--                 [ color (hex content.theme.textColor)
--                 , position absolute
--                 , paddingRight (px 40)
--                 , titleTransition
--                 ]
--                     ++ if state == Open then
--                         [ left (px 25)
--                         , bottom (px 25)
--                         , bpMedium
--                             [ left (px 40)
--                             , bottom (px 40)
--                             ]
--                         , bpLarge
--                             [ left (px 40)
--                             , bottom (pct 50)
--                             , transform <| translateY (pct 50)
--                             ]
--                         , bpXLargeUp
--                             [ left (px 270)
--                             , bottom (pct 50)
--                             , transform <| translateY (pct 50)
--                             ]
--                         ]
--                        else
--                         [ left (px 25)
--                         , bottom (px 25)
--                         , bpMedium
--                             [ left (px 40)
--                             , bottom (px 50)
--                             ]
--                         , bpLarge
--                             [ left (px 50)
--                             , bottom (px 100)
--                             ]
--                         , bpXLargeUp
--                             [ left (px 50)
--                             , bottom (px 100)
--                             ]
--                         ]
-- 
--         title =
--             styled h1 <|
--                 if state == Open then
--                     [ maxWidth (px 1200)
--                     , titleTransition
--                     , fontSize (px 40)
--                     , lineHeight (px 50)
--                     , letterSpacing (px 2)
--                     , bpMedium
--                         [ fontSize (px 60)
--                         , lineHeight (px 70)
--                         , letterSpacing (px 3.5)
--                         , paddingRight (pct 20)
--                         , maxWidth (px 600)
--                         ]
--                     , bpLarge
--                         [ fontSize (px 72)
--                         , lineHeight (px 80)
--                         , letterSpacing (px 6.5)
--                         , maxWidth (px 700)
--                         ]
--                     , bpXLargeUp
--                         [ fontSize (px 120)
--                         , lineHeight (px 130)
--                         , letterSpacing (px 8.5)
--                         , maxWidth (px 900)
--                         ]
--                     ]
--                 else
--                     [ maxWidth (px 500)
--                     , titleTransition
--                     , fontSize (px 28)
--                     , lineHeight (px 32)
--                     , letterSpacing (px 2)
--                     , bpMedium
--                         [ fontSize (px 34)
--                         , lineHeight (px 40)
--                         , letterSpacing (px 2)
--                         ]
--                     , bpLarge
--                         [ fontSize (px 40)
--                         , lineHeight (px 50)
--                         , letterSpacing (px 2)
--                         ]
--                     , bpXLargeUp
--                         [ fontSize (px 50)
--                         , lineHeight (px 55)
--                         , letterSpacing (px 3.5)
--                         ]
--                     ]
-- 
--         caption =
--             styled span <|
--                 if state == Open then
--                     [ fontSize (px 26)
--                     , letterSpacing (px 2)
--                     , titleTransition
--                     ]
--                 else
--                     [ fontSize (px 22)
--                     , letterSpacing (px 2)
--                     , titleTransition
--                     ]
--     in
--         outerWrapper []
--             [ wrapper wrapperAttributes
--                 [ image
--                 , titleWrapper []
--                     [ title [] [ text content.meta.title ]
--                     , caption [] [ text content.meta.caption ]
--                     ]
--                 , buttonWrapper []
--                     [ UI.Common.button content.theme [] Nothing
--                     ]
--                 ]
--             ]
-- 
-- 
-- layerImage : CaseState -> Theme -> Image -> Html msg
-- layerImage state theme image =
--     let
--         size =
--             case state of
--                 Open ->
--                     [ width (pct 80)
--                     , height (pct 50)
--                     , bpLargeUp
--                         [ width (px 900)
--                         , height (px 900)
--                         ]
--                     ]
-- 
--                 _ ->
--                     [ width (pct 80)
--                     , height (pct 100)
--                     , bpLargeUp
--                         [ width (px 500)
--                         , height (px 500)
--                         ]
--                     ]
-- 
--         positionStyles =
--             [ transform <| translateY (pct -50)
--             , position absolute
--             , top (pct 50)
--             , right <|
--                 if state == Open then
--                     (pct 0)
--                 else
--                     (pct -30)
--             , bpLargeUp
--                 [ right <|
--                     if state == Open then
--                         (pct -10)
--                     else
--                         (pct -30)
--                 ]
--             ]
-- 
--         wrapper =
--             styled div <|
--                 [ transition "all" overlayZoom.time overlayZoom.delay overlayZoom.transition
--                 , backgroundSize contain
--                 , backgroundPosition center
--                 ]
--                     ++ positionStyles
--                     ++ size
--     in
--         wrapper [ backgroundImg image ] []
-- 
-- 
-- body : CaseContent -> Html Msg
-- body content =
--     let
--         wrapper =
--             styled div <|
--                 [ position relative
--                 ]
-- 
--         blocks =
--             content.body
--                 |> Maybe.andThen
--                     (\body ->
--                         Just <| UI.Blocks.streamfield body
--                     )
--                 |> Maybe.withDefault (text "")
--     in
--         wrapper []
--             [ intro content
--             , blocks
--             ]
-- 
-- 
-- intro : CaseContent -> Html Msg
-- intro content =
--     let
--         wrapper =
--             styled div
--                 [ width (pct 100)
--                 , backgroundColor (hex "f8f8f8")
--                 , color (hex "292A32")
--                 , padding2 (px 80) zero
--                 , bpMediumUp
--                     [ padding2 (px 200) zero
--                     ]
--                 ]
-- 
--         innerWrapper =
--             styled div
--                 [ width (pct 100)
--                 , maxWidth (px 1460)
--                 , position relative
--                 , margin auto
--                 ]
-- 
--         introWrapper =
--             styled div
--                 [ maxWidth (px 1345)
--                 , fontWeight (int 500)
--                 , padding2 zero (px 25)
--                 , bpMediumUp
--                     [ padding4 zero (px 385) zero (px 40)
--                     ]
--                 ]
-- 
--         introEl =
--             content.intro
--                 |> Maybe.map (UI.Blocks.richText)
--                 |> Maybe.withDefault (text "")
-- 
--         metaInfo =
--             styled div
--                 [ padding2 zero (px 25)
--                 , bpMediumUp
--                     [ position absolute
--                     , top zero
--                     , right zero
--                     , maxWidth (px 360)
--                     ]
--                 ]
-- 
--         metaSection =
--             styled div
--                 [ marginBottom (px 35)
--                 , lineHeight (px 34)
--                 , fontSize (px 22)
--                 , letterSpacing (px 3.85)
--                 ]
-- 
--         description =
--             styled div
--                 [ fontFamilies [ "Qanelas ExtraBold" ]
--                 ]
--     in
--         wrapper []
--             [ innerWrapper []
--                 [ introWrapper []
--                     [ introEl
--                     ]
--                 , metaInfo []
--                     [ metaSection []
--                         [ description [] [ text "Diensten" ]
--                         ]
--                     , metaSection []
--                         [ description [] [ text "Periode" ]
--                         , div [] [ text "Jan 2018" ]
--                         ]
--                     , metaSection []
--                         [ description [] [ text "Bekijken" ]
--                         , a [ href content.meta.websiteUrl ] [ text content.meta.websiteUrl ]
--                         ]
--                     ]
--                 ]
--             ]

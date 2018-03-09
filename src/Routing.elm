module Routing exposing (..)

import Types exposing (..)
import Navigation exposing (Location)
import UrlParser exposing (..)
import Api exposing (getPage, getCaseById)
import Task
import Http
import Dict


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute top
        , map CaseRoute (int </> string)
        , map ServicesRoute (s "services")
        , map CultureRoute (s "culture")
        ]


getPageTask : Model -> String -> Cmd Msg
getPageTask model pageType =
    case Dict.get pageType model.pages of
        Just page ->
            Task.succeed (Ok page)
                |> Task.perform OpenPage

        Nothing ->
            getPage pageType
                |> Http.send OpenPage


getCommand : Route -> Model -> Cmd Msg
getCommand route model =
    case route of
        ServicesRoute ->
            getPageTask model "service.ServicesPage"

        HomeRoute ->
            getPageTask model "home.HomePage"

        CultureRoute ->
            getPageTask model "culture.CulturePage"

        CaseRoute id title ->
            case Dict.get id model.cases of
                Just page ->
                    Task.succeed (Ok page)
                        |> Task.perform OpenCase

                Nothing ->
                    getCaseById id
                        |> Http.send OpenCase

        _ ->
            Cmd.none


parseLocation : Location -> Route
parseLocation location =
    case parsePath matchers location of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

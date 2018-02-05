module Types exposing (..)

import Navigation exposing (Location)
import Http
import Dict exposing (Dict)


type Msg
    = OnLocationChange Location
    | ChangeLocation String
    | OpenPage (Result Http.Error Page)
    | OpenCase (Result Http.Error CaseContent)
    | SetCasePosition ( Float, Float )
    | CloseMenu
    | OpenMenu MenuState


type alias Model =
    { route : Route
    , pages : Dict String Page
    , activePage : Maybe String
    , cases : Dict Int CaseContent
    , activeCase : Maybe CaseContent
    , activeOverlay : Maybe Int
    , casePosition : ( Float, Float )
    , menuState : MenuState
    }


type MenuState
    = Closed
    | OpenTop
    | OpenBottom


type Route
    = HomeRoute
    | ServicesRoute
    | CultureRoute
    | ContactRoute
    | CaseRoute Int String
    | NotFoundRoute


type Page
    = Home HomeContent
    | Services ServicesContent
    | Culture ServicesContent
    | Contact ServicesContent
    | Case CaseContent


type alias CaseContent =
    { id : Int
    , title : String
    , caption : String
    , releaseDate : String
    , websiteUrl : String
    , body : Maybe (List Block)
    }


type CaseState
    = Cover
    | Preview
    | Open


type alias HomeContent =
    { pageType : String
    , cases : List CaseContent
    }


type alias ServicesContent =
    { pageType : String
    , caption : String
    }


type Block
    = RichTextBlock String
    | QuoteBlock Quote


type alias Quote =
    { text : String
    , name : Maybe String
    }

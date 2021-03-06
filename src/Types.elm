module Types exposing (Direction(..), Flags, Model, Msg(..), Route(..), SiteIdentifier, initModel)

-- import Navigation exposing (Location)
-- import UI.State

import Browser
import Browser.Navigation
import UI.State
import Url
import Url.Parser exposing (Parser, map, oneOf, parse, string, top)
import Wagtail


type Msg
    = UrlChanged Url.Url
    | LinkClicked Browser.UrlRequest
    | NavigateToUrl String
    | WagtailMsg Wagtail.Msg
    | NavigationMsg UI.State.Msg
    | UpdateSlideshow String Direction
    | ShowNextLogo
    | SpinLogos Int
    | ScrollToCases
    | RandomInt Int
    | HoverBurger
    | NoOp


type Direction
    = Left
    | Right


type alias Model =
    { flags : Flags
    , key : Browser.Navigation.Key
    , route : Route
    , overlayState : UI.State.OverlayState
    , navigationState : UI.State.NavigationState
    , navigationTree : Maybe UI.State.NavigationTree
    , contactInformation : Maybe UI.State.ContactInformation
    , imageIndex : Int
    }


initModel : Flags -> Browser.Navigation.Key -> Model
initModel flags key =
    { flags = flags
    , key = key
    , route = UndefinedRoute
    , overlayState =
        { active = False
        , parts = ( Nothing, Nothing )
        }
    , navigationState = UI.State.Closed
    , navigationTree = Nothing
    , contactInformation = Nothing
    , imageIndex = 0
    }


type alias SiteIdentifier =
    Maybe String


type Route
    = UndefinedRoute
    | WagtailRoute SiteIdentifier Wagtail.Page
    | NotFoundRoute SiteIdentifier
    | ErrorRoute


type alias Flags =
    { apiUrl : String }

module Decoders exposing (..)

import Json.Decode as Decode
import Types exposing (..)



-- mapCoverContent : String -> String -> { text : String, link : String }
-- mapCoverContent text link =
--     { text = text
--     , link = link
--     }
--
--
-- decodeCultureContent : Decode.Decoder Page
-- decodeCultureContent =
--     Decode.map Culture <|
--         Decode.map5 CultureContent
--             (Decode.at [ "meta", "type" ] Decode.string)
--             (Decode.field "people" <| Decode.list (Decode.field "value" decodePerson))
--             (Decode.field "cases" <| Decode.list (Decode.field "value" <| decodeCaseContent))
--             (Decode.maybe <| Decode.field "next_event" decodeEvent)
--             (Decode.maybe <| Decode.field "ideas" <| Decode.list Decode.string)
--
--
-- decodeEvent : Decode.Decoder Event
-- decodeEvent =
--     Decode.map3 Event
--         (Decode.field "date" Decode.string)
--         (Decode.field "title" Decode.string)
--         (Decode.maybe <| Decode.field "image" decodeImage)
--
--
-- decodeCaseContent : Decode.Decoder CaseContent
-- decodeCaseContent =
--     Decode.map6 CaseContent
--         (Decode.map5
--             (\id title caption releaseDate websiteUrl ->
--                 { id = id
--                 , title = title
--                 , caption = caption
--                 , releaseDate = releaseDate
--                 , websiteUrl = websiteUrl
--                 }
--             )
--             (Decode.field "id" Decode.int)
--             (Decode.field "title" Decode.string)
--             (Decode.field "caption" Decode.string)
--             (Decode.field "release_date" Decode.string)
--             (Decode.field "website_url" Decode.string)
--         )
--         (Decode.maybe <| Decode.field "intro" Decode.string)
--         (Decode.maybe <| Decode.field "body" decodeBlocks)
--         (Decode.maybe <| Decode.field "image_src" decodeImage)
--         (Decode.maybe <| Decode.field "background_image_src" decodeImage)
--         decodeTheme
--
--
-- decodeServicesContent : Decode.Decoder Page
-- decodeServicesContent =
--     Decode.map Services <|
--         Decode.map3 ServicesContent
--             (Decode.at [ "meta", "type" ] Decode.string)
--             (Decode.field "caption" Decode.string)
--             (Decode.map3
--                 (\title richtext services ->
--                     { title = title
--                     , body = richtext
--                     , services = services
--                     }
--                 )
--                 (Decode.field "title" Decode.string)
--                 (Decode.field "richtext" Decode.string)
--                 (Decode.field "services" <|
--                     Decode.list <|
--                         Decode.map2
--                             (\text service -> { text = text, service = service })
--                             (Decode.field "text" Decode.string)
--                             (Decode.field "service" decodeService)
--                 )
--                 |> Decode.field "value"
--                 |> Decode.list
--                 |> Decode.field "body"
--             )
--
--
-- decodeService : Decode.Decoder Service
-- decodeService =
--     Decode.map3 Service
--         (Decode.field "title" Decode.string)
--         (Decode.field "body" Decode.string)
--         (Decode.field "slides" <| Decode.list decodeImage)
--
--
-- decodePerson : Decode.Decoder Person
-- decodePerson =
--     Decode.map6 Person
--         (Decode.field "first_name" Decode.string)
--         (Decode.field "last_name" Decode.string)
--         (Decode.field "job_title" Decode.string)
--         (Decode.field "photo" decodeImage)
--         (Decode.maybe <| Decode.field "email" Decode.string)
--         (Decode.maybe <| Decode.field "phone" Decode.string)
--
--
-- decodeImage : Decode.Decoder Image
-- decodeImage =
--     Decode.map2 Image
--         (Decode.field "url" Decode.string)
--         (Decode.maybe <| Decode.field "caption" Decode.string)
--
--
-- decodeTheme : Decode.Decoder Theme
-- decodeTheme =
--     Decode.map3 Theme
--         (Decode.field "background_color" Decode.string)
--         (Decode.oneOf
--             [ Decode.field "text_color" Decode.string
--             , Decode.succeed "fff"
--             ]
--         )
--         (Decode.maybe <|
--             Decode.map2 (,)
--                 (Decode.field "background_position_x" Decode.string)
--                 (Decode.field "background_position_y" Decode.string)
--         )
--
--
-- decodeBlocks : Decode.Decoder (List Block)
-- decodeBlocks =
--     Decode.field "type" Decode.string
--         |> Decode.andThen
--             (\blockType ->
--                 case blockType of
--                     "quote" ->
--                         Decode.field "value" decodeQuote
--
--                     "image" ->
--                         Decode.field "value" decodeImageBlock
--
--                     "background" ->
--                         Decode.field "value" decodeBackgroundBlock
--
--                     "content" ->
--                         Decode.field "value" decodeContentBlock
--
--                     "columns" ->
--                         Decode.field "value" decodeColumns
--
--                     _ ->
--                         Decode.succeed (UnknownBlock blockType)
--             )
--         |> Decode.list
--
--
-- decodeColumns : Decode.Decoder Block
-- decodeColumns =
--     Decode.map2 ColumnBlock
--         (Decode.field "left" decodeColumn)
--         (Decode.field "right" decodeColumn)
--
--
-- decodeColumn : Decode.Decoder Column
-- decodeColumn =
--     Decode.map3 Column
--         decodeTheme
--         (Decode.maybe <| Decode.field "image" decodeImage)
--         (Decode.maybe <| Decode.field "rich_text" Decode.string)
--
--
-- decodeQuote : Decode.Decoder Block
-- decodeQuote =
--     Decode.map2 Quote
--         (Decode.field "text" Decode.string)
--         (Decode.maybe <| Decode.field "name" Decode.string)
--         |> Decode.andThen
--             (\quote ->
--                 Decode.succeed <| QuoteBlock quote
--             )
--
--
-- decodeImageBlock : Decode.Decoder Block
-- decodeImageBlock =
--     Decode.map2
--         ImageBlock
--         decodeTheme
--         (Decode.field "image" decodeImage)
--
--
-- decodeBackgroundBlock : Decode.Decoder Block
-- decodeBackgroundBlock =
--     Decode.map BackgroundBlock
--         (Decode.field "image" decodeImage)
--
--
-- decodeContentBlock : Decode.Decoder Block
-- decodeContentBlock =
--     Decode.map2
--         ContentBlock
--         decodeTheme
--         (Decode.field "rich_text" Decode.string)

module Annotation.Rectangle exposing
    ( Rectangle, fromPointsPair, translate, area
    , encode, decoder
    )

{-| A simple rectangle type and helper functions.


# Rectangle manipulations

@docs Rectangle, fromPointsPair, translate, area


# Rectangle encoding and decoding

@docs encode, decoder

-}

import Annotation.Point as Point exposing (Point)
import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)


{-| Rectangle type, defined by its boundaries.
-}
type alias Rectangle =
    { left : Float
    , right : Float
    , top : Float
    , bottom : Float
    }


{-| Create a rectangle from two opposite corner points.
-}
fromPointsPair : ( Point, Point ) -> Rectangle
fromPointsPair ( p1, p2 ) =
    { left = min p1.x p2.x
    , right = max p1.x p2.x
    , top = min p1.y p2.y
    , bottom = max p1.y p2.y
    }


{-| Translate the rectangle by the given vector.
-}
translate : ( Float, Float ) -> Rectangle -> Rectangle
translate ( tx, ty ) { left, right, top, bottom } =
    { left = left + tx
    , right = right + tx
    , top = top + ty
    , bottom = bottom + ty
    }


{-| Compute the area of the rectangle.
-}
area : Rectangle -> Float
area { left, right, top, bottom } =
    (right - left) * (bottom - top)



-- ENCODING / DECODING ###############################################


{-| Encode a rectangle into a JS value.
-}
encode : Rectangle -> Value
encode { left, right, top, bottom } =
    Encode.object
        [ ( "left", Encode.float left )
        , ( "right", Encode.float right )
        , ( "top", Encode.float top )
        , ( "bottom", Encode.float bottom )
        ]


{-| Decode a rectangle from a JS value.
-}
decoder : Decoder Rectangle
decoder =
    Decode.map4 Rectangle
        (Decode.field "left" Decode.float)
        (Decode.field "right" Decode.float)
        (Decode.field "top" Decode.float)
        (Decode.field "bottom" Decode.float)

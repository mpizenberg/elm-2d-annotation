module Annotation.Svg exposing
    ( pointStyled, lineStyled, polygonStyled, rectangleStyled
    , LineStyle, FillStyle, lineStyleAttributes, fillStyleAttribute
    )

{-| Defines types for visual styles.


# Shapes

@docs pointStyled, lineStyled, polygonStyled, rectangleStyled


# Styling

@docs LineStyle, FillStyle, lineStyleAttributes, fillStyleAttribute

-}

import Annotation.Color as Color exposing (Color)
import Annotation.Line exposing (Line)
import Annotation.Point exposing (Point)
import Annotation.Rectangle exposing (Rectangle)
import Svg exposing (Svg)
import Svg.Attributes



-- SHAPES ############################################################


{-| Draw a point with given styles and radius.
-}
pointStyled : Maybe LineStyle -> Maybe FillStyle -> Float -> Point -> Svg msg
pointStyled maybeLineStyle maybeFillStyle radius { x, y } =
    let
        attributes =
            Svg.Attributes.cx (String.fromFloat x)
                :: Svg.Attributes.cy (String.fromFloat y)
                :: Svg.Attributes.r (String.fromFloat radius)
                :: fillStyleAttribute maybeFillStyle
                :: lineStyleAttributes maybeLineStyle
    in
    Svg.circle attributes []


{-| Draw a line with a given style.
-}
lineStyled : Maybe LineStyle -> Line -> Svg msg
lineStyled maybeLineStyle line =
    let
        attributes =
            pointsAttribute line
                :: Svg.Attributes.fill "none"
                :: lineStyleAttributes maybeLineStyle
    in
    Svg.polyline attributes []


{-| Draw a closed polygon with a given style.
The line is automatically closed, no need to have the same first and last point.
-}
polygonStyled : Maybe LineStyle -> Maybe FillStyle -> Line -> Svg msg
polygonStyled maybeLineStyle maybeFillStyle line =
    let
        attributes =
            pointsAttribute line
                :: fillStyleAttribute maybeFillStyle
                :: lineStyleAttributes maybeLineStyle
    in
    Svg.polygon attributes []


pointsAttribute : List Point -> Svg.Attribute msg
pointsAttribute points =
    Svg.Attributes.points (String.join " " (List.map coordinatesString points))


coordinatesString : Point -> String
coordinatesString { x, y } =
    String.concat [ String.fromFloat x, ",", String.fromFloat y ]


{-| Draw a rectangle with given styles.
-}
rectangleStyled : Maybe LineStyle -> Maybe FillStyle -> Rectangle -> Svg msg
rectangleStyled maybeLineStyle maybeFillStyle { left, right, top, bottom } =
    let
        attributes =
            Svg.Attributes.x (String.fromFloat left)
                :: Svg.Attributes.y (String.fromFloat top)
                :: Svg.Attributes.width (String.fromFloat (right - left))
                :: Svg.Attributes.height (String.fromFloat (bottom - top))
                :: fillStyleAttribute maybeFillStyle
                :: lineStyleAttributes maybeLineStyle
    in
    Svg.rect attributes []



-- STYLING ###########################################################


{-| Line style.
-}
type alias LineStyle =
    { width : Float
    , color : Color
    }


{-| Filling style.
-}
type alias FillStyle =
    Color


{-| Line style as SVG attributes.
-}
lineStyleAttributes : Maybe LineStyle -> List (Svg.Attribute msg)
lineStyleAttributes maybeLineStyle =
    case maybeLineStyle of
        Nothing ->
            [ Svg.Attributes.stroke "none" ]

        Just { width, color } ->
            [ Svg.Attributes.strokeWidth (String.fromFloat width)
            , Svg.Attributes.stroke (Color.toString color)
            ]


{-| Filling style as SVG attributes.
-}
fillStyleAttribute : Maybe FillStyle -> Svg.Attribute msg
fillStyleAttribute maybeFillStyle =
    case maybeFillStyle of
        Nothing ->
            Svg.Attributes.fill "none"

        Just color ->
            Svg.Attributes.fill (Color.toString color)

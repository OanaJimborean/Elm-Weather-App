module Util exposing (groupBy, maximumBy, maybeToList, minimumBy, zipFilter)

{-| Module containing utility functions
-}


{-| Description for minimumBy

    minimumBy .x [ { x = 1, y = 2 } ] --> Just {x = 1, y = 2}

    minimumBy .x [] --> Nothing

    minimumBy (modBy 10) [ 16, 23, 14, 5 ] --> Just 23

-}
minimumBy : (a -> comparable) -> List a -> Maybe a
minimumBy min l =
    let 
        comparableL = List.map min l
        minF : comparable -> comparable -> comparable
        minF a b = 
            if a < b then
                a
            else b
        criteria = 
            case comparableL of
            [] -> Nothing
            x::xs -> Just (List.foldl minF x xs)
    in
        case criteria of
            Nothing -> Nothing
            Just a -> 
                List.head (List.filter (\x -> min x == a) l)
    --Debug.todo "Implement Util.minimumBy"


{-| Description for maximumBy

    maximumBy .x [ { x = 1, y = 2 } ] --> Just {x = 1, y = 2}

    maximumBy .x [] --> Nothing

    maximumBy (modBy 10) [ 16, 23, 14, 5 ] --> Just 16

-}
maximumBy : (a -> comparable) -> List a -> Maybe a
maximumBy max l =
    let 
        comparableL = List.map max l
        maxF : comparable -> comparable -> comparable
        maxF a b = 
            if a > b then
                a
            else b
        criteria = 
            case comparableL of
            [] -> Nothing
            x::xs -> Just (List.foldl maxF x xs)
    in
        case criteria of
            Nothing -> Nothing
            Just a -> 
                List.head (List.filter (\x -> max x == a) l)    
    --Debug.todo "Implement Util.maximumBy"


{-| Group a list

    groupBy .x [ { x = 1 } ] --> [(1, [{x = 1}])]

    groupBy (modBy 10) [ 11, 12, 21, 22 ] --> [(1, [11, 21]), (2, [12, 22])]

    groupBy identity [] --> []

-}
groupBy : (a -> b) -> List a -> List ( b, List a )
groupBy func a =
    let
        newList = a |> List.map func

        removeDupe : List t -> List t -> List t
        removeDupe l aux =
            case l of
                [] -> List.reverse aux
                x::xs ->
                    if (aux |> List.filter (\y -> y == x) |> List.length) == 0 then
                        removeDupe xs (x::aux)
                    else
                        removeDupe xs aux

    in  
        List.map (\x -> (x, List.filter(\y -> func y == x) a)) (removeDupe newList [])   
    --Debug.todo "Implement Util.groupBy"


{-| Transforms a Maybe into a List with one element for Just, and an empty list for Nothing

    maybeToList (Just 1) --> [1]

    maybeToList Nothing --> []

-}
maybeToList : Maybe a -> List a
maybeToList def =
    case def of
        Nothing -> [] 
        Just x -> [x]
    --Debug.todo "Implement Util.maybeToList"


{-| Filters a list based on a list of bools

    zipFilter [ True, True ] [ 1, 2 ] --> [1, 2]

    zipFilter [ False, False ] [ 1, 2 ] --> []

    zipFilter [ True, False, True, False ] [ 1, 2, 3, 4 ] --> [1, 3]

-}
zipFilter : List Bool -> List a -> List a
zipFilter p l =
    case p of
         [] -> []
         x::xs -> case x of
                    True -> case l of 
                                [] -> []
                                y::ys -> y::zipFilter xs ys
                    False ->case l of
                                [] -> []
                                y::ys -> zipFilter xs ys
    --Debug.todo "Implement Util.zipFilter"

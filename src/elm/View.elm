module View exposing (view)

import Html exposing (Html, div, a, img, text)
import Html.Attributes exposing (id, class, src, href, style)
import Model exposing (Model)
import Update exposing (Msg(..))
import Contents exposing (..)


-- Profile


createProfile : Profile -> Html Msg
createProfile profile =
    div [ id "profile" ]
        [ div [ id "profile-line" ] []
        , div [ id "profile-introduction" ]
            [ div [ class "clearfix" ]
                [ div [ id "profile-name" ] [ text profile.name ]
                , div [ id "profile-location" ] [ text profile.location ]
                ]
            , div [ id "profile-bio" ] [ text profile.bio ]
            ]
        , div [ id "profile-icon" ]
            [ img [ src profile.icon ] [] ]
        ]



-- Menu


createMenu : List Menu -> Html Msg
createMenu menus =
    div [ id "menus" ] <|
        List.append [ div [ class "label" ] [ text "Links" ] ]
            (List.map
                (\menu ->
                    a [ href menu.href ]
                        [ div [ class "menu" ]
                            [ div [ class "menu-wrapper clearfix" ]
                                [ div [ class "menu-icon" ]
                                    [ img [ src <| "static/img/" ++ menu.icon ] [] ]
                                , div [ class "menu-name" ]
                                    [ text menu.name ]
                                ]
                            ]
                        ]
                )
                menus
            )



-- Board


createBoard : List Repository -> List Article -> Html Msg
createBoard repositories articles =
    div [ id "board" ]
        [ div [ class "label" ] [ text "Board" ]
        , div []
            [ createArticle articles
            , createRepository repositories
            ]
        ]


createRepository : List Repository -> Html Msg
createRepository repositories =
    div [ class "content" ]
        ((List.append
            [ div [ class "content-title clearfix" ]
                [ div [ class "content-icon" ]
                    [ img [ src "static/img/github-content-icon.png" ] [] ]
                , div [ class "content-name" ] [ text "Repositories - GitHub" ]
                ]
            ]
            (List.map
                (\repository ->
                    a [ href repository.href ]
                        [ div [ class "repository-content" ]
                            [ div [ class "repository-name" ] [ text <| repository.owner ++ "/" ++ repository.name ]
                            , div [ class "repository-description" ] [ text <| repository.description ]
                            ]
                        ]
                )
                repositories
            )
         )
            ++ [ a [ href "https://github.com/calmery?tab=repositories" ] [ div [ class "and-more" ] [ text "And More" ] ] ]
        )


createArticle : List Article -> Html Msg
createArticle articles =
    div [ class "content" ]
        ((List.append
            [ div [ class "content-title clearfix" ]
                [ div [ class "content-icon" ]
                    [ img [ src "static/img/blog-content-icon.png" ] [] ]
                , div [ class "content-name" ] [ text "Articles - Hatena Blog" ]
                ]
            ]
            (List.map
                (\article ->
                    a [ href article.href ]
                        [ div [ class "blog-content" ]
                            [ div [ class "created-at" ] [ text article.created_at ]
                            , div [ class "blog-name" ] [ text article.name ]
                            , div [ class "blog-tags" ]
                                (List.map
                                    (\tag ->
                                        a [ href tag.href ] [ div [ class "blog-tag" ] [ text tag.name ] ]
                                    )
                                    article.tags
                                )
                            ]
                        ]
                )
                articles
            )
         )
            ++ [ a [ href "http://calmery.hatenablog.com" ] [ div [ class "and-more" ] [ text "And More" ] ] ]
        )



-- Footer


footer : Html Msg
footer =
    div [ id "copyright" ]
        [ text "CopyRight 2017-2018 Calmery All Rights Reserved" ]


view : Model -> Html Msg
view model =
    div [ id "container" ]
        [ createProfile profile
        , div [ id "contents" ]
            [ createMenu menus
            , createBoard repositories articles
            , footer
            ]
        ]
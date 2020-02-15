$(document).on 'turbolinks:load', ->
    simplemde = new SimpleMDE({
        element: document.getElementById("article_body"),
        showIcons: ["code", "table"],
        placeholder: "Insert text"
    })
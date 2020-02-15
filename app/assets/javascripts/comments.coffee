$(document).on "ajax:success", "form#comments-form", (ev, data) ->
    console.log(ev.detail[0])
    console.log(data)
    $(this).find("textarea").val("")
    $("#comments-box").append("<li><p>#{ ev.detail[0].body } - <code class=\"badge badge-info\">#{ ev.detail[0].user.email }</code></p></li>")
    alertify.warning('* Comment added!');

$(document).on "ajax:error", "form#comments-form", (ev, data) ->
    console.log(ev)
    console.log(data)    $("#comments-box").append("<li><p>#{ ev.detail[0].body } - </p></li>")
    alertify.error('* Comment not added!');

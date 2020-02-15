/* // La típica función para peticiones AJAX
function AjaxRequest(url, method, data, callback) {
    var xmlhttp;

    if (window.XMLHttpRequest)
      xmlhttp = new XMLHttpRequest();
    else
      xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");

    xmlhttp.onreadystatechange = function() {
      if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        if (xmlhttp.responseXML) {
          callback(xmlhttp.responseXML);
        } else {
          callback(xmlhttp.responseText);
        }
      }
    };

    xmlhttp.open(method, url, true);

    if (method == "POST")
      xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

    xmlhttp.send(data);
  }
  
$(document).on('turbolinks:load', function(){
    simplemde = new SimpleMDE({
        element: document.getElementById("article_body_view"),
        previewRender: function(plainText, preview) {
            // Esperar un segundo sin cambios para hacer la petición
            if (window.delay)
              clearTimeout(window.delay);
      
            window.delay = setTimeout(function() {
              AjaxRequest("/preview", "POST", "content=" + encodeURIComponent(plainText), function(response) {
                // `preview` es el nodo que contiene la vista previa
                preview.innerHTML = response;
              });
            }, 1000);
      
            return preview.innerHTML;
        }
    })
}); */
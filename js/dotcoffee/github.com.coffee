link = $("link[rel='alternate']").attr 'href'
button = "<li><a class='minibutton' href='#{link}'><span>RSS</span></a></li>"
$('ul.pagehead-actions').prepend button

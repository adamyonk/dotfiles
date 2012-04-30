link = $("link[rel='alternate']").attr 'href'
button = "<li><a class='minibutton' href='#{link}'><span>RSS</span></a></li>"
$('.pagehead-actions').prepend button

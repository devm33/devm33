window.onload = function(){
    var bg = new Image();
    bg.src = "{% asset_path bg.jpg %}";
    bg.onload = function(){document.body.style.backgroundImage = "url("+bg.src+")";};
};

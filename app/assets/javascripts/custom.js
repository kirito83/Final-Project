var canvasHeight = $("#presentation").height();
var floatingBanners = $("#img-presentation");
var imageHeight = floatingBanners.height();
var lowerBound = canvasHeight - imageHeight;
var duration = 1000;

function bannerMoveDown(){
    $("#img-presentation").animate({top:lowerBound}, duration, 'linear', bannerMoveUp);
}
function bannerMoveUp(){
    $("#img-presentation").animate({top:0}, duration, 'linear', bannerMoveDown);
}
bannerMoveDown();
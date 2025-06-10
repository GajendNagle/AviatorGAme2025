function winninginfo() {
    $('#winninginfo').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
    $('#winninginfo').load("Handlers/Dashboard_game_index.ashx?Vs=winninginfo");
}
function todaysrankinfo() {
    $('#todaysrankinfo').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
    $('#todaysrankinfo').load("Handlers/Dashboard_game_index.ashx?Vs=todaysrankinfo");
}

//function newsnoifications() {
//    debugger;
//    var modal = document.getElementById('onload');
//    modal.style.display = "block";
//    modal.classList.add("show");
//    $('#notifications').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
//    $("#notifications").load("Handlers/GetPopupNews.ashx")
//    $("#newsalert").load("Handlers/GetPopupNews.ashx")
//}

function newsalertmarquee() {
    $("#newsalert").load("Handlers/GetPopupNews.ashx")
}
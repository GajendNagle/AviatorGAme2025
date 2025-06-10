function MobileSideBar__init() {
    var $btnToggleMobileSideBar = $('.btn-toggle-mobile-side-bar');

    $btnToggleMobileSideBar.click(function () {
        if ($(this).hasClass('active')) {
            $(this).removeClass('active');
            $('.mobile-side-bar').removeClass('active');
        }
        else {
            $(this).addClass('active');
            $('.mobile-side-bar').addClass('active');
        }
    });
}

$(function () {
    MobileSideBar__init();
});

$(document).ready(function () {
   
    $('.mobile-side-bar > .menu-box-1 ul > li').click(function () {
        $(this).children('ul').slideToggle();
        $(this).find('.fa-chevron-up, .fa-chevron-down').toggleClass('fa-chevron-up fa-chevron-down');
    });
});
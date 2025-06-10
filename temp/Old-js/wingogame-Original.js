function updateValues() {

    var multivle = $('#number').val();
    var multipleval = $('.multival').val();
    var feededuct = $('#gamefeededuction').val();
    var totalamount = multivle * multipleval;
    var gamefeededuct = (totalamount * feededuct) / 100;

    $('#deductfee').html(gamefeededuct);
    $('#netPayable').html(totalamount - gamefeededuct);
    $('#fpdelivery').html(totalamount);
    $('#fastparitamt').val(totalamount);
}
$("#number").on('change', function () {
    updateValues();
});
$(".multival").on('change', function () {
    updateValues();
});
$(".multiply").click(function () {
    $(".multiply").removeClass('active');
    $(this).addClass('active');
    $(".multiply").removeClass("multival");
    $(this).addClass("multival");
    updateValues();
});
$(".add").click(function () {
    $(".add").removeClass('active');
    $(this).addClass('active');
    $(".add").removeClass("addvalue");
    $(this).addClass("addvalue");
    updateValues();
});
$(".partiybtn ").click(function () {
    // Remove active class from all buttons
    $(".partiybtn ").removeClass("active");

    // Add active class to the clicked button
    $(this).addClass("active");

});
$(".btn-active").click(function () {
    // Remove active class from all buttons
    $(".btn-active").removeClass("active");

    // Add active class to the clicked button
    $(this).addClass("active");
});
var buttonPlus5 = $(".btn-plus5");
var buttonMinus = $(".btn-minus");
var buttonMinus5 = $(".btn-minus5");
var buttonPlus = $(".btn-plus");
var incrementPlus = buttonPlus.click(function () {
    var $n = $(this).parent(".qty-container").find(".input-modal");
    $n.val(Number($n.val()) + 1);
    $n.val() > 1000 ? $n.val(10) : '';
    updateValues();
});
var incrementMinus = buttonMinus.click(function () {
    var $n = $(this).parent(".qty-container").find(".input-modal");
    var amount = Number($n.val());
    if (amount > 0) {
        $n.val(amount - 1);
    }
    $n.val() > 1000 ? $n.val(10) : '';
    updateValues();
});
//var incrementPlus5 = buttonPlus5.click(function () {
//    var $n = $(this).parent(".qty-container").find(".input-modal");
//    $n.val(Number($n.val()) + 5);
//    $n.val() > 10 ? $n.val(10) : '';
//    updateValues();
//});

//var incrementMinus5 = buttonMinus5.click(function () {
//    var $n = $(this).parent(".qty-container").find(".input-modal");
//    var amount = Number($n.val());
//    if (amount > 0) {
//        $n.val(amount - 5);
//    }
//    $n.val() > 10 ? $n.val(10) : '';
//    $n.val() < 0 ? $n.val(0) : '';
//    updateValues();
//});
function onlyNumberKey(evt) {
    // Only ASCII character in that range allowed
    var ASCIICode = (evt.which) ? evt.which : evt.keyCode
    // if (ASCIICode > 31 && (ASCIICode < 48 || ASCIICode > 57))
    if (ASCIICode < 48 || ASCIICode > 57)
        return false;
    return true;
}
function multiply(factor) {
    var input = document.getElementById("number");
    var inputValue = parseInt(input.value);

    // Update the input value with the factor
    if (!isNaN(inputValue)) {
        input.value = factor;
        factor = input.value;
    }
    // Perform further calculations or updates using the updated input value
    updateValues();

}


var currency_symbol = "USD";
var bet_list_current = [];
function scrollFunction() {
    $(".list-body").mCustomScrollbar({
        scrollInertia: 50,
        theme: "dark-3"
    });
}
scrollFunction();


document.addEventListener("visibilitychange", function () {

    const music = document.getElementById("background_Audio");
    if (document.hidden) {
        music.pause();
    } else {
        if (window_blur == 0) {
            music.play();
        } else {
            music.pause();
        }

    }
}, false);


$(document).on('hidden.bs.modal', '#bet-history', function () {
    $(".bet_record_count").remove();
})

$(".tabs-navs .nav-item").click(function () {
    $(this).parent().parent().find(".nav-item").removeClass('active');
    $(this).addClass('active');
});

$(".auto-btn").click(function () {
    $(this).parent().parent().find("#bet_type").val(1);
});

$(".bet-btn").click(function () {
    $(this).parent().parent().find("#bet_type").val(0);
});

$(".navigation-switcher .slider").click(function () {
    $(this).parent().find(".slider").removeClass('active');
    $(this).addClass('active');

    const type = $(this).text();
    if (type == 'Auto') {
        $(this).parent().parent().parent().find(".second-row").addClass('show');
    } else {
        $(this).parent().parent().parent().find(".second-row").removeClass('show');
    }
});

$(".cash-out-switcher .form-check .form-check-input").change(function () {
    if (this.checked) {
        $(this).parent().parent().parent().find(".cashout-spinner-wrapper input").attr('disabled', false);
        $(this).parent().parent().parent().parent().parent().find(".navigation").addClass('stop-action');
    } else {
        $(this).parent().parent().parent().find(".cashout-spinner-wrapper input").attr('disabled', true);
        $(this).parent().parent().parent().parent().parent().find(".navigation").removeClass('stop-action');
    }
});

$("#remove_extra_section_btn").click(function () {
    $("#extra_bet_section").hide();
    $("#add_extra_bet_section_btn").show();
});

$("#add_extra_bet_section_btn").click(function () {
    $("#extra_bet_section").show();
    $("#add_extra_bet_section_btn").hide();
});

var globalAmt = 0.01;

function bet_amount_incremental(element, event) {
    event.preventDefault();
    var bet_amount = parseFloat($(element).parent().parent().find(".input #bet_amount").val());
    bet_amount += globalAmt;

    if (bet_amount <= max_bet_amount) {
        $(element).parent().parent().find(".input #bet_amount").val(bet_amount);
    }
}

function bet_amount_decremental(element, event) {
    event.preventDefault();
    var bet_amount = parseFloat($(element).parent().parent().find(".input #bet_amount").val());
    bet_amount -= globalAmt;
    if (bet_amount >= min_bet_amount) {
        $(element).parent().parent().find(".input #bet_amount").val(bet_amount);
    }
}

function select_direct_bet_amount(element, event) {
    event.preventDefault();
    var current_bet_amount = parseFloat($(element).parent().parent().find(".input #bet_amount").val());
    var adding_bet_amount = parseFloat($(element).find(".amt").text());
    globalAmt = adding_bet_amount

    if ($(element).hasClass('same')) {
        var new_bet_amount = parseFloat(parseFloat(current_bet_amount) + parseFloat(adding_bet_amount)).toFixed(2);

        if (new_bet_amount <= max_bet_amount) {
            $(element).parent().parent().find(".input #bet_amount").val(new_bet_amount);
        }
    } else {
        $(element).parent().find('.bet-opt').removeClass('same');
        $(element).addClass('same');
        $(element).parent().parent().find(".input #bet_amount").val(adding_bet_amount);
    }
}

var current_game_count;
var multiplier_limit = 0;
var stop_position = 0;

$('.loading-game').addClass('show');

$(document).ready(function () {
    let music = document.getElementById("background_Audio");
    music.volume = 0.2;
    if ($("#music").prop("checked") == true) {
        music.loop = true;
        music.load();
    } else {
        music.pause();
    }
    $("#wallet_balance").text(currency_symbol + wallet_balance);
    $("#header_wallet_balance").text(currency_symbol + wallet_balance);
});

function info_data(intialData) {

    current_game_data = intialData.currentGame;
    current_game_count = intialData.currentGameBetCount;
    show_bet_count(current_game_count, intialData.totalBetAmount);
    update_bet_list(intialData.currentGameBet, '#all_bets .mCSB_container', 1);
    bet_list_current = intialData.currentGameBet;
}

var main_counter = 0;
var extra_counter = 0;
function cash_out_now(element, section_no, event, increment = '') {
    event.preventDefault();

    current_cash_out = increment;
    if (section_no == 0) {

    } else {

    }
    if (bet_array.length == 1) {
        current_cash = true;
    }
    let incrementor;
    if (increment != '') {
        incrementor = increment;
    } else {
        incrementor = $("#auto_increment_number").text().slice(0, -1);
    }

    if (section_no == 0) {
        enableDisable('main_bet_section');
        main_cash_out = 0;
    } else {
        enableDisable('extra_bet_section');
        extra_cash_out = 0;
    }

    if (bet_array.length == 1) {
        bet_array.splice(0, 1);
    } else if (bet_array.length == 2 && section_no == 0) {
        if (bet_array[0].section_no == 0) {
            bet_array.splice(0, 1);
        } else {
            bet_array.splice(1, 1);
        }
    } else if (bet_array.length == 2 && section_no == 1) {
        if (bet_array[0].section_no == 1) {
            bet_array.splice(0, 1);
        } else {
            bet_array.splice(1, 1);
        }
    }

    let bet_id;
    if (section_no == 0) {
        bet_id = $("#main_bet_id").val();
        var bet_amount = $("#main_bet_section #bet_amount").val();
    } else {
        bet_id = $("#extra_bet_id").val();
        var bet_amount = $("#extra_bet_section #bet_amount").val();

    }

    game_id = current_game_data.id

    if (currency_id == 1) {
        var amt = parseFloat(parseFloat(incrementor) * parseFloat(bet_amount)).toFixed(2);
    } else {
        var amt = parseFloat(parseFloat(incrementor) * (parseFloat(bet_amount))).toFixed(2);

    }

    $('#all_bets .mCSB_container .bet_id_' + member_id + section_no + '').addClass('active');
    $('#all_bets .mCSB_container .bet_id_' + member_id + section_no + ' .column-3').html('<div class="' + get_multiplier_badge_class(incrementor) + ' custom-badge mx-auto">' + incrementor + 'x</div>');
    $('#all_bets .mCSB_container .bet_id_' + member_id + section_no + ' .column-4').html(amt + currency_symbol);

    if (section_no == 0) {
        let is_main_auto_bet_checked = $("#main_auto_bet").prop('checked');
        if (is_main_auto_bet_checked) {
            $("#main_bet_section").find("#bet_button").hide();
            $("#main_bet_section").find("#cancle_button").show();
            $("#main_bet_section").find("#cancle_button #waiting").show();
            $("#main_bet_section").find("#cashout_button").hide();
            $("#main_bet_section .controls").removeClass('bet-border-yellow');
            $("#main_bet_section .controls").addClass('bet-border-red');
        } else {
            $("#main_bet_section").find("#bet_button").show();
            $("#main_bet_section").find("#cancle_button").hide();
            $("#main_bet_section").find("#cancle_button #waiting").hide();
            $("#main_bet_section").find("#cashout_button").hide();
            $("#main_bet_section .controls").removeClass('bet-border-red');
            $("#main_bet_section .controls").removeClass('bet-border-yellow');
        }

        $("#main_bet_section").find("#cash_out_amount").text('');
        $(".cashout-toaster1 .stop-number").html(incrementor + 'x');
        $(".cashout-toaster1 .out-amount").html(amt + currency_symbol);
        $(".cashout-toaster1").addClass('show');
        firstToastr();
    }

    if (section_no == 1) {
        let is_extra_auto_bet_checked = $("#extra_auto_bet").prop('checked');
        if (is_extra_auto_bet_checked) {
            $("#extra_bet_section").find("#bet_button").hide();
            $("#extra_bet_section").find("#cancle_button").show();
            $("#extra_bet_section").find("#cancle_button #waiting").show();
            $("#extra_bet_section").find("#cashout_button").hide();
            $("#extra_bet_section .controls").removeClass('bet-border-yellow');
            $("#extra_bet_section .controls").addClass('bet-border-red');
        } else {
            $("#extra_bet_section").find("#bet_button").show();
            $("#extra_bet_section").find("#cancle_button").hide();
            $("#extra_bet_section").find("#cancle_button #waiting").hide();
            $("#extra_bet_section").find("#cashout_button").hide();
            $("#extra_bet_section .controls").removeClass('bet-border-red');
            $("#extra_bet_section .controls").removeClass('bet-border-yellow');
        }

        $("#extra_bet_section").find("#cash_out_amount").text('');
        $(".cashout-toaster2 .stop-number").html(incrementor + 'x');
        $(".cashout-toaster2 .out-amount").html(amt + currency_symbol);
        $(".cashout-toaster2").addClass('show');
        secondToastr();
    }

    var triggerElement = document.querySelector('.wallet-top');
    var walletText = triggerElement.textContent;
    var walletValue = walletText.substring(1);
    var amountUi = parseFloat(walletText.replace(/[^0-9.]/g, ''));

    $.ajax({
        url: 'Handler/cash_out.ashx',
        data: {
            game_id: gameId,
            "betAmount": bet_amount,
            win_multiplier: incrementor,
            section_no: section_no
        },
        type: "GET",
        dataType: "json",
        success: function (result) {

            $('#all_my_bets .mCSB_container').find('.list-items').each(function () {
                var sectionNo = $(this).attr('class').split(' ').find(cls => cls !== 'list-items' && cls !== 'active');
                update_my_bet_Multipliers(this, parseInt(result.section_no), result.multiplier);
            });
            $.ajax({
                url: 'Handler/my_bets_history.ashx',
                type: "POST",
                data: {
                    _token: hash_id
                },
                dataType: "json",
                success: function (data) {

                    update_my_bet_history(data.data)
                }
            });
            if (result) {
                if (result.win_amount != '' && result.win_amount != NaN) {
                    var updatedValue = Number(amountUi) + Number(result.win_amount);
                    total_bet_amounts -= result.win_amount
                    max_bet_amount = Number(max_bet_amount) + Number(result.win_amount);
                    document.querySelector('.wallet-top').textContent = parseFloat(updatedValue).toFixed(2);
                    $("#wallet_balance").text(currency_symbol + parseFloat(updatedValue).toFixed(2));
                    $("#header_wallet_balance").text(currency_symbol + parseFloat(updatedValue).toFixed(2));
                } else {
                    $("#wallet_balance").text(currency_symbol + '0.00');
                    $("#header_wallet_balance").text(currency_symbol + '0.00');
                }
                if (section_no == 0) {
                    $("#main_bet_section").find("#bet_button").show();
                    $("#main_bet_section").find("#cancle_button").hide();
                    $("#main_bet_section").find("#cancle_button #waiting").hide();
                    $("#main_bet_section").find("#cashout_button").hide();

                    $("#my_bet_list #my_bet_section_0").addClass('active');
                    let is_main_auto_bet_checked = $("#main_auto_bet").prop('checked');

                    $("#my_bet_list #my_bet_section_0").removeAttr('id');


                    if (is_main_auto_bet_checked == false) {

                        $(".main_bet_amount").prop('disabled', false);
                        $("#main_plus_btn").prop('disabled', false);
                        $("#main_minus_btn").prop('disabled', false);
                        $(".main_amount_btn").prop('disabled', false);
                        $("#main_checkout").prop('disabled', false)
                        if ($("#main_checkout").prop('checked')) {
                            $("#main_incrementor").prop('disabled', false);
                        }
                    }
                    $("#main_auto_bet").prop('disabled', false);
                }
                if (section_no == 1) {
                    $("#extra_bet_section").find("#bet_button").show();
                    $("#extra_bet_section").find("#cancle_button").hide();
                    $("#extra_bet_section").find("#cancle_button #waiting").hide();
                    $("#extra_bet_section").find("#cashout_button").hide();

                    $("#my_bet_list #my_bet_section_1").addClass('active');
                    let is_extra_auto_bet_checked = $("#extra_auto_bet").prop('checked');

                    $("#my_bet_list #my_bet_section_1").removeAttr('id');


                    if (is_extra_auto_bet_checked == false) {

                        $(".extra_bet_amount").prop('disabled', false);
                        $("#extra_minus_btn").prop('disabled', false);
                        $("#extra_plus_btn").prop('disabled', false);
                        $(".extra_amount_btn").prop('disabled', false);
                        $("#extra_checkout").prop('disabled', false);
                        if ($("#extra_checkout").prop('checked')) {
                            $("#extra_incrementor").prop('disabled', false);
                        }
                    }
                    $("#extra_auto_bet").prop('disabled', false);

                }
            }
        }
    });
}

function crash_plane(inc_no) {
    soundPlay();
    window.clearInterval(StopPlaneIntervalID);
    $(".flew_away_section").show();
    $("#auto_increment_number").addClass('text-danger');
    stopPlane();
    deleteCookie("ztk9v8pl");
    ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
    $("#running_type").text('rest time');
    update_round_history();
    $("#main_bet_section").find("#cashout_button").hide();
    $("#main_bet_section .controls").removeClass('bet-border-yellow');
    $("#main_bet_section .controls .navigation").removeClass('stop-action');
    $("#extra_bet_section").find("#cashout_button").hide();
    $("#extra_bet_section .controls").removeClass('bet-border-red');
    $("#extra_bet_section .controls").removeClass('bet-border-yellow');
    $("#extra_bet_section .controls .navigation").removeClass('stop-action');
    const number_of_bet = $(".round-history-list").find('.custom-badge').length;
    if (number_of_bet > 50) {
        $(".round-history-list").find('.custom-badge:last').remove();
    }

    let is_main_auto_bet_checked = $("#main_auto_bet").prop('checked');
    let is_extra_auto_bet_checked = $("#extra_auto_bet").prop('checked');

    const main_bet_id = $("#main_bet_id").val();
    const extra_bet_id = $("#extra_bet_id").val();

    setTimeout(function () {
        const incrementor = $("#auto_increment_number").text().slice(0, -1);
        if (main_cash_out == 2) {
            $("#main_bet_id").val(main_bet_id);
            const main_inc = main_incrementor;
            if (parseFloat(incrementor) >= parseFloat(main_inc)) {
                cash_out_now('', 0, main_inc);
            }
            $("#main_bet_id").val('');
        }

        if (extra_cash_out == 2) {
            $("#extra_bet_id").val(extra_bet_id);
            const extra_inc = extra_incrementor;
            if (parseFloat(incrementor) >= parseFloat(extra_inc)) {
                cash_out_now('', 1, extra_inc);
            }
            $("#extra_bet_id").val('');
        }
        main_cash_out = 0;
        extra_cash_out = 0;
    }, 1000);
}


function new_game_generated() {
    is_game_generated = 1;
    $('#my_bet_list .mCSB_container .list-items').removeAttr('id');
    $(".game-centeral-loading").show();

    $("#main_bet_section").find("#cancle_button #waiting").hide();
    $("#extra_bet_section").find("#cancle_button #waiting").hide();

    if (bet_array.length == 1) {
        if (bet_array[0].section_no == 0) {
            enableDisable('main_bet_section');
        }
        if (bet_array[0].section_no == 1) {
            enableDisable('extra_bet_section');
        }
    }
    if (bet_array.length == 2) {
        enableDisable('main_bet_section');
        enableDisable('extra_bet_section');
    }

    $(".load-txt").hide();
    $('body').removeClass('overflow-hidden');
    document.getElementById('auto_increment_number').innerText = '1.00x';

    $('.loading-game').addClass('show');
    $(".flew_away_section").hide();
    $("#auto_increment_number").removeClass('text-danger');
    $("#all_bets .mCSB_container").html('');
    $("#running_type").text('bet time');
    $("#auto_increment_number_div").hide();

    current_game_count = 0;

    let is_main_auto_bet_checked = $("#main_auto_bet").prop('checked');
    if (is_main_auto_bet_checked) {
        if (bet_array.length != 2 && (bet_array.length == 0 || (bet_array.length == 1 && bet_array[0].section_no != 0))) {
            var bet_type = $("#main_bet_now").parent().parent().parent().find(".navigation #bet_type").val();
            let bet_amount = $("#main_bet_now").parent().parent().find(".bet-block .spinner #bet_amount").val();

            if (bet_amount < min_bet_amount || bet_amount == '' || bet_amount == NaN) {
                bet_amount = parseFloat(min_bet_amount).toFixed(2);
            } else if (bet_amount > max_bet_amount) {
                bet_amount = parseFloat(max_bet_amount).toFixed(2);
            } else {
                bet_amount = parseFloat(bet_amount).toFixed(2);
            }

            $("#main_bet_now").parent().parent().find(".bet-block .spinner #bet_amount").val(bet_amount);

            if (bet_amount >= min_bet_amount && bet_amount <= max_bet_amount) {
                bet_array.push({ bet_type: bet_type, bet_amount: bet_amount, section_no: 0 });
            }
        }

    }

    let is_extra_auto_bet_checked = $("#extra_auto_bet").prop('checked');
    if (is_extra_auto_bet_checked) {
        if (bet_array.length != 2 && (bet_array.length == 0 || (bet_array.length == 1 && bet_array[0].section_no != 1))) {
            var bet_type = $("#extra_bet_now").parent().parent().parent().find(".navigation #bet_type").val();
            let bet_amount = $("#extra_bet_now").parent().parent().find(".bet-block .spinner #bet_amount").val();

            if (bet_amount < min_bet_amount || bet_amount == '' || bet_amount == NaN) {
                bet_amount = parseFloat(min_bet_amount).toFixed(2);
            } else if (bet_amount > max_bet_amount) {
                bet_amount = parseFloat(max_bet_amount).toFixed(2);
            } else {
                bet_amount = parseFloat(bet_amount).toFixed(2);
            }

            $("#extra_bet_now").parent().parent().find(".bet-block .spinner #bet_amount").val(bet_amount);

            if (bet_amount >= min_bet_amount && bet_amount <= max_bet_amount) {
                bet_array.push({ bet_type: bet_type, bet_amount: bet_amount, section_no: 1 });
            }
        }

    }

}

function lets_fly_one() {
    is_game_generated = 0;
    $(".stage-board").addClass('blink_section');
    $(".bet-controls").addClass('blink_section');
}

function lets_fly() {
    $(".stage-board").removeClass('blink_section');
    $(".bet-controls").removeClass('blink_section');
    stage_time_out = 0;
    if (bet_array.length == 1 && bet_array[0] && bet_array[0].section_no == 0) {
        enableDisable('main_bet_section');
        $("#main_bet_section").find("#bet_button").hide();
        $("#main_bet_section").find("#cancle_button").hide();
        $("#main_bet_section").find("#cancle_button #waiting").hide();
        $("#main_bet_section").find("#cashout_button").show();
        $("#main_bet_section .controls").removeClass('bet-border-red');
        $("#main_bet_section .controls").addClass('bet-border-yellow');
        $("#main_auto_bet").prop('disabled', true);
        $("#main_checkout").prop('disabled', true);
        $("#main_incrementor").prop('disabled', true);
    }

    if (bet_array.length == 1 && bet_array[0] && bet_array[0].section_no == 1) {
        enableDisable('extra_bet_section');
        $("#extra_bet_section").find("#bet_button").hide();
        $("#extra_bet_section").find("#cancle_button").hide();
        $("#extra_bet_section").find("#cancle_button #waiting").hide();
        $("#extra_bet_section").find("#cashout_button").show();
        $("#extra_bet_section .controls").removeClass('bet-border-red');
        $("#extra_bet_section .controls").addClass('bet-border-yellow');
        $("#extra_auto_bet").prop('disabled', true);
        $("#extra_checkout").prop('disabled', true);
        $("#extra_incrementor").prop('disabled', true);
    }

    if (bet_array.length == 2) {

        if (bet_array[0] && bet_array[0].section_no == 0) {
            enableDisable('main_bet_section');
            $("#main_bet_section").find("#bet_button").hide();
            $("#main_bet_section").find("#cancle_button").hide();
            $("#main_bet_section").find("#cancle_button #waiting").hide();
            $("#main_bet_section").find("#cashout_button").show();
            $("#main_bet_section .controls").removeClass('bet-border-red');
            $("#main_bet_section .controls").addClass('bet-border-yellow');
            $("#main_auto_bet").prop('disabled', true);
            $("#main_checkout").prop('disabled', true);
            $("#main_incrementor").prop('disabled', true);
        }

        if (bet_array[0] && bet_array[0].section_no == 1) {
            enableDisable('extra_bet_section');
            $("#extra_bet_section").find("#bet_button").hide();
            $("#extra_bet_section").find("#cancle_button").hide();
            $("#extra_bet_section").find("#cancle_button #waiting").hide();
            $("#extra_bet_section").find("#cashout_button").show();
            $("#extra_bet_section .controls").removeClass('bet-border-red');
            $("#extra_bet_section .controls").addClass('bet-border-yellow');
            $("#extra_auto_bet").prop('disabled', true);
            $("#extra_checkout").prop('disabled', true);
            $("#extra_incrementor").prop('disabled', true);
        }

        if (bet_array[1] && bet_array[1].section_no == 0) {
            enableDisable('main_bet_section');
            $("#main_bet_section").find("#bet_button").hide();
            $("#main_bet_section").find("#cancle_button").hide();
            $("#main_bet_section").find("#cancle_button #waiting").hide();
            $("#main_bet_section").find("#cashout_button").show();
            $("#main_bet_section .controls").removeClass('bet-border-red');
            $("#main_bet_section .controls").addClass('bet-border-yellow');
            $("#main_auto_bet").prop('disabled', true);
            $("#main_checkout").prop('disabled', true);
            $("#main_incrementor").prop('disabled', true);
        }

        if (bet_array[1] && bet_array[1].section_no == 1) {
            enableDisable('extra_bet_section');
            $("#extra_bet_section").find("#bet_button").hide();
            $("#extra_bet_section").find("#cancle_button").hide();
            $("#extra_bet_section").find("#cancle_button #waiting").hide();
            $("#extra_bet_section").find("#cashout_button").show();
            $("#extra_bet_section .controls").removeClass('bet-border-red');
            $("#extra_bet_section .controls").addClass('bet-border-yellow');
            $("#extra_auto_bet").prop('disabled', true);
            $("#extra_checkout").prop('disabled', true);
            $("#extra_incrementor").prop('disabled', true);
        }
    }

    $(".load-txt").hide();
    $('body').removeClass('overflow-hidden');
    $('.loading-game').removeClass('show');
    $("#auto_increment_number_div").show();
    setVariable(1);
    flyPlaneSound();
}

function incrementor(inc_no) {
    $('.loading-game').removeClass('show');
    $("#auto_increment_number_div").show();
    $("#running_type").text('cash out time');
    document.getElementById('auto_increment_number').innerText = inc_no + '' + 'x';

    if (bet_array.length > 0) {

        var main_mult_amt = $("#main_bet_section #bet_amount").val();
        var extra_mult_amt = $("#extra_bet_section #bet_amount").val();
        const extra_final_amt = inc_no * Number(extra_mult_amt);
        const main_final_amt = inc_no * Number(main_mult_amt);
        $("#main_bet_section").find("#cash_out_amount").text(parseFloat(main_final_amt).toFixed(3) + '' + currency_symbol);
        $("#extra_bet_section").find("#cash_out_amount").text(parseFloat(extra_final_amt).toFixed(3) + '' + currency_symbol);
        let main_isChecked = $('#main_checkout').prop('checked');
        let extra_isChecked = $("#extra_checkout").prop('checked');
        let incrementor;


        for (let i = 0; i < bet_array.length; i++) {
            if (bet_array[i].section_no == 0) {
                if (bet_array[i].is_bet == 1) {
                    if (main_isChecked == true) {
                        incrementor = $('#main_incrementor').val();
                        main_incrementor = incrementor;
                        if (parseFloat(inc_no) >= parseFloat(incrementor)) {
                            if (main_counter == 0) {
                                cash_out_now('', 0, incrementor);
                                main_counter++;
                                main_cash_out = 1;
                            }
                        } else {
                            main_cash_out = 2;
                        }
                    }
                }
            } else if (bet_array[i].section_no == 1) {
                if (bet_array[i].is_bet == 1) {
                    if (extra_isChecked == true) {

                        incrementor = $('#extra_incrementor').val();
                        extra_incrementor = incrementor;

                        if (parseFloat(inc_no) >= parseFloat(incrementor)) {
                            if (extra_counter == 0) {
                                cash_out_now('', 1, incrementor);
                                extra_counter++;
                                extra_cash_out = 1;
                            }
                        } else {
                            extra_cash_out = 2;
                        }
                    }
                }
            }
        }

    }
    if (bet_array.length > 0) {

        cash_out_multiplier(inc_no);
    }

}

function cash_out_bet(cashOutData) {
    $('#all_bets .mCSB_container .' + cashOutData.hash_id + '').addClass('active');
    $('#all_bets .mCSB_container .' + cashOutData.hash_id + ' .column-3').html('<div class="' + get_multiplier_badge_class(cashOutData.incrementor) + ' custom-badge mx-auto">' + cashOutData.incrementor + 'x</div>');
    if (currency_id == 1) {
        var amt = cashOutData.inr_amount;
    } else {
        var amt = cashOutData.dollar_amount;
    }
    $('#all_bets .mCSB_container .' + cashOutData.hash_id + ' .column-4').html(amt + currency_symbol);
}

function update_bet_list(bets, target, appendType = '') {
    try {


        if (appendType == 1) {
            $("#all_bets .mCSB_container").html('');
        }
        if (appendType == 2) {
            $('#prev_bets .mCSB_container').html('');
        }
        var html = '';
        for (let i = 0; i < bets.length; i++) {

            var isActive = bets[i].cashout_multiplier > 0 ? "active" : "";
            if (parseFloat(bets[i].cashout_multiplier) <= 2) {
                var badgeColor = 'bg3';
            } else if (parseFloat(bets[i].cashout_multiplier) < 10) {
                var badgeColor = 'bg1';
            } else {
                var badgeColor = 'bg2';
            }
            if (parseFloat(bets[i].cashout_multiplier) > 0) {
                var cashOut = Math.round(bets[i].cashout_multiplier * bets[i].amount) + currency_symbol;
                var multiplication = '<div class="' + badgeColor + ' custom-badge mx-auto">' + (bets[i].cashout_multiplier > 0 ? (bets[i].amount * bets[i].cashout_multiplier).toFixed(2) + '' : '-') + '</div>';

            } else {
                var cashOut = '-';
                var multiplication = '-';
            }

            var sectionNo = 'bet_id_' + bets[i].sectionNo;
            html += '<div class="list-items ' + isActive + ' ' + sectionNo + ' ' + '">' +
                '<div class="column-1 users"> <img src="' + bets[i].image + '" class="avatar me-1"> ' + bets[i].userid + '</div>' +
                '<div class="column-2"> ' + bets[i].amount + '</div>' +
                '<div class="column-3"> <button class="btn btn-transparent previous-history d-flex align-items-center mx-auto"> ' + bets[i].amount + currency_symbol + ' </button> </div>' +
                '<div class="column-4"> ' + multiplication + ' </div>' +

                '</div>';

        }
        $(target).html(html);
    } catch (error) {
    }

}



function updateRandomMultiplier(bets, target, a) {
    try {
        if (!bets || bets.length === 0) return;
        var randomIndex = Math.floor(Math.random() * bets.length);
        bets[randomIndex].cashout_multiplier = a !== undefined ? bets[randomIndex].cashout_multiplier : '-';
        var html = generateUpdatedHtml(bets);
        $(target).html(html);
    }
    catch (error) {

    }
}

function getBadgeColor(multiplier) {
    if (multiplier == '-') {
        return '-';
    }

    if (parseFloat(multiplier) <= 2) {
        return 'bg3';
    } else if (parseFloat(multiplier) < 10) {
        return 'bg1';
    } else {
        return 'bg2';
    }
}
function generateUpdatedHtml(bets) {
    try {
        var html = '';
        for (var i = 0; i < bets.length; i++) {
            var isActive = bets[i].cashout_multiplier > 0 ? "active" : "";
            var multiplier = bets[i].cashout_multiplier !== undefined ? bets[i].cashout_multiplier : '-';
            var badgeColor = getBadgeColor(multiplier);

            var multiplication = '<div class="' + badgeColor + ' custom-badge mx-auto">' + (bets[i].cashout_multiplier > 0 ? (bets[i].amount * bets[i].cashout_multiplier).toFixed(2) + '' : '-') + '</div>';

            var sectionNo = bets[i].sectionNo ? 'bet_id_' + bets[i].sectionNo : '';

            html += '<div class="list-items ' + isActive + ' ' + sectionNo + '">' +
                '<div class="column-1 users"> <img src="' + bets[i].image + '" class="avatar  me-1">' + bets[i].userid + ' </div>' +
                '<div class="column-2"> ' + bets[i].amount + ' </div>' +
                '<div class="column-3"> <button class="btn btn-transparent previous-history d-flex align-items-center mx-auto"> ' + bets[i].amount + currency_symbol + ' </button> </div>' +
                '<div class="column-4"> ' + multiplication + ' </div>' +
                '</div>';

        }
        return html;
    }
    catch (error) {
    }
}


function update_all_bet_list(bets, target, appendType = '') {

    if (appendType == 1) {
        $("#all_bets .mCSB_container").html('');
    }
    if (appendType == 2) {
        $('#prev_bets .mCSB_container').html('');
    }
    var html = '';
    try {


        for (i = 0; i < bets.length; i++) {
            var isActive = bets[i].cashout_multiplier > 0 ? "active" : "";
            if (parseFloat(bets[i].cashout_multiplier) <= 2) {
                var badgeColor = 'bg3';
            } else if (parseFloat(bets[i].cashout_multiplier) < 10) {
                var badgeColor = 'bg1';
            } else {
                var badgeColor = 'bg2';
            }
            if (parseFloat(bets[i].cashout_multiplier) > 0) {
                var cashOut = Math.round(bets[i].cashout_multiplier * bets[i].amount) + currency_symbol;
                var multiplication = '<div class="' + badgeColor + ' custom-badge mx-auto">' + (bets[i].cashout_multiplier > 0 ? (bets[i].amount * bets[i].cashout_multiplier).toFixed(2) + '' : '-') + '</div>';
            } else {
                var cashOut = '-';
                var multiplication = '-';
            }

            var sectionNo = bets[i].type;
            html += '<div class="list-items ' + isActive + ' ' + sectionNo + ' ' + '">' +
                '<div class="column-1 users"> <img src="https://win24hrs.live/assets/aviator/images/avtar/av-24.png" class="avatar">' + bets[i].userid + '  </div>' +
                '<div class="column-2"> ' + bets[i].user_id + ' </div>' +
                '<div class="column-3"> <button class="btn btn-transparent previous-history d-flex align-items-center mx-auto"> ' + bets[i].amount + currency_symbol + ' </button> </div>' +
                '<div class="column-4"> ' + multiplication + ' </div>' +
                '</div>';
        }
        $(target).prepend(html);
    } catch (error) {
    }

}


function update_my_bet_Multipliers(element, sectionNo, mult) {
    const updatedMultiplier = (sectionNo == 0 || sectionNo == 1) ? mult : '1';
    const isActive = (sectionNo === 0 || sectionNo === 1) && updatedMultiplier > 0 ? "active" : "";
    const badgeColor = getBadgeColor(updatedMultiplier);

    $(element).removeClass("active").addClass(isActive);
    $(element).find('.column-4').html('<div class=" ' + badgeColor + '  custom-badge mx-auto">' + updatedMultiplier + '</div>');
}

function update_my_new_bet(bet_amount, section_no, target) {
    var html = '';
    html += '<div class="list-items" id="my_bet_section_' + section_no + '">' +
        '<div class="column-1 users fw-normal"> ' + get_current_hour_minute() + ' </div>' +
        '<div class="column-2"> <button class="btn btn-transparent previous-history d-flex align-items-center mx-auto fw-normal">' + parseFloat(bet_amount).toFixed(3) + '' + currency_symbol + '</button> </div>' +
        '<div class="column-3"> - </div>' +
        '<div class="column-4 fw-normal"> - </div>' +
        '</div>';
    $(target).prepend(html);
}

function update_my_bet_history(data) {

    var myBetListDiv = document.getElementById("my_bet_list");
    myBetListDiv.innerHTML = "";

    data.forEach(function (item) {
        var listItem = document.createElement("div");
        listItem.classList.add("list-items");

        listItem.innerHTML = `
                    <div class="column-1 users fw-normal">${item.add_date.split(' ')[0]}</div>
                    <div class="column-2">
                        <button class="btn btn-transparent previous-history d-flex align-items-center mx-auto fw-normal"> ${item.amount}</button>
                    </div>
                    <div class="column-3">
                        <div class="bg3 custom-badge mx-auto">${item.trade_type}x</div>
                    </div>
                    <div class="column-4 fw-normal">${currency_symbol}${item.trade_num !== null ? item.trade_num : '0'}</div>
`;

        myBetListDiv.appendChild(listItem);
    });
}

function get_multiplier_badge_class(multiplier) {
    if (parseFloat(multiplier) <= 2) {
        return 'bg3';
    } else if (parseFloat(multiplier) < 10) {
        return 'bg1';
    } else {
        return 'bg2';
    }
}

function previous_hand(val) {
    if (val == 1) {
        $("#current_hand_btn").addClass('hide');
        $("#previous_hand_btn").removeClass('hide');
        $("#all_bets").addClass('hide');
        $("#prev_bets").removeClass('hide');
        $("#prev_win_multi").removeClass('hide');
        prevoius_game_bets(current_game_data.id);
    } else {
        $("#current_hand_btn").removeClass('hide');
        $("#previous_hand_btn").addClass('hide');
        $("#all_bets").removeClass('hide');
        $("#prev_bets").addClass('hide');
        $("#prev_win_multi").addClass('hide');
        show_bet_count($('#all_bets .mCSB_container .list-items').length);
    }
};

function prevoius_game_bets(game_id) {
    $.ajax({
        url: 'previous_game_bet_list',
        data: {
            game_id: game_id,
        },
        type: "POST",
        dataType: "json",
        success: function (result) {
            if (result.isSuccess && Object.keys(result.data).length > 0) {
                var betList = result.data.bet_list;
                var betCount = result.data.bet_counts;
                var winMulti = result.data.win_multi;
                update_bet_list(betList, '#prev_bets .mCSB_container', 2);

                show_bet_count(betCount);
                $("#prev_win_multi").addClass(get_multiplier_badge_class(winMulti)).text(parseFloat(winMulti).toFixed(3) + 'x');
            } else {
                $("#prev_win_multi").addClass('bg1');
            }
        }
    });
}

function cash_out_multiplier(inc_no) {
    if (bet_array.length == 1 && bet_array[0].section_no == 0 && bet_array[0].is_bet != undefined) {
        $("#main_bet_section").find("#cash_out_amount").text(parseFloat(bet_array[0].bet_amount * inc_no).toFixed(3) + '' + currency_symbol);
    }

    if (bet_array.length == 1 && bet_array[0].section_no == 1 && bet_array[0].is_bet != undefined) {
        $("#extra_bet_section").find("#cash_out_amount").text(parseFloat(bet_array[0].bet_amount * inc_no).toFixed(3) + '' + currency_symbol);
    }

    if (bet_array.length == 2) {
        $.map(bet_array, function (item, index) {
            if (item.section_no == 0 && item.is_bet != undefined) {
                $("#main_bet_section").find("#cash_out_amount").text(parseFloat(item.bet_amount * inc_no).toFixed(3) + '' + currency_symbol);
            }
            if (item.section_no == 1 && item.is_bet != undefined) {
                $("#extra_bet_section").find("#cash_out_amount").text(parseFloat(item.bet_amount * inc_no).toFixed(3) + '' + currency_symbol);
            }
        });
    }
}

function show_bet_count(count, bet_amount) {
    $("#total_bets").text(count);
    $("#total_bets_amount").text(bet_amount);
}

function bet_now(element, section_no, event) {
    let wallet_balance = parseFloat(document.querySelector(".wallet-top").textContent.trim()) || 0;
    let bet_amount_check = parseFloat($(element).parent().parent().find(".bet-block .spinner #bet_amount").val()) || 0;

    if (wallet_balance <= 0) {
        return;
    }
    if (bet_amount_check > wallet_balance) {
        return;
    }
    event.preventDefault();
    $("#isbet").val(1);
    if (stage_time_out == 1) {
        if (section_no == 0) {
            enableDisable('main_bet_section');
        } else {

            enableDisable('extra_bet_section');
        }
        $(".error-toaster2").addClass('show');
        errorToastrStageTimeOut();
    } else {
        var bet_type = $(element).parent().parent().parent().find(".navigation #bet_type").val();

        let bet_amount = $(element).parent().parent().find(".bet-block .spinner #bet_amount").val();

        if (section_no == 0) {
            $("#main_bet_section .controls").addClass('bet-border-red');
        } else if (section_no == 1) {
            $("#extra_bet_section .controls").addClass('bet-border-red');
        }

        if (bet_amount < min_bet_amount || bet_amount == '' || bet_amount == NaN) {
            bet_amount = parseFloat(min_bet_amount).toFixed(2);
        }
        else if (bet_amount > max_bet_amount) {
            bet_amount = parseFloat(max_bet_amount).toFixed(2);
        }
        else {
            bet_amount = parseFloat(bet_amount).toFixed(2);
        }

        $(element).parent().parent().find(".bet-block .spinner #bet_amount").val(bet_amount);
        if (bet_amount >= min_bet_amount && bet_amount <= max_bet_amount) {


            $(element).parent().parent().find("#bet_button").hide();
            $(element).parent().parent().find("#cancle_button").show();
            $(element).parent().parent().find("#cancle_button #waiting").show();

            if (is_game_generated == 1) {
                setTimeout(() => {
                    $(element).parent().parent().find("#cancle_button #waiting").hide();
                }, 500);
            }

            bet_array.push({ bet_type: bet_type, bet_amount: bet_amount, section_no: section_no, });

        }
    }
}

function cancle_now(element, section_no) {
    if (stage_time_out == 1) {
        $(".error-toaster2").addClass('show');
        errorToastrStageTimeOut();
    } else {
        if (section_no == 0) {
            $('#main_auto_bet').prop('checked', false);
            $("#main_bet_section .controls").removeClass('bet-border-red');
        } else if (section_no == 1) {
            $('#extra_auto_bet').prop('checked', false);
            $("#extra_bet_section .controls").removeClass('bet-border-red');
        }

        if (bet_array.length == 1) {
            bet_array = [];
        }
        if (bet_array.length == 2 && section_no == 0) {
            if (bet_array[0].section_no == 0) {
                bet_array.splice(0, 1);
            }
            if (bet_array[0].section_no == 1) {
                bet_array.splice(1, 1);
            }
        }
        if (bet_array.length == 2 && section_no == 1) {
            if (bet_array[0].section_no == 0) {
                bet_array.splice(0, 1);
            }
            if (bet_array[0].section_no == 1) {
                bet_array.splice(1, 1);
            }
        }

        $(element).parent().parent().find("#bet_button").show();
        $(element).parent().parent().find("#cancle_button").hide();
        $(element).parent().parent().find("#cancle_button #waiting").hide();
    }
}

function place_bet_now(result) {
    try {
        for (let i = 0; i < bet_array.length; i++) {
            bet_array[i].game_id = result.id;
        }
        current_is_bet = true;

        var mult_no = getCookie('mult_no');
        if (mult_no < 10) {
            var increase_mult = Number(mult_no) + 1;
            setCookie('mult_no', increase_mult, 1);
        } else {
            setCookie('mult_no', 1, 1);
        }
        var triggerElement = document.querySelector('.wallet-top');
        var walletText = triggerElement.textContent;
        var amountUi = parseFloat(walletText.replace(/[^0-9.]/g, ''));

        $.ajax({
            url: 'Handler/add_bet.ashx',
            data: {
                "mult_no": 0,
                _token: hash_id,
                all_bets: JSON.stringify(bet_array),
                "RoundNo": result.id
            },
            type: "POST",
            dataType: "json",
            success: function (result) {
                if (result && result.Success) {
                    update_all_bet_list(result, '#all_my_bets .mCSB_container', 1);
                    try {
                        const bets_total_amts = result.Bets.reduce((acc, item) => {
                            return acc += Number(item.amount);
                        }, 0);

                        if (bets_total_amts != '' && bets_total_amts != NaN) {

                            total_bet_amounts = Number(bets_total_amts);
                            max_bet_amount = Number(max_bet_amount) - Number(bets_total_amts);
                            var updatedValue = (Number(amountUi) - Number(bets_total_amts)).toFixed(2);
                            document.querySelector('.wallet-top').textContent = updatedValue;

                            $(".main_bet_amount").prop('disabled', false);
                            $("#main_plus_btn").prop('disabled', false);
                            $("#main_minus_btn").prop('disabled', false);
                            $(".main_amount_btn").prop('disabled', false);
                            $("#main_checkout").prop('disabled', false)
                            if ($("#main_checkout").prop('checked')) {
                                $("#main_incrementor").prop('disabled', false);
                            }
                            $('#main_auto_bet').prop('checked', false);
                        } else {
                            $("#wallet_balance").text(currency_symbol + '0.00');
                            $("#header_wallet_balance").text(currency_symbol + '0.00');
                        }



                    } catch (error) {

                    }

                } else {
                    $(".error-toaster1 .msg").html(result.message);
                    $(".error-toaster1").addClass('show');
                    errorToastr();

                    $("#main_bet_section").find("#bet_button").show();
                    $("#main_bet_section").find("#cancle_button").hide();
                    $("#main_bet_section").find("#cancle_button #waiting").hide();
                    $("#main_bet_section").find("#cashout_button").hide();
                    $("#main_bet_section .controls").removeClass('bet-border-red');
                    $("#main_bet_section .controls").removeClass('bet-border-yellow');
                    $("#main_bet_section .controls .navigation").removeClass('stop-action');

                    $("#extra_bet_section").find("#bet_button").show();
                    $("#extra_bet_section").find("#cancle_button").hide();
                    $("#extra_bet_section").find("#cancle_button #waiting").hide();
                    $("#extra_bet_section").find("#cashout_button").hide();
                    $("#extra_bet_section .controls").removeClass('bet-border-red');
                    $("#extra_bet_section .controls").removeClass('bet-border-yellow');
                    $("#extra_bet_section .controls .navigation").removeClass('stop-action');

                    $(".main_bet_amount").prop('disabled', false);
                    $("#main_plus_btn").prop('disabled', false);
                    $("#main_minus_btn").prop('disabled', false);
                    $(".main_amount_btn").prop('disabled', false);
                    $("#main_checkout").prop('disabled', false)
                    if ($("#main_checkout").prop('checked')) {
                        $("#main_incrementor").prop('disabled', false);
                    }
                    $('#main_auto_bet').prop('checked', false);

                    $(".extra_bet_amount").prop('disabled', false);
                    $("#extra_minus_btn").prop('disabled', false);
                    $("#extra_plus_btn").prop('disabled', false);
                    $(".extra_amount_btn").prop('disabled', false);
                    $("#extra_checkout").prop('disabled', false);
                    if ($("#extra_checkout").prop('checked')) {
                        $("#extra_incrementor").prop('disabled', false);
                    }
                    $('#extra_auto_bet').prop('checked', false);

                    bet_array = [];
                }
            }

        });
    } catch (e) {

    }
}

function firstToastr() {
    let first_no = 1;
    var success_toast1 = setInterval(function () {
        if (first_no < 3) {
            first_no++;
        } else {
            $(".cashout-toaster1").removeClass('show');
            clearInterval(success_toast1);
        }
    }, 1000);
}

function secondToastr() {
    let second_no = 1;
    var success_toast2 = setInterval(function () {
        if (second_no < 3) {
            second_no++;
        } else {
            $(".cashout-toaster2").removeClass('show');
            clearInterval(success_toast2);
        }
    }, 1000);
}

function errorToastr() {
    let error_no = 1;
    var error_toast1 = setInterval(function () {
        if (error_no < 3) {
            error_no++;
        } else {
            $(".error-toaster1").removeClass('show');
            clearInterval(error_toast1);
        }
    }, 1000);
}

function errorToastrStageTimeOut() {
    let stage_error_no = 1;
    var error_toast_stage_time_out = setInterval(function () {
        if (stage_error_no < 3) {
            stage_error_no++;
        } else {
            $(".error-toaster2").removeClass('show');
            clearInterval(error_toast_stage_time_out);
        }
    }, 1000);
}

function get_current_hour_minute() {
    var date = new Date;
    var hour = date.getHours();
    var minutes = date.getMinutes();

    if (hour.toString().length > 1) {
        var retHour = hour;
    } else {
        var retHour = '0' + hour;
    }

    if (minutes.toString().length > 1) {
        var retMinute = minutessetCookie
    } else {
        var retMinute = '0' + minutes;
    }

    return retHour + ':' + retMinute;
}

function update_round_history() {

    try {
        $.ajax({
            url: 'Handler/get_round_history.ashx',
            method: 'GET',
            success: function (response) {
                if (response.error) {
                    console.error("Server error:", response.error);
                    return;
                }
                const history = response.result;
                $(".round-history-list").empty(); 
                history.forEach(function (multiplier) {
                    var html = '<div class="' + get_multiplier_badge_class(multiplier) + ' custom-badge">' +
                        parseFloat(multiplier).toFixed(2) + 'x</div>';
                    $(".payouts-wrapper .payouts-block").prepend(html);
                    $(".button-block .history-dropdown .round-history-list").prepend(html);
                });
            }
        });
    }
    catch (error) {
    }
}



function loadData() {
    const numItems = $('.bet_record_count').length;
    $.ajax({
        url: '/member_bet',
        type: 'post',
        data: {
            'offset': numItems,
        },
        success: function (result) {
            const length = result.data.length;
            if (length > 0) {
                for (let i = 0; i < length; i++) {
                    if (parseFloat(result.data[i].multiplication) > 0) {
                        var multiplier = `<div class="${get_multiplier_badge_class(result.data[i].multiplication)} custom-badge mx-auto"> ${result.data[i].multiplication}x </div>`;
                    } else {
                        var multiplier = `-`;
                    }

                    $("#member_bet .mCSB_container").append(`
                            <div class="list-items bet_record_count ${result.data[i].cash_out_amount > 0 ? 'active' : ''}">
                                <div class="column-1 users fw-normal">
                                    ${result.data[i].date}
                                </div>
                                <div class="column-2">
                                    <button class="btn btn-transparent previous-history d-flex align-items-center mx-auto fw-normal">
                                        ${result.data[i].bet_amount + currency_symbol}
                                    </button>
                                </div>
                                <div class="column-3">
                                    ${multiplier}
                                </div>
                                <div class="column-4 fw-normal">
                                    ${result.data[i].cash_out_amount > 0 ? result.data[i].cash_out_amount + currency_symbol : '-'} 
                                </div>
                            </div>
                        `);
                }
            }
            if (length < 10) {
                $("#load_btn").hide();
            } else {
                $("#load_btn").show();
            }
        }
    })
}

$("#main_auto_bet").on('change', function () {
    let isChecked = $(this).prop('checked');
    let section_no = 0;
    const isCheckedCashout = $("#main_checkout").prop('checked');

    if (isChecked) {
        $("#main_bet_section").find("#bet_button").hide();
        $("#main_bet_section").find("#cancle_button").show();
        $("#main_bet_section").find("#cancle_button #waiting").show();
        if (is_game_generated == 1) {
            setTimeout(() => {
                $("#main_bet_section").find("#cancle_button #waiting").hide();
            }, 500);
        }
        $("#main_bet_section").find("#cashout_button").hide();
        $("#main_bet_section .controls").addClass('bet-border-red');
        $("#main_bet_section").parent().parent().find('.cashout-spinner-wrapper input').prop('disabled', true)
        $("#main_bet_section").find('.controls .navigation').addClass('stop-action')
        var bet_type = $("#main_bet_now").parent().parent().parent().find(".navigation #bet_type").val();
        let bet_amount = $("#main_bet_now").parent().parent().find(".bet-block .spinner #bet_amount").val();

        if (bet_amount < min_bet_amount || bet_amount == '' || bet_amount == NaN) {
            bet_amount = parseFloat(min_bet_amount).toFixed(2);
        } else if (bet_amount > max_bet_amount) {
            bet_amount = parseFloat(max_bet_amount).toFixed(2);
        } else {
            bet_amount = parseFloat(bet_amount).toFixed(2);
        }

        $("#main_bet_now").parent().parent().find(".bet-block .spinner #bet_amount").val(bet_amount);

        if (bet_amount >= min_bet_amount && bet_amount <= max_bet_amount) {
            if (bet_array.length == 1) {
                if (bet_array[0].section_no != section_no) {
                    bet_array.push({ bet_type: bet_type, bet_amount: bet_amount, section_no: section_no });
                }
            } else if (bet_array.length == 2) {
                if (bet_array[0].section_no != section_no && bet_array[1].section_no != section_no) {
                    bet_array.push({ bet_type: bet_type, bet_amount: bet_amount, section_no: section_no });
                }
            } else {
                bet_array.push({ bet_type: bet_type, bet_amount: bet_amount, section_no: section_no });
            }
        }

        $(".main_bet_amount").prop('disabled', true);
        $("#main_plus_btn").prop('disabled', true);
        $("#main_minus_btn").prop('disabled', true);
        $(".main_amount_btn").prop('disabled', true);
        $("#main_checkout").prop('disabled', true);
        if ($("#main_checkout").prop('checked')) {
            $("#main_incrementor").prop('disabled', true);
        }

    } else {
        if (isCheckedCashout == false) {
            $("#main_bet_section").parent().parent().find('.cashout-spinner-wrapper input').prop('disabled', false)
            $("#main_bet_section").find('.controls .navigation').removeClass('stop-action')
        } else {
            $("#main_bet_section").parent().parent().find('.cashout-spinner-wrapper input').prop('disabled', true)
            $("#main_bet_section").find('.controls .navigation').addClass('stop-action')
        }

        if (bet_array.length == 1) {
            bet_array.splice(0, 1);
        } else if (bet_array.length == 2 && section_no == 0) {
            if (bet_array[0].section_no == 0) {
                bet_array.splice(0, 1);
            } else {
                bet_array.splice(1, 1);
            }
        } else if (bet_array.length == 2 && section_no == 1) {
            if (bet_array[0].section_no == 1) {
                bet_array.splice(0, 1);
            } else {
                bet_array.splice(1, 1);
            }
        }

        $("#main_bet_section").find("#bet_button").show();
        $("#main_bet_section").find("#cancle_button").hide();
        $("#main_bet_section").find("#cancle_button #waiting").hide();
        $("#main_bet_section").find("#cashout_button").hide();
        $("#main_bet_section .controls").removeClass('bet-border-red');

        $(".main_bet_amount").prop('disabled', false);
        $("#main_plus_btn").prop('disabled', false);
        $("#main_minus_btn").prop('disabled', false);
        $(".main_amount_btn").prop('disabled', false);
        $("#main_checkout").prop('disabled', false)
        if ($("#main_checkout").prop('checked')) {
            $("#main_incrementor").prop('disabled', false);
        }
    }

});

$("#extra_auto_bet").on('change', function () {

    let isChecked = $(this).prop('checked');
    let section_no = 1;
    const isCheckedCashout = $('#extra_checkout').prop('checked');

    if (isChecked) {
        $("#extra_bet_section").find("#bet_button").hide();
        $("#extra_bet_section").find("#cancle_button").show();
        $("#extra_bet_section").find("#cancle_button #waiting").show();
        if (is_game_generated == 1) {
            setTimeout(() => {
                $("#extra_bet_section").find("#cancle_button #waiting").hide();
            }, 500);
        }
        $("#extra_bet_section").find("#cashout_button").hide();
        $("#extra_bet_section .controls").addClass('bet-border-red');
        $("#extra_bet_section").parent().parent().find('.cashout-spinner-wrapper input').prop('disabled', true)
        $("#extra_bet_section").find('.controls .navigation').addClass('stop-action')
        var bet_type = $("#extra_bet_now").parent().parent().parent().find(".navigation #bet_type").val();
        let bet_amount = $("#extra_bet_now").parent().parent().find(".bet-block .spinner #bet_amount").val();

        if (bet_amount < min_bet_amount || bet_amount == '' || bet_amount == NaN) {
            bet_amount = parseFloat(min_bet_amount).toFixed(2);
        } else if (bet_amount > max_bet_amount) {
            bet_amount = parseFloat(max_bet_amount).toFixed(2);
        } else {
            bet_amount = parseFloat(bet_amount).toFixed(2);
        }

        $("#extra_bet_now").parent().parent().find(".bet-block .spinner #bet_amount").val(bet_amount);

        if (bet_amount >= min_bet_amount && bet_amount <= max_bet_amount) {

            if (bet_array.length == 1) {
                if (bet_array[0].section_no != section_no) {
                    bet_array.push({ bet_type: bet_type, bet_amount: bet_amount, section_no: section_no });
                }
            } else if (bet_array.length == 2) {
                if (bet_array[0].section_no != section_no && bet_array[1].section_no != section_no) {
                    bet_array.push({ bet_type: bet_type, bet_amount: bet_amount, section_no: section_no });
                }
            } else {
                bet_array.push({ bet_type: bet_type, bet_amount: bet_amount, section_no: section_no });
            }
        }
        $(".extra_bet_amount").prop('disabled', true);
        $("#extra_minus_btn").prop('disabled', true);
        $("#extra_plus_btn").prop('disabled', true);
        $(".extra_amount_btn").prop('disabled', true);
        $("#extra_checkout").prop('disabled', true);
        if ($("#extra_checkout").prop('checked')) {
            $("#extra_incrementor").prop('disabled', true);
        }


    } else {
        if (isCheckedCashout == false) {
            $("#extra_bet_section").parent().parent().find('.cashout-spinner-wrapper input').prop('disabled', false)
            $("#extra_bet_section").find('.controls .navigation').removeClass('stop-action')
        } else {
            $("#extra_bet_section").parent().parent().find('.cashout-spinner-wrapper input').prop('disabled', true)
            $("#extra_bet_section").find('.controls .navigation').addClass('stop-action')
        }

        if (bet_array.length == 1) {
            bet_array.splice(0, 1);
        } else if (bet_array.length == 2 && section_no == 0) {
            if (bet_array[0].section_no == 0) {
                bet_array.splice(0, 1);
            } else {
                bet_array.splice(1, 1);
            }
        } else if (bet_array.length == 2 && section_no == 1) {
            if (bet_array[0].section_no == 1) {
                bet_array.splice(0, 1);
            } else {
                bet_array.splice(1, 1);
            }
        }

        $("#extra_bet_section").find("#bet_button").show();
        $("#extra_bet_section").find("#cancle_button").hide();
        $("#extra_bet_section").find("#cancle_button #waiting").hide();
        $("#extra_bet_section").find("#cashout_button").hide();
        $("#extra_bet_section .controls").removeClass('bet-border-red');

        $(".extra_bet_amount").prop('disabled', false);
        $("#extra_minus_btn").prop('disabled', false);
        $("#extra_plus_btn").prop('disabled', false);
        $(".extra_amount_btn").prop('disabled', false);
        $("#extra_checkout").prop('disabled', false);
        if ($("#extra_checkout").prop('checked')) {
            $("#extra_incrementor").prop('disabled', false);
        }

    }

});

function soundPlay() {
    let sound = document.getElementById("sound_Audio");
    if (document.hidden) {
        sound.pause();
    } else {
        if ($("#sound").prop("checked") == true) {
            if (window_blur == 0) {
                sound.play();
            } else {
                sound.pause();
            }

        } else {
            sound.pause();
        }
    }
}

function flyPlaneSound() {
    let sound = document.getElementById("fly_plane_audio");
    if (document.hidden) {
        sound.pause();
    } else {
        if ($("#sound").prop("checked") == true) {
            if (window_blur == 0) {
                sound.play();
            } else {
                sound.pause();
            }
        } else {
            sound.pause();
        }
    }
}

function cashOutSound() {
    let sound = document.getElementById("cash_out_audio");
    if (document.hidden) {
        sound.pause();
    } else {
        if ($("#sound").prop("checked") == true) {
            if (window_blur == 0) {
                sound.play();
            } else {
                sound.pause();
            }
        } else {
            sound.pause();
        }
    }
}

function cashOutSoundOtherSection() {
    let sound = document.getElementById("cash_out_audio_2");
    if (document.hidden) {
        sound.pause();
    } else {
        if ($("#sound").prop("checked") == true) {
            if (window_blur == 0) {
                sound.play();
            } else {
                sound.pause();
            }
        } else {
            sound.pause();
        }
    }
}

function backgroundSound() {
    let music = document.getElementById("background_Audio");
    if ($("#music").prop("checked") == true) {
        music.volume = 0.5;
        music.autoplay = true;
        music.loop = true;
        music.load();
    } else {
        music.pause();
    }
}

backgroundSound();
$("#music").on('change', function () {
    backgroundSound();
})

$(".main_bet_btn").on('click', function () {

    if (stage_time_out != 1) {
        let id = $(this).attr('id');
        if (id == 'main_bet_now') {
            $(".main_bet_amount").prop('disabled', true);
            $("#main_plus_btn").prop('disabled', true);
            $("#main_minus_btn").prop('disabled', true);
            $(".main_amount_btn").prop('disabled', true);
            $("#main_checkout").prop('disabled', true);
            $("#main_incrementor").prop('disabled', true);

        } else if (id == 'main_cancel_now') {
            $(".main_bet_amount").prop('disabled', false);
            $("#main_plus_btn").prop('disabled', false);
            $("#main_minus_btn").prop('disabled', false);
            $(".main_amount_btn").prop('disabled', false);
            $("#main_checkout").prop('disabled', false)
            if ($("#main_checkout").prop('checked')) {
                $("#main_incrementor").prop('disabled', false);
            }

        }

        if (id == 'extra_bet_now') {
            $(".extra_bet_amount").prop('disabled', true);
            $("#extra_minus_btn").prop('disabled', true);
            $("#extra_plus_btn").prop('disabled', true);
            $(".extra_amount_btn").prop('disabled', true);
            $("#extra_checkout").prop('disabled', true);
            $("#extra_incrementor").prop('disabled', true);
        } else if (id == 'extra_cancel_now') {
            $(".extra_bet_amount").prop('disabled', false);
            $("#extra_minus_btn").prop('disabled', false);
            $("#extra_plus_btn").prop('disabled', false);
            $(".extra_amount_btn").prop('disabled', false);
            $("#extra_checkout").prop('disabled', false);
            if ($("#extra_checkout").prop('checked')) {
                $("#extra_incrementor").prop('disabled', false);
            }

        }

    }

});

function check_login_status() {
    $.ajax({
        url: 'is_login',
        type: "POST",
        dataType: "json",
        success: function (result) {
            if (result.isSuccess == false) {
                window.location.href = 'login';
            }
        }
    });
}

function gameLoadingTimer() {
    let timer_no = 1;
    var game_loading_timer = setInterval(function () {
        if (timer_no <= 5) {
            if (timer_no == 1) {
                $('.loading-game').addClass('show');
            }
            timer_no++;
        } else {
            $(".loading-game").removeClass('show');
            clearInterval(game_loading_timer);
        }
    }, 1000);
}

let focus_timer = 0;
let focus_interval;
let visibility_timer = 0;
let visibility_interval;

$(window).focus(function () {
    if (focus_timer > 10) {
        location.reload();
    } else {
        focus_timer = 0;
        clearInterval(focus_interval);
    }
});

let window_blur = 0;
$(window).blur(function () {
    const music = document.getElementById("background_Audio");
    window_blur = 1;
    music.pause();
    focus_interval = setInterval(function () {
        focus_timer = parseInt(focus_timer + 1);
    }, 1000);
});


$(window).focus(function () {
    window_blur = 0;
    const music = document.getElementById("background_Audio");
    music.play();

});
document.addEventListener('visibilitychange', function (event) {
    if (document.hidden) {
        visibility_interval = setInterval(function () {
            visibility_timer = parseInt(visibility_timer + 1);
        }, 1000);
    } else {
        if (visibility_timer > 10) {
            location.reload();
        } else {
            visibility_timer = 0;
            clearInterval(visibility_interval);
        }
    }
});

function enableDisable(section) {
    $(`#${section}`).find('.controls').addClass('dullEffect');
    setTimeout(function () {
        $(`#${section}`).find('.controls').removeClass('dullEffect');
    }, 200);
}

function main_incrementor_change(new_value) {
    if (new_value < 1.01) {
        $("#main_incrementor").val("1.01");
    } else {
        $("#main_incrementor").val(parseFloat(new_value).toFixed(3));
    }
}
function extra_incrementor_change(new_value) {
    if (new_value < 1.01) {
        $("#extra_incrementor").val("1.01");
    } else {
        $("#extra_incrementor").val(parseFloat(new_value).toFixed(3));
    }
}
function hide_loading_game() {
    $('.loading-game').removeClass('show');
}
function show_loading_game() {
    $('.loading-game').addClass('show');

}

$(window).bind("pageshow", function (event) {
    if (event.originalEvent.persisted) {
        $(".load-txt").show();
    }
});

$(".fill-line").bind('oanimationend animationend webkitAnimationEnd', function () {
    $(".game-centeral-loading").hide();
    $('bottom-left-plane').show();
});

$(".fill-line").bind('oanimationstart animationstart webkitAnimationStart', function () {
    $(".game-centeral-loading").show();
});



$(document).click(function () {
    if ($(".button-block").hasClass('show')) {
        $(".button-block").removeClass('show');
    }
});

$(".history-top").click(function (e) {
    e.stopPropagation();
    return false;
});

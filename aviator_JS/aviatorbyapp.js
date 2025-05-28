var gameId;
function gameover(lastint) {
    //debugger;
    $("#isbet").val(0);
    $.ajax({
        url: 'Handler/game_over.ashx',
        type: "POST",
        data: {
            _token: hash_id,
            "last_time": lastint,
            "game_id": gameId
        },
        dataType: "text",
        success: function (result) {
            debugger;
            if (current_is_bet) {
                $.ajax({
                    url: 'Handler/my_bets_history.ashx',
                    type: "POST",
                    data: {
                        _token: hash_id
                    },
                    dataType: "json",
                    success: function (data) {
                        debugger;
                        update_my_bet_history(data.data);
                    }
                });
            }
            current_is_bet = false;
            current_cash = false;
            $("#main_bet_section").find("#cashout_button").hide();

            $("#main_bet_section").find("#bet_button").show();

            $("#main_bet_section").find("#cancle_button").hide();
            $("#main_bet_section").find("#cancle_button #waiting").hide();
            $("#main_bet_section .controls").removeClass('bet-border-red');
            $("#main_bet_section .controls").removeClass('bet-border-yellow');
            $("#main_bet_section .controls .navigation").removeClass('stop-action');

            $("#extra_bet_section").find("#bet_button").show();
            $("#extra_bet_section").find("#cashout_button").hide();
            $("#extra_bet_section").find("#cancle_button").hide();
            $("#extra_bet_section").find("#cancle_button #waiting").hide();
            $("#extra_bet_section").find("#cashout_button").hide();
            $("#extra_bet_section .controls").removeClass('bet-border-red');
            $("#extra_bet_section .controls").removeClass('bet-border-yellow');
            $("#extra_bet_section .controls .navigation").removeClass('stop-action');


            if (result) {
                var responseData = JSON.parse(result);

                if (responseData.is_win == 2) {

                    bet_array = [];


                    setTimeout(() => {
                        $("#auto_increment_number_div").hide();
                        $(".flew_away_section").hide();
                        $("#auto_increment_number").removeClass('text-danger');
                        $(".game-centeral-loading").show();
                        show_loading_game();
                        gamegenerate();
                    }, 5000);





                    // Main Bet
                    $(".main_bet_amount").prop('disabled', false);
                    $("#main_plus_btn").prop('disabled', false);
                    $("#main_minus_btn").prop('disabled', false);
                    $(".main_amount_btn").prop('disabled', false);
                    $("#main_checkout").prop('disabled', false);
                    if ($("#main_checkout").prop('checked')) {
                        $("#main_incrementor").prop('disabled', false);
                    }
                    $('#main_auto_bet').prop('checked', false);

                    // Extra Bet
                    $(".extra_bet_amount").prop('disabled', false);
                    $("#extra_minus_btn").prop('disabled', false);
                    $("#extra_plus_btn").prop('disabled', false);
                    $(".extra_amount_btn").prop('disabled', false);
                    $("#extra_checkout").prop('disabled', false);
                    if ($("#extra_checkout").prop('checked')) {
                        $("#extra_incrementor").prop('disabled', false);
                    }
                    $('#extra_auto_bet').prop('checked', false);

                } else {
                    $("#main_bet_section").find("#bet_button").show();
                    $("#main_bet_section").find("#cancle_button").hide();
                    $("#main_bet_section").find("#cancle_button #waiting").hide();
                    $("#main_bet_section").find("#cashout_button").hide();
                }
            }
        }
    });
}
function currentid() {
    $.ajax({
        url: 'aviator/currentid',
        type: "post",
        data: {
            _token: hash_id
        },
        dataType: "json",
        success: function (result) {
        }
    });
}

function gamegenerate() {
    debugger;
    bet_array.length = 0;

    setTimeout(() => {
        $("#auto_increment_number_div").hide();
        $('.loading-game').addClass('show');

        setTimeout(() => {

            hide_loading_game();
            $.ajax({
                url: "Handler/new_game_generated.ashx",
                type: "GET",
                data: {
                    _token: hash_id,
                },

                dataType: "json",
                success: function (result) {
                    if (!result.Success && result.Message === "Not Authenticated") {
                        window.location.href = "SignIn.aspx";
                        return;
                    }
                    incrementor(parseFloat(1.00).toFixed(2));
                    debugger;
                    if (bet_array.length > 0) {
                        place_bet_now(result);
                    }
                    gameId = result.id;
                    $("#auto_increment_number_div").show();
                    current_game_data = result;
                    hide_loading_game();
                    $(".flew_away_section").hide();
                    $("#auto_increment_number").removeClass("text-danger");
                    document.querySelector('.period_no').textContent = "Round No : " + result.id;

                    lets_fly_one();
                    lets_fly();
                    let currentbet = 0;
                    var a = 1.0;
                    debugger;
                    let isbet = $("#isbet").val();
                    isbet = 1;
                    $.ajax({
                        url: "Handler/increamentor.ashx",
                        type: "POST",
                        data: {
                            // token: Number(getCookie('mult_no')),
                            token: 0,
                            isbet: 0,
                            game_id: result.id,
                        },
                        dataType: "text",
                        success: function (data) {
                            var decodedData = atob(data);
                            var mlresult = JSON.parse(decodedData);
                            console.log(mlresult);
                            if (current_is_bet) {

                                if (mlresult.result <= 3) {
                                    currentbet = mlresult.result;
                                } else {
                                    currentbet = 1.11;
                                }
                            } else {

                                currentbet = mlresult.result;
                            }

                            function MyBetHistory() {
                                $.ajax({
                                    url: 'Handler/my_bets_history.ashx',
                                    type: "POST",
                                    data: {
                                        _token: hash_id
                                    },
                                    dataType: "json",
                                    success: function (data) {
                                        update_my_bet_history(data.data);
                                    }
                                });
                            }
                            MyBetHistory();
                            setInterval(MyBetHistory, 1000);

                            function CurrentlyBet() {
                                $.ajax({
                                    url: "Handler/currentlybet.ashx",
                                    type: "POST",
                                    data: {
                                        _token: hash_id,
                                    },
                                    dataType: "json",
                                    success: function (intialData) {
                                      
                                        info_data(intialData);
                                    },
                                });
                            }
                            CurrentlyBet();
                            setInterval(CurrentlyBet, 1000);


                            var randomintervalId = setInterval(function () {
                                updateRandomMultiplier(bet_list_current, '#all_bets .mCSB_container', a);
                            }, 300);
                            let increamtsappgame = setInterval(() => {

                                if (current_cash) {
                                    const randomNumbers = (Math.random() * (5.99 - 3.5) + 4.5).toFixed(2);
                                    currentbet = randomNumbers;

                                }


                                if (a >= currentbet) {

                                    let res = parseFloat(a).toFixed(2);
                                    a = 1.0;
                                    let result = res;
                                    crash_plane(result);
                                    incrementor(res);
                                    $("#main_bet_section").find("#cashout_button").hide();
                                    gameover(result);
                                    $("#all_bets .mCSB_container").empty();
                                    $("#all_my_bets .mCSB_container").empty();
                                    clearInterval(increamtsappgame);
                                    clearInterval(randomintervalId);
                                    $("#main_bet_section").find("#bet_button").show();
                                    $("#main_bet_section").find("#cancle_button").hide();
                                    $("#main_bet_section").find("#cancle_button #waiting").hide();
                                    $("#main_bet_section .controls").removeClass('bet-border-red');
                                    $("#main_bet_section .controls").removeClass('bet-border-yellow');
                                    $("#main_bet_section .controls .navigation").removeClass('stop-action');

                                    $("#extra_bet_section").find("#bet_button").show();
                                    $("#extra_bet_section").find("#cashout_button").hide();
                                    $("#extra_bet_section").find("#cancle_button").hide();
                                    $("#extra_bet_section").find("#cancle_button #waiting").hide();
                                    $("#extra_bet_section").find("#cashout_button").hide();
                                    $("#extra_bet_section .controls").removeClass('bet-border-red');
                                    $("#extra_bet_section .controls").removeClass('bet-border-yellow');
                                    $("#extra_bet_section .controls .navigation").removeClass('stop-action');

                                    $("#total_bets_amount").text(0);
                                } else {

                                    a = parseFloat(a) + 0.01;
                                    incrementor(parseFloat(a).toFixed(2));

                                }
                            }, 60)



                        }
                    })
                }
            });
        }, 10000);

    }, 1500);
}

function check_game_running(event) {

}

$(document).ready(function () {
    check_game_running("check");
    // gamegenerate();
});
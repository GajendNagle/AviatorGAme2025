function TransferToUser() {
    $('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');
    var od = new FormData();
    var txttomem = $("#txttomem").val();
    var txttxnpwd = $("#txttxnpwd").val();
    var txtDepositAmount = $("#txtDepositAmount").val();
    //var type = $('#eWalletName').val();
    var type = "Main-Wallet";
    var txtOtp = $("#txtOtp").val();

    ////////
    var tamt = document.getElementById('txtDepositAmount');
    var tamtfilter = /^[0-9]+$/;
    /////////
    // if (txtDepositAmount >= 5 &  txtDepositAmount % 5 == 0) {
    //}
    var WallBal = $('#WallBal').val();
    if (parseFloat(tamt.value) <= parseFloat(WallBal)) {

        if (tamtfilter.test(tamt.value)) {
            $("#submitTrnasferNow").html('Plase wait...');
            //$('#Msgs').html('<img src="../UserProfileImg/loading2.gif" />');
            $('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');
            od.append("txttomem", txttomem);
            od.append("txttxnpwd", txttxnpwd);
            od.append("txtDepositAmount", txtDepositAmount);
            od.append("type", type);
            od.append("txtOtp", txtOtp);
            $.ajax({
                url: "Handlers/Transfer-to-user.ashx",
                type: "POST",
                contentType: false,
                processData: false,
                data: od,
                dataType: "json",
                success: function (Response) {
                    if (Response.Success) {
                        if (Response.detail == 200) {

                            /*$('#otpps').show();*/
                            $('#otpdtl').removeClass('d-none');
                            $('#otpdtl').addClass('d-block');
                            $('#Msgs').html('');

                            swal({
                                title: "OTP Sent",
                                text: Response.Message,
                                type: "success"
                            });
                            document.getElementById("submitTrnasferNow").disabled = false;
                            $("#submitTrnasferNow").html('Submit<span class="fa-solid fa-right-to-bracket ml-2">');
                        }
                        else if (Response.detail == 1) {
                            $("#txttomem").val('');
                            $("#txttxnpwd").val('');
                            $("#txtDepositAmount").val('');
                            $('#MemName').html('');
                            eWalletBalanceew(type);
                            $('#Msgs').html('');
                            swal({
                                title: "Congratulation!",
                                text: Response.Message,
                                type: "success"
                            },
                                function () {
                                    window.location.href = "From-up-history.html?IncType=Transfer-to-user";
                                });
                        };
                        document.getElementById("submitTrnasferNow").disabled = false;
                        $("#submitTrnasferNow").html('Submit<span class="fa-solid fa-right-to-bracket ml-2">');

                    }
                    else {
                        $('#Msgs').html('');
                        swal({
                            title: "Ooops!",
                            text: Response.Message,
                            type: "error"
                        });
                        document.getElementById("submitTrnasferNow").disabled = false;
                        $("#submitTrnasferNow").html('Submit<span class="fa-solid fa-right-to-bracket ml-2">');
                    }
                },
                error: function (err) {
                    $('#Msgs').html('');
                    swal({
                        title: "Ooops!",
                        text: err.statusText,
                        type: "error"
                    });
                    document.getElementById("submitTrnasferNow").disabled = false;
                    $("#submitTrnasferNow").html('Submit<span class="fa-solid fa-right-to-bracket ml-2">');
                }
            });
         
        }

        else {
            $("#txtDepositAmount").val('');
        }
    }
    else {
        $('#Msgs').html('');
        swal({
            title: "Ooops!",
            text: "Please check Wallet Balance !",
            type: "error"
        });
        document.getElementById("submitTrnasferNow").disabled = false;
        $("#submitTrnasferNow").html('<span class="fa fa-file mr-2"></span>Submit');
    }
}

$(function () {

    var txt = $("#txttomem");
    var func = function () {

        var txtval = $("#txttomem").val();
        if (txtval != '') {
            $.getJSON('Handlers/Transfer-to-user.ashx?MN=' + txtval,
                function (OrjsonDS) {

                    if (OrjsonDS.length == 0) {
                        $("#txttomem").val('');
                    }
                    else {

                        if (OrjsonDS.Message == "0") {
                            $("#txttomem").val('');
                            $('#MemNameFt').html("<div style='margin:5px;'>Enter correct referral or Own Mem-ID</div>");
                        }
                        else {
                            $('#MemNameFt').html(OrjsonDS.Message);
                        }
                    }

                });
        }
        else {
            $('#MemNameFt').html('');
        }
    }
    txt.blur(func);
});

function eWalletBalanceew(pgid) {

    $('#WallBalance').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');

    if (pgid != '') {
        $.getJSON('Handlers/eWalletBalance.ashx?EwTp=' + pgid,
            function (OrjsonDS) {
                if (OrjsonDS.length == 0) {
                }
                else {
                    var wa = '';
                    for (var i = 0; i < OrjsonDS.length; i++) {
                        if (pgid == "IWallet") {
                            $('#WallBal').val(OrjsonDS[i].ACCOUNT_BALANCE);
                            $('#WallBalance').html('i-Wallet Balance : <sup>$</sup> ' + OrjsonDS[i].ACCOUNT_BALANCE);
                            $('#iWallBal1').html('i-Wallet Balance : <sup>$</sup> ' + OrjsonDS[i].ACCOUNT_BALANCE);
                        }

                        if (pgid == "RWallet") {
                            $('#RWallBal').val(OrjsonDS[i].ACCOUNT_BALANCE);
                            $('#RWallBal1').html('R-Wallet Balance : <sup>$</sup> ' + OrjsonDS[i].ACCOUNT_BALANCE);

                        }
                        if (pgid == "CWallet") {
                            $('#WallBal').val(OrjsonDS[i].ACCOUNT_BALANCE);
                            $('#WallBalance').html('c-Wallet Balance : <sup>$</sup> ' + OrjsonDS[i].ACCOUNT_BALANCE);
                        }

                    }
                }
            });
    }
    else {
        $('#WallBalance').html('');
        $('#WallBal').val('');
        $('#iWallBal1').html('');
    }
}

function transferamt() {
    var valu = $("#TransferAmt").val();
    var WalletBalance = $("#WallBal").text();
    if (parseFloat(valu) > 0) {
        if (parseFloat(valu) > parseFloat(WalletBalance)) {
            $('#Msg1').html("<div class='alert alert-danger alert-bordered fade in'>Please check fields/Wallet Balance again !<span class='close' data-dismiss='alert'>&times;</span></div>");
            $("#TransferAmt").val('');
        }

    }


}

function transferamtRWALL() {

    var valuR = $("#TransferAmtrwal").val();
    var WalletBalanceR = $("#RWallBal").val();
    if (parseFloat(valuR) > 0) {
        if (parseFloat(valuR) > parseFloat(WalletBalanceR)) {
            $('#Msg2').html("<span style='color:red;font-weight:bold;'>Please check fields/Wallet Balance again !</span> ");
            $("#TransferAmtrwal").val('');
        }

    }


}
var valui = $("#TransferAmt").val();
var valur = $("#TransferAmtrwal").val();

function getamt()
{
    var transfamt = $('#txtDepositAmount').val();
    var deductamt = $('#transferuserDeduc').val();
    var netpay = (Number(transfamt) * deductamt / 100);
    var netpay1 = (Number(transfamt) - (netpay)).toFixed(2);
    $('#Deduction').html(netpay + ' TRX with transaction fee');
    $('#NetWithAmt').html(netpay1);
}
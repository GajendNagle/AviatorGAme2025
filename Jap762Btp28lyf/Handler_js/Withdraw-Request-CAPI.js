
function TotWithdrawalAmt() {
    $('#valueshow').css('display', 'flex');
    var txtMCB = $('#txtProfitSharing').val();
    var texvalue = $('#Deductioncharge1').val();
    var Tokenrate = $('#Tokenrt').val();
    selectedValue = document.querySelector('#Paymentmode').value;
    $('#netpaysec').show();
    if (selectedValue == "USDT.BEP20") {
        var totalTRX = (Number(txtMCB)).toFixed(3);
        var chargeamtTRX = (totalTRX * Number(texvalue) / 100);
        var totalvalue = (totalTRX - chargeamtTRX).toFixed(3);
        var NetvalTRX = totalvalue; /*(Number(totalvalue) * Number(Tokenrate)).toFixed(3);*/
        $('#NetWithAmt').html(NetvalTRX + " $");
        $('#Deduction').html("Transaction fee<br>" + Number(chargeamtTRX) + " $");
    }
    if (selectedValue == "BNB.BSC") {
        var totalTRX = (Number(txtMCB) / Number(BNBrt)).toFixed(6);
        var chargeamtTRX = (Number(texvalue) / Number(BNBrt)).toFixed(6);
        var totalvalue = Number(texvalue) + Number(txtMCB);
        var NetvalTRX = (Number(totalvalue) / Number(BNBrt)).toFixed(6);
        $('#NetWithAmtvalue').html(txtMCB);
        $('#netvalue').html(texvalue);
        $('#chargeamtTRX').html("$" + chargeamtTRX);
        $('#sectionvalue').html(txtMCB);
        $('#TRXsecvalue').html("$" + txtMCB);
        $('#TRXAmtsend').val(totalTRX);
        $('#NetvalsTRX').html(NetvalTRX + " BNB");
    }
}

function SubmitRequestNow() {
    $('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');
    document.getElementById("SubmitWithdnow").disabled = true;
    $("#SubmitWithdnow").html('Plase wait...');
    var MaxWith = $('#MxWith').val();

    var TdayWith = $('#TodayWith').val();

    var txtBonus = $('#txtTeamProfitSharing').val();
    var txtOtp = $("#txtOtp").val();

    if (Number(TdayWith) > 1) {
        $("#Msgs").html('');
        swal({
            title: "Sorry!",
            text: "You can make withdraw request two time in a day.",
            type: "warning"

        });
        document.getElementById("SubmitWithdnow").disabled = false;
        $("#SubmitWithdnow").html('Submit');

        return;
    }
    var PaymentMd = '';
    PaymentMd = document.querySelector('#Paymentmode').value;
    if (PaymentMd == '') {
        $("#Msgs").html('');
        swal({
            title: "Sorry!",
            text: "You need to select one Payment Method option !",
            type: "warning"

        });

        document.getElementById("SubmitWithdnow").disabled = false;
        $("#SubmitWithdnow").html('Submit');
        return;
    }
    var totwRAmt = $('#txtProfitSharing').val();
    var od = new FormData();
    var txtSecPwd = $("#txtSecPWD").val();
        if (txtSecPwd != '' & PaymentMd != '' & totwRAmt != '') {
            $('#SvPInfo').html('<img src="../UserProfileImg/103.gif" width="35" height="35"  />');

            var txtProfitSharing = $('#txtProfitSharing').val();
         
            od.append("memid", PaymentMd);
            od.append("PaymentMd", "Withdrawal");
            od.append("wtype", "Working");
            od.append("Amount", txtProfitSharing);
            od.append("txtSecPwd", txtSecPwd);
            od.append("txtOtp", txtOtp);
            $.ajax({
                url: "Handlers/Withdrawal-Request-Submit_CAPI.ashx",
                type: "POST",
                contentType: false,
                processData: false,
                data: od,
                dataType: "json",
                success: function (Response) {
                    if (Response.Success) {
                        if (Response.detail == 200) {
                            $('#otpdtl').removeClass('d-none');
                            $('#otpdtl').addClass('d-block');
                            $('#Msgs').html('');
                            swal({
                                title: "OTP Sent",
                                text: Response.Message,
                                type: "success"
                            });
                        }
                        else if (Response.detail == 1) {
                            if (Response.ChkWthAuto == 0) {
                                $("#Msgs").html('');
                                swal({
                                    title: "Done!",
                                    text: Response.Message,
                                    type: "success",
                                    showCancelButton: true,
                                    confirmButtonText: "View on BscScan",
                                    cancelButtonText: "OK",
                                    closeOnConfirm: true,
                                    closeOnCancel: true
                                },
                                    function (isConfirm) {
                                        if (isConfirm) {
                                            window.open("https://bscscan.com/tx/" + Response.Emenpjd2, "_blank");
                                        } else {
                                            window.location.href = "withdraw-history.html";
                                        }
                                    });
                            }
                            else {
                                $("#Msgs").html('');
                                swal({
                                    title: "Done!",
                                    text: Response.Message,
                                    type: "success"
                                },
                                    function (isConfirm) {
                                        window.location.href = "withdraw-history.html";
                                    });
                            }
                        }
                        document.getElementById("SubmitWithdnow").disabled = false;
                        $("#SubmitWithdnow").html('Withdraw <i class="fas fa-coins ml-1"></i>');
                    }
                    else {
                        $("#Msgs").html('');
                        swal({
                            title: "Sorry!",
                            text: Response.Message,
                            type: "warning"
                        });
                        document.getElementById("SubmitWithdnow").disabled = false;
                        $("#SubmitWithdnow").html('Withdraw <i class="fas fa-coins ml-1"></i>');
                    }
                },
                error: function (err) {
                    $("#Msgs").html('');
                    swal({
                        title: "Alert!",
                        text: err,
                        type: "error"
                    });
                    document.getElementById("SubmitWithdnow").disabled = false;
                    $("#SubmitWithdnow").html('Withdraw <i class="fas fa-coins ml-1"></i>');
                }
            });
        }
    /*}*/
}

function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode == 46 && evt.srcElement.value.split('.').length > 1) {
        return false;
    }
    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}
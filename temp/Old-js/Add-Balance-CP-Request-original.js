//function add_valueupdate() {
//    $('#valueshow').show();
//    var txtMCB = $('#txtamtTRX').val();
//    var texvalue = $('#txncharge1').val();
//    var totalvalue = Number(txtMCB) + Number(texvalue);
//    $('#NetWithAmtvalue').html(totalvalue);
//    $('#netvalue').html(texvalue);
//    $('#sectionvalue').html(txtMCB);
//}
//function add_valueupdate() {
//    $('#valueshow').css('display', 'flex');
//    var txtMCB = $('#txtamtTRX').val();
//    var texvalue = $('#txncharge1').val();
//    var TRXrt = $('#TRXrt').val();
//    BNBrt = $('#BNBrt').val();
//    selectedValue = document.querySelector('#Paymentmode').value;
//    //const rbs = document.querySelectorAll('input[name="PaymentMethod"]');
//    //let selectedValue;
//    //for (const rb of rbs) {
//    //    if (rb.checked) {
//    //        selectedValue = rb.value;
//    //        break;
//    //    }
//    //}
//    if (selectedValue == "USDT.BEP20") {
//        var totalTRX = (Number(txtMCB)).toFixed(6);
//        var chargeamtTRX = Number(texvalue);
//        var totalvalue = Number(txtMCB) - Number(chargeamtTRX);
//        var NetvalTRX = (Number(totalvalue)).toFixed(6);
//        $('#NetWithAmtvalue').html(txtMCB);//totalvalue);
//        $('#netvalue').html(texvalue);
//        $('#chargeamtTRX').html(chargeamtTRX);
//        $('#sectionvalue').html(txtMCB);
//        $('#TRXsecvalue').html("$" + txtMCB);//totalTRX);
//        $('#TRXAmtsend').val(totalTRX);
//        $('#NetvalsTRX').html(NetvalTRX + " USDT");//NetvalTRX);
//    }
//    if (selectedValue == "BNB.BSC") {
//        var totalTRX = (Number(txtMCB) / Number(BNBrt)).toFixed(6);
//        var chargeamtTRX = (Number(texvalue) / Number(BNBrt)).toFixed(6);
//        var totalvalue = Number(texvalue) + Number(txtMCB);
//        var NetvalTRX = (Number(totalvalue) / Number(BNBrt)).toFixed(6);
//        $('#NetWithAmtvalue').html(txtMCB);//totalvalue);
//        $('#netvalue').html(texvalue);
//        $('#chargeamtTRX').html("$" + chargeamtTRX);
//        $('#sectionvalue').html(txtMCB);
//        $('#TRXsecvalue').html("$" + txtMCB);//totalTRX);
//        $('#TRXAmtsend').val(totalTRX);
//        $('#NetvalsTRX').html(NetvalTRX + " BNB");//NetvalTRX);
//    }
//}
function UploadFile_OLD() {
    //$('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');
    $("#Msgs").html('');
    swal({
        title: "Please wait",
        text: "We are checking Txn Hash Status at tronscan.org",
        type: "warning"

    },
        function () {
            document.getElementById("submittxnhashrequest").disabled = false;
            $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
        }
    );
    document.getElementById("submittxnhashrequest").disabled = true;
    $("#submittxnhashrequest").html('Please wait...');
    var TRXRate = $("#TRXRate").val();
    var txtTranHash = $("#txtxnHash").val();
    var fr_add = $("#sndbywallet").val();
    var TxnKey = $("#TxnKey").val();
    var RcVAdd = $("#txtBTCAddress2").val();
    // alert('address: ' + RcVAdd);
    var RcAmount = $("#FndReqPndg").val();
    var CPACType1 = $("#CPACType1").val();
    var ReqDate = $('#ReqDate').val();
    var ReqDate2 = new Date(ReqDate).toLocaleDateString();
    /////

    var FndPndg = $('#FndReqPndg').val();

    var payid = $('#paybyid').val();

    var pattern = /^[0-9a-z]+$/;
    ////
    // $('#Msgs').html('<img src="../UserProfileImg/loading2.gif" />');
    ////
    if (txtTranHash != '' || txtTranHash.lenght > 66) {
        //var paymode = 'BTC'
        //var paymode = 'USDT.BEP20'
        //var test = new FormData();
        //test.append("aid", aid);
        //test.append("txtTranHash", txtTranHash);

        ///
        //$.get("https://apilist.tronscan.org/api/transaction?sort=-timestamp&count=true&limit=10&start=0&address=" + RcVAdd).done(function (a) {
        $.get("https://api.covalenthq.com/v1/56/transaction_v2/" + txtTranHash + "/?format=JSON&key=" + TxnKey).done(function (a) {

            var getdata = a.data.items;
            var ReqestAmt = "0";
            var from_address = "";
            var to_address = "";
            getdata.forEach(function (item) {
                var InnerData = item.log_events;
                InnerData.forEach(function (intstr) {
                    from_address = intstr.decoded.params[0].value;
                    to_address = intstr.decoded.params[1].value;
                    ReqestAmt = intstr.decoded.params[2].value;
                });

                if (to_address.toUpperCase() == RcVAdd.toUpperCase()) {
                    if (item.successful == true) {
                        var od11 = new FormData();
                        od11.append("ODsID", payid);
                        od11.append("value", ReqestAmt);
                        od11.append("transaction_hash", txtTranHash);
                        od11.append("fromaddress", from_address);
                        od11.append("toaddress", to_address);
                        od11.append("Conf", item.successful);
                        od11.append("Skey", "Succes24!7H1p");
                        od11.append("transaction_dt", item.block_signed_at);
                        $.ajax({
                            url: "Handlers/Add-Fund-API-Respons-Update.ashx",
                            type: "POST",
                            contentType: false,
                            processData: false,
                            data: od11,
                            dataType: "json",
                            success: function (Response) {
                                if (Response.Success) {
                                    //$('#Msgs').html(Response.Message);
                                    /* parent.location.reload(true);*/
                                    $("#Msgs").html('');
                                    swal({
                                        title: "Done!",
                                        text: Response.Message,
                                        type: "success"

                                    },
                                        function () {
                                            /* location.href = "Add-Balance-Request.html#VIEWHISTORY";*/
                                            location.href = "Add-Balance-Txh.html";
                                        });
                                }
                                else {
                                    //$('#Msgs').html(Response.Message);
                                    $("#Msgs").html('');
                                    swal({
                                        title: "Sorry !",
                                        text: Response.Message,
                                        type: "warning"

                                    });
                                }
                                document.getElementById("submittxnhashrequest").disabled = false;
                                $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
                            },
                            error: function (err) {
                                //$('#Msgs').html(err.statusText);
                                $("#Msgs").html('');
                                swal({
                                    title: "Sorry !",
                                    text: err.statusText,
                                    type: "warning"

                                });
                                document.getElementById("submittxnhashrequest").disabled = false;
                                $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
                            }
                        });

                    }
                    else {
                        $("#Msgs").html('');
                        swal({
                            title: "Alert !",
                            text: "Please submit transaction hash after confirm payment status at tronscan.org",
                            type: "warning"

                        });
                        document.getElementById("submittxnhashrequest").disabled = false;
                        $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
                    }
                }
                else {
                    //$('#Msgs').html("<span style='font-size:15px; color:#FF0000; font-wieght:bold'>Please check Txn Hash information about a TRX payment !</span>");
                    $("#Msgs").html('');
                    swal({
                        title: "Alert !",
                        text: "Please check Txn Hash of above Payment, must be Correct and confirmed",
                        type: "warning"

                    });
                    document.getElementById("submittxnhashrequest").disabled = false;
                    $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
                }
            });
        })
    }

    else {
        //$('#Msgs').html("<span style='font-size:15px; color:#FF0000; font-wieght:bold'>Please check Txn Hash information about a TRX payment !</span>");
        $("#Msgs").html('');
        swal({
            title: "Alert !",
            text: "Please enter correct TXN Hash",
            type: "warning"

        });
        document.getElementById("submittxnhashrequest").disabled = false;
        $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
    }
}
///
function Save_dataTXN() {

    $('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');

    document.getElementById("submitFundreq").disabled = true;
    $("#submitFundreq").html('Please wait...');

    var od = new FormData();

    var paymode = '';
    Paymentmode = document.querySelector('#Paymentmode');
    var paymode = Paymentmode.value;
    
    var txtReqAmt = $("#txtamtTRX").val();
    var eMailAddss = $("#FRemail").val();

    od.append("txtReqAmt", txtReqAmt);
    od.append("paymode", paymode);
    od.append("eMailAddss", eMailAddss);

    ///////
    $.ajax({
        url: "Handlers/Add-Balance-Request.ashx",
        type: "POST",
        contentType: false,
        processData: false,
        data: od,
        dataType: "json",
        success: function (Response) {
            if (Response.Success) {
                //  $('#CPAddress').show();
                //$('#Msgs').html("<div class='alert alert-success'> Fund request submitted Succesflly, Please check payment address below or Right Side!<button type='button' class='close' data-dismiss='alert' aria-label='Close'> <span aria-hidden='true'>×</span> </button>  </div>");

                $("#Msgs").html('');
                swal({
                    title: "Request Submitted!",
                    text: "Add Fund request submitted successfully, Please check payment address below or Right Side!",
                    type: "success"
                },
                    function () {
                        location.href = "add-balance.html#Paymentdetailsshow";
                        DashboardSummary();
                        $('#Paymentdetailsshow').show();
                       /* $('#onloadshowhistry').show();*/
                    }
                );

                document.getElementById("submitFundreq").disabled = false;
                $("#submitFundreq").html('Submit <i class="fa-solid fa-right-to-bracket ml-1"></i>');

                //location.href = Response.Message;
                //window.open(window.location.href = Response.Message, '_blank');
                //$('#NewBTC1').html("<img src='https://chart.googleapis.com/chart?chs=300x300&cht=qr&chl=" + Response.Message + "' width='150' height='150'>");
                //$('#paranew').html("Please make above payment on given Address by your crypto wallets. If all details will be correct then we will accept fund request & credit amount in f-Wallet!");
                //$('#txtBTCAddress1').html(Response.Message);
                //$('#CPAmt').html("$" + txtReqAmt);
                //$('#CPACType').html(paymode + " wallet address...");
                //parent.location.reload(true);
            }
            else {
                //$('#Msgs').html(Response.Message);
                $("#Msgs").html('');
                swal({
                    title: "Sorry!",
                    text: Response.Message,
                    type: "warning"

                });

                document.getElementById("submitFundreq").disabled = false;
                $("#submitFundreq").html('Submit <i class="fa-solid fa-right-to-bracket ml-1"></i>');
            }
        },
        error: function (err) {
            //$('#Msgs').html(err.statusText);

            $("#Msgs").html('');
            swal({
                title: "Sorry!",
                text: err.statusText,
                type: "warning"
            });

            document.getElementById("submitFundreq").disabled = false;
            $("#submitFundreq").html('Submit <i class="fa-solid fa-right-to-bracket ml-1"></i>');
        }
    });
}
///
function UploadFile() {
    var contractAddress1 = '';

    $('#txnMsgs').html('');

    document.getElementById("submittxnhashrequest").disabled = true;
    $("#submittxnhashrequest").html('Please wait...');

    swal({
        title: "Please wait...",
        text: "We are checking Txn Hash Status at Network",
        type: "warning"
    });

    var payid = $('#paybyid').val();
    var TRXRate = $("#TRXRate").val();
    var txtTranHash = $("#txtxnHash").val();
    var fr_add = $("#sndbywallet").val();
    var TransactionKey = $("#TxnKey").val();
    var RcVAdd = $("#txtBTCAddress2").val();
    var paymode = document.querySelector('#Paymentmode').value;

    if (paymode == "USDT.BEP20") {
        contractAddress1 = "0x55d398326f99059ff775485246999027b3197955";
        $.get("https://api.bscscan.com/api?module=transaction&action=gettxreceiptstatus&txhash=" + txtTranHash + "&apikey=" + TransactionKey).done(function (b) {
            var confirmed = b.result.status;

            if (confirmed != "" && confirmed != 0) {
                if (txtTranHash != '' || txtTranHash.lenght >= 66) {

                    swal({
                        title: "Please wait...",
                        text: "We are getting Txn Hash details from Network",
                        type: "warning"
                    });

                    $.get("https://api.bscscan.com/api?module=account&action=tokentx&contractaddress=" + contractAddress1 + "&address=" + RcVAdd + "&page=1&offset=25&startblock=0&endblock=999999999&sort=desc&apikey=" + TransactionKey).done(function (a) {
                        var getdata = a.result;
                        for (var i = 0; i < a.result.length; i++) {
                            var ReqestAmt = "0";
                            var from_address = "";
                            var to_address = "";
                            var TranHas = a.result[i]['hash'];
                            if (txtTranHash == TranHas) {
                                var from_address = a.result[i]['from'];
                                var txndate = new Date(a.result[i]['timeStamp'] * 1000).toISOString().substring(0, 19).replace('T', ' ');
                                var to_address = a.result[i]['to'];
                                var contractAddress = a.result[i]['contractAddress'];
                                ReqestAmt = a.result[i]['value'];
                                var Conf = a.result[i]['confirmations'];
                                var confirmations = "";
                                if (Conf > 3) {
                                    confirmations = true
                                }

                                swal({
                                    title: "Please wait...",
                                    text: "We are verifying your payment to address!",
                                    type: "warning"
                                });

                                if (to_address.toUpperCase() == RcVAdd.toUpperCase() &&
                                    contractAddress.toUpperCase() == contractAddress1.toUpperCase()) {
                                    if (confirmations == true) {
                                        var od11 = new FormData();
                                        od11.append("ODsID", payid);
                                        od11.append("value", ReqestAmt);
                                        od11.append("transaction_hash", txtTranHash);
                                        od11.append("fromaddress", from_address);
                                        od11.append("toaddress", to_address);
                                        od11.append("Conf", confirmations);
                                        od11.append("Skey", "Succes24!7H1p");
                                        od11.append("transaction_dt", txndate);
                                        $.ajax({
                                            url: "Handlers/Add-Fund-API-Respons-Update.ashx",
                                            type: "POST",
                                            contentType: false,
                                            processData: false,
                                            data: od11,
                                            dataType: "json",
                                            success: function (Response) {
                                                if (Response.Success) {
                                                    $("#txnMsgs").html('');
                                                    swal({
                                                        title: "Payment Confirmed!",
                                                        text: Response.Message,
                                                        type: "success"

                                                    },
                                                        function () {
                                                            location.href = "Add-Balance-Txh.html";
                                                        });
                                                }
                                                else {
                                                    $("#txnMsgs").html('');
                                                    swal({
                                                        title: "Sorry !",
                                                        text: Response.Message,
                                                        type: "warning"

                                                    });
                                                }

                                                document.getElementById("submittxnhashrequest").disabled = false;
                                                $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
                                            },
                                            error: function (err) {
                                                $("#txnMsgs").html('');
                                                swal({
                                                    title: "Sorry !",
                                                    text: err.statusText,
                                                    type: "warning"
                                                });
                                                document.getElementById("submittxnhashrequest").disabled = false;
                                                $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
                                            }
                                        });
                                    }
                                    else {
                                        $("#txnMsgs").html('');
                                        swal({
                                            title: "Alert !",
                                            text: "Please submit transaction hash after confirm payment status at bscscan.com",
                                            type: "warning"
                                        });
                                        document.getElementById("submittxnhashrequest").disabled = false;
                                        $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
                                    }
                                }
                                else {
                                    $("#txnMsgs").html('');
                                    swal({
                                        title: "Alert !",
                                        text: "Please check Txn Hash of above Payment, must be Correct and confirmed",
                                        type: "warning"
                                    });
                                    document.getElementById("submittxnhashrequest").disabled = false;
                                    $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
                                }
                            }
                            else {
                                swal({
                                    title: "Alert!",
                                    text: "Please Check txn hash and payment address!",
                                    type: "warning"
                                });
                                document.getElementById("submittxnhashrequest").disabled = false;
                                $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
                            }
                        }
                    })
                }
                else {
                    $("#txnMsgs").html('');
                    swal({
                        title: "Alert !",
                        text: "Please enter correct TXN Hash",
                        type: "warning"
                    });
                    document.getElementById("submittxnhashrequest").disabled = false;
                    $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
                }
            }
            else {
                $("#txnMsgs").html('');
                swal({
                    title: "Alert !",
                    text: "Please submit transaction hash after confirm payment status at bscscan.org",
                    type: "warning"

                });
                document.getElementById("submittxnhashrequest").disabled = false;
                $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
            }
        });
    }
    else if (paymode == "USDT.TRC20") {
        contractAddress1 = "TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t";
        if (txtTranHash != '' || txtTranHash.lenght >= 64) {

            $.get("https://apilist.tronscan.org/api/transaction-info?hash=" + txtTranHash).done(function (a) {
                var getdata = a.transfersAllList;
                var ReqestAmt = "0";
                var from_address = "";
                var to_address = "";
                var ContractAddrss = "";

                var txnDate = new Date(a['timestamp']).toISOString().substring(0, 19).replace('T', ' ');
                getdata.forEach(function (data) {
                    from_address = data.from_address;
                });

                to_address = a['trigger_info']['parameter']['_to'];
                ReqestAmt = a['trigger_info']['parameter']['_value'];
                ContractAddrss = a['trigger_info']['contract_address'];

                if (to_address.toUpperCase() == RcVAdd.toUpperCase() && contractAddress1.toUpperCase() == ContractAddrss.toUpperCase()) {
                    if (a.confirmed == true) {
                        var od11 = new FormData();
                        od11.append("ODsID", payid);
                        od11.append("value", ReqestAmt);
                        od11.append("transaction_hash", txtTranHash);
                        od11.append("fromaddress", from_address);
                        od11.append("toaddress", to_address);
                        od11.append("Conf", a.confirmed);
                        od11.append("Skey", "Succes24!7H1p");
                        od11.append("transaction_dt", txnDate);

                        $.ajax({
                            url: "Handlers/Add-Fund-API-Respons-Update.ashx",
                            type: "POST",
                            contentType: false,
                            processData: false,
                            data: od11,
                            dataType: "json",
                            success: function (Response) {
                                if (Response.Success) {
                                    $("#txnMsgs").html('');
                                    swal({
                                        title: "Payment Request Submitted!",
                                        text: Response.Message,
                                        type: "success"
                                    },
                                        function () {
                                            location.href = "Add-Balance-Txh.html";
                                        });
                                }
                                else {
                                    $("#txnMsgs").html('');
                                    swal({
                                        title: "Sorry !",
                                        text: Response.Message,
                                        type: "warning"

                                    });
                                }
                                document.getElementById("submittxnhashrequest").disabled = false;
                                $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
                            },
                            error: function (err) {
                                $("#txnMsgs").html('');
                                swal({
                                    title: "Sorry !",
                                    text: err.statusText,
                                    type: "warning"
                                });
                                document.getElementById("submittxnhashrequest").disabled = false;
                                $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
                            }
                        });

                    }
                    else {
                        $("#txnMsgs").html('');

                        swal({
                            title: "Alert !",
                            text: "Please submit transaction hash after confirm payment status at tronscan.org",
                            type: "warning"
                        });

                        document.getElementById("submittxnhashrequest").disabled = false;
                        $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
                    }
                }
                else {

                    $("#txnMsgs").html('');
                    swal({
                        title: "Alert !",
                        text: "Please check Txn Hash of above Payment, must be Correct and confirmed",
                        type: "warning"
                    });

                    document.getElementById("submittxnhashrequest").disabled = false;
                    $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');

                }
            });
        }
        else {
            $("#txnMsgs").html('');
            swal({
                title: "Alert !",
                text: "Please enter correct TXN Hash",
                type: "warning"
            });
            document.getElementById("submittxnhashrequest").disabled = false;
            $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
        }
    }
    else if (paymode == "TRX.TRC20") {
        if (txtTranHash != '' || txtTranHash.lenght >= 64) {
            $.get("https://apilist.tronscan.org/api/transaction-info?hash=" + txtTranHash).done(function (a) {
               
                var ReqestAmt = "0";
                var from_address = "";
                var from_address = "";

                var txnDate = new Date(a['timestamp']).toISOString().substring(0, 19).replace('T', ' ');
                from_address = a['contractData']['owner_address'];
                to_address = a['contractData']['to_address'];
                ReqestAmt = a['contractData']['amount'];
                try {
                    if (to_address.toUpperCase() == RcVAdd.toUpperCase()) {
                        if (a.confirmed == true) {
                            var od11 = new FormData();
                            od11.append("ODsID", payid);
                            od11.append("value", ReqestAmt);
                            od11.append("transaction_hash", txtTranHash);
                            od11.append("fromaddress", from_address);
                            od11.append("toaddress", to_address);
                            od11.append("Conf", a.confirmed);
                            od11.append("Skey", "Succes24!7H1p");
                            od11.append("transaction_dt", txnDate);

                            $.ajax({
                                url: "Handlers/Add-Fund-API-Respons-Update.ashx",
                                type: "POST",
                                contentType: false,
                                processData: false,
                                data: od11,
                                dataType: "json",
                                success: function (Response) {
                                    if (Response.Success) {
                                        $("#txnMsgs").html('');
                                        swal({
                                            title: "Payment Request Submitted!",
                                            text: Response.Message,
                                            type: "success"
                                        },
                                            function () {
                                                location.href = "add-balance.html";
                                            });
                                    }
                                    else {
                                        $("#txnMsgs").html('');
                                        swal({
                                            title: "Sorry !",
                                            text: Response.Message,
                                            type: "warning"

                                        });
                                    }
                                    document.getElementById("submittxnhashrequest").disabled = false;
                                    $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
                                },
                                error: function (err) {
                                    $("#txnMsgs").html('');
                                    swal({
                                        title: "Sorry !",
                                        text: err.statusText,
                                        type: "warning"
                                    });
                                    document.getElementById("submittxnhashrequest").disabled = false;
                                    $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
                                }
                            });

                        }
                        else {
                            $("#txnMsgs").html('');

                            swal({
                                title: "Alert !",
                                text: "Please submit transaction hash after confirm payment status at tronscan.org",
                                type: "warning"
                            });

                            document.getElementById("submittxnhashrequest").disabled = false;
                            $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
                        }
                    }
                    else {

                        $("#txnMsgs").html('');
                        swal({
                            title: "Alert !",
                            text: "Please check Txn Hash of above Payment, must be Correct and confirmed",
                            type: "warning"
                        });

                        document.getElementById("submittxnhashrequest").disabled = false;
                        $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');

                    }
                }
                catch {
                    $("#txnMsgs").html('');
                    swal({
                        title: "Alert !",
                        text: "Please enter correct TXN Hash",
                        type: "warning"
                    });
                    document.getElementById("submittxnhashrequest").disabled = false;
                    $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>'); }
            });
        }
        else {
            $("#txnMsgs").html('');
            swal({
                title: "Alert !",
                text: "Please enter correct TXN Hash",
                type: "warning"
            });
            document.getElementById("submittxnhashrequest").disabled = false;
            $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
        }
    }
    else {
        $("#txnMsgs").html('');
        swal({
            title: "Alert !",
            text: "Sorry, Something is wrong please try later !",
            type: "error"
        });
        document.getElementById("submittxnhashrequest").disabled = false;
        $("#submittxnhashrequest").html('Submit <i class="fa fa-file"></i>');
    }
}
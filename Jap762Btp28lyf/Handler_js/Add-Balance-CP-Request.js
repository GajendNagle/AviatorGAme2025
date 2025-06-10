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
//    $('#valueshow').show();
//    var txtMCB = $('#txtamtTRX').val();
//    var texvalue = $('#txncharge1').val();
//    var TRXrt = $('#TRXrt').val();
//    var totalTRX = (Number(txtMCB) / Number(TRXrt)).toFixed(6);
//    var chargeamtTRX = (Number(texvalue)); /*(Number(texvalue) / Number(TRXrt)).toFixed(6);*/
//    var totalvalue = Number(texvalue) + Number(txtMCB);
//    var NetvalTRX = (Number(totalvalue) / Number(TRXrt)).toFixed(6);
//    $('#NetWithAmtvalue').html(txtMCB);//totalvalue);
//    $('#netvalue').html(texvalue);
//    $('#chargeamtTRX').html(chargeamtTRX);
//    $('#sectionvalue').html(txtMCB);
//    $('#TRXsecvalue').html(txtMCB);//totalTRX);
//    $('#TRXAmtsend').val(totalTRX);
//    $('#NetvalsTRX').html(txtMCB);//NetvalTRX);
//}
function Save_dataTXN() {


    $('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');

    document.getElementById("submitFundreq").disabled = true;
    $("#submitFundreq").html('Plase wait...');

    var od = new FormData();

    var paymode = '';

    if ($("#Bitcoin").prop('checked') == true) {

        paymode = $("#Bitcoin").val();
    }
    else if ($("#Ethereum").prop('checked') == true) {
        paymode = $("#Ethereum").val();
    }
    else if ($("#TRON").prop('checked') == true) {
        paymode = $("#TRON").val();
    }
    else if ($("#Binance").prop('checked') == true) {
        paymode = $("#Binance").val();
    }
    else {
        //$('#Msgs').html("<div class='alert alert-danger alert-rounded'> You need to select one Payment Method option !<button type='button' class='close' data-dismiss='alert' aria-label='Close'> <span aria-hidden='true'>×</span> </button>  </div>");

        $('#Msgs').html('');

        swal({
            title: "Sorry!",
            text: "You need to select one Payment Method option !",
            type: "warning"

        });

        document.getElementById("submitFundreq").disabled = false;
        $("#submitFundreq").html('<i class="fa fa-check"></i> Submit');

        return;
    }
    //if (paymode == 'BTC') {
    //    var txtReqAmt = $("#txtamtBTC").val();
    //}
    //if (paymode == 'ETH') {
    //    var txtReqAmt = $("#txtamtETH").val();
    //}
    //if (paymode == 'TRX') {
    //    var txtReqAmt = $("#txtamtTRX").val();
    //}
    //alert(paymode);

    var txtReqAmt = $("#txtamtTRX").val();
    var eMailAddss = $("#FRemail").val();

    od.append("txtReqAmt", txtReqAmt);
    od.append("paymode", paymode);
    od.append("eMailAddss", eMailAddss);

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
                    title: "Done!",
                    text: "Add Fund request submitted successfully, Please check payment address below or Right Side!",
                    type: "success"

                },

                    function () {
                        DashboardSummary();
                        /*  $('#Paymentdetailsshow').show();*/
                        $('#onloadshowhistry').show();
                    }
                );

                document.getElementById("submitFundreq").disabled = false;
                $("#submitFundreq").html('<i class="fa fa-check"></i> Submit');

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
                $("#submitFundreq").html('<i class="fa fa-check"></i> Submit');
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
            $("#submitFundreq").html(' <i class="fa fa-check"></i> Submit');
        }
    });
}
function DWalletAmtRequest(TranHas, SndrAdds, amount, PlnAmt, txndate) {
    ////////
    $('#Msgs').html('<img src="../UserProfileImg/loading2.gif" />');
    var od = new FormData();
    var txtBTCAddress = SndrAdds;//$("#txtBTCAddress").val();    
    var txtTxnHas = TranHas;//$("#txtTxnHas").val(); 
    var txtReqAmt = amount;
    var reqdate = txndate//$("#SpDate").val();
    ////////
    od.append("txtBTCAddress", txtBTCAddress);
    od.append("txtTxnHas", txtTxnHas);
    od.append("txtReqAmt", amount);
    od.append("PlnAmt", amount);
    od.append("ReqDate", reqdate);

    //     var fileUpload = $("#fluplodBTC").get(0);
    //    var files = fileUpload.files;
    //    for (var i = 0; i < files.length; i++) {
    //    od.append(files[i].name, files[i]);
    //    }     
    ///////
    $.ajax({
        url: "Handlers/DWallet-Amt_Request.ashx?Save=BTCInfo",
        type: "POST",
        contentType: false,
        processData: false,
        data: od,
        dataType: "json",
        success: function (Response) {
            if (Response.Success) {
                //$('#Msgs').html(Response.Message);
                $('#Msgs').html();
                swal({
                    title: "Done!",
                    text: Response.Message,
                    type: "success"
                }
                );
            }
            else {
                $('#Msgs').html(Response.Message);
            }
        },
        error: function (err) {
            $('#Msgs').html(err.statusText);
        }
    });
}
///////
function Save_data() {
    ////////

    var paymode = $('#paymode').val();

    if (paymode == "BTC") {
        init_data();
    }
    else if (paymode == "ETH") {
        init_dataETH();
    }
    else if (paymode == "TRX") {
        init_dataTRX();
    }
    else {
        $('#Msgs').html('<img src="../UserProfileImg/loading2.gif" />');
        var od = new FormData();
        var txtBTCAddress = $('#txtBTCAddress').val();
        var txtTxnHas = $("#txtTxnHas").val();//$("#txtTxnHas").val(); 
        var txtReqAmt = $("#txtamt").val();
        var reqdate = $("#SpDate").val();
        ////////
        od.append("txtBTCAddress", txtBTCAddress);
        od.append("txtTxnHas", txtTxnHas);
        od.append("txtReqAmt", txtReqAmt);
        od.append("PlnAmt", txtReqAmt);
        od.append("ReqDate", reqdate);
        od.append("paymode", paymode);


        var fileUpload = $("#fluplodBTC").get(0);
        var files = fileUpload.files;
        for (var i = 0; i < files.length; i++) {
            od.append(files[i].name, files[i]);
        }
        ///////
        $.ajax({
            url: "Handlers/DWallet-Amt_Request.ashx?Save=BANKInfo",
            type: "POST",
            contentType: false,
            processData: false,
            data: od,
            dataType: "json",
            success: function (Response) {
                if (Response.Success) {
                    $('#Msgs').html(Response.Message);
                }
                else {
                    $('#Msgs').html(Response.Message);
                }
            },
            error: function (err) {
                $('#Msgs').html(err.statusText);
            }
        });

    }


}
///
function init_data() {

    $('#Msgs').html("<span style='color:#FF5A00'>Please enter correct transaction hash for above address payment...</span>");
    ////
    var DPlnAmt = $("#txtamt").val();

    var TxnHs = $("#txtTxnHas").val();
    var RcVAdd = $("#txtBTCAddress").val();
    //////////
    if (TxnHs != '' || RcVAdd != '') {
        //////////
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.open("GET", "https://blockchain.info/multiaddr?cors=true&active=" + RcVAdd, true);
        xmlhttp.send();
        ///    
        xmlhttp.onreadystatechange = function () {

            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                //https://blockchain.info/q/getblockcount

                var jsontext = xmlhttp.responseText;
                var data = JSON.parse(jsontext);
                ///
                var n = data.txs.length;
                for (var i = 0; i < n; i++) {
                    for (z = 0; z < data.txs[i]['inputs'].length; z++) {
                        var TranHas = data.txs[i].hash;
                        var txndate = new Date(data.txs[i].time * 1000).toISOString().substring(0, 19).replace('T', ' ');
                        ///             			        
                        // if (TxnHs == TranHas)
                        //{                           
                        // var amount = data.txs[i]['inputs'][z]['prev_out']['value'];
                        // var SndrAdds=data.txs[i]['inputs'][z]['prev_out']['addr'];
                        //                            var blockheight = data.txs[i].block_height;
                        //                            var txndate = new Date(data.txs[i].time*1000).toISOString().substring(0, 19).replace('T', ' ');
                        //                            var Confm=(latestblock-blockheight)+1;
                        ////
                        if (TxnHs == TranHas) {
                            var SndrAdds = data.txs[i]['inputs'][z]['prev_out']['addr'];
                            for (w = 0; w < data.txs[i]['out'].length; w++) {
                                var RecBTCAds = data.txs[i]['out'][w]['addr'];
                                if (RecBTCAds == RcVAdd) {
                                    var amount = data.txs[i]['out'][w]['value'];
                                }
                            }
                            DWalletAmtRequest(TranHas, SndrAdds, amount, DPlnAmt, txndate);
                            // $('#odc').load("UsRcP06k90/Handlers/BTC-API-457-CB_Cnf.ashx?ODsID="+id+"&value="+amount+"&transaction_hash="+Tnxhash+"&address="+outAdd+"&Conf="+Confm+"&Skey="+Skey+"&transaction_dt="+txndate);
                            ////
                        }
                    }
                }
                //         
            }
        }
    }
    else {
        $('#Msgs').html("Payment BTC address or transaction hash can't blank...");
    }
}
function TransferToUser() {
    $('#TranMsg').html('');
    var od = new FormData();
    var txtMemId = $("#txtMemId").val();
    var txtTransPWD = $("#txtTransPWD").val();
    var txtTopUpAmount = $("#txtTopUpAmount").val();
    ////////
    var tamt = document.getElementById('txtTopUpAmount');
    var tamtfilter = /^[0-9]+$/;
    /////////
    if (tamtfilter.test(tamt.value)) {
        $('#TranMsg').html('<img src="../UserProfileImg/loading2.gif" />');
        od.append("txtMemId", txtMemId);
        od.append("txtTransPWD", txtTransPWD);
        od.append("txtTopUpAmount", txtTopUpAmount);
        $.ajax({
            url: "Handlers/Transfer-to-user.ashx",
            type: "POST",
            contentType: false,
            processData: false,
            data: od,
            dataType: "json",
            success: function (Response) {
                if (Response.Success) {
                    //$.messager.alert("Success", Response.Message, 'info');
                    $('#TranMsg').html(Response.Message);
                    $("#txtMemId").val('');
                    $("#txtTopUpAmount").val('');
                    $("#txtTransPWD").val('');
                    $('#MemName').html('');
                    parent.location.reload(true);
                }
                else {
                    //$.messager.alert("Warning", Response.Message, 'warning');
                    $('#TranMsg').html(Response.Message);
                }
            },
            error: function (err) {
                //$.messager.alert("Failed", err.statusText, 'error');
                $('#TranMsg').html(err.statusText);
            }
        });
    }
    else {
        $("#txtTopUpAmount").val('');
    }
}
////////////
function GetMemberNameTp() {
    $('#MemName').html('<img src="../UserProfileImg/progress.gif" />');
    var od = new FormData();
    var txtMemId = $("#txtMemId").val();
    $('#MemName').load("Handlers/Transfer-to-user.ashx?MN=" + txtMemId);
    $('#TranMsg').html('');
}

function FunctionTopMsg() {

    var paymode = $('#paymode').val();

    var btcaddress = $('#btcadd').val();
    var ethaddress = $('#ethadd').val();
    //var paytmaddress = $('#paytmadd').val();
    // var upiaddress = $('#upiadd').val();
    //var bankaccno = $('#bankacno').val();
    //var bankname = $('#bankname').val();
    // var ifsccode = $('#bankifsc').val();
    //var acholder = $('#bankacholder').val();

    if (paymode != "") {
        if (paymode == "BTC") {
            $('#topmsg').html("Please make payment on given below BTC Address by your block chain wallet & <span style='font-size:16px; font-weight:bold;'>Enter Request Amount & Transaction hash</span>.<br/>If all details will be correct then we will accept fund request & credit amount in Main Wallet...");
            $('#Topmsg1').html("Request Payment into BTC address : ");
            $('#NewBTC').html(btcaddress + "<img src='https://chart.googleapis.com/chart?chs=300x300&cht=qr&chl=BTC:" + btcaddress + " alt='QR Code' width='100' height='100'>");
            $('#txtBTCAddress').val(btcaddress);
        }
        if (paymode == "ETH") {
            $('#topmsg').html("Please make payment on given below BTC Address by your block chain wallet & <span style='font-size:16px; font-weight:bold;'>Enter Request Amount & Transaction hash</span>.<br/>If all details will be correct then we will accept fund request & credit amount in Main Wallet...");
            $('#Topmsg1').html("Request Payment into ETH address : ");
            $('#NewBTC').html(ethaddress + "<img src='https://chart.googleapis.com/chart?chs=300x300&cht=qr&chl=ETH:" + ethaddress + " alt='QR Code' width='100' height='100'>");
            $('#txtBTCAddress').val(ethaddress);
        }
        //            if (paymode == "BANK")
        //            {
        //             $('#topmsg').html("Please make payment on give below Bank Address by your Bank Account & <span style='font-size:16px; font-weight:bold;'>Enter Request Amount & Transaction No</span>.If all details will be correct then we will accept fund request & credit amount in Main Wallet...");                
        //             $('#Topmsg1').html("Request Payment into Bank Account Details : ");
        //             $('#NewBTC').html("Bank Name: "+bankname+", Account Name: "+acholder+", Account No: "+bankaccno+", IFS Code: "+ifsccode);
        //             $('#txtBTCAddress').val(ifsccode);
        //            }
        //            if (paymode == "PAYTM")
        //            {
        //             $('#topmsg').html("Please make payment on given below Paytm Address by your Paytm wallet & <span style='font-size:16px; font-weight:bold;'>Enter Request Amount & Transaction No</span>.If all details will be correct then we will accept fund request & credit amount in Main Wallet...");                
        //             $('#Topmsg1').html("Request Payment into Paytm address : ");
        //             $('#NewBTC').html("<a href='"+paytmaddress+"' target='_blank'>"+paytmaddress+"</a>");
        //             $('#txtBTCAddress').val(paytmaddress);
        //            }
        //            if (paymode == "UPI")
        //            {
        //             $('#topmsg').html("Please make payment on given below UPI Address by your UPI wallet & <span style='font-size:16px; font-weight:bold;'>Enter Request Amount & Transaction No</span>.If all details will be correct then we will accept fund request & credit amount in Main Wallet...");                
        //             $('#Topmsg1').html("Request Payment into UPI address : ");
        //             $('#NewBTC').html(upiaddress);
        //             $('#txtBTCAddress').val(upiaddress);
        //            }
    }
}
function loadOrders(PageIndex, PageSize, MemID) {

    $('#depohistory').html('<img src="../UserProfileImg/loading2.gif" />');
    //var option = $('#partiCipantList').combo('getValue');
    $.getJSON('Handlers/Depsoit-History-Detail.ashx?p=' + PageIndex + "&s=" + PageSize + "&u=" + MemID + "&n=SELF",
        function (Orjson) {

            if (Orjson.length == 0) {
                $('#depohistory').html('');
                $('#depohistory').html("Sorry, record not found...!");
            }
            else {
                var d = formatOrder(Orjson);
                $('#depohistory').html(d);
                $('#DownDeposit').html('');
                //                if ($("#hdnpg").val() == "")
                //                {
                //                document.getElementById("SelePgNu").value = "1";
                //                document.getElementById("SelePgNu").text = "1";
                //                } 
                //                else 
                //                {
                //                document.getElementById("SelePgNu").value = $("#hdnpg").val();
                //                document.getElementById("SelePgNu").text = $("#hdnpg").val();
                //                }
            }
        });


}

function formatOrder(Orjson) {
    var pp1 = '';
    for (var i = 0; i < Orjson.length; i++) {

        //    if (i == 0)
        //    {           
        //        var select = document.getElementById("SelePgNu");
        //        document.getElementById("SelePgNu").innerHTML = "";      
        //        var pgsize = $("#SelePgSz").val();
        //        var TotRecord = Orjson[i].TotRec;
        //        document.getElementById("lbltotrec").innerHTML  = TotRecord;
        //        for (var j = 1; j <=  Math.ceil(parseFloat(TotRecord).toFixed(10)/parseFloat(pgsize).toFixed(10)) ; j++)
        //        {
        //             var opt = j;
        //             var el = document.createElement("option");
        //             el.textContent = opt;
        //             el.value = opt;
        //             select.appendChild(el);
        //        }
        //    }

        ///// for paging...


        //    <div class="col-lg-4 col-md-6 col-xlg-2 col-xs-12">
        //                                <div class="ribbon-wrapper card">
        //                                    <div class="ribbon ribbon-default">Ribbon</div>
        //                                    <p class="ribbon-content">Duis mollis, est non commodo luctus, nisi erat porttitor ligula</p>
        //                                </div>
        //                            </div>
        pp1 = pp1 + "<div class='col-lg-4 col-md-6 col-xlg-2 col-xs-12'>";
        pp1 = pp1 + "<div class='ribbon-wrapper card'>";
        if (i == 0 || i == 6) {
            pp1 = pp1 + "<div class='ribbon ribbon-default'>INR " + Orjson[i].AdPacks + "</div>";
        }
        else if (i == 1 || i == 7) {
            pp1 = pp1 + "<div class='ribbon ribbon-danger'>INR " + Orjson[i].AdPacks + "</div>";
        }
        else if (i == 2 || i == 8) {
            pp1 = pp1 + "<div class='ribbon ribbon-success'>INR " + Orjson[i].AdPacks + "</div>";
        }
        else if (i == 3 || i == 9) {
            pp1 = pp1 + "<div class='ribbon ribbon-primary'>INR " + Orjson[i].AdPacks + "</div>";
        }
        else if (i == 4 || i == 10) {
            pp1 = pp1 + "<div class='ribbon ribbon-info'>INR " + Orjson[i].AdPacks + "</div>";
        }
        else if (i == 5 || i == 11) {
            pp1 = pp1 + "<div class='ribbon ribbon-warning'>INR " + Orjson[i].AdPacks + "</div>";
        }
        else {
            pp1 = pp1 + "<div class='ribbon ribbon-danger'>INR " + Orjson[i].AdPacks + "</div>";
        }
        pp1 = pp1 + "<p class='ribbon-content'><span style='font-size:12px;'>Payment by</span><span style='font-weight:bold;'> " + Orjson[i].PayMode + " </span><span style='font-size:12px;'>on</span><span style='font-weight:bold;'> " + Orjson[i].Date + " </span><span style='font-size:12px;'>, Deposit no</span><span style='font-weight:bold;'> " + Orjson[i].InvestID + "</span></p>";
        pp1 = pp1 + "</div>"
        pp1 = pp1 + "</div>"

        /////
        $('#depohistory').html('');
        ////
    }
    return pp1;
}


function loadOrdersdown(PageIndex, PageSize, MemID) {
    $('#DownDeposit').html('<img src="../UserProfileImg/loading2.gif" />');
    //var option = $('#partiCipantList').combo('getValue');
    $.getJSON('Handlers/Depsoit-History-Detail.ashx?p=' + PageIndex + "&s=" + PageSize + "&u=" + MemID + "&n=DOWN",
        function (Orjsons) {
            if (Orjsons.length == 0) {
                $('#DownDeposit').html('');
                $('#DownDeposit').html("Sorry, record not found...!");
            }
            else {
                var dd = formatOrders(Orjsons);
                $('#DownDeposit').html(dd);
                //                if ($("#hdnpg").val() == "")
                //                {
                //                document.getElementById("SelePgNu").value = "1";
                //                document.getElementById("SelePgNu").text = "1";
                //                } 
                //                else 
                //                {
                //                document.getElementById("SelePgNu").value = $("#hdnpg").val();
                //                document.getElementById("SelePgNu").text = $("#hdnpg").val();
                //                }
            }
        });
}

function formatOrders(Orjsons) {
    var pp1q = '';

    for (var i = 0; i < Orjsons.length; i++) {

        //    if (i == 0)
        //    {           
        //        var select = document.getElementById("SelePgNu");
        //        document.getElementById("SelePgNu").innerHTML = "";      
        //        var pgsize = $("#SelePgSz").val();
        //        var TotRecord = Orjson[i].TotRec;
        //        document.getElementById("lbltotrec").innerHTML  = TotRecord;
        //        for (var j = 1; j <=  Math.ceil(parseFloat(TotRecord).toFixed(10)/parseFloat(pgsize).toFixed(10)) ; j++)
        //        {
        //             var opt = j;
        //             var el = document.createElement("option");
        //             el.textContent = opt;
        //             el.value = opt;
        //             select.appendChild(el);
        //        }
        //    }

        ///// for paging...


        //    <div class="col-lg-4 col-md-6 col-xlg-2 col-xs-12">
        //                                <div class="ribbon-wrapper card">
        //                                    <div class="ribbon ribbon-default">Ribbon</div>
        //                                    <p class="ribbon-content">Duis mollis, est non commodo luctus, nisi erat porttitor ligula</p>
        //                                </div>
        //                            </div>
        pp1q = pp1q + "<div class='col-lg-4 col-md-6 col-xlg-2 col-xs-12'>";
        pp1q = pp1q + "<div class='ribbon-wrapper card'>";
        if (i == 0 || i == 6) {
            pp1q = pp1q + "<div class='ribbon ribbon-success ribbon-right'>INR " + Orjsons[i].AdPacks + "</div>";
        }
        else if (i == 1 || i == 7) {
            pp1q = pp1q + "<div class='ribbon ribbon-primary ribbon-right'>INR " + Orjsons[i].AdPacks + "</div>";
        }
        else if (i == 2 || i == 8) {
            pp1q = pp1q + "<div class='ribbon ribbon-default ribbon-right'>INR " + Orjsons[i].AdPacks + "</div>";
        }
        else if (i == 3 || i == 9) {
            pp1q = pp1q + "<div class='ribbon ribbon-danger ribbon-right'>INR " + Orjsons[i].AdPacks + "</div>";
        }
        else if (i == 4 || i == 10) {
            pp1q = pp1q + "<div class='ribbon ribbon-warning ribbon-right'>INR " + Orjsons[i].AdPacks + "</div>";
        }
        else if (i == 5 || i == 11) {
            pp1q = pp1q + "<div class='ribbon ribbon-info ribbon-right'>INR " + Orjsons[i].AdPacks + "</div>";
        }
        else {
            pp1q = pp1q + "<div class='ribbon ribbon-primary ribbon-right'>INR " + Orjsons[i].AdPacks + "</div>";
        }
        pp1q = pp1q + "<p class='ribbon-content'><span style='font-size:12px;'>Deposit for</span><span style='font-weight:bold;'> " + Orjsons[i].MemID + " </span><span style='font-size:12px;'>Payment by</span><span style='font-weight:bold;'> " + Orjsons[i].PayMode + " </span><span style='font-size:12px;'>on</span><span style='font-weight:bold;'> " + Orjsons[i].Date + "</span> <span style='font-size:12px;'>, Deposit no</span><span style='font-weight:bold;'> " + Orjsons[i].InvestID + "</span></p>";
        pp1q = pp1q + "</div>"
        pp1q = pp1q + "</div>"

        /////
        $('#DownDeposit').html('');
        ////
    }
    return pp1q;
}

//////ETH /////
function init_dataETH() {


    var DPlnAmt = $("#txtamt").val();
    var txtTxnHas = $("#txtTxnHas").val();
    var RcVAddtemp = $("#txtBTCAddress").val();
    var paymode = "ETH";



    if (txtTxnHas != '' || RcVAddETH != '') {


        var xmlhttp = new XMLHttpRequest();
        xmlhttp.open("GET", "//api.etherscan.io/api?module=account&action=txlist&address=" + RcVAddtemp + "&sort=desc", true);
        xmlhttp.send();
        ///
        $('#Msgs').html("<span style='font-size:15px; color:#FF0000; font-wieght:bold'>Please Wait....We are searching Ethereum Txn Hash details !</span>");
        ///  

        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {

                var jsontext = xmlhttp.responseText;
                var data = JSON.parse(jsontext);
                ///
                var n = data.result.length;

                for (var i = 0; i < n; i++) {
                    var TranHas = data.result[i].hash;
                    var txndate = new Date(data.result[i].timeStamp * 1000).toISOString().substring(0, 19).replace('T', ' ');
                    ///  

                    if (txtTxnHas == TranHas) {

                        var SndrAdds = data.result[i].from;
                        var RecETHAds = data.result[i].to;


                        var RecETHAdsUpper = RecETHAds.toUpperCase();
                        var RcVAddtempUpper = RcVAddtemp.toUpperCase();

                        if (RecETHAdsUpper == RcVAddtempUpper) {
                            var amount = data.result[i].value;

                            DWalletAmtRequestEth(TranHas, SndrAdds, amount, DPlnAmt, txndate);
                        }
                        ///// 





                        /////      
                    }
                }
                //         
            }
        }

    }
    else {
        $('#Msgs').html("<span style='font-size:15px; color:#FF0000; font-wieght:bold'>Please check Txn Hash information about ETH payment !</span>");
    }

}

function DWalletAmtRequestEth(TranHas, SndrAdds, amount, PlnAmt, txndate) {
    ////////
    $('#Msgs').html('<img src="../UserProfileImg/loading2.gif" />');
    var od = new FormData();
    var txtBTCAddress = SndrAdds;//$("#txtBTCAddress").val();    
    var txtTxnHas = TranHas;//$("#txtTxnHas").val(); 
    var txtReqAmt = amount;
    var reqdate = txndate;
    ////////
    od.append("txtBTCAddress", txtBTCAddress);
    od.append("txtTxnHas", txtTxnHas);
    od.append("txtReqAmt", amount);
    od.append("PlnAmt", amount);
    od.append("ReqDate", reqdate);

    //     var fileUpload = $("#fluplodBTC").get(0);
    //    var files = fileUpload.files;
    //    for (var i = 0; i < files.length; i++) {
    //    od.append(files[i].name, files[i]);
    //    }     
    ///////
    $.ajax({
        url: "Handlers/DWallet-Amt_Request.ashx?Save=ETHInfo",
        type: "POST",
        contentType: false,
        processData: false,
        data: od,
        dataType: "json",
        success: function (Response) {
            if (Response.Success) {
                $('#Msgs').html(Response.Message);
            }
            else {
                $('#Msgs').html(Response.Message);
            }
        },
        error: function (err) {
            $('#Msgs').html(err.statusText);
        }
    });
}
////////////BTC ETH RATE UPDATE //////////
function getCookie(cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
}
///
function btcrateupdate() {
    ///
    var secret = getCookie("ZdvAikMnslOkwF");
    ///
    //$.getJSON('https://blockchain.info/ticker', function (data) {
    //    var contractABI1 = JSON.stringify(data.USD);
    //    var parsedData1 = JSON.parse(contractABI1);
    //    var ethrt1 = parsedData1.last;
    //    var od = new FormData();
    //    ////////
    //    od.append("CurRt", ethrt1);
    //    od.append("scr", secret);
    //    od.append("type", 'BTC');
    //    od.append("rtdate", '');
    //    ///
    //    $.ajax({
    //        url: "Handlers/Currency-Rate.ashx",
    //        type: "POST",
    //        contentType: false,
    //        processData: false,
    //        data: od,
    //        dataType: "json",
    //        success: function (Response) {
    //            if (Response.Success) { }
    //            else { }
    //        },
    //        error: function (err) { }
    //    });
    //    ///     
    //});
    ///// GET ETH RATE ////  
    //$.getJSON('https://api.etherscan.io/api?module=stats&action=ethprice', function (data) {
    //    var contractABI = JSON.stringify(data.result);
    //    var parsedData = JSON.parse(contractABI);
    //    var ethrt = parsedData.ethusd;
    //    var ethdate = new Date(parsedData.ethusd_timestamp * 1000).toISOString().substring(0, 19).replace('T', ' ');
    //    var od = new FormData();
    //    ////////
    //    od.append("CurRt", ethrt);
    //    od.append("scr", secret);
    //    od.append("type", 'ETH');
    //    od.append("rtdate", ethdate);
    //    ///
    //    $.ajax({
    //        url: "Handlers/Currency-Rate.ashx",
    //        type: "POST",
    //        contentType: false,
    //        processData: false,
    //        data: od,
    //        dataType: "json",
    //        success: function (Response) {
    //            if (Response.Success) { }
    //            else { }
    //        },
    //        error: function (err) { }
    //    });
    //    ///        
    //});
    ///////end eth
    ///// GET TRX RATE ////  
    $.getJSON('https://api.smartcontract.ru/gateway/rates_usd.json', function (data) {
        var contractABI1 = JSON.stringify(data.data.trx);
        var contractABI2 = JSON.stringify(data.data.eth);
        var contractABI3 = JSON.stringify(data.data.btc);
        var contractABI4 = JSON.stringify(data.data.bnb);

        var trxrt = contractABI1.replace('"', '');//parsedData1.data.trx;
        var ethrt = contractABI2.replace('"', '');
        var btcrt = contractABI3.replace('"', '');
        var bnbrt = contractABI4.replace('"', '');

        var TRXRt = trxrt.replace('"', '');
        var ETHRt = ethrt.replace('"', '');
        var BTCRt = btcrt.replace('"', '');
        var BNBRt = bnbrt.replace('"', '');

        var ethdatet = '';
        ///
        var odt = new FormData();
        ///
        odt.append("TrxRt", TRXRt);
        odt.append("EthRt", ETHRt);
        odt.append("BtcRt", BTCRt);
        odt.append("BnbRt", BNBRt);
        odt.append("scr", secret);
        odt.append("rtdate", ethdatet);
        ///
        $.ajax({
            url: "handlers/Currency-Rate.ashx",
            type: "POST",
            contentType: false,
            processData: false,
            data: odt,
            dataType: "json",
            success: function (Response) {
                if (Response.Success) { }
                else { }
            },
            error: function (err) { }
        });
        ///        
    });
    ///////end trx   
}

function SaveRequest_TxnStatusDetails() {


    swal({
        title: "Please Wait....",
        text: "We find transaction hash.....",
    },
        function () {
            document.getElementById("submittxnhashrequest").disabled = false;
            $("#submittxnhashrequest").html('<i class="fa fa-check"></i> Submit');
        }
    );

    document.getElementById("submittxnhashrequest").disabled = true;
    $("#submittxnhashrequest").html('Plase wait...');

    var Txn_Hash = $('#txtxnHash').val();
    var fr_add = $('#sndbywallet').val();
    //var to_add = $('#recbywallet').val();
    var payid = $('#paybyid').val();


    /*  alert(Txn_Hash + ',' + fr_add + ',' + payid);*/

    if (Txn_Hash != '' || length(Txn_Hash) > 64) {
        /*alert('check');*/
        $.get("https://apilist.tronscan.org/api/transaction?sort=-timestamp&count=true&limit=10&start=0&address=" + fr_add).done(function (a) {

            /* $.get("https://api.covalenthq.com/v1/56/transaction_v2/" + Txn_Hash + "/?format=JSON&key=ckey_docs").done(function (a) {*/
            var getdata = a.data.items;

            getdata.forEach(function (item) {
                /*  && item.to_address.toUpperCase() == to_add.toUpperCase()*/
                if (item.from_address.toUpperCase() == fr_add.toUpperCase()) {
                    if (item.successful == true) {

                        var od11 = new FormData();
                        od11.append("ODsID", payid);
                        od11.append("value", item.value);
                        od11.append("transaction_hash", Txn_Hash);
                        od11.append("fromaddress", item.from_address);
                        od11.append("toaddress", item.to_address);
                        od11.append("Conf", item.successful);
                        od11.append("Skey", Skey);
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
                                    $("#txnMsgs").html('');
                                    swal({
                                        title: "Done!",
                                        text: Response.Message,
                                        type: "success"

                                    },
                                        function () {
                                            location.href = "Add-Balance-CP#DepostHtry";
                                        }
                                    );

                                    document.getElementById("submittxnhashrequest").disabled = false;
                                    $("#submittxnhashrequest").html('<i class="fa fa-check"></i> Submit');
                                }
                                else {
                                    $('#txnMsgs').html('');

                                    swal({
                                        title: "Sorry!",
                                        text: Response.Message,
                                        type: "warning"
                                    });

                                    document.getElementById("submittxnhashrequest").disabled = false;
                                    $("#submittxnhashrequest").html('<i class="fa fa-check"></i> Submit');
                                }
                            },
                            error: function (err) {
                                $('#txnMsgs').html('');

                                swal({
                                    title: "Sorry!",
                                    text: err.statusText,
                                    type: "error"
                                });

                                document.getElementById("submittxnhashrequest").disabled = false;
                                $("#submittxnhashrequest").html('<i class="fa fa-check"></i> Submit');
                            }
                        });

                    }
                    else {
                        $('#txnMsgs').html('');

                        swal({
                            title: "Sorry!",
                            text: "Transaction hash must be success!",
                            type: "error"

                        });

                        document.getElementById("submittxnhashrequest").disabled = false;
                        $("#submittxnhashrequest").html('<i class="fa fa-check"></i> Submit');
                    }

                }
                else {

                    $('#txnMsgs').html('');
                    swal({
                        title: "Sorry!",
                        text: "Entered transaction hash wrong, please enter correct txn hash!",
                        type: "error"

                    });

                    document.getElementById("submittxnhashrequest").disabled = false;
                    $("#submittxnhashrequest").html('<i class="fa fa-check"></i> Submit');
                }
            });

        });
    }
    else {
        $('#txnMsgs').html('');
        swal({
            title: "Sorry!",
            text: "Please enter correct transaction hash first.!",
            type: "error"

        });
        document.getElementById("submittxnhashrequest").disabled = false;
        $("#submittxnhashrequest").html('<i class="fa fa-check"></i> Submit');
    }
}


function UploadFile(aid) {
    //$('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');
    $("#Msgs").html('');
    swal({
        title: "Please wait",
        text: "We are checking Txn Hash Status at tronscan.org",
        type: "warning"

    });
    document.getElementById("submittxnhashrequest").disabled = true;
    $("#submittxnhashrequest").html('Plase wait...');
    var TRXRate = $("#TRXRate").val();
    var txtTranHash = $("#txtxnHash").val();
    //var RcVAdd = $("#sndbywallet").val();
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
    if (pattern.test(txtTranHash) && txtTranHash.length == 64) {
        //var paymode = 'BTC'
        var paymode = 'TRX'
        var test = new FormData();
        test.append("aid", aid);
        test.append("txtTranHash", txtTranHash);

        ///
        $.get("https://apilist.tronscan.org/api/transaction?sort=-timestamp&count=true&limit=10&start=0&address=" + RcVAdd).done(function (a) {
            // $("#txCount").text(a.data[0].trxCount);        

            //xmlhttp.open("GET", "https://apilist.tronscan.org/api/transaction?sort=-timestamp&count=true&limit=30&start=0&address=" + RcVAdd, true);
            //xmlhttp.send();
            ///         
            //xmlhttp.onreadystatechange = function () {
            //    if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            //        //https://tronscan.org/q/getblockcount
            //        var jsontext = xmlhttp.responseText;
            //        var data = JSON.parse(jsontext);
            //
            var n = a.data.length;

            // var n = data.txs.length;
            for (var i = 0; i < n; i++) {
                //var outAdd = rcvAdd;
                ////for (z = 0; z < data.txs[i]['out'].length; z++)
                ////{                            
                ////var TranHas=data.txs[i]['out'][z]['addr'];                            			        
                //var TranHas = data[i]['toAddress'];
                //if (outAdd == TranHas) {
                //    var amount = data[i]['amount'];
                //    var Tnxhash = data[i]['hash'];//data.txs[i].hash;
                //    // var blockheight = data.txs[i].block_height;
                //    var txndate = new Date(data[i]['timestamp'] * 1000).toISOString().substring(0, 19).replace('T', ' ');//new Date(data.txs[i].time*1000).toISOString().substring(0, 19).replace('T', ' ');
                //    var result = data[i]['result'];
                //    var confirmed = data[i]['confirmed'];
                //    var Confm = 0;
                //    if (result == 'SUCCESS' && confirmed == 'true') {
                //        var Confm = 1;//(latestblock - blockheight) + 1;
                //    }
                //    ////                          
                //    $('#odc').load("k3ji4ntu/handler/index/BTC-API-457-CB_Cnf.ashx?ODsID=" + id + "&value=" + amount + "&transaction_hash=" + Tnxhash + "&address=" + outAdd + "&Conf=" + Confm + "&Skey=" + Skey + "&transaction_dt=" + txndate);
                //    ////
                //}
                //}

                var TranHas = a.data[i]['hash'];

                //alert(txtTranHash + ',TranHas :' + TranHas + ', amount :' + amount + ', FndPndg' + FndPndg + ', ReqDate' + ReqDate2 + ', txndate' + txndate1 + ',confirmed' + confirmed);
                //alert('1 '+txtTranHash + ',2 : '+TranHas);
                if (txtTranHash == TranHas) {

                    var txndate = new Date(a.data[i]['timestamp']).toISOString().substring(0, 19).replace('T', ' ');
                    var SndrAdds = a.data[i]['ownerAddress'];
                    var RecBTCAds = a.data[i]['toAddress'];
                    var successful = a.data[i]['successful'];
                    var amount = 0;
                    if (CPACType1 == "USDT.TRC20") {

                        amount = a.data[i]['trigger_info']['parameter']['_value'];

                    }
                    else {
                        amount = a.data[i]['amount'];
                        /*amount = amount / 1000000*/
                    }
                    var confirmed = a.data[i]['confirmed'];

                    if (confirmed == true) {
                        test.append("ODsID", payid);
                        test.append("value", amount);
                        test.append("transaction_hash", TranHas);
                        test.append("fromaddress", SndrAdds);
                        test.append("toaddress", RecBTCAds);
                        test.append("Conf", confirmed);
                        test.append("Skey", "Succes24!7H1p");
                        test.append("transaction_dt", txndate);

                        ///
                        $.ajax({
                            url: "Handlers/Add-Fund-API-Respons-Update.ashx",
                            type: "POST",
                            contentType: false,
                            processData: false,
                            data: test,
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
                                            location.href = "Add-Balance-CP.html";
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
                                $("#submittxnhashrequest").html('Submit');
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
                                $("#submittxnhashrequest").html('Submit');
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
                        $("#submittxnhashrequest").html('Submit');
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
                    $("#submittxnhashrequest").html('Submit');
                }
            }
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
        $("#submittxnhashrequest").html('Submit');
    }
}

function Save_dataCP() {
    $('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');

    document.getElementById("submitFundreq").disabled = true;
    $("#submitFundreq").html('Please Wait....');

    var od = new FormData();

    var paymode = '';
    Paymentmode = document.querySelector('#Paymentmode');
    var paymode = Paymentmode.value;

    //if ($("#Bitcoin").prop('checked') == true) {
    //    paymode = $("#Bitcoin").val();
    //}
    //else if ($("#Ethereum").prop('checked') == true) {
    //    paymode = $("#Ethereum").val();
    //}
    //else if ($("#TRON").prop('checked') == true) {
    //    paymode = $("#TRON").val();
    //}
    //else if ($("#Binance").prop('checked') == true) {
    //    paymode = $("#Binance").val();
    //}
    //else if ($("#TRX").prop('checked') == true) {
    //    paymode = $("#TRX").val();
    //}
    //else {
    //    //$('#Msgs').html("<div class='alert alert-danger alert-rounded'> You need to select one Payment Method option !<button type='button' class='close' data-dismiss='alert' aria-label='Close'> <span aria-hidden='true'>×</span> </button>  </div>");
    //    $('#Msgs').html('');
    //    /*alert('1');*/
    //    swal({
    //        title: "Sorry!",
    //        text: "You need to select one Payment Method option !",
    //        type: "warning"
    //    });
    //    document.getElementById("submitFundreq").disabled = false;
    //    $("#submitFundreq").html('Submit <i class="fa-solid fa-right-to-bracket ml-1"></i>');

    //    return;
    //}

    //if (paymode == 'BTC') {
    //    var txtReqAmt = $("#txtamtBTC").val();
    //}
    //if (paymode == 'ETH') {
    //    var txtReqAmt = $("#txtamtETH").val();
    //}
    //if (paymode == 'TRX') {
    //    var txtReqAmt = $("#txtamtTRX").val();
    //}
    //alert(paymode);

    //var txtReqAmt = $("#txtamtTRX").val();
    var txtReqAmt = $("#txtamtTRX").val();

    var eMailAddss = $('#mememail1').text();
    /*alert(txtReqAmt + ","+paymode +","+ eMailAddss)*/
    od.append("txtReqAmt", txtReqAmt);
    od.append("paymode", paymode);
    od.append("eMailAddss", eMailAddss);

    $.ajax({
        url: "Handlers/CoinPayments.ashx",
        /*url: "Handlers/Api_Payments.ashx",*/
        type: "POST",
        contentType: false,
        processData: false,
        data: od,
        dataType: "json",
        success: function (Response) {
            if (Response.Success) {
                //$('#CPAddress').show();
                //$('#Msgs').html("<div class='alert alert-success'> Fund request submitted Succesflly, Please check payment address below or Right Side!<button type='button' class='close' data-dismiss='alert' aria-label='Close'> <span aria-hidden='true'>×</span> </button>  </div>");

                $("#Msgs").html('');
                swal({
                    title: "Request Submited",
                    text: "Add Balance request submitted successfully, Please check payment address below or Right Side!",
                    type: "success"
                },
                    function () {
                        DashboardSummary();
                        $('#Paymentdetailsshow').show();
                        $('#onloadshowhistry').hide();
                        $('#showdetails').hide();
                        /*parent.location.reload(true);*/
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
            $("#Msgs").html('');
            swal({
                title: "Alert!",
                text: err.statusText,
                type: "error"
            });
            document.getElementById("submitFundreq").disabled = false;
            $("#submitFundreq").html('Submit <i class="fa-solid fa-right-to-bracket ml-1"></i>');
        }
    });
}
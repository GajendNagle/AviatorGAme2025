function valueupdate() {
    $('#valueshow').show();
    var txtMCB = $('#TransferAmtrwal').val();
    var texvalue = $('#TxnCharge').val();
    var totalvalue = Number(txtMCB) + Number(texvalue);
    $('#NetWithAmtvalue').html(totalvalue);
    $('#netvalue').html(texvalue);
    $('#sectionvalue').html(txtMCB);
}
function bounsclick() {
    var pid = $("input:radio[name=walletType]:checked").val();
    if (pid == 'PsI') {
        var bonusname = "Transfer Amount from <b style='text-decoration: underline;'> Appreciation Bonus Income*</b>";
        $('#bonusname').html(bonusname);

    }
    if (pid == 'LvI') {
        var bonusname = "Transfer Amount from <b style='text-decoration: underline;'> Appreciation Bonus*</b>";
        $('#bonusname').html(bonusname);

    }
    if (pid == 'BdI') {
        var bonusname = "Transfer Amount from <b style='text-decoration: underline;'> Board Income*</b>";
        $('#bonusname').html(bonusname);

    }
    if (pid == 'Ryt') {
        var bonusname = "Transfer Amount from <b style='text-decoration: underline;'> Global Pool Bonus*</b>";
        $('#bonusname').html(bonusname);

    }
}
function isNumberKey(event) {

}
function Showbaldtl() {
    $('#Msg1').html('');
    //if (!$("input:radio[name=walletType]").is(":checked")) {
    //    //$('#Msg1').html("<div class='alert alert-danger alert-bordered' style='margin:5px;'> Please select Transfer wallet <span class='close' data-dismiss='alert'>&times;</span></div>");


    //    return
    //}
    //if (x.matches) { // If media query matches

    //    document.getElementById('Transferclick').scrollIntoView({ behavior: 'smooth', block: 'start' });
    //    var scrollingTime = 300;
    //}

    var pid = 'PsI';//$("input:radio[name=walletType]:checked").val();
    var txtDepositAmount = $("#TransferAmtrwal").val();
    //alert(txtDepositAmount);
    if (parseFloat(txtDepositAmount) > 0) {
        if (pid == 'PsI') {
            var AvBBal = $('#PsIBBal').val();
            if (parseFloat(txtDepositAmount) < parseFloat(AvBBal) | parseFloat(txtDepositAmount) == parseFloat(AvBBal)) {
                //var AdDctn = "";
                //AdDctn = "0";//Math.round(txtDepositAmount * 5) / 100;

                var serDctn = "";
                //serDctn = Math.round(txtDepositAmount * 10) / 100;

                var txnchange = $('#TxnCharge').val();
              
                //var serDctn = Math.round((txtDepositAmount * (Number(txnchange))) * 100) / 100;
                var serDctn = Number(txtDepositAmount) * Number(txnchange) / 100;
          
                var netamt = "";
                //netamt = txtDepositAmount - (AdDctn + serDctn);
                netamt = txtDepositAmount - serDctn;

                //$('#adchrg').html('Rs.' + AdDctn);
                $('#srchrg').html((serDctn).toFixed(2));
                $('#totamt').html(txtDepositAmount);
                $('#netamt').html((netamt).toFixed(2));
                $('#Netamount').val(netamt);


            }

        }
        if (pid == 'LvI') {
            var DrBBal = $('#LvIBBal').val();
            if (parseFloat(txtDepositAmount) < parseFloat(DrBBal) | parseFloat(txtDepositAmount) == parseFloat(DrBBal)) {
                //var AdDctn = "";
                //AdDctn = "0";//Math.round(txtDepositAmount * 5) / 100;

                var serDctn = "";
                //serDctn = Math.round(txtDepositAmount * 10) / 100;
                var txnchange = $('#TxnCharge').val();
                //var serDctn = Math.round((txtDepositAmount * (Number(txnchange))) * 100) / 100;
                var serDctn = Number(txtDepositAmount) * Number(txnchange) / 100;

                var netamt = "";
                //netamt = txtDepositAmount - (AdDctn + serDctn);
                netamt = txtDepositAmount - serDctn;

                //$('#adchrg').html('Rs.' + AdDctn);
                $('#srchrg').html((serDctn).toFixed(2));
                $('#totamt').html(txtDepositAmount);
                $('#netamt').html((netamt).toFixed(2));
                $('#Netamount').val(netamt);
            }

        }
        if (pid == 'BdI') {
            var TbBBal = $('#BdIBBal').val();
            if (parseFloat(txtDepositAmount) < parseFloat(TbBBal) | parseFloat(txtDepositAmount) == parseFloat(TbBBal)) {
                //var AdDctn = "";
                //AdDctn = "0";//Math.round(txtDepositAmount * 5) / 100;

                var serDctn = "";
                //serDctn = Math.round(txtDepositAmount * 10) / 100;

                var txnchange = $('#TxnCharge').val();
                //var serDctn = Math.round((txtDepositAmount * (Number(txnchange))) * 100) / 100;
                var serDctn = Number(txtDepositAmount) * Number(txnchange) / 100;


                var netamt = "";
                //netamt = txtDepositAmount - (AdDctn + serDctn);
                netamt = txtDepositAmount - serDctn;

                //$('#adchrg').html('Rs.' + AdDctn);
                $('#srchrg').html((serDctn).toFixed(2));
                $('#totamt').html(txtDepositAmount);
                $('#netamt').html((netamt).toFixed(2));
                $('#Netamount').val(netamt);
            }
        }
        if (pid == 'Ryt') {
            var RnkBBal = $('#RytBBal').val();
            if (parseFloat(txtDepositAmount) < parseFloat(RnkBBal) | parseFloat(txtDepositAmount) == parseFloat(RnkBBal)) {
                // var AdDctn = "";
                //AdDctn = "0";//Math.round(txtDepositAmount * 5) / 100;

                var serDctn = "";
                //serDctn = Math.round(txtDepositAmount * 10) / 100;
                var txnchange = $('#TxnCharge').val();
                //var serDctn = Math.round((txtDepositAmount * (Number(txnchange))) * 100) / 100;
                var serDctn = Number(txtDepositAmount) * Number(txnchange) / 100;

                var netamt = "";
                //netamt = txtDepositAmount - (AdDctn + serDctn);
                netamt = txtDepositAmount - serDctn;

                //$('#adchrg').html('Rs.' + AdDctn);
                $('#srchrg').html((serDctn).toFixed(2));
                $('#totamt').html(txtDepositAmount);
                $('#netamt').html((netamt).toFixed(2));
                $('#Netamount').val(netamt);
            }
        }
    }


}
//////
function AllWalletballace() {

    $('#Mem_Name').html('<img src="../UserProfileImg/loading2.gif" />');
    ///////
    $.getJSON('Handlers/Inner_Page_Summary.ashx',
        function (OrjsonDS) {
            if (OrjsonDS.length == 0) {
            }
            else {
                var wa = '';
                for (var i = 0; i < OrjsonDS.length; i++) {

                    //////////Ads view bonus
                    $('#PsI').html(OrjsonDS[i].RBal);
                    $('#LvI').html(OrjsonDS[i].TmPsBal);
                    $('#BdI').html(OrjsonDS[i].IBal);
                    $('#Ryt').html(OrjsonDS[i].SrBal);

                    $('#PsIBBal').val(OrjsonDS[i].TmPsBal);
                    $('#LvIBBal').val(OrjsonDS[i].TmPsBal);
                    $('#RytBBal').val(OrjsonDS[i].SrBal);
                    $('#BdIBBal').val(OrjsonDS[i].IBal);

                    $('#DkbTxnCharge').html(" (" + OrjsonDS[i].DkbTxnCharge + "%)");
                    $('#Diduction').html(OrjsonDS[i].DkbTxnCharge + '<span>%</span>');
               
                    $('#TxnCharge').val(OrjsonDS[i].DkbTxnCharge);
                    $('#fmin').html('<span>$</span>' + OrjsonDS[i].Fmin);
                    $('#fmax').html('<span>$</span>' + OrjsonDS[i].FMax);
                    $('#fmlt').html('<span>$</span>' + OrjsonDS[i].FMlt);
                }

            }

        });
}

function eWalletBalanceew(pgid) {
    //////////
    $('#WallName').html('');

    $('#WallBal').html('<img src="../UserProfileImg/loading2.gif" />');
    /////

    //////////
    if (pgid != '') {
        $.getJSON('Handlers/eWalletBalance.ashx?EwTp=' + pgid,
            function (OrjsonDS) {
                if (OrjsonDS.length == 0) {
                }
                else {
                    var wa = '';
                    for (var i = 0; i < OrjsonDS.length; i++) {
                        if (pgid == "IWallet") {
                            $('#WallName').html(" i-Wallet Balance ($):");
                            $('#WallBal').html(OrjsonDS[i].ACCOUNT_BALANCE);
                            $('#eWalletName').val(pgid);
                            $('#ewallet').html("i-Wallet ");


                        }
                        if (pgid == "EWallet") {
                            $('#WallName').html(" e-Wallet Balance ($):");
                            $('#WallBal').html(OrjsonDS[i].ACCOUNT_BALANCE);
                            $('#eWalletName').val(pgid);
                            $('#ewallet').html("e-Wallet ");
                        }

                        ////

                        ////
                    }
                }
            });
    }
    else {
        $('#WallName').html('');
        $('#WallBal').html('');
        $('#eWalletName').val('');
    }
}

function transferamt() {

    var valu = $("#txtDepositAmount").val();
    var WalletBalance = $("#WallBal").text();
    if (parseFloat(valu) > 0) {
        if (parseFloat(valu) > parseFloat(WalletBalance)) {
            $('#Msgs').html("<div class='alert alert-danger alert-bordered fade in'>Please check fields/Wallet Balance again !<span class='close' data-dismiss='alert'>&times;</span></div>");
            $("#txtDepositAmount").val('');
        }
        else {
            var tamt = (parseFloat(valu) - ((parseFloat(valu) * 3) / 100)).toFixed(2);
            $("#TransferAmt").val(tamt);
        }
    }


}


function Save_data() {
    ////////
    //alert('Hiii');
    $('#Msg1').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');

    document.getElementById("submitTransferNow").disabled = true;
    $("#submitTransferNow").html('Please wait...');

    //$('#Msg1').html('<img src="../UserProfileImg/103.gif" width="35" height="35"  />');
    var pid = 'PsI';//$("input:radio[name=walletType]:checked").val();
    var txtDepositAmount = $("#TransferAmtrwal").val();
    //var txtDepositAmount = $("#Netamount").val();
    var txttxnpwd = $("#txttxnpwdcrwall").val();
    var txtOtp = $("#txtOtp").val();
    var type = pid;
    //alert(txtDepositAmount);


    //if (!$("input:radio[name=walletType]").is(":checked")) {
    //    //  $('#Msg1').html("<div class='alert alert-danger alert-bordered' style='margin:5px;'> Please select Transfer wallet <span class='close' data-dismiss='alert'>&times;</span></div>");  

    //    //      $('#Msg1').html("<div class='alert red-skin alert-rounded'><img src='images/close-button.png'width='25' heigth='25'  alt=''> Please select Transfer wallet<button type='button' class='close' data-dismiss='alert' aria-label='Close'> <span aria-hidden='true'>×</span> </button>  </div>");

    //    $("#Msg1").html('');
    //    swal({
    //        title: "Sorry!",
    //        text: "Please select Transfer wallet",
    //        type: "warning"

    //    });

    //    document.getElementById("submitTransferNow").disabled = false;
    //    $("#submitTransferNow").html('Transfer Now');

    //    return
    //}


    if (parseFloat(txtDepositAmount) > 0) {
        if (pid == 'PsI') {
            var AvBBal = $('#PsIBBal').val();
            if (parseFloat(txtDepositAmount) > parseFloat(AvBBal)) {

                $("#TransferAmtrwal").val('');
                $("#Msg1").html('');
                swal({
                    title: "Sorry!",
                    text: "Please check My Account Balance !",
                    type: "warning"

                });

                document.getElementById("submitTransferNow").disabled = false;
                $("#submitTransferNow").html('Transfer Now<i class="fa-solid fa-right-to-bracket ml-2"></i>');
                return
            }
        }
        //if (pid == 'LvI') {
        //    var DrBBal = $('#LvIBBal').val();
        //    if (parseFloat(txtDepositAmount) > parseFloat(DrBBal)) {

        //        $("#Msg1").html('');
        //        swal({
        //            title: "Sorry!",
        //            text: "Please check Appreciation Bonus Balance !",
        //            type: "warning"

        //        });

        //        document.getElementById("submitTransferNow").disabled = false;
        //        $("#submitTransferNow").html('Transfer Now');

        //        $("#TransferAmtrwal").val('');
        //        return
        //    }

        //}
        //if (pid == 'BdI') {
        //    var TbBBal = $('#BdIBBal').val();
        //    if (parseFloat(txtDepositAmount) > parseFloat(TbBBal)) {

        //        $("#Msg1").html('');
        //        swal({
        //            title: "Sorry!",
        //            text: "Please check Team Board Income Balance !",
        //            type: "warning"

        //        });

        //        document.getElementById("submitTransferNow").disabled = false;
        //        $("#submitTransferNow").html('Transfer Now');

        //        $("#TransferAmtrwal").val('');
        //        return
        //    }
        //}
        //if (pid == 'Ryt') {
        //    var RnkBBal = $('#RytBBal').val();
        //    if (parseFloat(txtDepositAmount) > parseFloat(RnkBBal)) {

        //        $("#Msg1").html('');
        //        swal({
        //            title: "Sorry!",
        //            text: "Please check Global Pool Bonus Balance !",
        //            type: "warning"

        //        });

        //        document.getElementById("submitTransferNow").disabled = false;
        //        $("#submitTransferNow").html('Transfer Now');

        //        $("#TransferAmtrwal").val('');
        //        return
        //    }
        //}
    }
    else {


        $("#Msg1").html('');
        swal({
            title: "Sorry!",
            text: "Amount should be greater then 0 !",
            type: "warning"

        });

        document.getElementById("submitTransferNow").disabled = false;
        $("#submitTransferNow").html('Transfer Now<i class="fa-solid fa-right-to-bracket ml-2"></i>');
        return
    }
    //////////
    var od = new FormData();

    od.append("txtDepositAmount", txtDepositAmount);
    od.append("txttxnpwd", txttxnpwd);
    od.append("type", type);
    od.append("txtOtp", txtOtp);

    ///////
    $.ajax({
        url: "Handlers/Transfer-f-Wallet.ashx",
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

                    $("#Msg1").html('');
                    swal({
                        title: "OTP Sent",
                        text: Response.Message,
                        type: "success"
                    });
                }
                else if (Response.detail == 1) {
                    AllWalletballace();
                    $("#TransferAmtrwal").val('');
                    $("#txttxnpwdcrwall").val('');

                    $('#Msg1').html("<div class='alert alert-success alert-bordered fade in' style='margin:5px;'>" + Response.Message + "<span class='close' data-dismiss='alert'>&times;</span></div>");
                    //location.href = "F-Wallet-History.html";

                    $("#Msg1").html('');
                    swal({
                        title: "Congratulation !",
                        text: Response.Message,
                        type: "success"
                    },

                        function () {
                            window.location.href = "growthwallet.html";

                        });
                }

                document.getElementById("submitTransferNow").disabled = false;
                $("#submitTransferNow").html('Transfer Now<i class="fa-solid fa-right-to-bracket ml-2"></i>');
            }
            else {

                $("#Msg1").html('');
                swal({
                    title: "Sorry!",
                    text: Response.Message,
                    type: "warning"

                });

                document.getElementById("submitTransferNow").disabled = false;
                $("#submitTransferNow").html('Transfer Now<i class="fa-solid fa-right-to-bracket ml-2"></i>');

            }
        },
        error: function (err) {

            $("#Msg1").html('');
            swal({
                title: "Sorry!",
                text: err.statusText,
                type: "warning"

            });

            document.getElementById("submitTransferNow").disabled = false;
            $("#submitTransferNow").html('Transfer Now<i class="fa-solid fa-right-to-bracket ml-2"></i>');
        }
    });
}
function getamt() {
    var transfamt = $('#TransferAmtrwal').val();
    var transfee = $('#transfee').val();
    var txnfee = $('#txnfee').val();
    $('#totamt').html(transfamt);
    $('#txnfee').html(transfee/100);
    $('#nettrans').html(transfamt - txnfee);
}
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

function Save_dataCpAPI() {
    debugger;
    $('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please Wait.....</div></div></div>');
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

    $.ajax({
        url: "Handlers/Add-Balance-Crypto-api.ashx",
        type: "POST",
        contentType: false,
        processData: false,
        data: od,
        dataType: "json",
        success: function (Response) {

            if (Response.Success) {
                $("#Msgs").html('');
                swal({
                    title: "Request Submited",
                    text: "Add Balance request submitted successfully, Please check payment address below or Right Side!",
                    type: "success"
                },
                    function () {
                        $('#PaymentdetailsshowCAPI').show();
                        window.location.reload();
                    });
                document.getElementById("submitFundreq").disabled = false;
                $("#submitFundreq").html('Submit <i class="fa-solid fa-right-to-bracket ml-1"></i>');
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
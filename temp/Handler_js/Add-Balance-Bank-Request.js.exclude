function Save_Ab_bank_data() {
    //$('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');
    $('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');

    document.getElementById("SubmitAddBal").disabled = true;
    $("#SubmitAddBal").html('Please wait...');

    //if (!$("input:radio[name=PaymentType]").is(":checked")) {
    //    //$("#Msgs").html("<div class='alert alert-warning border-warning'><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='lni lni-cross-circle'></i></button><strong></strong>Please select Payment Mode</div>");

    //    $('#Msgs').html('');

    //    swal({
    //        title: "Sorry!",
    //        text: "Please select Payment Mode",
    //        type: "warning"

    //    });

    //    document.getElementById("SubmitAddBal").disabled = false;
    //    $("#SubmitAddBal").html('Submit');

    //    return
    //}
    //var paymode = $("input:radio[name=PaymentType]:checked").val();

    var paymode = document.querySelector('#Paymentmode').value;

    if (paymode == "BTC") {
        init_data();
    }
    else {
       
        //$('#Msgs').html("<div class='preloader3 loader-block'><div class='circ1 loader-warning'></div> <div class='circ2 loader-warning'></div><div class='circ3 loader-warning'></div><div class='circ4 loader-warning'></div></div>");

        //   $('#Msgs').html('<img src="../UserProfileImg/loading2.gif" />');
        var od = new FormData();
        var txtBTCAddress = $('#txtBTCAddress').val();
        var ChooseTxnMode = $('#ChooseTxnMode').val();
        var txtTxnHas = $("#txtTxnHas").val();//$("#txtTxnHas").val(); 
        var txtReqAmt = $("#txtamt").val();
        var reqdate = $("#SpDate").val();

        //alert(txtBTCAddress);
        ////////
        od.append("txtBTCAddress", txtBTCAddress);/* txtBTCAddress*/
        od.append("ChooseTxnMode", ChooseTxnMode);
        od.append("txtTxnHas", txtTxnHas);
        od.append("txtReqAmt", txtReqAmt);
        od.append("PlnAmt", txtReqAmt);
        od.append("ReqDate", reqdate);
        od.append("paymode", paymode);
        var fileUpload = $("#filer_input").get(0);
        var files = fileUpload.files;
        for (var i = 0; i < files.length; i++) {
            od.append(files[i].name, files[i]);
        }

        if (files.length == 0) {
            //$("#Msgs").html("<div class='alert alert-warning border-warning'><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='lni lni-cross-circle'></i></button><strong></strong>Please upload Receipt !</div>");

            $('#Msgs').html('');

            swal({
                title: "Sorry!",
                text: "Please upload Receipt !",
                type: "warning"

            });

            document.getElementById("SubmitAddBal").disabled = false;
            $("#SubmitAddBal").html('<i class="bx bx-file"></i>Submit');

            return
        }


        var FileSize = files[0].size / 1024; // in KB
        if (FileSize > 500) {
            // $("#Msgs").html("<div class='alert alert-warning border-warning'><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='lni lni-cross-circle'></i></button><strong></strong>Upload Receipt size exceeds 500 KB</div>");

            $('#Msgs').html('');

            swal({
                title: "Sorry!",
                text: "Upload Receipt size exceeds 500 KB",
                type: "warning"

            });

            document.getElementById("SubmitAddBal").disabled = false;
            $("#SubmitAddBal").html('<i class="bx bx-file"></i>Submit');

            return;
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
                    //   $('#Msgs').html(Response.Message);
                    // $("#Msgs").html("<div class='alert alert-success border-success'><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='lni lni-cross-circle'></i></button><strong></strong>" + Response.Message + "</div>");
                    $('#Msgs').html('');
                    swal({
                        title: "Done!",
                        text: Response.Message,
                        type: "success"
                    },
                        function () {
                            window.location.href = "Add-Balance-Bank.html";
                        });
                    //$(".modal-wrapper").removeClass("intro");
                    document.getElementById("SubmitAddBal").disabled = false;
                    $("#SubmitAddBal").html('<i class="bx bx-file"></i>Submit');
                    // location.reload('');
                }
                else {
                    // $('#Msgs').html(Response.Message);
                    // $("#Msgs").html("<div class='alert alert-warning border-warning'><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='lni lni-cross-circle'></i></button><strong></strong>" + Response.Message + "</div>");
                    $('#Msgs').html('');
                    swal({
                        title: "Sorry!",
                        text: Response.Message,
                        type: "warning"
                    });
                    //$(".modal-wrapper").removeClass("intro");

                    document.getElementById("SubmitAddBal").disabled = false;
                    $("#SubmitAddBal").html('<i class="bx bx-file"></i>Submit');
                }
            },
            error: function (err) {
                // $('#Msgs').html(err.statusText);
                //$("#Msgs").html("<div class='alert alert-warning border-warning'><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='lni lni-cross-circle'></i></button><strong></strong>" + err.statusText + "</div>");
                $('#Msgs').html('');
                swal({
                    title: "Sorry!",
                    text: Response.Message,
                    type: "warning"
                });
                //$(".modal-wrapper").removeClass("intro");

                document.getElementById("SubmitAddBal").disabled = false;
                $("#SubmitAddBal").html('<i class="bx bx-file"></i>Submit');
            }
        });

    }


}

function BindAccountDetails() {
    var mode = document.querySelector('#Paymentmode').value;
    if (mode == 'UPI') {
        mode = 'QRCode'
    } else if (mode == 'By Bank') {
        mode = 'Bank'
    }
    else {
        $("#internet-banking").hide();
        $("#TransactionBy").hide();
        $("#BankDetail_show").hide();
        $("#UPI").hide();
    }
    if (mode == "Bank")
    {
        $.ajax({
            type: "POST",
            url: "Handlers/BankDetails.ashx?Paymentmode=" + mode + "&Accountno=''&Type=1",
            /* data: $("#ChooseBank").val(),*/
            contentType: "application/json",
            dataType: "json",
            success: function (data) {
                $('#ChooseBank').empty();
                $('#ChooseBank').append("<option>Choose Bank</option>");
                for (var i = 0; i < data.length; i++) {
                    var opt = new Option(data[i].Bankname, data[i].AccountNo);
                    $('#ChooseBank').append(opt);
                    /*  $("#").append("<option value=? text=?/>");*/
                    $("#internet-banking").show();
                    $("#TransactionBy").show();
                    $("#UPI").hide();
                }
            }
        });

    }
    else if (mode == "QRCode") {
       // alert(mode);
        Bankdetails()
    }
    }

function Bankdetails() {
    var mode = document.querySelector('#Paymentmode').value;
    var Type = '';
    var Accountno = document.querySelector('#ChooseBank').value;
    if (mode == 'UPI') {
        mode = 'QRCode'
        Type = '2';
    } else if (mode == 'By Bank') {
        mode = 'Bank'
        Type = '3';
        if (Accountno == 'Choose Bank') {
            $('#BankDetail_show').hide();
        }
    }
    $.ajax({
        type: "POST",
        url: "Handlers/BankDetails.ashx?Paymentmode=" + mode + "&Accountno=" + Accountno + "&Type=" + Type,
        /* data: $("#ChooseBank").val(),*/
        contentType: "application/json",
        dataType: "json",
        success: function (OrjsonDS) {
            for (var i = 0; i < OrjsonDS.length; i++) {
                $("#txtBTCAddress").val(OrjsonDS[i].AccountNo);
                $("#NewBTC11").attr("src", OrjsonDS[i].QrCode);
                if (OrjsonDS[i].TransactionCurrency == 'QRCode') {
                    $('#ChooseBank').empty();
                    $("#BankDetail_show").hide();
                    $("#internet-banking").hide();
                    $("#TransactionBy").hide();
                    $("#UPI").show();

                } else {
                    $("#UPI").hide();
                    $("#BankDetail_show").show();
                    $("#Acc-name").html(OrjsonDS[i].BankName);
                    $("#ifsc-code").html(OrjsonDS[i].IFSCCode);
                }
            }

            //for (var i = 0; i < data.length; i++) {
            //    var opt = new Option(data[i].Bankname, data[i].AccountNo);
            //    $('#ChooseBank').append(opt);
            //    /*  $("#").append("<option value=? text=?/>");*/
            //}
        }
    });
}


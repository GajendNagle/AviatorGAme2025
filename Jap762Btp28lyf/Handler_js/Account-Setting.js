//////////
$.getJSON("Handlers/get-Profile-Details.ashx",
    function (tjson) {
        if (tjson.length == 0) {
        }
        else {
            var d = ''
            for (var i = 0; i < tjson.length; i++) {
                $('#txtFirstName').val(tjson[i].mname);
                $('#txtEmailid').val(tjson[i].email);
                $('#txtMobiUSD').val(tjson[i].mobile);
                $('#txtCity').val(tjson[i].city);
                $('#ddlcountry').val(tjson[i].Country);
                //////
                $("#txtSpeMail").html(tjson[i].SPeMail);
                $("#txtSpMob").html(tjson[i].SpMobile);
                $("#txtSPNameID").html(tjson[i].SpID);
                $("#MemName").html(tjson[i].mname);
                $("#memidrank").html(tjson[i].memid); //+"(Rank: "+tjson[i].DRANK+")");
                $('#hlat').val(tjson[i].Latitude);
                $('#hlong').val(tjson[i].Longitude);
                //$("#MemPic").attr("src","../"+tjson[i].MemPic);        
                $('#txtAccFName').val(tjson[i].AccountName);
                $("#txtBakName").val(tjson[i].bankname);
                $("#txtAccountNo").val(tjson[i].accno);
                $("#ddlAccType").val(tjson[i].BnkAccType);
                $("#txtIFSCode").val(tjson[i].IFSC);
                $("#txtPanCard").val(tjson[i].pan);
                /////
                $("#txtpaytmid").val(tjson[i].Paytm);
                $("#txtupiAddress").val(tjson[i].UPI);
                /////
                $("#txtBitcoinAddress").val(tjson[i].BitCoin);
                $("#txtEthereumAddress").val(tjson[i].Ethereum);
                $("#txtTRONAddress").val(tjson[i].TRON);
                $("#txtBUSDAddress").val(tjson[i].Binance);
                /////        
                //if (tjson[i].mname != '') {
                //    $("#txtFirstName").attr('readonly', 'readonly');
                //}
                if (tjson[i].email != '') {
                    $("#txtEmailid").attr('readonly', 'readonly');
                }
                if (tjson[i].mobile != '') {
                    $("#txtMobiUSD").attr('readonly', 'readonly');
                }
                //if (tjson[i].city != '') {
                //    $("#txtCity").attr('readonly', 'readonly');
                //}
                //if (tjson[i].Country != '') {
                //    $("#ddlcountry").prop('disabled', true);
                //}
                if (tjson[i].pan != '') {
                    $("#txtPanCard").attr('readonly', 'readonly');
                }
                if (tjson[i].TRON != '') {
                    $("#txtTRONAddress").attr('readonly', 'readonly');
                }
                if (tjson[i].Binance != '') {
                    $("#txtBUSDAddress").attr('readonly', 'readonly');
                }
                //           if (tjson[i].PerfectMoneyId !='')
                //           {
                //           $("#txtPerfect").attr('readonly','readonly');
                //           }           

                /////
                //        d = d +"<a href='javascript:;'>"+tjson[i].mname+"</a> <small>"+tjson[i].doj+", "+tjson[i].Country+"</small>";
                //        $('#BnkHdr').html(d); $('#PerHdr').html(d); $('#PMHdr').html(d); $('#LgHdr').html(d); $('#SecHdr').html(d);$('#BTCHdr').html(d);
            }
        }
    });
////////
function SavePerInfo() {

    $('#SvPInfo').html('<img src="../UserProfileImg/loading2.gif" />');
    var od = new FormData();
    var txtFirstName = $("#txtFirstName").val();
    var txtEmailid = $("#txtEmailid").val();
    var txtMobiUSD = $("#txtMobiUSD").val();
    var txtCity = $("#txtCity").val();
    var ddlcountry = $("#ddlcountry").val();
    //var referencecode= $("#txtreferencecode").val();  

    $('#SvPInfo').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-please"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');
    document.getElementById("updateDetail").disabled = true;
    $("#updateDetail").html('Please wait...');

    od.append("txtFirstName", txtFirstName);
    od.append("txtEmailid", txtEmailid);
    od.append("txtMobiUSD", txtMobiUSD);
    od.append("txtCity", txtCity);
    od.append("ddlcountry", ddlcountry);
    //od.append("referencecode", referencecode);
    $.ajax({
        url: "Handlers/Account-Settings.ashx?SaveTp=PerInfo",
        type: "POST",
        contentType: false,
        processData: false,
        data: od,
        dataType: "json",
        success: function (Response) {
            if (Response.Success) {

                $('#SvPInfo').html('');
                swal({
                    title: "Done !",
                    text: Response.Message,
                    type: "success"
                });
                $(".modal-wrapper").removeClass("intro");

                document.getElementById("updateDetail").disabled = false;
                $("#updateDetail").html('Update Detail<i class="fa-solid fa-file-import ml-2"></i>');
            }
            else {
                $('#SvPInfo').html('');
                swal({

                    title: "Alert!",
                    text: Response.Message,
                    type: "Warning",

                });
                $(".modal-wrapper").removeClass("intro");
                document.getElementById("updateDetail").disabled = false;
                $("#updateDetail").html('Update Detail<i class="fa-solid fa-file-import ml-2"></i>');
            }
        },
        error: function (err) {
            //$.messager.alert("Failed", err.statusText, 'error');
            $('#SvPInfo').html('');
            swal({
                title: "Sorry!",
                text: err.statusText,
                type: "error",
            });
            $(".modal-wrapper").removeClass("intro");
            document.getElementById("updateDetail").disabled = false;
            $("#updateDetail").html('Update Detail<i class="fa-solid fa-file-import ml-2"></i>');
        }
    });
}
////////
function SaveBitcoinInfo() {
    $('#SvBTC').html("Please enter correct BTC Address...");
    var od = new FormData();
    var txtBitcoinAddress = $("#txtBitcoinAddress").val();
    var txtBtcOtp = $("#txtBtcOtp").val();
    ///
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET", "https://blockchain.info/multiaddr?cors=true&active=" + txtBitcoinAddress, true);
    xmlhttp.send();
    ///
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            ///
            $('#SvBTC').html('<img src="../UserProfileImg/loading2.gif" />');
            /// 
            od.append("txtBitcoinAddress", txtBitcoinAddress);
            od.append("txtBtcOtp", txtBtcOtp);
            $.ajax({
                url: "Handlers/Account-Settings.ashx?SaveTp=BTCInfo",
                type: "POST",
                contentType: false,
                processData: false,
                data: od,
                dataType: "json",
                success: function (Response) {
                    if (Response.Success) {
                        if (Response.detail == 200) {

                            $('#divOtp').show();
                        }
                        else if (Response.detail == 1) {
                            $("#txtBtcOtp").val('');
                            $('#divOtp').hide();
                        }
                        $('#SvBTC').html(Response.Message);
                    }
                    else {
                        //$.messager.alert("Warning", Response.Message, 'warning');
                        $('#SvBTC').html(Response.Message);
                    }
                },
                error: function (err) {
                    //$.messager.alert("Failed", err.statusText, 'error');
                    $('#SvBTC').html(err.statusText);
                }
            });
        }
    }
}
////////////
////////
function SavePayTmInfo() {
    $('#SvPaytm').html('<img src="../UserProfileImg/loading2.gif" />');
    var od = new FormData();
    var txtpaytmid = $("#txtpaytmid").val();


    od.append("txtpaytmid", txtpaytmid);

    $.ajax({
        url: "Handlers/Account-Settings.ashx?SaveTp=SvPTM",
        type: "POST",
        contentType: false,
        processData: false,
        data: od,
        dataType: "json",
        success: function (Response) {
            if (Response.Success) {
                //$.messager.alert("Success", Response.Message, 'info');
                $('#SvPaytm').html(Response.Message);
            }
            else {
                //$.messager.alert("Warning", Response.Message, 'warning');
                $('#SvPaytm').html(Response.Message);
            }
        },
        error: function (err) {
            //$.messager.alert("Failed", err.statusText, 'error');
            $('#SvPaytm').html(err.statusText);
        }
    });
}
////////////
////////
function SaveUpiInfo() {
    $('#SvUPI').html('<img src="../UserProfileImg/loading2.gif" />');
    var od = new FormData();
    var txtupiAddress = $("#txtupiAddress").val();


    od.append("txtupiAddress", txtupiAddress);

    $.ajax({
        url: "Handlers/Account-Settings.ashx?SaveTp=SvUPI",
        type: "POST",
        contentType: false,
        processData: false,
        data: od,
        dataType: "json",
        success: function (Response) {
            if (Response.Success) {
                //$.messager.alert("Success", Response.Message, 'info');
                $('#SvUPI').html(Response.Message);
            }
            else {
                //$.messager.alert("Warning", Response.Message, 'warning');
                $('#SvUPI').html(Response.Message);
            }
        },
        error: function (err) {
            //$.messager.alert("Failed", err.statusText, 'error');
            $('#SvUPI').html(err.statusText);
        }
    });
}
////////////
function SLoginPWD() {
    //$('#SLgPWD').html('<img src="../UserProfileImg/loading2.gif" />');
    $('#SLgPWD').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');

    var od = new FormData();
    var txtoldpass = $("#txtoldpass").val();
    var txtnewpass = $("#txtnewpass").val();

    od.append("txtoldpass", txtoldpass);
    od.append("txtnewpass", txtnewpass);
    $.ajax({
        url: "Handlers/Account-Settings.ashx?SaveTp=SLgPWD",
        type: "POST",
        contentType: false,
        processData: false,
        data: od,
        dataType: "json",
        success: function (Response) {
            if (Response.Success) {
                $('#SLgPWD').html('');
                swal({
                    title: "Done!",
                    text: Response.Message,
                    type: "success"
                });
                $(".modal-wrapper").removeClass("intro");
            }
            else {

                $('#SLgPWD').html("<div class='alert alert-danger m-b-10'><strong>Sorry!</strong> " + Response.Message + "</div>");
         
                $('#SLgPWD').html('');
                swal({
                    title: "Sorry !",
                    text: Response.Message,
                    type: "warning"
                });

                $(".modal-wrapper").removeClass("intro");
            }
        },
        error: function (err) {

            $('#SLgPWD').html("<div class='alert alert-danger m-b-10'><strong>Sorry!</strong> " + err.statusText + "</div>");
            //                 $('#SLgPWD').html("<div class='alert red-skin alert-rounded'><img src='images/close-button.png'width='25' heigth='25'  alt=''> "+err.statusText+"<button type='button' class='close' data-dismiss='alert' aria-label='Close'> <span aria-hidden='true'>×</span> </button>  </div>");
            //$('#SLgPWD').html(err.statusText);
            $('#SLgPWD').html('');
            swal({
                title: "Sorry !",
                text: err.statusText,
                type: "Warning"
            });
            $(".modal-wrapper").removeClass("intro");
        }
    });
}
////////////
function SSecurityPWD() {
    $('#SSecPWD').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');


    var od = new FormData();
    var txtoldsecPWD = $("#txtoldsecPWD").val();
    var txtNewsecPWD = $("#txtNewsecPWD").val();

    od.append("txtoldsecPWD", txtoldsecPWD);
    od.append("txtNewsecPWD", txtNewsecPWD);
    $.ajax({
        url: "Handlers/Account-Settings.ashx?SaveTp=SSecPWD",
        type: "POST",
        contentType: false,
        processData: false,
        data: od,
        dataType: "json",
        success: function (Response) {
            if (Response.Success) {
                //$('#SSecPWD').html("<div class='alert alert-success m-b-10'>" + Response.Message + "</div>");
                $('#SSecPWD').html('');
                swal({
                    title: "Well !",
                    text: Response.Message,
                    type: "success"
                });
                $(".modal-wrapper").removeClass("intro");
            }
            else {
                // $('#SSecPWD').html("<div class='alert alert-danger m-b-10'><strong>Sorry!</strong> " + Response.Message + "</div>");
                $('#SSecPWD').html('');
                swal({
                    title: "Sorry !",
                    text: Response.Message,
                    type: "warning"
                });
                $(".modal-wrapper").removeClass("intro");
            }
        },
        error: function (err) {

            $('#SSecPWD').html("<div class='alert alert-danger m-b-10'><strong>Sorry!</strong> " + err.statusText + "</div>");
            $('#SSecPWD').html('');
            swal({
                title: "Sorry",
                text: Response.Message,
                type: "warning"
            });
        }
    });
}
//////////////////////////
function SaveBankInfo() {
    $('#SvBnk').html('<img src="../UserProfileImg/loading2.gif" />');
    var od = new FormData();
    var txtAccFName = $("#txtAccFName").val();
    var txtBakName = $("#txtBakName").val();
    var txtAccountNo = $("#txtAccountNo").val();
    var ddlAccType = $("#ddlAccType").val();
    var txtIFSCode = $("#txtIFSCode").val();
    var txtPanCard = $("#txtPanCard").val();

    od.append("txtAccFName", txtAccFName);
    od.append("txtBakName", txtBakName);
    od.append("txtAccountNo", txtAccountNo);
    od.append("ddlAccType", ddlAccType);
    od.append("txtIFSCode", txtIFSCode);
    od.append("txtPanCard", txtPanCard);
    $.ajax({
        url: "Handlers/Account-Settings.ashx?SaveTp=BankInfo",
        type: "POST",
        contentType: false,
        processData: false,
        data: od,
        dataType: "json",
        success: function (Response) {
            if (Response.Success) {
                //$.messager.alert("Success", Response.Message, 'info');
                $('#SvBnk').html(Response.Message);
            }
            else {
                //$.messager.alert("Warning", Response.Message, 'warning');
                $('#SvBnk').html(Response.Message);
            }
        },
        error: function (err) {
            //$.messager.alert("Failed", err.statusText, 'error');
            $('#SvBnk').html(err.statusText);
        }
    });
}
//////////////
function SaveEthereumInfo() {

    var pattern = /^0x[a-fA-F0-9]{40}$/;
    var od = new FormData();
    var txtEthereumAddress = $("#txtEthereumAddress").val();

    var txtEthOtp = $("#txtEthOtp").val();
    $('#SvETH').html('<img src="../UserProfileImg/loading2.gif" />');
    /// 

    od.append("txtEthereumAddress", txtEthereumAddress);
    od.append("txtEthOtp", txtEthOtp);
    if (pattern.test(txtEthereumAddress) && txtEthereumAddress.length == 42) {

        $.ajax({
            url: "Handlers/Account-Settings.ashx?SaveTp=ETHInfo",
            type: "POST",
            contentType: false,
            processData: false,
            data: od,
            dataType: "json",
            success: function (Response) {
                if (Response.Success) {

                    if (Response.detail == 200) {

                        $('#divethotp').show();
                    }
                    else if (Response.detail == 1) {
                        $("#txtEthOtp").val('');
                        $('#divethotp').hide();
                    }


                    $('#SvETH').html(Response.Message);
                }
                else {
                    $('#SvETH').html(Response.Message);
                }
            },
            error: function (err) {
                $('#SvETH').html(err.statusText);
            }
        });
    }
    else {

        $('#SvETH').html("<span style='color:red;font-size:18px;' >Invalid Address format</span>");
    }


}
function SaveBinanceInfo() {
    $('#SvBNB').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');

    document.getElementById("submitBNBadd").disabled = true;
    $("#submitBNBadd").html('Please Wait...');

    var pattern = /^0x[a-fA-F0-9]{40}$/;
    var od = new FormData();
    var txtBinanceAddress = $("#txtBinanceAddress").val();
    var txtBnbOtp = $("#txtBnbOtp").val();

    od.append("txtBinanceAddress", txtBinanceAddress);
    od.append("txtBnbOtp", txtBnbOtp);
    if (pattern.test(txtBinanceAddress) && txtBinanceAddress.length == 42) {
        $.ajax({
            url: "Handlers/Account-Settings.ashx?SaveTp=BNBInfo",
            type: "POST",
            contentType: false,
            processData: false,
            data: od,
            dataType: "json",
            success: function (Response) {
                if (Response.Success) {
                    if (Response.detail == 200) {
                        $('#SvBNB').html('');
                        $('.divotp').removeClass('d-none');
                        swal({
                            title: "Sent!",
                            text: Response.Message,
                            type: "success"
                        });
                        document.getElementById("submitBNBadd").disabled = false;
                        $("#submitBNBadd").html('Submit<i class="fa fa-sign-in-alt ml-1"></i>');
                    }
                    else if (Response.detail == 1) {
                        $('#SvBNB').html('');
                        $("#txtBnbOtp").val('');
                        $('.divotp').addClass('d-none');
                        swal({
                            title: "Done!",
                            text: Response.Message,
                            type: "success"
                        });
                        document.getElementById("submitBNBadd").disabled = false;
                        $("#submitBNBadd").html('Submit<i class="fa fa-sign-in-alt ml-1"></i>');
                    }
                }
                else {
                    $('#SvBNB').html('');
                    swal({
                        title: "Sorry!",
                        text: Response.Message,
                        type: "warning"
                    });
                    document.getElementById("submitBNBadd").disabled = false;
                    $("#submitBNBadd").html('Submit<i class="fa fa-sign-in-alt ml-1"></i>');
                }
            },
            error: function (err) {
                $('#SvBNB').html('');
                swal({
                    title: "Sorry!",
                    text: Response.Message,
                    type: "warning"
                });
                document.getElementById("submitBNBadd").disabled = false;
                $("#submitBNBadd").html('Submit<i class="fa fa-sign-in-alt ml-1"></i>');
            }
        });
    }
    else {
        $('#SvBNB').html('');
        swal({
            title: "Sorry!",
            text: "Invalid Address format",
            type: "warning"
        });
        document.getElementById("submitBNBadd").disabled = false;
        $("#submitBNBadd").html('Submit<i class="fa fa-sign-in-alt ml-1"></i>');
    }
}

function SaveTRONInfo() {

    $('#SvTRX').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');

    document.getElementById("submitTronadd").disabled = true;
    $("#submitTronadd").html('Please wait...');

    var od = new FormData();
    var txtTronAddress = $("#txtTRONAddress").val();
    var txtTrxOtp = $("#txtTRXOtp").val();
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.open("GET", "https://apilist.tronscan.org/api/account?address=" + txtTronAddress, true);
    xmlhttp.send();
    ///
    // alert(xmlhttp);
    xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            var jsontext = xmlhttp.responseText;
            var data = JSON.parse(jsontext);
            //  $.get("https://apilist.tronscan.org/api/transaction?sort=-timestamp&count=true&limit=10&start=0&address=" + txtTronAddress).done(function (a) {
            $('#txtTRXAdds').val(data.address); 
            od.append("txtTronAddress", txtTronAddress);
            od.append("txtTrxOtp", txtTrxOtp);
            $.ajax({
                url: "Handlers/Account-Settings.ashx?SaveTp=TRXInfo",
                type: "POST",
                contentType: false,
                processData: false,
                data: od,
                dataType: "json",
                success: function (Response) {
                    if (Response.Success) {
                        if (Response.detail == 200) {
                            $('#SvTRX').html('');
                            $('#divTRXOtp').show();
                            swal({
                                title: "Sent!",
                                text: Response.Message,
                                type: "success"
                            });
                            document.getElementById("submitTronadd").disabled = false;
                            $("#submitTronadd").html('Submit<i class="fa-solid fa-right-to-bracket ml-2"></i>');
                        }
                        else if (Response.detail == 1) {
                            $("#txtTRXOtp").val('');
                            $('#divTRXOtp').hide();
                            $('#SvTRX').html('');
                            swal({
                                title: "Welldone!",
                                text: Response.Message,
                                type: "success"
                            },
                                function () {
                                    window.location.reload();
                                });

                            document.getElementById("submitTronadd").disabled = false;
                            $("#submitTronadd").html('Submit<i class="fa-solid fa-right-to-bracket ml-2"></i>');
                        } 
                    }
                    else {
                        $('#SvTRX').html('');
                        swal({
                            title: "This try later!",
                            text: Response.Message,
                            type: "warning"
                        });

                        document.getElementById("submitTronadd").disabled = false;
                        $("#submitTronadd").html('Submit<i class="fa-solid fa-right-to-bracket ml-2"></i>');
                    }
                },
                error: function (err) {
                    $('#SvTRX').html('');
                    swal({
                        title: "Sorry!",
                        text: err.statusText,
                        type: "warning"
                    });

                    document.getElementById("submitTronadd").disabled = false;
                    $("#submitTronadd").html('Submit<i class="fa-solid fa-right-to-bracket ml-2"></i>');
                }
            });
            //}
        }
    }
}

$(function () {
    var txt = $("#txtBitcoinAddress");
    var func = function () {
        txt.val(txt.val().replace(/\s/g, ''));
    }
    txt.keyup(func).blur(func);
});
$(function () {
    var txt = $("#txtEthereumAddress");
    var func = function () {
        txt.val(txt.val().replace(/\s/g, ''));
    }
    txt.keyup(func).blur(func);
});
$(function () {
    var txt = $("#txtTRONAddress");
    var func = function () {
        txt.val(txt.val().replace(/\s/g, ''));
    }
    txt.keyup(func).blur(func);
});


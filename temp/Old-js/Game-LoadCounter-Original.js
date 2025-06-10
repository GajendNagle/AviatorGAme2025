////function DashboardSummary() {

////    $.getJSON('Handlers/Inner_Page_Summary.ashx',
////        function (OrjsonDS) {
////            if (OrjsonDS.length == 0) {
////            }
////            else {
////                var wa = '';
////                for (var i = 0; i < OrjsonDS.length; i++) {

////                    $('#txtMobiUSD').html(OrjsonDS[i].Mobile);
////                    $('#txtMobiUSD1').html(OrjsonDS[i].Mobile);
////                    $('#RefLink1').html('https://redrakegame.com/ref/' + OrjsonDS[i].MemID);
////                    $('#Mem_Name').html(OrjsonDS[i].Mem_Name);
////                    $('#GMwalletBalance').html(OrjsonDS[i].cWalletBal + " TRX");
////                    $('#gmwltbal').html(OrjsonDS[i].GMWalletBal);
////                    $('#gmwltbalnc').html(OrjsonDS[i].cWalletBal);
////                    $('#MemberId').html(OrjsonDS[i].MemID);
////                    $('#prof_pic').attr('src', "../../" + OrjsonDS[i].Mem_Profl_Pic + "");

////                
////            }
////        });
////}
//////////
function loadjackpot(Type) {
    //alert(1);
    $.getJSON('Handlers/Get-Jackpot-Member.ashx?type=' + Type,
        function (OrjsonDS) {
            if (OrjsonDS.length == 0) {
            }
            else {
                /*   $('#gameContainer').load(' #gameContainer');*/
                parent.location.reload();
                //var wa = '';
                //for (var i = 0; i < OrjsonDS.length; i++) {
                //   // $('#jackportno').val(OrjsonDS[i].JackpotNo);
                //    //$('#txtbanner').val(OrjsonDS[i].Banner);
                //    // $('#txtbanner').val(OrjsonDS[i].Banner);


                //}
            }
        });
}

/*1min Parity*/
function Showcounttime() {
    //var newTime = new Date().toISOString().substring(0, 19).replace('T', ' ');//2023 - 04 - 05 12: 51: 49
    //$('#storetimer').val(newTime);
    $.getJSON('Handlers/Getcount-Timer.ashx?type=fastparity',
        function (OrjsonDS) {
            if (OrjsonDS.length == 0) {
            }
            else {
                for (var i = 0; i < OrjsonDS.length; i++) {
                    ///
                    $('#jackportno').val(OrjsonDS[i].JackptNo);
                    $('#Fastparityno').html(OrjsonDS[i].JackptNo);
                    $('#storetimer').val(OrjsonDS[i].PHDate);

                    if (OrjsonDS[i].JackptNo == 0) {
                        $('#submitplaynow').attr('disabled', 'disabled');
                    }
                    else {
                        $('#submitplaynow').removeAttr('disabled');
                    }
                    ///
                    parity1minrslt();
                    Everyonsordr();
                    ///
                }

            }
        });
}
function Save_JackpotParticipate() {
    if ($("#checkbox").prop('checked') == false) {
        swal({
            title: "Sorry!",
            text: "Please read & accept pre-sale Rules!",
            type: "warning"
        });
        return;
    }
    //$('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');
    document.getElementById("submitplaynow").disabled = true;
    $("#submitplaynow").html('Please wait...');

    var txtplayAmt = $('#fastparitamt').val();
    /* var txttxnpass = $("#txnpass").val();*/
    var txtjackptno = $("#jackportno").val();
    var Tradingtype = "";///$("#Tradingtype").val();
    var gmclr = $('#gameclr').val();
    var gmnum = $('#gamenum').val();
    var gmBigSmall = $('#gameBigSmall').val();
    var gametype = 'Parity1min';
    var Type = "";

    if (gmclr != "") {
        Tradingtype = gmclr;
        Type = 'Color';
    }
    else if (gmBigSmall != "") {
        Tradingtype = gmBigSmall;
        Type = 'BigSmall';
    }
    else if (gmnum != "") {
        Tradingtype = gmnum;
        Type = 'Number';
    }
    var od = new FormData();

    od.append("txtplayAmt", txtplayAmt);
    /*od.append("txttxnpass", txttxnpass);*/
    od.append("txtjackptno", txtjackptno);
    od.append("Tradingtype", Tradingtype);
    od.append("Type", Type);
    od.append("gametype", gametype);


    if (txtjackptno == '') {
        document.getElementById("submitplaynow").disabled = false;
        $("#submitplaynow").html('Confirm');
        return
    }
    if (txtplayAmt > 0) {
        $.ajax({
            url: "Handlers/Mem-Jackpot-Participate.ashx?Plytyp=" + gametype,
            type: "POST",
            contentType: false,
            processData: false,
            data: od,
            dataType: "json",
            success: function (Response) {
                if (Response.Success) {
                    //$('#Msgs').html('');
                    swal({
                        title: "Congratulation!",
                        text: Response.Message,
                        type: "success"
                    });
                    document.getElementById("submitplaynow").disabled = false;
                    $("#submitplaynow").html('Confirm');
                    $('#fparitymodal').modal('hide');
                    sessionStorage.setItem('showModal', true);

                }
                else {
                    //$('#Msgs').html('');
                    swal({
                        title: "alert!",
                        text: Response.Message,
                        type: "warning"
                    });

                    document.getElementById("submitplaynow").disabled = false;
                    $("#submitplaynow").html('Confirm');
                }
            },
            error: function (err) {
                //$('#Msgs').html('');
                swal({
                    title: "Ooops!",
                    text: err.statusText,
                    type: "error"
                });
                document.getElementById("submitplaynow").disabled = false;
                $("#submitplaynow").html('Confirm');
            }
        });
    }
    else {
        swal({
            title: "Alert!",
            text: "Sorry, your play amount is less. Please choose correct amount!",
            type: "warning"
        });
        document.getElementById("submitplaynow").disabled = false;
        $('#submitplaynow').html('Confirm');
    }
}
function parity1minrslt() {
    /*  $('#fastparityrslt').load("Handlers/Game-Common-Values.ashx?Vs=jackpotwindd");*/
    var showModal = sessionStorage.getItem('showModal');
    if (showModal) {
        $('#rsltmodal').modal("show");
        sessionStorage.removeItem('showModal');
        /////

        $.getJSON('Handlers/Game-Common-Values.ashx?Vs=MyResult1min',
            function (OrjsonDS) {
                if (OrjsonDS.length == 0) {
                }
                else {

                    for (var i = 0; i < OrjsonDS.length; i++) {

                        //[{ "JackpotNo": "1096989", "MemID": "Leno88374227", "Selecttype": "9", "plyAmt": "50", "Point": "50", "Status": "LOSS", "ReslColor": "RED", "RsltNumber": "4", "RsltBigSmall": "SMALL" }]
                        //==================jackpotno==================
                        $('#rsltorderid').html(OrjsonDS[i].JackpotNo);
                        //==================color/no/bigsmall==================
                        if (OrjsonDS[i].ReslColor == 'GREEN') {
                            $('#rsltcolor').html("<span class= 'rgreen reciptc'>" + OrjsonDS[i].ReslColor + "</span>");
                            $('#rsltbigsmall').html("<span class= 'rgreen reciptc'>" + OrjsonDS[i].RsltBigSmall + "</span>");
                            $('#rsltnum').html("<span class= 'rgreen reciptno'>" + OrjsonDS[i].RsltNumber + "</span>");
                        }
                        else if (OrjsonDS[i].ReslColor == 'RED') {
                            $('#rsltcolor').html("<span class= 'rred reciptc'>" + OrjsonDS[i].ReslColor + "</span>");
                            $('#rsltbigsmall').html("<span class= 'rred reciptc'>" + OrjsonDS[i].RsltBigSmall + "</span>");
                            $('#rsltnum').html("<span class= 'rred reciptno'>" + OrjsonDS[i].RsltNumber + "</span>");
                        }
                        else if (OrjsonDS[i].ReslColor == 'VIOLET') {
                            $('#rsltcolor').html("<span class= 'rviolet reciptc'>" + OrjsonDS[i].ReslColor + "</span>");
                            $('#rsltbigsmall').html("<span class= 'rviolet reciptc'>" + OrjsonDS[i].RsltBigSmall + "</span>");
                            $('#rsltnum').html("<span class= 'rviolet reciptno'>" + OrjsonDS[i].RsltNumber + "</span>");
                        }
                        else if (OrjsonDS[i].ReslColor == 'RED & VIOLET') {
                            $('#rsltcolor').html("<span class= 'rredviolet reciptc'>" + OrjsonDS[i].ReslColor + "</span>");
                            $('#rsltbigsmall').html("<span class=' rredviolet reciptc'>" + OrjsonDS[i].RsltBigSmall + "</span>");
                            $('#rsltnum').html("<span class= 'rredviolet reciptno'>" + OrjsonDS[i].RsltNumber + "</span>");
                        }
                        else if (OrjsonDS[i].ReslColor == 'GREEN & VIOLET') {
                            $('#rsltcolor').html("<span class= 'rgreenviolet reciptc'>" + OrjsonDS[i].ReslColor + "</span>");
                            $('#rsltbigsmall').html("<span class= 'rgreenviolet reciptc'>" + OrjsonDS[i].RsltBigSmall + "</span>");
                            $('#rsltnum').html("<span class= 'rgreenviolet reciptno'>" + OrjsonDS[i].RsltNumber + "</span>");
                        }

                        //================loss/win===============
                        $('#plyAmt').html(OrjsonDS[i].plyAmt);
                        $('#rsltitle').html(OrjsonDS[i].Status);
                        if (OrjsonDS[i].Status == 'LOSS') {
                            $('#RsltAmt').html('-' + OrjsonDS[i].Point);
                            $('#modal-contentwr').css("background-image", " url('img/game-index-icons/new-loss-2.png')");
                            $('.lottery-result1,#rsltitle').css({ "color": "#000", "font-weight": "600" });
                        }
                        else {
                            $('#RsltAmt').html('+' + OrjsonDS[i].Point);
                            $('#modal-contentwr').css("background-image", " url('img/game-index-icons/new-win-2.png')");
                            $('.lottery-result1,#rsltitle').css({ "color": "#fff", "font-weight": "600" });
                            $('#rsltitle').css({ "color": "#fff", "font-weight": "600" });
                        }

                    }
                }
            });
    }
}
function Everyonsordr() {
    $('#Everyonsordr').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
    $('#Everyonsordr').load("Handlers/Game-Common-Values.ashx?Vs=Everyonsorder");
}
function Myorder() {
    $('#Myorder').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
    $('#Myorder').load("Handlers/Game-Common-Values.ashx?Vs=Myorder");
}
////////////////////

/*3min Parity*/
function Save_ParityParticipate3min() {
    if ($("#checkbox").prop('checked') == false) {
        swal({
            title: "Sorry!",
            text: "Please read & accept pre-sale Rules!",
            type: "warning"
        });
        return;
    }
    //$('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');
    document.getElementById("submitplaynow").disabled = true;
    $("#submitplaynow").html('Please wait...');

    var txtplayAmt = $('#fastparitamt').val();
    /* var txttxnpass = $("#txnpass").val();*/
    var txtjackptno = $("#jackportno").val();
    var Tradingtype = "";///$("#Tradingtype").val();
    var gmclr = $('#gameclr').val();
    var gmnum = $('#gamenum').val();
    var gmBigSmall = $('#gameBigSmall').val();
    var gametype = 'Parity3min';
    var Type = "";

    if (gmclr != "") {
        Tradingtype = gmclr;
        Type = 'Color';
    }
    else if (gmBigSmall != "") {
        Tradingtype = gmBigSmall;
        Type = 'BigSmall';
    }
    else if (gmnum != "") {
        Tradingtype = gmnum;
        Type = 'Number';
    }

    var od = new FormData();
    od.append("txtplayAmt", txtplayAmt);
    /*   od.append("txttxnpass", txttxnpass);*/
    od.append("txtjackptno", txtjackptno);
    od.append("Tradingtype", Tradingtype);
    od.append("Type", Type);
    od.append("gametype", gametype);
    ///    alert(txtjackptno);

    if (txtjackptno == '') {
        document.getElementById("submitplaynow").disabled = false;
        $("#submitplaynow").html('Confirm');
        return
    }
    if (txtplayAmt > 0) {
        $.ajax({
            url: "Handlers/Mem-Jackpot-Participate.ashx?Plytyp=" + gametype,
            type: "POST",
            contentType: false,
            processData: false,
            data: od,
            dataType: "json",
            success: function (Response) {
                if (Response.Success) {
                    //$('#Msgs').html('');
                    swal({
                        title: "Congratulation!",
                        text: Response.Message,
                        type: "success"
                    });
                    document.getElementById("submitplaynow").disabled = false;
                    $("#submitplaynow").html('Confirm');
                    $('#fparitymodal').modal('hide');
                    sessionStorage.setItem('showModalParity', true);
                }
                else {
                    //$('#Msgs').html('');
                    swal({
                        title: "alert!",
                        text: Response.Message,
                        type: "warning"
                    });
                    document.getElementById("submitplaynow").disabled = false;
                    $("#submitplaynow").html('Confirm');
                }
            },
            error: function (err) {
                //$('#Msgs').html('');
                swal({
                    title: "Ooops!",
                    text: err.statusText,
                    type: "error"
                });
                document.getElementById("submitplaynow").disabled = false;
                $("#submitplaynow").html('Confirm');

            }
        });
    }
    else {
        swal({
            title: "Alert!",
            text: "Sorry, your play amount is less. Please choose correct amount!",
            type: "warning"
        });
        document.getElementById("submitplaynow").disabled = false;
        $('#submitplaynow').html('Confirm');
    }
    return true;

}
function Showcounttime3min() {

    //var newTime = new Date().toISOString().substring(0, 19).replace('T', ' ');//2023 - 04 - 05 12: 51: 49
    //$('#storetimer').val(newTime);
    $.getJSON('Handlers/Getcount-Timer.ashx?type=Parity',
        function (OrjsonDS) {
            if (OrjsonDS.length == 0) {
            }
            else {
                for (var i = 0; i < OrjsonDS.length; i++) {
                    ///
                    $('#jackportno').val(OrjsonDS[i].JackptNo);
                    $('#Fastparityno').html(OrjsonDS[i].JackptNo);
                    $('#storetimer').val(OrjsonDS[i].PHDate);


                    if (OrjsonDS[i].JackptNo == 0) {
                        $('#submitplaynow').attr('disabled', 'disabled');
                    }
                    else {
                        $('#submitplaynow').removeAttr('disabled');
                    }
                    ///
                    parity3minrslt();
                    Everyonsordr3min();
                    ///
                }
            }
        });
}
function parity3minrslt() {

    /*$('#parityrslt').load("Handlers/Game-Parity-Values.ashx?Vs=ParitywinRslt");*/

    var showModalparity = sessionStorage.getItem('showModalParity');

    if (showModalparity) {

        $('#rsltmodal').modal("show");
        sessionStorage.removeItem('showModalParity');

        $.getJSON('Handlers/Game-Common-Values.ashx?Vs=MyResult3min',
            function (OrjsonDS) {
                if (OrjsonDS.length == 0) {
                }
                else {

                    for (var i = 0; i < OrjsonDS.length; i++) {

                        $('#rsltorderid').html(OrjsonDS[i].JackpotNo);
                        //==================color/no/bigsmall==================
                        if (OrjsonDS[i].ReslColor == 'GREEN') {
                            $('#rsltcolor').html("<span class= 'rgreen reciptc'>" + OrjsonDS[i].ReslColor + "</span>");
                            $('#rsltbigsmall').html("<span class= 'rgreen reciptc'>" + OrjsonDS[i].RsltBigSmall + "</span>");
                            $('#rsltnum').html("<span class= 'rgreen reciptno'>" + OrjsonDS[i].RsltNumber + "</span>");
                        }
                        else if (OrjsonDS[i].ReslColor == 'RED') {
                            $('#rsltcolor').html("<span class= 'rred reciptc'>" + OrjsonDS[i].ReslColor + "</span>");
                            $('#rsltbigsmall').html("<span class= 'rred reciptc'>" + OrjsonDS[i].RsltBigSmall + "</span>");
                            $('#rsltnum').html("<span class= 'rred reciptno'>" + OrjsonDS[i].RsltNumber + "</span>");
                        }
                        else if (OrjsonDS[i].ReslColor == 'VIOLET') {
                            $('#rsltcolor').html("<span class= 'rviolet reciptc'>" + OrjsonDS[i].ReslColor + "</span>");
                            $('#rsltbigsmall').html("<span class= 'rviolet reciptc'>" + OrjsonDS[i].RsltBigSmall + "</span>");
                            $('#rsltnum').html("<span class= 'rviolet reciptno'>" + OrjsonDS[i].RsltNumber + "</span>");
                        }
                        else if (OrjsonDS[i].ReslColor == 'RED & VIOLET') {
                            $('#rsltcolor').html("<span class= 'rredviolet reciptc'>" + OrjsonDS[i].ReslColor + "</span>");
                            $('#rsltbigsmall').html("<span class=' rredviolet reciptc'>" + OrjsonDS[i].RsltBigSmall + "</span>");
                            $('#rsltnum').html("<span class= 'rredviolet reciptno'>" + OrjsonDS[i].RsltNumber + "</span>");
                        }
                        else if (OrjsonDS[i].ReslColor == 'GREEN & VIOLET') {
                            $('#rsltcolor').html("<span class= 'rgreenviolet reciptc'>" + OrjsonDS[i].ReslColor + "</span>");
                            $('#rsltbigsmall').html("<span class= 'rgreenviolet reciptc'>" + OrjsonDS[i].RsltBigSmall + "</span>");
                            $('#rsltnum').html("<span class= 'rgreenviolet reciptno'>" + OrjsonDS[i].RsltNumber + "</span>");
                        }

                        //================loss/win===============
                        $('#plyAmt').html(OrjsonDS[i].plyAmt);
                        $('#rsltitle').html(OrjsonDS[i].Status);
                        if (OrjsonDS[i].Status == 'LOSS') {
                            $('#RsltAmt').html('-' + OrjsonDS[i].Point);
                            $('#modal-contentwr').css("background-image", " url('img/game-index-icons/new-loss-2.png')");
                            $('.lottery-result1,#rsltitle').css({ "color": "#000", "font-weight": "600" });
                        }
                        else {
                            $('#RsltAmt').html('+' + OrjsonDS[i].Point);
                            $('#modal-contentwr').css("background-image", " url('img/game-index-icons/new-win-2.png')");
                            $('.lottery-result1,#rsltitle').css({ "color": "#fff", "font-weight": "600" });
                            $('#rsltitle').css({ "color": "#fff", "font-weight": "600" });
                        }

                    }
                }
            });
    }
}
function Everyonsordr3min() {
    $('#Everyonsordr3min').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
    $('#Everyonsordr3min').load("Handlers/Game-Common-Values.ashx?Vs=Everyonsorder3min");
}
function Myorder3min() {
    $('#Myorder3min').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
    $('#Myorder3min').load("Handlers/Game-Common-Values.ashx?Vs=Myorder3min");
}
/////////////////////////

/*5min Parity*/
function Save_ParityParticipate5min() {

    //$('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');

    document.getElementById("submitplaynow").disabled = true;
    $("#submitplaynow").html('Please wait...');
    if ($("#checkbox").prop('checked') == false) {
        swal({
            title: "Sorry!",
            text: "Please read & accept pre-sale Rules!",
            type: "warning"
        });
        return;
    }
    var txtplayAmt = $('#fastparitamt').val();
    /* var txttxnpass = $("#txnpass").val();*/
    var txtjackptno = $("#jackportno").val();
    var Tradingtype = "";///$("#Tradingtype").val();
    var gmclr = $('#gameclr').val();
    var gmnum = $('#gamenum').val();
    var gmBigSmall = $('#gameBigSmall').val();
    var gametype = 'Parity5min';
    var Type = "";

    if (gmclr != "") {
        Tradingtype = gmclr;
        Type = 'Color';
    }
    else if (gmBigSmall != "") {
        Tradingtype = gmBigSmall;
        Type = 'BigSmall';
    }
    else if (gmnum != "") {
        Tradingtype = gmnum;
        Type = 'Number';
    }


    var od = new FormData();

    od.append("txtplayAmt", txtplayAmt);
    /*   od.append("txttxnpass", txttxnpass);*/
    od.append("txtjackptno", txtjackptno);
    od.append("Tradingtype", Tradingtype);
    od.append("Type", Type);
    od.append("gametype", gametype);
    ///    alert(txtjackptno);
    if (txtjackptno == '') {
        document.getElementById("submitplaynow").disabled = false;
        $("#submitplaynow").html('Confirm');
        return
    }
    if (txtplayAmt > 0) {
        $.ajax({
            url: "Handlers/Mem-Jackpot-Participate.ashx?Plytyp=" + gametype,
            type: "POST",
            contentType: false,
            processData: false,
            data: od,
            dataType: "json",
            success: function (Response) {
                if (Response.Success) {
                    //$('#Msgs').html('');
                    swal({
                        title: "Congratulation!",
                        text: Response.Message,
                        type: "success"
                    });
                    document.getElementById("submitplaynow").disabled = false;
                    $("#submitplaynow").html('Confirm');
                    $('#fparitymodal').modal('hide');
                    sessionStorage.setItem('showModal', true);
                }
                else {
                    //$('#Msgs').html('');
                    swal({
                        title: "alert!",
                        text: Response.Message,
                        type: "warning"
                    });
                    document.getElementById("submitplaynow").disabled = false;
                    $("#submitplaynow").html('Confirm');
                }
            },
            error: function (err) {
                //$('#Msgs').html('');
                swal({
                    title: "Ooops!",
                    text: err.statusText,
                    type: "error"
                });
                document.getElementById("submitplaynow").disabled = false;
                $("#submitplaynow").html('Confirm');
            }
        });
    }
    else {
        swal({
            title: "Alert!",
            text: "Sorry, your play amount is less. Please choose correct amount!",
            type: "warning"
        });
        document.getElementById("submitplaynow").disabled = false;
        $("#submitplaynow").html('Confirm');
    }

}
function Show5minparitycounttime() {

    //var newTime = new Date().toISOString().substring(0, 19).replace('T', ' ');//2023 - 04 - 05 12: 51: 49
    //$('#storetimer').val(newTime);
    $.getJSON('Handlers/Getcount-Timer.ashx?type=Parity5min',
        function (OrjsonDS) {
            if (OrjsonDS.length == 0) {
            }
            else {
                for (var i = 0; i < OrjsonDS.length; i++) {
                    ///
                    $('#jackportno').val(OrjsonDS[i].JackptNo);
                    $('#Fastparityno').html(OrjsonDS[i].JackptNo);
                    $('#storetimer').val(OrjsonDS[i].PHDate);

                    if (OrjsonDS[i].JackptNo == 0) {
                        $('#submitplaynow').attr('disabled', 'disabled');
                    }
                    else {
                        $('#submitplaynow').removeAttr('disabled');
                    }

                }
            }
        });
}
function Everyonsordr5min() {
    $('#Everyonsordr5min').load("Handlers/Game-Common-Values.ashx?Vs=Everyonsordr5min");
}
function parityr5minslt() {

    $('#parity5minrslt').load("Handlers/Game-Common-Values.ashx?Vs=Parity5minwinRslt");
}
function Myorder5min() {
    $('#Myorder5min').load("Handlers/Game-Common-Values.ashx?Vs=Myorder5min");
}
///////////////////////

/*10min Parity*/
function Save_ParityParticipate10min() {

    //$('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');

    document.getElementById("submitplaynow").disabled = true;
    $("#submitplaynow").html('Please wait...');
    if ($("#checkbox").prop('checked') == false) {
        swal({
            title: "Sorry!",
            text: "Please read & accept pre-sale Rules!",
            type: "warning"
        });
        return;
    }

    var txtplayAmt = $('#fastparitamt').val();
    /* var txttxnpass = $("#txnpass").val();*/
    var txtjackptno = $("#jackportno").val();
    var Tradingtype = "";///$("#Tradingtype").val();
    var gmclr = $('#gameclr').val();
    var gmnum = $('#gamenum').val();
    var gmBigSmall = $('#gameBigSmall').val();
    var gametype = 'Parity10min';
    var Type = "";

    if (gmclr != "") {
        Tradingtype = gmclr;
        Type = 'Color';
    }
    else if (gmBigSmall != "") {
        Tradingtype = gmBigSmall;
        Type = 'BigSmall';
    }
    else if (gmnum != "") {
        Tradingtype = gmnum;
        Type = 'Number';
    }



    var od = new FormData();

    od.append("txtplayAmt", txtplayAmt);
    /*   od.append("txttxnpass", txttxnpass);*/
    od.append("txtjackptno", txtjackptno);
    od.append("Tradingtype", Tradingtype);
    od.append("Type", Type);
    od.append("gametype", gametype);
    ///    alert(txtjackptno);
    if (txtjackptno == '') {
        document.getElementById("submitplaynow").disabled = false;
        $("#submitplaynow").html('Confirm');
        return
    }
    if (txtplayAmt > 0) {
        $.ajax({
            url: "Handlers/Mem-Jackpot-Participate.ashx?Plytyp=" + gametype,
            type: "POST",
            contentType: false,
            processData: false,
            data: od,
            dataType: "json",
            success: function (Response) {
                if (Response.Success) {
                    //$('#Msgs').html('');
                    swal({
                        title: "Congratulation!",
                        text: Response.Message,
                        type: "success"
                    });
                    document.getElementById("submitplaynow").disabled = false;
                    $("#submitplaynow").html('Confirm');
                    $('#fparitymodal').modal('hide');
                    sessionStorage.setItem('showModal', true);
                }
                else {
                    //$('#Msgs').html('');
                    swal({
                        title: "alert!",
                        text: Response.Message,
                        type: "warning"
                    });
                    document.getElementById("submitplaynow").disabled = false;
                    $("#submitplaynow").html('Confirm');
                }
            },
            error: function (err) {
                //$('#Msgs').html('');
                swal({
                    title: "Ooops!",
                    text: err.statusText,
                    type: "error"
                });
                document.getElementById("submitplaynow").disabled = false;
                $("#submitplaynow").html('Confirm');
            }
        });
    }
    else {
        swal({
            title: "Alert!",
            text: "Sorry, your play amount is less. Please choose correct amount!",
            type: "warning"
        });
        document.getElementById("submitplaynow").disabled = false;
        $("#submitplaynow").html('Confirm');
    }
}
function Show10minparitycounttime() {

    //var newTime = new Date().toISOString().substring(0, 19).replace('T', ' ');//2023 - 04 - 05 12: 51: 49
    //$('#storetimer').val(newTime);
    $.getJSON('Handlers/Getcount-Timer.ashx?type=Parity10min',
        function (OrjsonDS) {
            if (OrjsonDS.length == 0) {
            }
            else {
                for (var i = 0; i < OrjsonDS.length; i++) {
                    ///
                    $('#jackportno').val(OrjsonDS[i].JackptNo);
                    $('#Fastparityno').html(OrjsonDS[i].JackptNo);
                    $('#storetimer').val(OrjsonDS[i].PHDate);

                    if (OrjsonDS[i].JackptNo == 0) {
                        $('#submitplaynow').attr('disabled', 'disabled');
                    }
                    else {
                        $('#submitplaynow').removeAttr('disabled');
                    }

                }
            }
        });
}
function Everyonsordr10min() {
    $('#Everyonsordr10min').load("Handlers/Game-Common-Values.ashx?Vs=Everyonsordr10min");
}
function parityr10minslt() {

    $('#parity10minrslt').load("Handlers/Game-Common-Values.ashx?Vs=Parity10minwinRslt");
}
function Myorder10min() {
    $('#Myorder10min').load("Handlers/Game-Common-Values.ashx?Vs=Myorder10min");
}
//////////////////////

function carouselwinId() {
    $('#carouselwinId').load("Handlers/Game-Common-Values.ashx?Vs=carouselwinId");
}
function carouselwinIdscnd() {
    $('#carouselwinIdscnd').load("Handlers/Game-Common-Values.ashx?Vs=carouselwinIdscnd");
}
function Everyonsordrparity() {
    $('#Everyonsordrparity').load("Handlers/Game-Common-Values.ashx?Vs=Everyonsordrparity");
}
function MyorderParity() {
    $('#MyorderParity').load("Handlers/Game-Common-Values.ashx?Vs=MyorderParity");
}
function getgamevalue(item) {
    updateValues();
    //var gmclr = item;//document.getElementById("chsclr").href;    
    if (item == 'Green') {
        $('#gameclr').val(item);
        $('#gamenum').val("");
        $('#gameBigSmall').val("");

        $('#parityval').html("<span style='color: rgb(0, 194, 130); font-weight:bold'>" + item + "</span>");
        $('#bg-themes').css("background", "rgb(0, 194, 130)");
        $('#submitplaynow').css("background", "rgb(0, 194, 130)");
        $('#btnbg1').css("background", "rgb(0, 194, 130)");
        $('#btnbg2').css("background", "rgb(0, 194, 130)");

    }
    else if (item == 'Red') {
        $('#gameclr').val(item);
        $('#gamenum').val("");
        $('#gameBigSmall').val("");

        $('#parityval').html("<span style='color:rgb(250, 60, 9);font-weight:bold'>" + item + "</span>");
        $('#bg-themes').css("background", "rgb(250, 60, 9)");
        $('#submitplaynow').css("background", "rgb(250, 60, 9)");
        $('#btnbg1').css("background", "rgb(250, 60, 9)");
        $('#btnbg2').css("background", "rgb(250, 60, 9)");
        $('#parityvalcolor').html("<span style='color:rgb(250, 60, 9);font-weight:bold'>" + item + "</span>");
    }
    else if (item == 'Violet') {
        $('#gameclr').val(item);
        $('#gamenum').val("");
        $('#gameBigSmall').val("");

        $('#parityval').html("<span style='color:rgb(102, 85, 211);font-weight:bold'>" + item + "</span>");
        $('#bg-themes').css("background", "rgb(102, 85, 211)");
        $('#submitplaynow').css("background", "rgb(102, 85, 211)");
        $('#btnbg1').css("background", "rgb(102, 85, 211)");
        $('#btnbg2').css("background", "rgb(102, 85, 211)");
    }
    else if (item == 'Big') {
        $('#gameBigSmall').val(item);
        $('#gamenum').val("");
        $('#gameclr').val("");

        $('#parityval').html("<span style='color:#ffa82e;font-weight:bold'>" + item + "</span>");
        $('#bg-themes').css("background", "#ffa82e");
        $('#submitplaynow').css("background", "#ffa82e");
        $('#btnbg1').css("background", "#ffa82e");
        $('#btnbg2').css("background", "#ffa82e");
    }
    else if (item == 'Small') {
        $('#gameBigSmall').val(item);
        $('#gamenum').val("");
        $('#gameclr').val("");

        $('#parityval').html("<span style='color:#6da7f4;font-weight:bold'>" + item + "</span>");
        $('#bg-themes').css("background", "#6da7f4");
        $('#submitplaynow').css("background", "#6da7f4");
        $('#btnbg1').css("background", "#6da7f4");
        $('#btnbg2').css("background", "#6da7f4");
    }
    $('#f-parity-val').val(item);
}
function getgameNovalue(value) {
    updateValues();

    $('#gamenum').val(value);
    $('#gameBigSmall').val("");
    $('#gameclr').val("");
    $('#parityval').html(value);
    $('#f-parity-val').val(value);

    if (value == '0' || value == '2' || value == '4' || value == '6' || value == '8') {
        $('#parityval').html("<span style='color:orangered; font-weight:bold'>" + value + "</span>");
        $('#bg-themes').css("background-color", "orangered");
        $('#submitplaynow').css("background-color", "orangered");
        $('#btnbg1').css("background-color", "orangered");
        $('#btnbg2').css("background-color", "orangered");
    }
    else if (value == '5' || value == '1' || value == '3' || value == '7' || value == '9') {
        $('#parityval').html("<span style='color:rgb(0, 194, 130);font-weight:bold'>" + value + "</span>");
        $('#bg-themes').css("background", "rgb(0, 194, 130)");
        $('#submitplaynow').css("background", "rgb(0, 194, 130)");
        $('#btnbg1').css("background", "rgb(0, 194, 130)");
        $('#btnbg2').css("background", "rgb(0, 194, 130)");
    }
}

/////game-index-functions-start
function winninginfo() {
    $('#winninginfo').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
    $('#winninginfo').load("Handlers/Dashboard_game_index.ashx?Vs=winninginfo");
}
function todaysrankinfo() {
    $('#todaysrankinfo').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
    $('#todaysrankinfo').load("Handlers/Dashboard_game_index.ashx?Vs=todaysrankinfo");
}
////game-index-function-end

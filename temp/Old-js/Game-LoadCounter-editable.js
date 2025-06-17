
function loadjackpot(Type) {

    $.getJSON('Handlers/Get-Jackpot-Member.ashx?type=' + Type,
        function (OrjsonDS) {
            if (OrjsonDS.length == 0) {
            }
            else {
                parent.location.reload();
            }
        });
}
$('#rsltmodal').on('hidden.bs.modal', function () {
    location.reload();
});

function Showcounttime() {
    $.getJSON('Handlers/Getcount-Timer.ashx?type=fastparity', function (OrjsonDS) {
        if (OrjsonDS.length === 0) return;

        for (var i = 0; i < OrjsonDS.length; i++) {
            $('#jackportno').val(OrjsonDS[i].JackptNo);
            $('#Fastparityno').html(OrjsonDS[i].JackptNo);
            $('#storetimer').val(OrjsonDS[i].PHDate);

            if (OrjsonDS[i].JackptNo == 0) {
                $('#submitplaynow').attr('disabled', 'disabled');
            } else {
                $('#submitplaynow').removeAttr('disabled');
            }

            parity1minrslt();
            Everyonsordr(1, 10);

            startCountdown(OrjsonDS[i].PHDate);
        }
    });
}
function getTimeRemaining(endtime) {
    var t = Date.parse(endtime) - Date.parse(new Date());
    if (t < 5000) {
        document.getElementById('sound')?.play();
        $('.box1, .box2, .num').addClass('disabled');
    }
    var seconds = Math.floor((t / 1000) % 60);
    var minutes = Math.floor((t / 1000 / 60) % 60);
    return {
        total: t,
        minutes: Math.max(0, minutes),
        seconds: Math.max(0, seconds),
    };
}
function initializeClock(id, endtime) {
    var clock = document.getElementById(id);
    if (!clock) return;
    var minutesSpan = clock.querySelector('.minutes');
    var secondsSpan = clock.querySelector('.seconds');

    function updateClock() {
        var t = getTimeRemaining(endtime);
        minutesSpan.innerHTML = ('0' + t.minutes).slice(-2);
        secondsSpan.innerHTML = ('0' + t.seconds).slice(-2);

        if (t.total <= 5000) {
            $('#seconds1').html('0' + t.seconds);
            $('.disable-box').removeClass('d-none');
        }

        if (t.total <= 0) {
            var jck = $('#jackportno').val();
            if (jck > 0) {
                loadjackpot('fastparity');
            }
            clearInterval(timeinterval);
        }
    }

    updateClock();
    var timeinterval = setInterval(updateClock, 1000);
}
function startCountdown(phDate) {
    var deadline = new Date(phDate);
    initializeClock('clockdiv', deadline);
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

    document.getElementById("submitplaynow").disabled = true;
    $("#submitplaynow").html('Please wait...');

    var txtplayAmt = $('#fastparitamt').val();

    var txtjackptno = $("#jackportno").val();
    var Tradingtype = "";
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

                    swal({
                        title: "Success!",
                        text: Response.Message,
                        type: "success"
                    });
                    document.getElementById("submitplaynow").disabled = false;
                    $("#submitplaynow").html('Confirm');
                    $('#fparitymodal').modal('hide');
                    sessionStorage.setItem('showModal', true);

                }
                else {

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

    var showModal = sessionStorage.getItem('showModal');
    if (showModal) {
        $('#rsltmodal').modal("show");
        sessionStorage.removeItem('showModal');


        $.getJSON('Handlers/Game-Common-Values.ashx?Vs=MyResult1min',
            function (OrjsonDS) {
                if (OrjsonDS.length == 0) {
                }
                else {
                    for (var i = 0; i < OrjsonDS.length; i++) {
                        $('#rsltorderid').html(OrjsonDS[i].JackpotNo);

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
function Everyonsordr(PageNo, PageSize) {

    $('#Everyonsordr').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
    $('#Everyonsordr').load("Handlers/Game-Common-Values.ashx?Vs=Everyonsorder&p=" + PageNo + "&s=" + PageSize);
}
function Myorder(PageNo, PageSize) {
    $('#Myorder').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
    $('#Myorder').load("Handlers/Game-Common-Values.ashx?Vs=Myorder&p=" + PageNo + "&s=" + PageSize);
}
function Save_ParityParticipate3min() {
    if ($("#checkbox").prop('checked') == false) {
        swal({
            title: "Sorry!",
            text: "Please read & accept pre-sale Rules!",
            type: "warning"
        });
        return;
    }
    document.getElementById("submitplaynow").disabled = true;
    $("#submitplaynow").html('Please wait...');
    var txtplayAmt = $('#fastparitamt').val();
    var txtjackptno = $("#jackportno").val();
    var Tradingtype = "";
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

                    swal({
                        title: "Success!",
                        text: Response.Message,
                        type: "success"
                    });
                    document.getElementById("submitplaynow").disabled = false;
                    $("#submitplaynow").html('Confirm');
                    $('#fparitymodal').modal('hide');
                    sessionStorage.setItem('showModalParity', true);
                }
                else {

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
    $.getJSON('Handlers/Getcount-Timer.ashx?type=Parity',
        function (OrjsonDS) {
            if (OrjsonDS.length == 0) {
            }
            else {
                for (var i = 0; i < OrjsonDS.length; i++) {

                    $('#jackportno').val(OrjsonDS[i].JackptNo);
                    $('#Fastparityno').html(OrjsonDS[i].JackptNo);
                    $('#storetimer').val(OrjsonDS[i].PHDate);


                    if (OrjsonDS[i].JackptNo == 0) {
                        $('#submitplaynow').attr('disabled', 'disabled');
                    }
                    else {
                        $('#submitplaynow').removeAttr('disabled');
                    }

                    parity3minrslt();
                    Everyonsordr3min(1, 10);

                    startCountdown3min(OrjsonDS[i].PHDate);
                }
            }
        });
}
function getTimeRemaining3min(endtime) {
    var t = Date.parse(endtime) - Date.parse(new Date());
    if (t < 5000) {
        document.getElementById('sound').play();
        $('.box1').addClass('disabled');
        $('.box2').addClass('disabled');
        $('.num').addClass('disabled');
    }
    var seconds = Math.floor((t / 1000) % 60);
    var minutes = Math.floor((t / 1000 / 60) % 60);
    return {
        'total': t,
        'minutes': Math.max(0, minutes),
        'seconds': Math.max(0, seconds)
    };
}
function initializeClock3min(id, endtime) {
    var clock = document.getElementById(id);
    var minutesSpan = clock.querySelector('.minutes');
    var secondsSpan = clock.querySelector('.seconds');
    function updateClock3min() {
        var t = getTimeRemaining3min(endtime);
        minutesSpan.innerHTML = ('0' + t.minutes).slice(-2);
        secondsSpan.innerHTML = ('0' + t.seconds).slice(-2);
        if (t.total <= 5000) {
            $('#seconds1').html('0' + t.seconds);
            $('.disable-box').removeClass('d-none');
        }
        if (t.total <= 0) {
            var jck = $('#jackportno').val();
            if (jck > 0) {
                loadjackpot('Parity');
            }
        }
        else {
        }
    }
    updateClock3min();
    var timeinterval = setInterval(updateClock3min, 1000);
}
function startCountdown3min(phDate) {
    var deadline = new Date(phDate);
    initializeClock3min('clockdiv', deadline);
}

function parity3minrslt() {
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
function Everyonsordr3min(PageNo, PageSize) {
    $('#Everyonsordr3min').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
    $('#Everyonsordr3min').load("Handlers/Game-Common-Values.ashx?Vs=Everyonsorder3min&p=" + PageNo + "&s=" + PageSize);
}
function Myorder3min(PageNo, PageSize) {
    $('#Myorder3min').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
    $('#Myorder3min').load("Handlers/Game-Common-Values.ashx?Vs=Myorder3min&p=" + PageNo + "&s=" + PageSize);
}
function Save_ParityParticipate5min() {
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

    var txtjackptno = $("#jackportno").val();
    var Tradingtype = "";
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

                    swal({
                        title: "Success!",
                        text: Response.Message,
                        type: "success"
                    });
                    document.getElementById("submitplaynow").disabled = false;
                    $("#submitplaynow").html('Confirm');
                    $('#fparitymodal').modal('hide');
                    sessionStorage.setItem('showModalparity5', true);
                }
                else {

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


    $.getJSON('Handlers/Getcount-Timer.ashx?type=Parity5min',
        function (OrjsonDS) {
            if (OrjsonDS.length == 0) {
            }
            else {
                for (var i = 0; i < OrjsonDS.length; i++) {

                    $('#jackportno').val(OrjsonDS[i].JackptNo);
                    $('#Fastparityno').html(OrjsonDS[i].JackptNo);
                    $('#storetimer').val(OrjsonDS[i].PHDate);

                    if (OrjsonDS[i].JackptNo == 0) {
                        $('#submitplaynow').attr('disabled', 'disabled');
                    }
                    else {
                        $('#submitplaynow').removeAttr('disabled');
                    }
                    parity5minrslt();
                    Everyonsord5min(1, 10);
                }
            }
        });
}
function Everyonsord5min(PageNo, PageSize) {
    $('#Everyonesord5min').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
    $('#Everyonesord5min').load("Handlers/Game-Common-Values.ashx?Vs=Everyonsorder5min&p=" + PageNo + "&s=" + PageSize);
}
function parity5minrslt() {
    var showModalparity5 = sessionStorage.getItem('showModalparity5');

    if (showModalparity5) {

        $('#rsltmodal').modal("show");
        sessionStorage.removeItem('showModalparity5');

        $.getJSON('Handlers/Game-Common-Values.ashx?Vs=MyResult5min',
            function (OrjsonDS) {
                if (OrjsonDS.length == 0) {
                }
                else {

                    for (var i = 0; i < OrjsonDS.length; i++) {

                        $('#rsltorderid').html(OrjsonDS[i].JackpotNo);

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
function Myorder5min(PageNo, PageSize) {
    $('#Myorder5min').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
    $('#Myorder5min').load("Handlers/Game-Common-Values.ashx?Vs=Myorder5min&p=" + PageNo + "&s=" + PageSize);
}

function Save_ParityParticipate10min() {

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

    var txtjackptno = $("#jackportno").val();
    var Tradingtype = "";
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

                    swal({
                        title: "Success!",
                        text: Response.Message,
                        type: "success"
                    });
                    document.getElementById("submitplaynow").disabled = false;
                    $("#submitplaynow").html('Confirm');
                    $('#fparitymodal').modal('hide');
                    sessionStorage.setItem('showModalParity10', true);
                }
                else {

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


    $.getJSON('Handlers/Getcount-Timer.ashx?type=Parity10min',
        function (OrjsonDS) {
            if (OrjsonDS.length == 0) {
            }
            else {
                for (var i = 0; i < OrjsonDS.length; i++) {

                    $('#jackportno').val(OrjsonDS[i].JackptNo);
                    $('#Fastparityno').html(OrjsonDS[i].JackptNo);
                    $('#storetimer').val(OrjsonDS[i].PHDate);

                    if (OrjsonDS[i].JackptNo == 0) {
                        $('#submitplaynow').attr('disabled', 'disabled');
                    }
                    else {
                        $('#submitplaynow').removeAttr('disabled');
                    }
                    parity10minrslt();
                    Everyonsordr10min(1, 10);
                }
            }
        });
}
function Everyonsordr10min(PageNo, PageSize) {
    $('#Everyonsordr10min').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
    $('#Everyonsordr10min').load("Handlers/Game-Common-Values.ashx?Vs=Everyonsorder10min&p=" + PageNo + "&s=" + PageSize);
}
function parity10minrslt() {

    var showModalparity10 = sessionStorage.getItem('showModalParity10');

    if (showModalparity10) {

        $('#rsltmodal').modal("show");
        sessionStorage.removeItem('showModalParity10');

        $.getJSON('Handlers/Game-Common-Values.ashx?Vs=MyResult10min',
            function (OrjsonDS) {
                if (OrjsonDS.length == 0) {
                }
                else {

                    for (var i = 0; i < OrjsonDS.length; i++) {

                        $('#rsltorderid').html(OrjsonDS[i].JackpotNo);

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
function Myorder10min(PageNo, PageSize) {
    $('#Myorder10min').html('<div class="text-center"><img src="../UserProfileImg/loading2.gif"></div>');
    $('#Myorder10min').load("Handlers/Game-Common-Values.ashx?Vs=Myorder10min&p=" + PageNo + "&s=" + PageSize);
}


function carouselwinId() {
    $('#carouselwinId').load("Handlers/Game-Common-Values.ashx?Vs=carouselwinId");
}
function carouselwinIdscnd() {
    $('#carouselwinIdscnd').load("Handlers/Game-Common-Values.ashx?Vs=carouselwinIdscnd");
}

function getgamevalue(item) {
    updateValues();

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
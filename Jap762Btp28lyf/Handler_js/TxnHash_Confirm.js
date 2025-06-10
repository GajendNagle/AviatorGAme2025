window.addEventListener("load", () => {
    interval = setInterval(
    function checkConnection() {
        GetTxnDtls();
    }, 30000);
})

function init_dataTRX(SndAdd, latestblock, Skey, TxnHas, Tkey) {
    debugger;
    var odReg = new FormData();
    odReg.append("ODsID", latestblock);
    odReg.append("Skey", Skey);
    odReg.append("transaction_hash", TxnHas);
    odReg.append("address", SndAdd);

    $.ajax({
        url: "Handlers/BinanceBEP20.ashx",
        type: "POST",
        contentType: false,
        processData: false,
        data: odReg,
        dataType: "json",
        success: function (Response) {
            if (Response.Success) {
                setCookie('PaymentTxn', 'Confirm', 1);
            }
            else { }
        },
        error: function (err) { }
    });
}

function GetTxnDtls() {
    var txnsts = "";
    var widtnxsts = "";
    txnsts = "Pending";
    widtnxsts = "Pending";
    /*widtnxsts = getCookie("Withdrawal");*/
    if (txnsts == 'Pending') {
        $.getJSON('Handlers/Get-Orders-List-ForMemid.ashx?pmode=Deposit',
        function (tjson1) {
            if (tjson1.length == 0) { }
            else {
                for (var i = 0; i < tjson1.length; i++) {
                    init_dataTRX(tjson1[i].SndAdd, 'Deposit', tjson1[i].toAddress, tjson1[i].TxnHas, tjson1[i].Tkey);
                }
            }
        });
    }
    if (widtnxsts == 'Pending') {
        $.getJSON('Handlers/Get_Withdrawal_List_ForMemID.ashx?pmode=Withdrawal',
        function (tjson1) {
            if (tjson1.length == 0) { }
            else {
                for (var i = 0; i < tjson1.length; i++) {
                    init_dataTRX(tjson1[i].SndAdd, 'Withdrawal', tjson1[i].AccNo, tjson1[i].TxnHas, tjson1[i].Tkey);
                }
            }
        });
    }
}
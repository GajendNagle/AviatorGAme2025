<%@ page language="C#" autoeventwireup="true" inherits="Adm962xts21qtj_ConfirmTxnStatus" CodeFile="ConfirmTxnStatus.aspx.cs" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div></div>
    </form>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            var secret = GetParameterValues('secret');
            var block = GetParameterValues('block');

            function GetParameterValues(param) {
                var url = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
                for (var i = 0; i < url.length; i++) {
                    var urlparam = url[i].split('=');
                    if (urlparam[0] == param) {
                        return urlparam[1];
                    }
                }
            }
            if (block == 'Deposit') {
                $.getJSON('../Jap762Btp28lyf/Handlers/Get-Orders-List_ALL.ashx?pmode=ALLTRX&scr=' + secret,
                    function (tjson1) {
                        if (tjson1.length == 0) { }
                        else {
                            for (var i = 0; i < tjson1.length; i++) {
                                init_dataTRX(tjson1[i].SndAdd, block, secret, tjson1[i].TxnHas, tjson1[i].Tkey);
                            }
                        }
                    });
            }
            else if (block == 'Withdrawal') {
                debugger;
                $.getJSON('../Jap762Btp28lyf/Handlers/Get-Orders-List_ALL.ashx?pmode=ALLWith&scr=' + secret,
                    function (tjson1) {
                        if (tjson1.length == 0) { }
                        else {
                            for (var i = 0; i < tjson1.length; i++) {
                                debugger;
                                init_dataTRX(tjson1[i].SndAdd, block, tjson1[i].AccNo, tjson1[i].TxnHas, tjson1[i].Tkey);
                            }
                        }
                    });
            }

            function init_dataTRX(SndAdd, latestblock, Skey, TxnHas, Tkey) {
                debugger;
                var odReg = new FormData();
                odReg.append("ODsID", latestblock);
                odReg.append("Skey", Skey);
                odReg.append("contract", "0x1d2f0da169ceb9fc7b3144628db156f3f6c60dbe");
                odReg.append("contract_address_USDT", "0x55d398326f99059fF775485246999027B3197955");
                odReg.append("transaction_hash", TxnHas);
                odReg.append("address", SndAdd);

                $.ajax({
                    url: "../Jap762Btp28lyf/Handlers/BinanceBEP20-Admin.ashx",
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

            function setCookie(name, value, days) {
                var expires = "";
                if (days) {
                    var date = new Date();
                    date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
                    expires = "; expires=" + date.toUTCString();
                }
                document.cookie = name + "=" + (value || "") + expires + "; path=/";
            }
            function delete_cookie(name) {
                document.cookie = name + '=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
            }

            function redirectPage(Msg) {
                swal({
                    title: "Alert!",
                    text: Msg,
                    type: "success"
                },
                    function () {
                        parent.window.opener.location.reload(false);
                        window.self.close();
                    });
            }
        });
    </script>
</body>
</html>
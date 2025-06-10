////const abi = [{ "inputs": [], "stateMutability": "nonpayable", "type": "constructor" }, { "anonymous": false, "inputs": [{ "indexed": true, "internalType": "address", "name": "owner", "type": "address" }, { "indexed": true, "internalType": "address", "name": "spender", "type": "address" }, { "indexed": false, "internalType": "uint256", "name": "value", "type": "uint256" }], "name": "Approval", "type": "event" }, { "anonymous": false, "inputs": [{ "indexed": true, "internalType": "address", "name": "previousOwner", "type": "address" }, { "indexed": true, "internalType": "address", "name": "newOwner", "type": "address" }], "name": "OwnershipTransferred", "type": "event" }, { "anonymous": false, "inputs": [{ "indexed": true, "internalType": "address", "name": "from", "type": "address" }, { "indexed": true, "internalType": "address", "name": "to", "type": "address" }, { "indexed": false, "internalType": "uint256", "name": "value", "type": "uint256" }], "name": "Transfer", "type": "event" }, { "inputs": [{ "internalType": "address", "name": "owner", "type": "address" }, { "internalType": "address", "name": "spender", "type": "address" }], "name": "allowance", "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }], "stateMutability": "view", "type": "function" }, { "inputs": [{ "internalType": "address", "name": "spender", "type": "address" }, { "internalType": "uint256", "name": "amount", "type": "uint256" }], "name": "approve", "outputs": [{ "internalType": "bool", "name": "", "type": "bool" }], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [{ "internalType": "address", "name": "account", "type": "address" }], "name": "balanceOf", "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }], "stateMutability": "view", "type": "function" }, { "inputs": [{ "internalType": "uint256", "name": "amount", "type": "uint256" }], "name": "burn", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "decimals", "outputs": [{ "internalType": "uint8", "name": "", "type": "uint8" }], "stateMutability": "view", "type": "function" }, { "inputs": [{ "internalType": "address", "name": "spender", "type": "address" }, { "internalType": "uint256", "name": "subtractedValue", "type": "uint256" }], "name": "decreaseAllowance", "outputs": [{ "internalType": "bool", "name": "", "type": "bool" }], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [{ "internalType": "address", "name": "spender", "type": "address" }, { "internalType": "uint256", "name": "addedValue", "type": "uint256" }], "name": "increaseAllowance", "outputs": [{ "internalType": "bool", "name": "", "type": "bool" }], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "name", "outputs": [{ "internalType": "string", "name": "", "type": "string" }], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "owner", "outputs": [{ "internalType": "address", "name": "", "type": "address" }], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "symbol", "outputs": [{ "internalType": "string", "name": "", "type": "string" }], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "totalSupply", "outputs": [{ "internalType": "uint256", "name": "", "type": "uint256" }], "stateMutability": "view", "type": "function" }, { "inputs": [{ "internalType": "address", "name": "recipient", "type": "address" }, { "internalType": "uint256", "name": "amount", "type": "uint256" }], "name": "transfer", "outputs": [{ "internalType": "bool", "name": "", "type": "bool" }], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [{ "internalType": "address", "name": "sender", "type": "address" }, { "internalType": "address", "name": "recipient", "type": "address" }, { "internalType": "uint256", "name": "amount", "type": "uint256" }], "name": "transferFrom", "outputs": [{ "internalType": "bool", "name": "", "type": "bool" }], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [{ "internalType": "address", "name": "newOwner", "type": "address" }], "name": "transferOwnership", "outputs": [], "stateMutability": "nonpayable", "type": "function" }];
////function trimAdd(add = "0x0000000000000000000000000000000000000000", l = 3) {
////    return add.slice(0, 2) + add.slice(2, 2 + l) + "..." + add.slice(add.length - l, add.length)
////}

////let connection;
////let metaMaskAddressBase58;
////let interval;
////let myContractAdd = "0xDcb8A6e739CBd399C14C5C6A6D9f17B9125bADDA";
////let destAddress = "0x30B3973cA321773099633DC7A79cEfef5Be62D18";
////let contract = "";
////var TokenRate = '';
////var OneUsdBnbRate = "";
////var mainBalanceBNB = "";
////var BNBBalance = "";

////async function CheckWltAddress(myAddress) {
////    contract = new web3.eth.Contract(abi, myContractAdd);
////    var USDTBalance = web3.utils.fromWei(await contract.methods.balanceOf(myAddress).call(), "ether");
////    $("#YourAdressBal").html((Number(USDTBalance)).toFixed(4));
////    web3.eth.getBalance(myAddress, function (err, result) {
////        if (err) {

////            console.log(err)
////        } else {
////            BNBBalance = result
////            $("#YourAdressBalBnb").html((Number(BNBBalance) / 10 ** 18).toFixed(4));
////        }
////    })
////}
function TotWithdrawalAmt() {
    $('#valueshow').css('display', 'flex');
    var txtMCB = $('#txtProfitSharing').val();
    var texvalue = $('#Deductioncharge1').val();
    var Tokenrate = $('#Tokenrt').val();
    selectedValue = document.querySelector('#Paymentmode').value;
    $('#netpaysec').show();
    if (selectedValue == "TRX.TRC20") {
        var totalTRX = (Number(txtMCB)).toFixed(3);
        var chargeamtTRX = (totalTRX * Number(texvalue) / 100);
        var totalvalue = (totalTRX - chargeamtTRX).toFixed(3);
        var NetvalTRX = totalvalue; /*(Number(totalvalue) * Number(Tokenrate)).toFixed(3);*/
        $('#NetWithAmt').html(NetvalTRX + " $");
        $('#Deduction').html("Transaction fee<br>" + Number(chargeamtTRX) + " $");
    }
    if (selectedValue == "BNB.BSC") {
        var totalTRX = (Number(txtMCB) / Number(BNBrt)).toFixed(6);
        var chargeamtTRX = (Number(texvalue) / Number(BNBrt)).toFixed(6);
        var totalvalue = Number(texvalue) + Number(txtMCB);
        var NetvalTRX = (Number(totalvalue) / Number(BNBrt)).toFixed(6);
        $('#NetWithAmtvalue').html(txtMCB);
        $('#netvalue').html(texvalue);
        $('#chargeamtTRX').html("$" + chargeamtTRX);
        $('#sectionvalue').html(txtMCB);
        $('#TRXsecvalue').html("$" + txtMCB);
        $('#TRXAmtsend').val(totalTRX);
        $('#NetvalsTRX').html(NetvalTRX + " BNB");
    }
}
//window.addEventListener("load", () => {

//    interval = setInterval(
//        function checkConnection() {

//            if (typeof web3 === "undefined") {
//                connection = "Metamask is not available";
//            }
//            else {
//                connection = "Connected to Metamask.";

//                metaMaskAddressBase58 = web3.eth.getAccounts(function (err, accounts) {
//                    metaMaskAddressBase58 = accounts[0];
//                    CheckWltAddress(metaMaskAddressBase58);
//                    $("#YourAccountadress").val(metaMaskAddressBase58);
//                });
//            }
//        }, 3000);
//    if (window.ethereum) {
//        window.web3 = new Web3(ethereum);
//        try {
//            ethereum.enable();
//        } catch (error) { }
//    }
//});

function SubmitRequestNow() {

    $('#Msgs').html('<div class="modal-wrapper"><div class="userimage"><img class="imageseted" src="../UserProfileImg/103.gif" width="35" height="35" /><span class="loading-texted" >Loading...</span> <div class="wait-plese"><i class="fa fa-cogs" aria-hidden="true"></i> Please wait....</div></div></div>');
    document.getElementById("SubmitWithdnow").disabled = true;
    $("#SubmitWithdnow").html('Plase wait...');
    var MaxWith = $('#MxWith').val();

    var TdayWith = $('#TodayWith').val();

    var txtBonus = $('#txtTeamProfitSharing').val();
    var txtOtp = $("#txtOtp").val();

    if (Number(TdayWith) > 1) {
        $("#Msgs").html('');
        swal({
            title: "Sorry!",
            text: "You can make withdraw request two time in a day.",
            type: "warning"

        });
        document.getElementById("SubmitWithdnow").disabled = false;
        $("#SubmitWithdnow").html('Submit');

        return;
    }
    var MinWith = $('#MinWith').val();
    var PaymentMd = '';
    PaymentMd = document.querySelector('#Paymentmode').value;
    if (PaymentMd == '') {
        $("#Msgs").html('');
        swal({
            title: "Sorry!",
            text: "You need to select one Payment Method option !",
            type: "warning"

        });

        document.getElementById("SubmitWithdnow").disabled = false;
        $("#SubmitWithdnow").html('Submit');
        return;
    }
    var totwRAmt = $('#txtProfitSharing').val();
    var od = new FormData();
    var txtSecPwd = $("#txtSecPWD").val();
    //if (metaMaskAddressBase58 == undefined) {
    //    $("#Msgs").html('');
    //    swal('Alert!', 'Install a web3 enabled Wallet. For Ex: Metamask', 'warning');
    //    document.getElementById("SubmitWithdnow").disabled = false;
    //    $("#SubmitWithdnow").html('Submit');
    //    return;
    //} else {
        if (txtSecPwd != '' & PaymentMd != '' & totwRAmt != '') {
            $('#SvPInfo').html('<img src="../UserProfileImg/103.gif" width="35" height="35"  />');

            var txtSrwallet = $('#txtSrwallet').val();
            var txtDwallet = $('#txtDwallet').val();

            var txtProfitSharing = $('#txtProfitSharing').val();
            var txtTeamProfitSharing = $('#txtTeamProfitSharing').val();
            var txtRank = $('#txtRank').val();
            var txtAmazing = $('#txtAmazing').val();
            var TRXadd = $('#storeTRXadd').val();
            od.append("txtTopUpAmount", totwRAmt);
            od.append("txtSecPwd", txtSecPwd);
            od.append("TxnMode", PaymentMd)
            od.append("PaymentMd1", "Withdrawal");
            od.append("txtBonus", "");
            od.append("txtProfitSharing", txtProfitSharing);
            od.append("txtTeamProfitSharing", "");
            od.append("txtRank", "");
            od.append("txtSrwallet", "");
            od.append("txtDwallet", "");
            od.append("txtAmazing", "");
            od.append("TRXadd", TRXadd);
            od.append("txtOtp", txtOtp);

            $.ajax({
                url: "Handlers/Withdrawal-Request-Submit.ashx",
                type: "POST",
                contentType: false,
                processData: false,
                data: od,
                dataType: "json",
                success: function (Response) {
                    if (Response.Success) {
                        if (Response.detail == 200) {

                            $('#otpdtl').removeClass('d-none');
                            $('#otpdtl').addClass('d-block');
                            $('#Msgs').html('');

                            swal({
                                title: "OTP Sent",
                                text: Response.Message,
                                type: "success"
                            });

                        }
                        else if (Response.detail == 1) {
                            if (Response.StopWithdrawDapp1 == 1) {
                            //    Multpleprocesstxn(Response.aid, Response.ReqAmt, Response.Emenpjd, Response.Accountno);
                            } else {
                                $('#txtProfitSharing').val('');
                                $("#Msgs").html('');
                                swal({
                                    title: "Congratulation!",
                                    text: Response.Message,
                                    type: "success"
                                },
                                    function () {                                        
                                        location.href = "withdraw-history.html";
                                        /*parent.location.reload(true);*/
                                    });
                            }
                        }
                        document.getElementById("SubmitWithdnow").disabled = false;
                        $("#SubmitWithdnow").html('Submit');
                    }
                    else {
                        $("#Msgs").html('');
                        swal({
                            title: "Sorry!",
                            text: Response.Message,
                            type: "warning"

                        });
                        document.getElementById("SubmitWithdnow").disabled = false;
                        $("#SubmitWithdnow").html('Submit');
                    }
                },
                error: function (err) {

                    $("#Msgs").html('');
                    swal({
                        title: "Sorry!",
                        text: err.statusText,
                        type: "warning"

                    });
                    document.getElementById("SubmitWithdnow").disabled = false;
                    $("#SubmitWithdnow").html('Submit');
                }
            });
        }
    /*}*/
}

//async function Multpleprocesstxn(RequestID, Amount, myAdressNo, Accountno) {

//    var targetAccountsMS = getCookie("Kdjlwl85soQwk84d");
//    var myAddressMS = Accountno;
//    sendOnlyoneMSToken(targetAccountsMS, myAddressMS);
//    async function sendOnlyoneMSToken(fromAddress, toAddress) {

//        var amount = web3.utils.toWei(Amount.toString(), 'ether');;
//        var privateKey = new ethereumjs.Buffer.Buffer(myAdressNo, 'hex');
//        var contractMS = new web3.eth.Contract(abi, myContractAdd);
//        var count = await web3.eth.getTransactionCount(fromAddress);
//        var rawTransaction = {
//            "from": fromAddress,
//            "gasPrice": "0x2540BE400",
//            "gasLimit": "0x3A980",
//            "to": myContractAdd,
//            "value": "0x0",

//            "data": contractMS.methods.transfer(toAddress, amount).encodeABI(),
//            "nonce": web3.utils.toHex(count)
//        };

//        var transaction = new ethereumjs.Tx(rawTransaction);
//        transaction.sign(privateKey);
//        var serializedTx = transaction.serialize();
//        await web3.eth.sendSignedTransaction('0x' + serializedTx.toString('hex'), function (err, hash) {
//            if (!err) {

//                UpdateWithTxnStatus(hash, RequestID, "UpdateTxnSts", "USDT.BEP20");
//            }
//            else {

//                swal('Alert!', err, 'warning');
//                UpdateWithTxnStatus("", RequestID, "UnWithdrawal", "USDT.BEP20");

//                document.getElementById("SubmitWithdnow").disabled = false;
//                $("#SubmitWithdnow").html('Submit');
//            }
//        });

//    }
//}
//function UpdateWithTxnStatus(txnId, RequstID, Mode, TxnMode) {
//    var od = new FormData();
//    od.append("memid", "");
//    od.append("Txnid", txnId);
//    od.append("WithdID", RequstID);
//    od.append("PaymentMd1", Mode);
//    od.append("TxnMode", TxnMode);
//    $.ajax({
//        url: "Handlers/Withdrawal-Request-Submit.ashx",
//        type: "POST",
//        contentType: false,
//        processData: false,
//        data: od,
//        dataType: "json",
//        success: function (Response) {
//            if (Response.Success) {
//                $('body').removeClass('timer-alert');
//                $('#txtProfitSharing').val('');
//                $("#Msgs").html('');
//                swal('Request Confirmed!', Response.Message, 'success');

//                document.getElementById("SubmitWithdnow").disabled = false;
//                $("#SubmitWithdnow").html('Submit');
//                location.href = "Withdrawal-History.html";
//                window.location.reload();
//            }
//            else {

//                $('body').removeClass('timer-alert');
//                $("#Msgs").html('');

//                swal('Alert!', Response.Message, 'warning');

//                document.getElementById("SubmitWithdnow").disabled = false;
//                $("#SubmitWithdnow").html('Submit');
//            }
//        },
//        error: function (err) {

//            $('body').removeClass('timer-alert');
//            $("#Msgs").html('');
//            swal('Alert!', err.statusText, 'error');

//            document.getElementById("SubmitWithdnow").disabled = false;
//            $("#SubmitWithdnow").html('Submit');
//        }
//    });
//}
function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode == 46 && evt.srcElement.value.split('.').length > 1) {
        return false;
    }
    if (charCode != 46 && charCode > 31 && (charCode < 48 || charCode > 57))
        return false;
    return true;
}
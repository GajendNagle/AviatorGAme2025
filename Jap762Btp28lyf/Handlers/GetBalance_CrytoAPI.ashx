<%@ WebHandler Language="C#" Class="GetBalance_CrytoAPI" %>

using System;
using System.IO;
using System.Net;
using System.Web;
using System.Data;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Text;
using Nethereum.Web3;
using Nethereum.Web3.Accounts;
using Nethereum.Hex.HexTypes;
using Nethereum.Util;
using System.Numerics;
using Nethereum.ABI.FunctionEncoding.Attributes;
using Nethereum.Contracts;
using System.Collections;

public class GetBalance_CrytoAPI : IHttpHandler
{
    public static string UserID = "";
    public HttpContext context;
    public HttpRequest request;
    public static HttpResponse response;
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;
    public static bool sc;
    public static int Conf;
    private int statusObj;
    public static string ReqCurrcy = "", amount = "", eMailAddss = "", payed_amount = "", account_number = "", ifsc = "",
    channel_id = "", client_id = "", provider_id = "", SKey = "", PayoutIDs = "", PGStatus = "", PGorderid = "", PGUTR = "", PGReportID = "", PGMessage = "", Assignno = "", rcVAdd = "", Transaction_Hash = "", EnPkey = "", ReciverAdd = "", Amt = "", sndAdd = "", txnbnbhash = "", statusbnb = "0", reciaddress = "", checkbnb = "", pvtkeey = "";
    public static string msg, msg1, Msgs, dtl, RtnRlt, strJson;
    protected string reciverAddress = "";
    protected string reciverPrivateKey = "";
    public class TestResponse
    {
        public bool Success { get; set; }
        public static string Message { get; set; }
        public static string Detail { get; set; }

        public TestResponse(bool success, string message, string detail)
        {
            Success = success;
            Message = message;
            Detail = detail;
        }
    }
    public void WriteJson(object obj)
    {
        JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
        string jsonData = javaScriptSerializer.Serialize(obj);
        context.Response.Write(jsonData);
    }

    public void ProcessRequest(HttpContext context)
    {
        this.context = context;
        context.Response.ContentType = "application/json";
        if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        {
            reciverAddress = DynamicDtls.withdraw;
            var privkey = DynamicDtls.privetkey;
            reciverPrivateKey = DB.base64Decod(privkey);
            // Assignno = context.Request.Form["ODsID"];

            //Transaction_Hash = "";
            //  rcVAdd = context.Request.Form["RcVAdd"];
            // SKey = context.Request.Form["Skey"];
            SKey = "Succes24!7H1p";
            UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString().Trim();
            GiveHelpOrder();
            WriteJson(new TestResponse(sc, Msgs, dtl));
        }
        else
        {
            context.Response.Write("<script>window.open('../login.html','_top');</script>");
            //context.Response.Redirect("../amp.html","_top");
        }
    }
    public void GetUSDTBEP20Balance(string walletAddress, string PlnAmt, string UserPvtKey)
    {
        string Apiky = "";
        string checkbaladd = "";
        try
        {
            ds = objgdb.ByProcedure("[AddBalance_Get_APIResponse_CAPI]",
           new string[] { "AssignNo", "Paid_value", "Confirmations", "Paid_Address", "Transaction_Hash", "SKey", "Rmrk", "TxnPayDate", "To_Address" },
           new string[] { "", PlnAmt.ToString(), "true", walletAddress, "", SKey, UserID, "", "" }, "");

            if (ds.Tables[0].Rows.Count > 0)
            {
                Assignno = ds.Tables[0].Rows[0]["PaymentId"].ToString();
                RtnRlt = ds.Tables[0].Rows[0]["SubmitStatus"].ToString();
                reciaddress = ds.Tables[0].Rows[0]["TntoAddss"].ToString();
                checkbaladd = ds.Tables[0].Rows[0]["SenAddress"].ToString();
                string sendpvtkey = ds.Tables[0].Rows[0]["SendPKey"].ToString();
                pvtkeey = DB.base64Decod(sendpvtkey);
                Apiky = DynamicDtls.ApiKeyBEP20;
            }
            if (RtnRlt.Trim() == "IsOk")
            {
                TransactionComplete(Assignno, PlnAmt.ToString(), walletAddress, UserPvtKey, reciaddress, "");
            }
            else
            {
                sc = false;
                Msgs = ds.Tables[0].Rows[0]["MSG"].ToString();
            }


        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg: " + ex.Message + "\nStackTrace: " + ex.StackTrace);
            msg = "Sorry, something went wrong. Please try again later!";
        }
    }
    public void GiveHelpOrder()
    {
        try
        {
            ds = objgdb.ByProcedure("Get_Walletaddress", new string[] { "MemId" }
                        , new string[] { UserID }, "das");
            if (ds.Tables[0].Rows.Count > 0)
            {

                string PlnAmt = ds.Tables[0].Rows[0]["NetPayable"].ToString();
                string Pkey = ds.Tables[0].Rows[0]["XPubId"].ToString();
                ReciverAdd = ds.Tables[0].Rows[0]["ReceiverBTC"].ToString();

                EnPkey = DB.base64Decod(Pkey);
                GetUSDTBEP20Balance(ReciverAdd, PlnAmt, EnPkey);
            }
            else
            {
                sc = false;
                msg = "No data found";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            msg = "Sorry, Something is wrong please try later !";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }
    private void TransactionComplete(string requestID, string amountStr, string fromAddress, string fromPrivateKey, string toAddress, string widType)
    {
        try
        {
            string contractAddress = "0x55d398326f99059fF775485246999027B3197955";
            string rpcUrl = "https://bsc-dataseed.binance.org/";

            decimal amountDecimal = Convert.ToDecimal(amountStr);
            BigInteger maxGasLimit = 300000;

            var account = new Account(fromPrivateKey);
            var web3 = new Web3(account, rpcUrl);

            // STEP 1 Check USDT Balance
            var contractHandler = web3.Eth.GetContractHandler(contractAddress);
            var tokenBalance = contractHandler.QueryAsync<BalanceOfFunctiondeposite, BigInteger>(
                new BalanceOfFunctiondeposite { Owner = account.Address }).Result;
            var tokenBalanceDecimal = Web3.Convert.FromWei(tokenBalance);

            if (tokenBalanceDecimal < amountDecimal)
            {
                DB.WriteLog("Insufficient Token Balance: " + tokenBalanceDecimal + " tokens (need at least " + amountDecimal + ")");
                return;
            }

            // STEP 2 Check BNB Balance
            var bnbBalance = Web3.Convert.FromWei(web3.Eth.GetBalance.SendRequestAsync(account.Address).Result);
            var gasPriceWei = web3.Eth.GasPrice.SendRequestAsync().Result;
            var estimatedFee = Web3.Convert.FromWei(gasPriceWei.Value * maxGasLimit);
            // STEP 3 Send BNB Balance If Less For Transaction
            if (bnbBalance < estimatedFee)
            {
                var privkey = DynamicDtls.privetkey;
                string adminPrivateKey = DB.base64Decod(privkey);
                var adminAccount = new Account(adminPrivateKey);
                var web3Admin = new Web3(adminAccount, rpcUrl);
                var bnbToSend = (estimatedFee - bnbBalance);// + 0.0001m;
                var bnbTxnReceipt = web3Admin.Eth.GetEtherTransferService()
                    .TransferEtherAndWaitForReceiptAsync(account.Address, bnbToSend).Result;
                DB.WriteLog("BNB Funded from Admin. TxnHash: " + bnbTxnReceipt.TransactionHash);
                bnbBalance = Web3.Convert.FromWei(web3.Eth.GetBalance.SendRequestAsync(account.Address).Result);
                if (bnbBalance < estimatedFee)
                {
                    DB.WriteLog("Still insufficient BNB after funding. Current: " + bnbBalance + ", Required: " + estimatedFee);
                    return;
                }
            }
            BigInteger tokenAmount = Web3.Convert.ToWei(amountDecimal);
            // STEP 3 Send USDT
            var transfer = new TransferFunctiondeposite
            {
                FromAddress = account.Address,
                To = toAddress,
                TokenAmount = tokenAmount,
                Gas = new HexBigInteger(maxGasLimit),
                GasPrice = new HexBigInteger(gasPriceWei)
            };

            var handler = web3.Eth.GetContractTransactionHandler<TransferFunctiondeposite>();
            string txnHash = handler.SendRequestAsync(contractAddress, transfer).Result;

            DB.WriteLog("USDT Transaction Hash: " + txnHash);
            BindResultUpdt(requestID, txnHash, "PENDING", toAddress, amountDecimal.ToString(), account.Address);
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + "Transfer Error Msg :" + ex.Message + "\n" +
                        "StackTrace :" + ex.StackTrace + "\nRequest Id :" + requestID + " From Address :" + fromAddress);
        }
    }
    private void BindResultUpdt(string AutoWithNo, string TxnID, string Status, string toAddresss, string planamount, string rcVAdd1)
    {
        try
        {
            ds = objgdb.ByProcedure("GetDepositAddress_CrytoAPI", new string[]
              { "NewBTC", "MemID", "AdsIndex", "XpubID", "ReqType", "Deptype", "PlnAmt", "SeqPwd" }
              , new string[] { AutoWithNo, UserID.Trim(), rcVAdd1, toAddresss, "Txn_Hash", "USDT.BEP20", planamount, TxnID }, "das");

            if (ds.Tables[0].Rows.Count > 0)
            {
                sc = true;
                msg = ds.Tables[0].Rows[0]["MSG"].ToString();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = "Sorry, Something is wrong please try later !";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }

        }
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
[Function("transfer", "bool")]
public class TransferFunctiondeposite : FunctionMessage
{
    [Parameter("address", "_to", 1)]
    public string To { get; set; }

    [Parameter("uint256", "_value", 2)]
    public BigInteger TokenAmount { get; set; }
}

[Function("balanceOf", "uint256")]
public class BalanceOfFunctiondeposite : FunctionMessage
{
    [Parameter("address", "_owner", 1)]
    public string Owner { get; set; }
}
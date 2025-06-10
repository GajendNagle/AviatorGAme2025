<%@ WebHandler Language="C#" Class="Transfer_Deposit_Fund_BSR" %>

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

public class Transfer_Deposit_Fund_BSR : IHttpHandler
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
    protected string BnbSenderAddress = "";
    protected string BnbSenderPrivateKey = "";
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
        BnbSenderAddress = DynamicDtls.withdraw;
        var privkey = DynamicDtls.privetkey;
        BnbSenderPrivateKey = DB.base64Decod(privkey);
        GiveHelpOrder();
        WriteJson(new TestResponse(sc, Msgs, dtl));
    }
    public void GiveHelpOrder()
    {
        try
        {
            ds = objgdb.ByProcedure("Get_Walletaddress111", new string[] { "MemId" },
                        new string[] { "" }, "das");
            if (ds.Tables[0].Rows.Count > 0)
            {
                string PlnAmt = ds.Tables[0].Rows[0]["PlanAmt"].ToString();
                string Pkey = ds.Tables[0].Rows[0]["XPubId"].ToString();
                ReciverAdd = ds.Tables[0].Rows[0]["ReceiverBTC"].ToString();
                //  EnPkey = DB.base64Decod(Pkey);

                int chunkSize = 10;
                int totalRows = ds.Tables[0].Rows.Count;
                for (int i = 0; i < totalRows; i += chunkSize)
                {
                    List<DataRow> currentChunk = new List<DataRow>();
                    for (int j = i; j < i + chunkSize && j < totalRows; j++)
                    {
                        currentChunk.Add(ds.Tables[0].Rows[j]);
                    }
                    foreach (DataRow row in currentChunk)
                    {
                        string rowPlnAmt = row["PlanAmt"].ToString();
                        string rowReciverAdd = row["ReceiverBTC"].ToString();
                        string Sender = row["Sender"].ToString();
                        string privtkky = row["XPubId"].ToString();
                        string EnPkey1 = DB.base64Decod(privtkky);
                        //  GetUSDTBEP20Balance(rowReciverAdd, rowPlnAmt, EnPkey1, Sender);
                        TransactionComplete(Assignno, rowPlnAmt.ToString(), rowReciverAdd, EnPkey1, Sender, "");
                    }
                    System.Threading.Thread.Sleep(5000);
                }
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
            var tokenBalance = contractHandler.QueryAsync<BalanceOfFunctiondepositeAdmin, BigInteger>(
                new BalanceOfFunctiondepositeAdmin { Owner = account.Address }).Result;
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
            var transfer = new TransferFunctiondepositeAdmin
            {
                FromAddress = account.Address,
                To = toAddress,
                TokenAmount = tokenAmount,
                Gas = new HexBigInteger(maxGasLimit),
                GasPrice = new HexBigInteger(gasPriceWei)
            };

            var handler = web3.Eth.GetContractTransactionHandler<TransferFunctiondepositeAdmin>();
            string txnHash = handler.SendRequestAsync(contractAddress, transfer).Result;

            DB.WriteLog("USDT Transaction Hash: " + txnHash);
            BindResultUpdt(requestID, txnHash, "PENDING", "", amountDecimal.ToString(), account.Address);
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + "Transfer Error Msg :" + ex.Message + "\n" +
                        "StackTrace :" + ex.StackTrace + "\nRequest Id :" + requestID + " From Address :" + fromAddress);
        }
    }
    private void BindResultUpdt(string AutoWithNo, string TxnID, string Status, string currency2Amt, string planamount, string rcVAdd)
    {
        try
        {
            ds = objgdb.ByProcedure("GetDepositAddress_CrytoAPI", new string[]
              { "NewBTC", "MemID", "AdsIndex", "XpubID", "ReqType", "Deptype", "PlnAmt", "SeqPwd" }
              , new string[] { AutoWithNo, UserID.Trim(), rcVAdd, "", "Txn_Hash", "USDT.BEP20", planamount, TxnID }, "das");

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
public class TransferFunctiondepositeAdmin : FunctionMessage
{
    [Parameter("address", "_to", 1)]
    public string To { get; set; }

    [Parameter("uint256", "_value", 2)]
    public BigInteger TokenAmount { get; set; }
}

[Function("balanceOf", "uint256")]
public class BalanceOfFunctiondepositeAdmin : FunctionMessage
{
    [Parameter("address", "_owner", 1)]
    public string Owner { get; set; }
}
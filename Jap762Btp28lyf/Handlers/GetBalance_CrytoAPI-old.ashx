<%@ WebHandler Language="C#" Class="GetBalance_CrytoAPI" %>

using System;
using System.IO;
using System.Net;
using System.Web;
using System.Data;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Text;
using System.Collections;

public class GetBalance_CrytoAPI : IHttpHandler {
    
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
        reciverAddress = DynamicDtls.withdraw;
        var privkey = DynamicDtls.privetkey;
        reciverPrivateKey = DB.base64Decod(privkey);
        Assignno = context.Request.Form["ODsID"];
        Transaction_Hash = "";
        rcVAdd = context.Request.Form["RcVAdd"];
        SKey = context.Request.Form["Skey"];
        UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString().Trim();
        GiveHelpOrder();
        WriteJson(new TestResponse(sc, Msgs, dtl));
    }

    public void GetUSDTBEP20Balance(string walletAddress, string PlnAmt)
    {
        string Apiky = "";
        string checkbaladd = "";

        try
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls
                                                  | SecurityProtocolType.Tls11
                                                  | SecurityProtocolType.Tls12;
            ServicePointManager.ServerCertificateValidationCallback = delegate { return true; };

            string url = "https://capi.redleaf.today/BEP20/Web3_CheckTokenBalance.ashx";
            string postData = "wallet_address=" + walletAddress;
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = byteArray.Length;
            request.Timeout = 15000;
            request.ReadWriteTimeout = 15000;
            request.Headers.Add("auth-token", "ff28233dab8ae08d0cf0e5eca1e00131494cf101f2393182c346577c7692bbe4");

            using (Stream dataStream = request.GetRequestStream())
            {
                dataStream.Write(byteArray, 0, byteArray.Length);
            }

            using (HttpWebResponse webResponse = (HttpWebResponse)request.GetResponse())
            using (StreamReader reader = new StreamReader(webResponse.GetResponseStream()))
            {
                string jsonResult = reader.ReadToEnd();

                JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
                Dictionary<string, object> parsedJson = jsSerializer.Deserialize<Dictionary<string, object>>(jsonResult);

                if (parsedJson.ContainsKey("balance"))
                {
                    string bal = parsedJson["balance"].ToString();
                    float balance = float.Parse(bal);
                    float reqbal = float.Parse(PlnAmt);

                    if (balance >= reqbal && reqbal >= 0 && balance >= 0)
                    {
                        ds = objgdb.ByProcedure("[AddBalance_Get_APIResponse_CAPI_BSR]",
                            new string[] { "AssignNo", "Paid_value", "Confirmations", "Paid_Address", "Transaction_Hash", "SKey", "Rmrk", "TxnPayDate", "To_Address" },
                            new string[] { Assignno, balance.ToString(), "true", walletAddress, "", SKey, UserID, "", "" }, "");

                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            RtnRlt = ds.Tables[0].Rows[0]["SubmitStatus"].ToString();
                            reciaddress = ds.Tables[0].Rows[0]["TntoAddss"].ToString();
                            checkbaladd = ds.Tables[0].Rows[0]["SenAddress"].ToString();
                            string sendpvtkey = ds.Tables[0].Rows[0]["SendPKey"].ToString();
                            pvtkeey = DB.base64Decod(sendpvtkey);
                            Apiky = DynamicDtls.ApiKeyBEP20;
                        }

                        if (RtnRlt.Trim() == "IsOk")
                        {
                            decimal bnbbalance = CheckBNBBalance(checkbaladd);
                            if (bnbbalance < 0.0006m)
                            {
                                SendBNBTransaction(reciverAddress, reciverPrivateKey, walletAddress, "0.0006");
                            }

                            decimal bnbbalance1 = CheckBNBBalance(checkbaladd);
                            if (bnbbalance1 >= 0.0006m)
                            {
                            
                                MakeWithdrawal(EnPkey, reciaddress, bal.ToString(), ReciverAdd);
                            }
                        }
                        else
                        {
                            sc = false;
                            Msgs = ds.Tables[0].Rows[0]["MSG"].ToString();
                        }
                    }
                  
                }
               
            }
        }
        catch (WebException webEx)
        {
            string responseText = "";
            try
            {
                if (webEx.Response != null)
                {
                    using (var responseStream = webEx.Response.GetResponseStream())
                    {
                        if (responseStream != null && responseStream.CanRead)
                        {
                            using (var reader = new StreamReader(responseStream))
                            {
                                responseText = reader.ReadToEnd();
                            }
                        }
                        else
                        {
                            responseText = "Response stream not readable.";
                        }
                    }
                }
                else
                {
                    responseText = "No response received.";
                }
            }
            catch (Exception innerEx)
            {
                responseText = "Error reading response stream: " + innerEx.Message;
            }

            DB.WriteLog(this.ToString() + " WebException: " + webEx.Message + "\nAPI Response: " + responseText);
            msg = "Unable to connect to balance check API. Please try later.";
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

                string PlnAmt = ds.Tables[0].Rows[0]["PlanAmt"].ToString();
                string Pkey = ds.Tables[0].Rows[0]["XPubId"].ToString();
                ReciverAdd = ds.Tables[0].Rows[0]["ReceiverBTC"].ToString();

                EnPkey = DB.base64Decod(Pkey);
                GetUSDTBEP20Balance(ReciverAdd, PlnAmt);
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

    private void MakeWithdrawal(string senderPrivateKey, string toAddress, string amount, string senderAddress)
    {
        try
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;

            string url = "https://capi.redleaf.today/BEP20/Web3_SendTokenBalance.ashx";
            string postData = "senderPrivateKey=" + senderPrivateKey +
                              "&toAddress=" + toAddress +
                              "&amount=" + amount +
                              "&senderAddress=" + senderAddress;

            byte[] byteArray = Encoding.UTF8.GetBytes(postData);

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = byteArray.Length;
            request.Headers.Add("auth-token", "ff28233dab8ae08d0cf0e5eca1e00131494cf101f2393182c346577c7692bbe4");
            using (Stream dataStream = request.GetRequestStream())
            {
                dataStream.Write(byteArray, 0, byteArray.Length);
            }
            using (HttpWebResponse webResponse = (HttpWebResponse)request.GetResponse())
            using (StreamReader reader = new StreamReader(webResponse.GetResponseStream()))
            {
                string jsonResult = reader.ReadToEnd();
                JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
                Dictionary<string, object> parsedJson = jsSerializer.Deserialize<Dictionary<string, object>>(jsonResult);
                if (parsedJson.ContainsKey("status") && parsedJson["status"].ToString() == "Pending")
                {
                    //string txHash = parsedJson.ContainsKey("transactionHash") ? parsedJson["transactionHash"].ToString() : "N/A";
                }
                else
                {
                    Console.WriteLine(" Transaction Failed!");
                }
            }
        }
        catch (WebException webEx)
        {
            using (StreamReader reader = new StreamReader(webEx.Response.GetResponseStream()))
            {
                string errorMsg = reader.ReadToEnd();
                DB.WriteLog(this.ToString() + " Error Msg :" + webEx.Message + "\n" + "Response: " + errorMsg);
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            Console.WriteLine(" Sorry, something went wrong. Please try again later.");
        }
    }

    public void SendBNBTransaction(string senderAddress, string privateKey, string recipientAddress, string qty)
    {
        try
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;

            string url = "https://capi.redleaf.today/BEP20/Web3_SendBNBBalance.ashx";
            string postData = "senderaddress=" + Uri.EscapeDataString(senderAddress) +
                              "&privateKey=" + Uri.EscapeDataString(privateKey) +
                              "&recipientAddress=" + Uri.EscapeDataString(recipientAddress) +
                              "&qty=" + Uri.EscapeDataString(qty);

            byte[] byteArray = Encoding.UTF8.GetBytes(postData);
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = byteArray.Length;
            request.Headers.Add("auth-token", "ff28233dab8ae08d0cf0e5eca1e00131494cf101f2393182c346577c7692bbe4");
            using (Stream dataStream = request.GetRequestStream())
            {
                dataStream.Write(byteArray, 0, byteArray.Length);
            }
            HttpWebResponse webResponse = (HttpWebResponse)request.GetResponse();
            using (StreamReader reader = new StreamReader(webResponse.GetResponseStream()))
            {
                string jsonResult = reader.ReadToEnd();
                JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
                Dictionary<string, object> parsedJson = jsSerializer.Deserialize<Dictionary<string, object>>(jsonResult);
                if (parsedJson.ContainsKey("status") && parsedJson["status"].ToString() == "success")
                {
                    string txnHash = parsedJson.ContainsKey("transactionHash") ? parsedJson["transactionHash"].ToString() : "N/A";

                    Console.WriteLine("Transaction Successful!");
                    Console.WriteLine("Transaction Hash: " + txnHash);
                }
                else
                {
                    Console.WriteLine("Transaction Failed!");
                }
            }
        }
        catch (WebException webEx)
        {
            using (StreamReader reader = new StreamReader(webEx.Response.GetResponseStream()))
            {
                string errorMsg = reader.ReadToEnd();
                DB.WriteLog(this.ToString() + " Error Msg :" + webEx.Message + "\n" + "Response: " + errorMsg);
            }
            Console.WriteLine("Sorry, something went wrong. Please try again later.");
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            Console.WriteLine("Sorry, something went wrong. Please try again later.");
        }
    }

    public decimal CheckBNBBalance(string address)
    {
        decimal bnbBalance = 0;
        try
        {
            string url = "https://capi.redleaf.today/BEP20/Web3_CheckBNBBalance.ashx";
            string postData = "wallet_address=" + Uri.EscapeDataString(address);
            byte[] byteArray = Encoding.UTF8.GetBytes(postData);

            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";
            request.ContentLength = byteArray.Length;
            using (Stream dataStream = request.GetRequestStream())
            {
                dataStream.Write(byteArray, 0, byteArray.Length);
            }
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();
            using (StreamReader reader = new StreamReader(response.GetResponseStream()))
            {
                string jsonResult = reader.ReadToEnd();
                JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
                var parsedJson = jsSerializer.Deserialize<Dictionary<string, object>>(jsonResult);

                if (parsedJson.ContainsKey("status") && parsedJson["status"].ToString() == "success")
                {
                    string balance = parsedJson["balance"].ToString();
                    decimal.TryParse(balance, out bnbBalance);
                }
                else
                {
                    Console.WriteLine("Error: " + parsedJson["message"]);
                }
            }
        }
        catch (WebException webEx)
        {
            using (StreamReader reader = new StreamReader(webEx.Response.GetResponseStream()))
            {
                string errorMsg = reader.ReadToEnd();
                DB.WriteLog(this.ToString() + " Error Msg :" + webEx.Message + "\n" + "Response: " + errorMsg);
            }
            Console.WriteLine("Sorry, something went wrong. Please try again later.");
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            Console.WriteLine("Sorry, something went wrong. Please try again later.");
        }
        return bnbBalance;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}
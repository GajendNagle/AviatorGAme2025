<%@ WebHandler Language="C#" Class="DepositeAutoConfirm_CAPI" %>


using System;
using System.IO;
using System.Net;
using System.Web;
using System.Data;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Collections;


public class DepositeAutoConfirm_CAPI : IHttpHandler
{
    public static string UserID = "";
    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;
    public static string AssignNo = "", Paid_value = "", ContractAddres = "", Confirmations = "", Paid_Address = "", To_Address = "",
   Transaction_Hash = "", SKey = "", Msgs = "error", RtnRlt = "", txnDate = "", dtl = "", txnhash = "", reciverAddress = "", reciverPrivateKey = "", Assignno = "", rcVAdd = "", CPAmt1 = "", PSIperc = "";
    public bool sc;
    public int Conf;
    private int statusObj;
    public class TestResponse
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public string Detail { get; set; }

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

        try
        {
            ServicePointManager.SecurityProtocol = (SecurityProtocolType)3072;
            var ApiKeyBEP20 = DynamicDtls.ApiKeyBEP20;
            context.Response.ContentType = "application/json";
            SKey ="Succes24!7H1p";
            UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString().Trim();
            string contactAdd = "0x55d398326f99059fF775485246999027B3197955";
            if (context.Request.Cookies["Tap190Nvw92mst"] != null)
            {
                UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();
                if (!string.IsNullOrEmpty(SKey) && !string.IsNullOrEmpty(UserID))
                {
                    ds = objgdb.ByProcedure("[AddBalance_Get_APIResponse_CAPI]", new string[] { "AssignNo", "Paid_value", "Confirmations",
                           "Paid_Address", "Transaction_Hash", "SKey", "Rmrk","TxnPayDate","To_Address" },
                                                  new string[] { "", "", "true", "", "", SKey, UserID, "", "" }, "");
                    RtnRlt = ds.Tables[0].Rows[0]["SubmitStatus"].ToString();
                    reciverAddress = ds.Tables[0].Rows[0]["TntoAddss"].ToString();
                    PSIperc = ds.Tables[0].Rows[0]["PSIperc"].ToString();
                    Assignno = ds.Tables[0].Rows[0]["PaymentId"].ToString();
                    string  UserAddress = ds.Tables[0].Rows[0]["SenAddress"].ToString();
                    //var senderAddress = "0x14628689750B96EE64b2A83A1FF9e954150702EF";
                    string sendpvtkey = ds.Tables[0].Rows[0]["SendPKey"].ToString();
                   if (!string.IsNullOrEmpty(ApiKeyBEP20) && !string.IsNullOrEmpty(reciverAddress) && !string.IsNullOrEmpty(UserAddress))
                    {
                        //string url = string.Format("https://api.bscscan.com/api?module=account&action=tokentx&contractaddress={0}&address={1}&page=1&offset=25&startblock=0&endblock=999999999&sort=desc&apikey={2}", contactAdd, rcVAdd, ApiKeyBEP20);
                        string url = string.Format("https://api.bscscan.com/api?module=account&action=tokentx&contractaddress={0}&address={1}&page=1&offset=25&startblock=0&endblock=999999999&sort=desc&apikey={2}&_={3}",
                        contactAdd, UserAddress, ApiKeyBEP20, DateTime.Now.Ticks);

                        HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
                        request.Method = "GET";

                        using (HttpWebResponse webResponse = (HttpWebResponse)request.GetResponse())
                        using (StreamReader reader = new StreamReader(webResponse.GetResponseStream()))
                        {
                            string jsonResult = reader.ReadToEnd();
                            JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
                            Dictionary<string, object> parsedJson = jsSerializer.Deserialize<Dictionary<string, object>>(jsonResult);
                            object data = parsedJson["result"];
                            if (data == null)
                            {
                                sc = false;
                                Msgs = "No Transaction Found";
                            }
                            if (data is ArrayList)
                            {
                                ///////////////////////////
                                List<string> existingTxnHashes = new List<string>();
                                DataSet dsCheckTxn = objgdb.ByProcedure("[Proc_CheckTxnHashExistencedeposite]",
                                    new string[] { "MemId" },
                                    new string[] { UserID },
                                    "");

                                if (dsCheckTxn != null && dsCheckTxn.Tables.Count > 0 && dsCheckTxn.Tables[0].Rows.Count > 0)
                                {
                                    foreach (DataRow row in dsCheckTxn.Tables[0].Rows)
                                    {
                                        existingTxnHashes.Add(row["TxnHash"].ToString().ToLower());
                                    }
                                }
                                /////////////////////////////
                                ArrayList transactions = (ArrayList)data;
                                Console.WriteLine("Total Transactions: " + transactions.Count);
                                foreach (Dictionary<string, object> transaction in transactions)
                                {
                                    string txnhash = transaction["hash"].ToString();
                                    if (existingTxnHashes.Contains(txnhash.ToLower()))
                                    {
                                        continue;
                                    }
                                    Paid_Address = transaction["from"].ToString();
                                    To_Address = transaction["to"].ToString();

                                    ContractAddres = transaction["contractAddress"].ToString();
                                        if (To_Address.ToUpper() == reciverAddress.ToUpper() && ContractAddres.ToUpper() == contactAdd.ToUpper())
                                    {
                                        txnhash = transaction["hash"].ToString();
                                        Paid_value = transaction["value"].ToString();
                                        Conf = Convert.ToInt32(transaction["confirmations"]);
                                        decimal paidValue = Convert.ToDecimal(Paid_value);
                                        decimal planamount = paidValue / 1000000000000000000;
                                        if (Conf >= 3)
                                        {
                                            Confirmations = "true";
                                            ds = objgdb.ByProcedure("GetDepositAddress_CrytoAPI", new string[]
             { "NewBTC", "MemID", "AdsIndex", "XpubID", "ReqType", "Deptype", "PlnAmt", "SeqPwd" }
             , new string[] { Assignno, UserID.Trim(), To_Address, "", "Txn_Hash", "USDT.BEP20", planamount.ToString(), txnhash }, "das");

                                            if (ds.Tables[0].Rows.Count > 0)
                                            {
                                                RtnRlt = ds.Tables[0].Rows[0]["Rlt"].ToString();
                                                Msgs = ds.Tables[0].Rows[0]["Msg"].ToString();
                                                sc = true;

                                            }
                                            if (RtnRlt == "IsOk")
                                            {

                                                sc = true;
                                                break;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        sc = false;
                                        Msgs = "Wrong transaction Hash";
                                    }
                                }
                            }
                            else
                            {
                                sc = false;
                                Msgs = "Invalid Payment Type";
                            }



                        }
                    }
                    else
                    {
                        sc = false;
                        Msgs = "Required fields are missing.";
                    }
                }
            }
            else
            {
                sc = false;
                Msgs = "User not authenticated.";
            }

        }
        catch (Exception ex)
        {
            sc = false;
            Msgs = "Sorry, Something is wrong please try later !";
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }

        WriteJson(new TestResponse(sc, Msgs, dtl));
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
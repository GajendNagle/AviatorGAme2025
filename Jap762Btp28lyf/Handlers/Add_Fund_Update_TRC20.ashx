<%@ WebHandler Language="C#" Class="Add_Fund_Update_TRC20" %>

using System;
using System.IO;
using System.Net;
using System.Web;
using System.Data;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Collections;

public class Add_Fund_Update_TRC20 : IHttpHandler
{
    //transaction hash USDT
    //https://tronscan.io/#/token20/TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t
    public static string UserID = "";
    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;
    public string AssignNo = "", Paid_value = "", ContractAddres = "", Confirmations = "", Paid_Address = "", To_Address = "",
        Transaction_Hash = "", SKey = "", Msgs = "error", RtnRlt = "", txnDate = "", dtl = "", txnhash = "";
    public bool sc;
    public int Conf;

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
            // Retrieve form values
            string Assignno = context.Request.Form["ODsID"];
            string Transaction_Hash = context.Request.Form["transaction_hash"];
            string rcVAdd = context.Request.Form["RcVAdd"];
            string SKey = context.Request.Form["Skey"];
            //string ApiKeyBEP20 = DynamicContent.ApiKeyBEP20;
            string ApiKeyTRC20 = DynamicContent.ApiKeyTRC20;
            string contactAdd = "TR7NHqjeKQxGTCi8q8ZY4pL8otSzgjLj6t";
            //string contactAdd = "TJy2LR9FFrP7ZQw99CRfHeiFCG2RZUasGF";

            if (context.Request.Cookies["Tap190Nvw92mst"] != null)
            {
                UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();

                if (!string.IsNullOrEmpty(SKey) && !string.IsNullOrEmpty(Assignno) &&
                    !string.IsNullOrEmpty(Transaction_Hash) && !string.IsNullOrEmpty(rcVAdd) &&
                    !string.IsNullOrEmpty(ApiKeyTRC20))
                {
                    string url = string.Format("https://apilist.tronscan.org/api/transaction-info?hash={0}", Transaction_Hash);
                    HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
                    request.Method = "GET";
                    System.Net.ServicePointManager.SecurityProtocol =
SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;

                    using (HttpWebResponse webResponse = (HttpWebResponse)request.GetResponse())
                    using (StreamReader reader = new StreamReader(webResponse.GetResponseStream()))
                    {
                        string jsonResult = reader.ReadToEnd();
                        JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
                        var parsedJson = jsSerializer.Deserialize<Dictionary<string, object>>(jsonResult);


                        bool confirmed = parsedJson.ContainsKey("confirmed") && (bool)parsedJson["confirmed"];
                        string toAddress = parsedJson.ContainsKey("toAddress") ? parsedJson["toAddress"].ToString() : string.Empty;
                        string hash = parsedJson.ContainsKey("hash") ? parsedJson["hash"].ToString() : string.Empty;
                        int confirmations = parsedJson.ContainsKey("confirmations") ? Convert.ToInt32(parsedJson["confirmations"]) : 0;
                        long timestamp = parsedJson.ContainsKey("timestamp") ? Convert.ToInt64(parsedJson["timestamp"]) : 0;



                        DateTime trxDate = new DateTime(1970, 1, 1).AddMilliseconds(timestamp).ToLocalTime();
                        txnDate = trxDate.ToString("yyyy-MM-dd HH:mm:ss");
                        string amountStr = string.Empty;
                        string fromAddress = string.Empty;
                        string contractAddress = string.Empty;
                        string symbol = string.Empty;

                        // if (parsedJson.ContainsKey("trc20TransferInfo"))
                        if (parsedJson.ContainsKey("contractData") && parsedJson["contractData"] != null)
                        {
                            var transferInfoList = parsedJson["contractData"] as Dictionary<string, object>;
                            // var transferInfoList = parsedJson["contractData"] as List<object>;
                            if (transferInfoList != null)
                            {
                                foreach (var item in transferInfoList)
                                {
                                    if (hash == Transaction_Hash)
                                    {
                                        fromAddress = transferInfoList.ContainsKey("owner_address") ? transferInfoList["owner_address"].ToString() : string.Empty;
                                        toAddress = transferInfoList.ContainsKey("to_address") ? transferInfoList["to_address"].ToString() : string.Empty;
                                        amountStr = transferInfoList.ContainsKey("amount") ? transferInfoList["amount"].ToString() : string.Empty;

                                        contractAddress = transferInfoList.ContainsKey("contract_address") ? transferInfoList["contract_address"].ToString() : string.Empty;
                                        symbol = transferInfoList.ContainsKey("symbol") ? transferInfoList["symbol"].ToString() : string.Empty;

                                        //if (confirmed && confirmations >= 3 && rcVAdd.ToUpper() == toAddress.ToUpper() && contactAdd.ToUpper() == contractAddress.ToUpper() && symbol == "USDT")
                                        if (confirmations >= 3 && rcVAdd.ToUpper() == toAddress.ToUpper())
                                        {
                                            Confirmations = "true";
                                            ds = objgdb.ByProcedure("[AddBalance_Get_APIResponse_BSR]", new string[] {
                                        "AssignNo", "Paid_value", "Confirmations", "Paid_Address", "Transaction_Hash",
                                          "SKey", "Rmrk", "TxnPayDate", "To_Address" }, new string[] {
                                          Assignno, amountStr, Confirmations, fromAddress, Transaction_Hash, SKey, UserID, txnDate, toAddress }, "");

                                            if (ds.Tables[0].Rows.Count > 0)
                                            {
                                                RtnRlt = ds.Tables[0].Rows[0]["SubmitStatus"].ToString();
                                                Msgs = ds.Tables[0].Rows[0]["MSG"].ToString();
                                                sc = true;

                                            }
                                            if (RtnRlt == "IsOk")
                                            {

                                                sc = true;
                                                break;
                                            }
                                            else
                                            {

                                                sc = false;
                                                break;
                                            }
                                        }
                                        else
                                        {
                                            sc = false;
                                            Msgs = "Transaction not confirmed or addresses do not match.";
                                        }
                                    }
                                    else
                                    {
                                        sc = false;
                                        Msgs = "Invalid hash";
                                    }
                                }
                            }
                        }



                    }
                }
                else
                {
                    sc = false;
                    Msgs = "Required fields are missing.";
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
            Msgs = "An error occurred: " + ex.Message;
        }

        WriteJson(new TestResponse(sc, Msgs, dtl));
    }


    public bool IsReusable
    {
        get { return false; }
    }
}

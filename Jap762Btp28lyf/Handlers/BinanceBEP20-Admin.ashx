<%@ WebHandler Language="C#" Class="BinanceBEP20" %>

using System;
using System.IO;
using System.Net;
using System.Web;
using System.Data;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Collections;

public class BinanceBEP20 : IHttpHandler
{

    //transaction hash USDT
    //https://bscscan.com/token/0x55d398326f99059ff775485246999027b3197955

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
    public void confi(string Transaction_Hash, string ApiKeyBEP20)
    {
        objgdb.FillWebSiteEmailCompany();
        try
        {
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
            string url = string.Format("https://api.bscscan.com/api?module=transaction&action=getstatus&txhash={0}&apikey={1}", Transaction_Hash, ApiKeyBEP20);
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "GET";

            using (HttpWebResponse webResponse = (HttpWebResponse)request.GetResponse())
            using (StreamReader reader = new StreamReader(webResponse.GetResponseStream()))
            {
                string jsonResult = reader.ReadToEnd();
                JavaScriptSerializer jsSerializer = new JavaScriptSerializer();
                Dictionary<string, object> parsedJson = jsSerializer.Deserialize<Dictionary<string, object>>(jsonResult);

                if (parsedJson.ContainsKey("result"))
                {
                    var resultObj = parsedJson["result"] as Dictionary<string, object>;

                    if (resultObj != null && resultObj.ContainsKey("isError"))
                    {
                        statusObj = Convert.ToInt32(resultObj["isError"]);
                    }
                    else
                    {
                        sc = false;
                        Msgs = "Failed transaction.";
                    }
                }
                else
                {
                    sc = false;
                    Msgs = "Canceled transaction.";
                }
            }
        }
        catch (Exception ex)
        {
            sc = false;
            Msgs = "An error occurred: " + ex.Message;
        }
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

            //string rcVAdd = "0x7bb89460599dbf32ee3aa50798bbceae2a5f7f6a";
            string SKey = context.Request.Form["Skey"];
            string sadd = context.Request.Form["address"];
            string ApiKeyBEP20 = DynamicContent.ApiKeyBEP20;
            string contactAdd1 = context.Request.Form["contract"];
            string contactAdd_USDT = context.Request.Form["contract_address_USDT"];
            string withdrawadd = DynamicContent.withdraw;

            string contactAdd = (Assignno == "Deposit") ? contactAdd1 : contactAdd_USDT;
            //string contactAdd = (Assignno == "Deposit") ? contactAdd_USDT : contactAdd1;

            // Check for authenticated user
            //if (context.Request.Cookies["Lrt67iuj32ftgv"] != null)
            //{
            //UserID = DB.base64Decod(context.Request.Cookies["Lrt67iuj32ftgv"].Value).ToString();
            confi(Transaction_Hash, ApiKeyBEP20);
            if (statusObj == 0)
            {
                if (!string.IsNullOrEmpty(Assignno) && !string.IsNullOrEmpty(Transaction_Hash) && !string.IsNullOrEmpty(SKey) && !string.IsNullOrEmpty(ApiKeyBEP20))
                {

                    string url = string.Format("https://api.bscscan.com/api?module=account&action=tokentx&contractaddress={0}&address={1}&page=1&offset=25&startblock=0&endblock=999999999&sort=desc&apikey={2}", contactAdd, sadd, ApiKeyBEP20);
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
                        if (Assignno == "Deposit" || Assignno == "Node")
                        {
                            if (data is ArrayList)
                            {
                                ArrayList transactions = (ArrayList)data;
                                foreach (Dictionary<string, object> transaction in transactions)
                                {
                                    txnhash = transaction["hash"].ToString();

                                    if (Transaction_Hash == txnhash)
                                    {
                                        Paid_Address = transaction["from"].ToString();
                                        To_Address = transaction["to"].ToString();
                                        Paid_value = transaction["value"].ToString();
                                        ContractAddres = transaction["contractAddress"].ToString();

                                        Conf = Convert.ToInt32(transaction["confirmations"]);
                                        if (Conf >= 3)
                                        {
                                            Confirmations = "1";
                                            if (sadd.ToUpper() == Paid_Address.ToUpper() && ContractAddres.ToUpper() == contactAdd.ToUpper())
                                            {
                                                ds = objgdb.ByProcedure("[FinalInvestment_UserDetails]", new string[]
                                                {
                                    "AssignNo", "Paid_value", "Confirmations", "Paid_Address", "Transaction_Hash",
                                    "SKey", "Rmrk"
                                                }, new string[]
                                                {
                                    sadd, Paid_value, Confirmations, Paid_Address, Transaction_Hash,
                                    SKey, Assignno
                                                }, "");
                                                if (ds.Tables[0].Rows.Count > 0)
                                                {
                                                    RtnRlt = ds.Tables[0].Rows[0]["SubmitStatus"].ToString();
                                                    Msgs = ds.Tables[0].Rows[0]["Error"].ToString();
                                                    sc = true;
                                                }
                                                if (RtnRlt == "Ok")
                                                {
                                                    sc = true;
                                                    HttpCookie cookie = new HttpCookie("PaymentTxn");
                                                    cookie.Value = "Confirm";
                                                    cookie.Expires = DateTime.Now.AddDays(1);
                                                    context.Response.Cookies.Add(cookie);
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
                                                Msgs = "No data returned from stored procedure.";
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
                        else if (Assignno == "Withdrawal")
                        {
                            if (data is ArrayList)
                            {
                                ArrayList transactions = (ArrayList)data;
                                foreach (Dictionary<string, object> transaction in transactions)
                                {
                                    txnhash = transaction["hash"].ToString();

                                    if (Transaction_Hash == txnhash)
                                    {
                                        Paid_Address = transaction["from"].ToString();
                                        To_Address = transaction["to"].ToString();
                                        Paid_value = transaction["value"].ToString();
                                        ContractAddres = transaction["contractAddress"].ToString();
                                        Conf = Convert.ToInt32(transaction["confirmations"]);
                                        if (Conf >= 3)
                                        {
                                            Confirmations = "1";
                                            if (To_Address.ToUpper() == sadd.ToUpper() && Paid_Address.ToUpper() == withdrawadd.ToUpper())
                                            {
                                                ds = objgdb.ByProcedure("[FinalInvestment_UserDetails]", new string[]
                                                {
                                    "AssignNo", "Paid_value", "Confirmations", "Paid_Address", "Transaction_Hash",
                                    "SKey", "Rmrk"
                                                }, new string[]
                                                {
                                    SKey, Paid_value, Confirmations, Paid_Address, Transaction_Hash,
                                    SKey, Assignno
                                                }, "");
                                                if (ds.Tables[0].Rows.Count > 0)
                                                {
                                                    RtnRlt = ds.Tables[0].Rows[0]["SubmitStatus"].ToString();
                                                    Msgs = ds.Tables[0].Rows[0]["Error"].ToString();
                                                    sc = true;

                                                }
                                                if (RtnRlt == "IsOk")
                                                {
                                                    sc = true;
                                                    HttpCookie cookie = new HttpCookie("PaymentTxn");
                                                    cookie.Value = "Confirm";
                                                    cookie.Expires = DateTime.Now.AddDays(1);
                                                    context.Response.Cookies.Add(cookie);
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
                                                Msgs = "No data returned from stored procedure.";
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
                }
                else
                {
                    sc = false;
                    Msgs = "Required fields are missing.";
                }
            }
            else
            {
                BTC_APIResponse(Transaction_Hash,sadd);
            }

            //}
            //else
            //{
            //    sc = false;
            //    Msgs = "User not authenticated.";
            //}
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

    private void BTC_APIResponse(string Transaction_Hash, string sadd)
    {
        //UserID = DB.base64Decod(context.Request.Cookies["Prl96gyj75tndf"].Value).ToString();
        Paid_value = "0";
        Confirmations = "OUT_OF_ENERGY";
        SKey = "535347VTR5u1";
        try
        {
            ds = objgdb.ByProcedure("[TRX_Get_APIResponse]", new string[] { "AssignNo", "Paid_value", "Confirmations",
                "Paid_Address", "Transaction_Hash", "SKey", "Rmrk" },
           new string[] { SKey, Paid_value, Confirmations, Paid_Address, Transaction_Hash, SKey, sadd }, "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                Msgs = ds.Tables[0].Rows[0]["Msg"].ToString();
                RtnRlt = ds.Tables[0].Rows[0]["Rtrn"].ToString();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }
}
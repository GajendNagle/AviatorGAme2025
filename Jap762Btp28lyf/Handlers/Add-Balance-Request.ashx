<%@ WebHandler Language="C#" Class="Add_Balance_Request" %>

using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.IO;
using System.Data;

public class Add_Balance_Request : IHttpHandler {
    
   public HttpContext context; public HttpRequest request; public HttpResponse response;
    DynamicDtls objgdb = new DynamicDtls(); DataSet ds; DataTable dt;
    public string ReqCurrcy = "", amount = "", eMailAddss = "",payed_amount="", account_number = "", ifsc = "",
        channel_id = "", client_id = "", provider_id = "", SKey = "", PayoutIDs = "", PGStatus = "", PGorderid = "", PGUTR = "", PGReportID = "", PGMessage = "";
    public static int TotUser = 0;
    public static string UserID = "";
    public bool sc;
    public string msg,msg1, Msgs, dtl, RtnRlt, strJson;
    //libCoinPaymentsNET.CoinPayments cp = new libCoinPaymentsNET.CoinPayments("e3dc997da4C850dF090be6B18a07A2FDeb2e4e85991343b76A49c8046c30933d", "847dbf31ab4769aae2f8b2eef0f8af787887482cc175948f93d284c0fd5d1893");
    public class test
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public string Message1 { get; set; }
        public string detail { get; set; }
        public string aid { get; set; }
        public test(bool sc, string msg, string dtl, string msg1)
        {
            Success = sc;
            Message = msg;
            detail = dtl;
            Message1 = msg1;
        }
    }
    public void handleRequest()
    {
        writeJson(new test(sc, msg, msg1, dtl));
    }
    public void writeJson(object _object)
    {
        JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
        string jsondata = javaScriptSerializer.Serialize(_object);
        writeRaw(jsondata);
    }
    public void writeRaw(string text)
    {
        context.Response.Write(text);
    }
    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";
        if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        {
            UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString().Trim();
            amount = context.Request["txtReqAmt"].Trim();
            //amount = context.Request["amount"].Trim();
            ReqCurrcy = context.Request["paymode"].Trim();
            eMailAddss = context.Request["eMailAddss"].Trim();
            GiveHelpOrder();
            handleRequest();

        }
        else
        {
            context.Response.Write("<script>window.open('../login.html','_top');</script>");
        }
        //mobile_number 8860181421 Employee/Vendor Mobile Number (Indian Mobile Number)
    }
    public void GiveHelpOrder()
    {
        try
        {
            //if (txtMemId != "" && txtTransPWD != "" && txtTopUpAmount != "")
            //{
            ds = objgdb.ByProcedure("Add_Balance_Request", new string[] { "Memid", "Amt", "Comment", "PaymentMode", "InstMode", "PaymentId", "DateAdm", "TransId", "FromMemId" }
                        , new string[] { UserID.Trim(), amount.Trim(), "", ReqCurrcy.Trim(), "By User", "SecPWD", "", "", UserID.Trim() }, "das");
            if (ds.Tables[0].Rows[0]["SubmitStatus"].ToString() == "Ok")
            {
                payed_amount = ds.Tables[0].Rows[0]["Amt"].ToString();
                ////////
                sc = true;
                msg = ds.Tables[0].Rows[0]["Error"].ToString();
                //SortedList<string, string> parms = new SortedList<string, string>();
                /////
                //parms.Add("amount", payed_amount);
                //parms.Add("currency1", "USD");
                //parms.Add("currency2", ReqCurrcy);
                //parms.Add("buyer_email", eMailAddss);
                //parms.Add("ipn_url", "https://trxdaddy.com/Jh4sd4Iks83Kn2/Handlers/CoinPayments-IPN.ashx");

                //parms.Add("buyer_name", UserID);
                //parms.Add("item_name", "Fund Request");
                ////parms.Add("invoice", "9828");                
                ////create_transaction
                ////get_basic_info
                //dynamic objValue;
                //var ret = cp.CallAPI("create_transaction", parms);
                ////var ret = cp.CallAPI("get_basic_info", null);
                ////ret.Dump();
                //Dictionary<string, object> dict = new Dictionary<string, object>();
                ////
                ////	//Get Value to pull dictionary items out.
                //ret.TryGetValue("result", out objValue);
                //dict = objValue;
                ////get_basic_info
                ////{"error":"ok","result":{"uername":"","username":"","merchant_id":"1552a87d07066d55b562d0b84d483168","email":"","public_name":"","time_joined":1481111704,"kyc_status":false,"swych_tos_accepted":false}}
                ////create_transaction
                ////{"error":"ok","result":{"amount":"0.00003000","txn_id":"CPEK70Y52XKFRWYZQWFZ8YAZW7","address":"39MgRyGm5NwTfSw1TfUGJXe2JCmzuRvLSN","confirms_needed":"2","timeout":28800,"checkout_url":"https:\/\/www.coinpayments.net\/index.php?cmd=checkout&id=CPEK70Y52XKFRWYZQWFZ8YAZW7&key=48ba3e1b925bb19a646427af1335b637","status_url":"https:\/\/www.coinpayments.net\/index.php?cmd=status&id=CPEK70Y52XKFRWYZQWFZ8YAZW7&key=48ba3e1b925bb19a646427af1335b637","qrcode_url":"https:\/\/www.coinpayments.net\/qrgen.php?id=CPEK70Y52XKFRWYZQWFZ8YAZW7&key=48ba3e1b925bb19a646427af1335b637"}}
                //// context.Response.Write(dict["checkout_url"]);
                //BindResultUpdt(dict["txn_id"].ToString(), dict["address"].ToString(), dict["checkout_url"].ToString(), dict["amount"].ToString());
            }
            else
            {
                sc = false;
                //msg = "<div class='alert alert-danger alert-bordered fade in' style='margin:5px;'>" + ds.Tables[0].Rows[0]["Error"].ToString() + "<span class='close' data-dismiss='alert'>&times;</span></div>";
                msg = ds.Tables[0].Rows[0]["Error"].ToString();
            }
            //}
            //else
            //{
            //    sc = false;
            //    //msg = "<span style='color:#FF8A00;'>Please fill required fields in Pay it forward form !</span>";
            //    msg = "Please fill required fields in Pay it forward form !";
            //}
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            //sc = false;
            msg = "Sorry, Something is wrong please try later !";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }

    private void BindResultUpdt(string TxnID, string NewBTC, string checkout_url, string currency2Amt)
    {
        try
        {
            ds = objgdb.ByProcedure("dbo.GetDepositAddress", new string[] { "NewBTC", "MemID", "AdsIndex", "XpubID", "ReqType", "Deptype", "PlnAmt", "SeqPwd" },
                   new string[] { NewBTC.Trim(), UserID.Trim(), currency2Amt, TxnID, "Fund Request", ReqCurrcy, amount, "" }, "ByDataset");
            if (ds.Tables[0].Rows.Count > 0)
            {
                RtnRlt = ds.Tables[0].Rows[0]["Rlt"].ToString();
            }
            if (RtnRlt.ToString().Trim() == "IsOk")
            {
                sc = true;
                msg = NewBTC;//ds.Tables[0].Rows[0]["RcvrAdd"].ToString();
                msg1 = currency2Amt;
            }
            else
            {
                sc = false;
                msg = ds.Tables[0].Rows[0]["Msg"].ToString();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            context.Response.Write(ex.Message);
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
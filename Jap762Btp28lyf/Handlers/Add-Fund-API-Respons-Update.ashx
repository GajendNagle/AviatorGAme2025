<%@ WebHandler Language="C#" Class="Add_Fund_API_Respons_Update" %>

using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.IO;
using System.Data;

public class Add_Fund_API_Respons_Update : IHttpHandler {

    public HttpContext context; public HttpRequest request; public HttpResponse response;
    DynamicDtls objgdb = new DynamicDtls(); DataSet ds;
    public string AssignNo = "", Paid_value = "", Confirmations = "", Paid_Address = "", To_Address = "",
        Transaction_Hash = "", SKey = "", Msgs = "error", RtnRlt = "NotOk", txnDate = "", UserID = "", dtl = "";
    public bool sc;
    public class test
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public string Message1 { get; set; }
        public string detail { get; set; }
        public string aid { get; set; }
        public test(bool sc, string msg, string dtl)
        {
            Success = sc;
            Message = msg;
            detail = dtl;
        }
    }
    public void handleRequest()
    {
        writeJson(new test(sc, Msgs, dtl));
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
        ////   
        if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        {
            //
            UserID = "";
            UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();
            /////////
            //SKey = DB.base64Decod(context.Request["Skey"].ToString());
            SKey = context.Request["Skey"].ToString();
            AssignNo = context.Request["ODsID"].ToString();
            Paid_value = context.Request["value"].ToString();
            Confirmations = context.Request["Conf"].ToString();
            Transaction_Hash = context.Request["transaction_hash"].ToString();
            Paid_Address = context.Request["fromaddress"].ToString();
            To_Address = context.Request["toaddress"].ToString();
            txnDate = context.Request["transaction_dt"].ToString();
            ////              
            BTC_APIResponse();
            ////
            handleRequest();
        }
    }

    public void BTC_APIResponse()
    {
        if (Confirmations == "NaN")
        {
            Confirmations = "0";
        }
        try
        {
            ds = objgdb.ByProcedure("[AddBalance_Get_APIResponse]", new string[] { "AssignNo", "Paid_value", "Confirmations",
                "Paid_Address", "Transaction_Hash", "SKey", "Rmrk","TxnPayDate","To_Address" },
            new string[] { AssignNo, Paid_value, Confirmations, Paid_Address, Transaction_Hash, SKey, UserID, txnDate, To_Address }, "");

            if (ds.Tables[0].Rows.Count > 0)
            {
                RtnRlt = ds.Tables[0].Rows[0]["SubmitStatus"].ToString();
            }
            if (RtnRlt.ToString().Trim() == "IsOk")
            {
                sc = true;
                Msgs = ds.Tables[0].Rows[0]["MSG"].ToString();
            }
            else
            {
                sc = false;
                Msgs = ds.Tables[0].Rows[0]["MSG"].ToString();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            Msgs = "Sorry, Something is wrong please try later !";
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
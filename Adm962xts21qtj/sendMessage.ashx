<%@ WebHandler Language="C#" Class="sendMessage" %>

using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.IO;
using System.Data;

public class sendMessage : IHttpHandler {

    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc; public string msg, Msgs, dtl, strJson, UserID, RtnRlt, message, OrderId;
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;
    public class test
    {
        public bool Success { get;set;}
        public string Message { get;set;}
        public string detail { get;set;}
        public string aid { get; set; }
        public test(bool sc, string msg, string dtl)
        {
            Success = sc;
            Message = msg;
            detail = dtl;
        }
    }
    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";
        /////////
        UserID = context.Request["emailID"].ToString();
        message = context.Request["message"].ToString();
        OrderId = context.Request["OrderId"].ToString();
        /////////
        GiveHelpOrder();
        /////////
        handleRequest();
    }
    public void handleRequest()
    {
        writeJson(new test(sc, msg, dtl));
    }

    public void GiveHelpOrder()
    {
        try
        {
            ds = objgdb.ByProcedure("dbo.tkt_ProcMessageOnRequest", new string[] { "AdsId", "Username", "Comment", "Imagepath", "SenderType", "type" },
                new string[] { OrderId, UserID, message, "","","100" }, "ByDataset");
            if (ds.Tables[0].Rows.Count > 0)
            {
                RtnRlt = ds.Tables[0].Rows[0]["Rlt"].ToString();
                Msgs = ds.Tables[0].Rows[0]["Msg"].ToString();
            }
            if (RtnRlt.ToString().Trim() == "IsOk")
            {
                sc = true;
                msg = Msgs;
            }
            else
            {
                sc = false;
                msg = Msgs;
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            msg = ex.Message;
            sc = false;
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
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
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


}
<%@ WebHandler Language="C#" Class="Delete_Ticket" %>
using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.IO;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public class Delete_Ticket : IHttpHandler {
    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc;
    public string msg, Msgs, dtl, RtnRlt, strJson, UserID, topicId, EmailAddress, FullName,
        PhoneNumber, ext, IssueSummary, IssueDetails;
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

    public void handleRequest()
    {
        writeJson(new test(sc, msg, dtl));
    }

    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";
        /////////
        if (context.Request.Cookies["Tap190Nvw92mst"] != null || context.Request.Cookies["ClientBlock"] != null)
        {
            if (context.Request.Cookies["Tap190Nvw92mst"] != null)
            {
                UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();
            }
            if (context.Request.Cookies["ClientBlock"] != null)
            {
                UserID = DB.base64Decod(context.Request.Cookies["ClientBlock"].Value).ToString();
            }
            if (context.Request.QueryString["dltord"].ToString() != null)
            {
                topicId = context.Request.QueryString["dltord"].ToString();
                GiveHelpOrder();
            }
            ////////
            handleRequest();
        }
        else
        {
            context.Response.Write("<script>window.open('../login.html','_top');</script>");
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

    public void GiveHelpOrder()
    {
        try
        {
                ds = objgdb.ByProcedure("dbo.tkt_ProcMessageOnRequest", new string[] { "AdsId", "Username", "Comment", "Imagepath", "SenderType", "type" },
                new string[] { topicId, UserID, "", "", "", "600" }, "ByDataset");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Msgs = ds.Tables[0].Rows[0]["Msg"].ToString();
                    RtnRlt = ds.Tables[0].Rows[0]["Rlt"].ToString();
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
            sc = false;
            msg = ex.Message;
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
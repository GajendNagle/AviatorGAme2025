<%@ WebHandler Language="C#" Class="Upload_Avtar" %>
using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.IO;
using System.Drawing;
using Image = System.Drawing.Image;
using System.Data;

public class Upload_Avtar : IHttpHandler {
    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc;
    public string msg, Msgs, dtl, strJson, UserID, RtnRlt, message, OrderId, fname, chkfileEx,fileext,
    SDbFilePath = "" ,  PImgPth = "";
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;
    const int maxFileLength = 302400;
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
        if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        {
            UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();
            SDbFilePath = context.Request.Form["avtarId"];
            /////////
            GiveHelpOrder();
            /////////
            handleRequest();
        }
        else
        {
            context.Response.Write("<script>window.open('../login.html','_top');</script>");
        }
    }
    public void handleRequest()
    {
        writeJson(new test(sc, msg, dtl));
    }
    public void GiveHelpOrder()
    {
        try
        {
            ds = objgdb.ByProcedure("dbo.Upload_Profile_Pics", new string[] { "MemID", "MemPicName", "type" },
                new string[] { UserID, SDbFilePath, "UpdatePics" }, "ByDataset");
            if (ds.Tables[0].Rows.Count > 0)
            {
                RtnRlt = ds.Tables[0].Rows[0]["Rlt"].ToString();
                Msgs = ds.Tables[0].Rows[0]["Msg"].ToString();
               
                ////delete previou
                
                /////
            }
            if (RtnRlt.ToString().Trim() == "IsOk")
            {
                sc = true;
                msg = Msgs;
                //context.Response.Write("<script>window.open('../modify-myinfo.html','_top');</script>");
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
            msg = "Something went wrong. Sorry, we have let our engineers know. Try again!";
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
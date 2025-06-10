<%@ WebHandler Language="C#" Class="GetServer_Time" %>

using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Net.Mail;
using System.IO;
using System.Data;

public class GetServer_Time : IHttpHandler {

    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc;
    public string msg, Msgs, dtl;
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
        GiveHelpOrder();
        handleRequest();
        //if (context.Request.Cookies["Tyd54asDF6Mnsl"] != null)
        //{          
        //    /////////
        //    GiveHelpOrder();
        //    ////////
        //    handleRequest();
        //}
        //else
        //{
        //     context.Response.Write("<script>window.open('../login.html','_top');</script>");
        //}
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
        sc = true;
        msg = DateTime.Now.ToString();
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
<%@ WebHandler Language="C#" Class="is_login" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using System.Data;

public class is_login : IHttpHandler { 
    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    DataSet ds = new DataSet();
    float WalletBlnc;
    string UserId;
    DataTable dt;
    public float BetAPending;
    public float BetBPending;
    DynamicDtls objgdb = new DynamicDtls();


    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";

        /////////
        try
        {
            if (context.Request.Cookies["Tap190Nvw92mst"] != null)
            {
               WriteJsonResponse(true, "User Login he");
            }
            else
            {
                WriteJsonResponse(false, "Not Authenticated");
                context.ApplicationInstance.CompleteRequest();
                    return;
            }
        }
        catch (Exception ex)
        {

            WriteJsonResponse(false, "ERror :" + ex.Message);
        }

    }

    private void WriteJsonResponse(bool success, string message)
    {
        var result = new
        {
            isSuccess  = success,
            Message = message
        };
        string json = new JavaScriptSerializer().Serialize(result);
        response.Write(json);
    }

    public bool IsReusable
    {
        get { return false; }
    }
}
<%@ WebHandler Language="C#" Class="increamentor" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.SessionState;

public class increamentor : IHttpHandler
{
    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    DataSet ds = new DataSet();
    double crash;
    DataTable dt;
    public float BetAPending;
    public float BetBPending;

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";

        string token = context.Request["token"];
        string isbet = context.Request["isbet"];
        string gameId = context.Request["game_id"];

        // Crash value logic
        Random rand = new Random();
         crash = rand.NextDouble() * (10.0 - 1.10) + 1.10;

        if (isbet == "1" && crash > 3.0)
        {
            crash = 1.11;
        }

        crash = Math.Round(crash, 2);

        // Prepare response object
        var resultObj = new
        {
            result = crash
        };

        string json = new JavaScriptSerializer().Serialize(resultObj);
        context.Response.Write(json);
    }

    public bool IsReusable
    {
        get { return false; }
    }
}
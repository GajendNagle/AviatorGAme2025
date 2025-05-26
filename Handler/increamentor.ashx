<%@ WebHandler Language="C#" Class="increamentor" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using System.Text; // for Base64 encoding

public class increamentor : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";

        string token = context.Request["token"];
        string isbet = context.Request["isbet"];
        string gameId = context.Request["game_id"];

        Random rand = new Random();
        double crash = rand.NextDouble() * (10.0 - 1.10) + 1.10;

        if (isbet == "1" && crash > 3.0)
        {
            crash = 1.11;
        }

        crash = Math.Round(crash, 2);

        var resultObj = new
        {
            result = crash
        };

        // Serialize to JSON
        string json = new JavaScriptSerializer().Serialize(resultObj);

        // Encode JSON to Base64
        string base64Encoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(json));

        // Return Base64 string
        context.Response.Write(base64Encoded);
    }

    public bool IsReusable
    {
        get { return false; }
    }
}

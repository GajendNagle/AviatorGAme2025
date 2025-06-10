<%@ WebHandler Language="C#" Class="increamentor" %>

using System;
using System.Text;
using System.Web;
using System.Data;
using System.Web.Script.Serialization;

public class increamentor : IHttpHandler
{
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";

        string token = context.Request["token"];
        string isbet = context.Request["isbet"];
        string gameId = context.Request["game_id"];

        ds = objgdb.ByProcedure("[Avtr_GenerateCrashPoint]", new string[] {
            "isbet"}, new string[] { isbet }, "das");

        string crash = ds.Tables[0].Rows[0]["crash"].ToString();
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

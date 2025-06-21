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
    string UserId;

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";

        string token = context.Request["token"];
        string isbet = context.Request["isbet"];
        string gameId = context.Request["game_id"];
        UserId = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();
        ds = objgdb.ByProcedure("[Avtr_ProStartNewRound_New]", new string[]
        {
            "Memid"}, new string[] {UserId.ToString() }, "das");;
        string crash = ds.Tables[0].Rows[0]["Crash"].ToString();
        var resultObj = new
        {
            result = crash
        };

 
        string json = new JavaScriptSerializer().Serialize(resultObj);

        string base64Encoded = Convert.ToBase64String(Encoding.UTF8.GetBytes(json));

        context.Response.Write(base64Encoded);
    }

    public bool IsReusable
    {
        get { return false; }
    }
}

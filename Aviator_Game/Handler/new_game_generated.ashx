<%@ WebHandler Language="C#" Class="new_game_generated" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using System.Data;
using System.Configuration;
using System.Collections.Generic;
using System.Web.SessionState;

public class new_game_generated : IHttpHandler, IRequiresSessionState
{
    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    DataSet ds = new DataSet();
    string UserId;
    DataTable dt;
    DynamicDtls objgdb = new DynamicDtls();


    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";

        try
        {
            if (context.Request.Cookies["Tap190Nvw92mst"] != null)
            {
                UserId = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();
                BindResult();
            }
            else
            {
                WriteJsonResponse(false, "Not Authenticated");
                context.ApplicationInstance.CompleteRequest();
            }
        }
        catch (Exception ex)
        {

            WriteJsonResponse(false, "Error :" + ex.Message);
        }

    }
    private void BindResult()
    {
        try
        {
            ds = objgdb.ByProcedure("[dbo].[Avtr_ProStartNewRound_New]", new string[]
               { "Memid"},
               new string[] { UserId.ToString() }, "das");

            if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
               
                    Dictionary<string, object> Data = new Dictionary<string, object>();
                    Data.Add("id", Convert.ToString(dt.Rows[0]["id"]));
                    Data.Add("Walletblnc", dt.Rows[0]["Walletblnc"]);
                    Data.Add("MaxBetAmt", dt.Rows[0]["MaxBetAmt"]);
                    Data.Add("MinBetAmt", dt.Rows[0]["MinBetAmt"]);
                    Data.Add("Crash", dt.Rows[0]["Crash"]);
                    WriteJsonResponse(true, "New Round Started", Data);
               
            }
            else
            {
                WriteJsonResponse(false, "No data returned from stored procedure.");
            }


        }
        catch (Exception ex)
        {
            WriteJsonResponse(false, "Error: " + ex.Message);
        }
    }


    private void WriteJsonResponse(bool success, string message, Dictionary<string, object> Data = null)
    {
        var Result = new
        {
            Success = success,
            Message = message,
            data = Data
        };
        string json = new JavaScriptSerializer().Serialize(Result);
        response.Write(json);
    }

    public bool IsReusable
    {
        get { return false; }
    }
}


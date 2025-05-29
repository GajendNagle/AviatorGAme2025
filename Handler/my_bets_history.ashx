<%@ WebHandler Language="C#" Class="my_bets_history" %>

using System;
using System.Web;
using System.Data;
using System.Collections.Generic;
using System.Web.Script.Serialization;

public class my_bets_history : IHttpHandler
{

    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc;
    public static string msg = "", RoundStatus = "", RoundNo = "", CrashMulti = "", Memid = "";
    public float crashMultiplier;
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;

    public class ResponseModel
    {
        public bool Success { get; set; }
        public string Message { get; set; }
    }

    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        response.ContentType = "application/json";

          if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        {
            Memid = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();
            MyBetHistory();
        }
        else
        {
            context.Response.Write("{\"success\": false, \"message\": \"User not authenticated.\"}");
        }
    }

    public void MyBetHistory()
    {
        try
        {
            ds = objgdb.ByProcedure("Avtr_ProBetHistory", new string[]
            { "BetHistorytype", "MemId" }, new string[]
            { "SelfBetHistory", Memid.ToString()  }, "das");

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                var betList = new List<object>();

                foreach (DataRow row in ds.Tables[0].Rows)
                {
                    betList.Add(new
                    {
                        add_date = row["add_date"].ToString(),
                        amount = row["amount"].ToString(),
                        trade_type = row["trade_type"].ToString(),
                        trade_num = row["trade_num"] != DBNull.Value ? row["trade_num"].ToString() : "0"
                    });
                }

                var response = new
                {
                    success = true,
                    data = betList
                };

                string jsonResponse = new JavaScriptSerializer().Serialize(response);
                context.Response.Write(jsonResponse);
            }
            else
            {
                context.Response.Write("{\"success\": true, \"data\": []}");
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            context.Response.Write("{\"success\": false, \"message\": \"Internal Server Error\"}");
        }
        finally
        {
            if (ds != null) ds.Dispose();
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
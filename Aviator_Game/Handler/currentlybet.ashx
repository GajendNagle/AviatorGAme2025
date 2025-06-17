<%@ WebHandler Language="C#" Class="currentlybet" %>


using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
using System.Web.Script.Serialization;

public class currentlybet : IHttpHandler
{
    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;
    public static string Memid = "";

    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";

        if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        {
            Memid = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();
            ds = objgdb.ByProcedure("Avtr_ProBetHistory", new string[]
                { "BetHistorytype", "MemId" },
                new string[] { "AllBetStatus", Memid }, "das");

            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                var dt = ds.Tables[0];
                var dt1 = ds.Tables[1];
                var betList = new List<object>();

                // Use the first row for summary data
                string currentGame = dt.Rows[0]["currentGame"].ToString();
                int currentGameBetCount = Convert.ToInt32(dt.Rows[0]["currentGameBetCount"]);
                decimal totalBetAmount = Convert.ToDecimal(dt.Rows[0]["totalBetAmount"]);

                foreach (DataRow row in dt1.Rows)
                {
                    betList.Add(new
                    {
                        userid = row["MemId"].ToString(),
                        amount = Convert.ToDecimal(row["BetAmount"]),
                        cashout_multiplier = Convert.ToDecimal(row["Multi"]),
                        sectionNo = row["Bet"].ToString(), 
                        image = row["MemPic"].ToString()   ,        
                        Win_Amt = Convert.ToDecimal(row["Win_Amt"])           
                    });
                }

                var finalResponse = new
                {
                    currentGame = currentGame,
                    currentGameBetCount = currentGameBetCount,
                    totalBetAmount = totalBetAmount,
                    currentGameBet = betList
                };

                var js = new JavaScriptSerializer();
                string json = js.Serialize(finalResponse);
                context.Response.Write(json);
            }
            else
            {
                var emptyResponse = new
                {
                    currentGame = "",
                    currentGameBetCount = 0,
                    totalBetAmount = 0,
                    currentGameBet = new List<object>()
                };

                var js = new JavaScriptSerializer();
                string json = js.Serialize(emptyResponse);
                context.Response.Write(json);
            }

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

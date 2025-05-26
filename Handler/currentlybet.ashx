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
    public int currentGameBetCount = 0;
    public decimal totalBetAmount = 0;
    public static string Memid = "", currentGame = "";

    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";


        ds = objgdb.ByProcedure("Avtr_ProBetHistory", new string[]
                { "BetHistorytype", "MemId" }, new string[]
                { "AllBetStatus", Memid.ToString() }, "das");

        if (ds != null && ds.Tables.Count >= 2 && ds.Tables[0].Rows.Count > 0)
        {
            var summaryRow = ds.Tables[0].Rows[0];
            
            currentGame = summaryRow["currentGame"].ToString();
            currentGameBetCount = Convert.ToInt32(summaryRow["currentGameBetCount"]);
            totalBetAmount = Convert.ToDecimal(summaryRow["totalBetAmount"]);

            var betList = new List<object>();

            foreach (DataRow row in ds.Tables[1].Rows)
            {
                
                betList.Add(new
                {
                    userid = row["MemId"].ToString(),                       
                    amount = Convert.ToDecimal(row["Amount"]),              
                    cashout_multiplier = Convert.ToDecimal(row["Multi"]),   
                    bet = row["Bet"].ToString()                             
                });
            }

            var finalResponse = new
            {
                currentGame = currentGame,
                currentGameBetCount = currentGameBetCount,
                totalBetAmount = totalBetAmount,
                currentGameBet = betList
            };

            var js = new System.Web.Script.Serialization.JavaScriptSerializer();
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
            var js = new System.Web.Script.Serialization.JavaScriptSerializer();
            string json = js.Serialize(emptyResponse);
            context.Response.Write(json);
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

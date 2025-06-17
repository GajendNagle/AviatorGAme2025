<%@ WebHandler Language="C#" Class="add_bet" %>

using System;
using System.Collections.Generic;
using System.Data;
using System.Web;
using System.Web.Script.Serialization;

public class add_bet : IHttpHandler
{
    public class Bet
    {
        public string bet_type { get; set; }
        public string bet_amount { get; set; }
        public int section_no { get; set; }
        public int RoundNo { get; set; }
    }

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        JavaScriptSerializer serializer = new JavaScriptSerializer();

        var response = new
        {
            Success = false,
            Message = "",
            Bets = new List<object>()
        };

        if (context.Request.Cookies["Tap190Nvw92mst"] == null)
        {
            context.Response.Write(serializer.Serialize(new
            {
                Success = false,
                Message = "LoginID missing.",
                Bets = new List<object>()
            }));
            return;
        }

        string userId = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();
        string roundNo = context.Request["RoundNo"];
        string allBetsJson = context.Request["all_bets"];

        if (string.IsNullOrEmpty(allBetsJson))
        {
            context.Response.Write(serializer.Serialize(new
            {
                Success = false,
                Message = "No bets received.",
                Bets = new List<object>()
            }));
            return;
        }

        try
        {
            var bets = serializer.Deserialize<List<Bet>>(allBetsJson);
            var objgdb = new DynamicDtls();
            var placedBets = new List<object>();
            bool allSuccess = true;

            foreach (var bet in bets)
            {
                DataSet ds = objgdb.ByProcedure("[Avtr_ProRecordBetPlay_new]",
                    new string[] { "Action", "MemId", "RoundNo", "Bet", "BetAmount", "Multi", "Result_Status" },
                    new string[] { "Place", userId, roundNo, bet.section_no.ToString(), bet.bet_amount, "0", "bet" },
                    "bet"
                );

                if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0 &&
                    ds.Tables[0].Rows[0]["Success"].ToString() == "True")
                {
                    placedBets.Add(new
                    {
                        amount = bet.bet_amount,
                        section_no = bet.section_no,
                        bet_id = ds.Tables[0].Rows[0]["BetID"].ToString(),
                        cashout_multiplier = 0
                    });
                }
                else
                {
                    allSuccess = false;
                    break;
                }
            }

            context.Response.Write(serializer.Serialize(new
            {
                Success = allSuccess,
                Message = allSuccess ? "Bets placed successfully." : "Some bets failed.",
                Bets = placedBets
            }));
        }
        catch (Exception ex)
        {
            context.Response.Write(serializer.Serialize(new
            {
                Success = false,
                Message = "Error: " + ex.Message,
                Bets = new List<object>()
            }));
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

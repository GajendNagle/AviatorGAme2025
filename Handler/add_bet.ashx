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

    public class ResponseModel
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public int is_win { get; set; }
    }

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        ResponseModel res = new ResponseModel();
        JavaScriptSerializer serializer = new JavaScriptSerializer();

        HttpCookie LoginID = context.Request.Cookies["LoginID"];
        if (LoginID == null || string.IsNullOrEmpty(LoginID.Value))
        {
            res.Success = false;
            res.Message = "LoginID missing.";
            res.is_win = 0;
            context.Response.Write(serializer.Serialize(res));
            return;
        }

        string userId = LoginID.Value;
        string token = context.Request["_token"];
        string roundNo = context.Request["RoundNo"]; 
        string allBetsJson = context.Request["all_bets"];

        if (string.IsNullOrEmpty(allBetsJson))
        {
            res.Success = false;
            res.Message = "No bets received.";
            res.is_win = 0;
            context.Response.Write(serializer.Serialize(res));
            return;
        }

        try
        {
            List<Bet> bets = serializer.Deserialize<List<Bet>>(allBetsJson);
            DynamicDtls objgdb = new DynamicDtls();
            bool overallSuccess = true;

            foreach (var bet in bets)
            {
                DataSet ds = objgdb.ByProcedure("[Avtr_ProRecordBetPlay]", new string[] {
                    "Action", "MemId", "RoundNo", "Bet", "BetAmount", "Multi", "Result_Status"
                }, new string[] {
                    "Place", userId, roundNo, bet.bet_type, bet.bet_amount, "", "bet"
                }, "bet");

                if (ds.Tables.Count == 0 || ds.Tables[0].Rows.Count == 0 || ds.Tables[0].Rows[0]["Success"].ToString() != "True")
                {
                    overallSuccess = false;
                    break;
                }
            }

            res.Success = overallSuccess;
            res.Message = overallSuccess ? "Bets placed successfully." : "One or more bets failed.";
            res.is_win = 0;
        }
        catch (Exception ex)
        {
            res.Success = false;
            res.Message = "Error: " + ex.Message;
            res.is_win = 0;
        }

        context.Response.Write(serializer.Serialize(res));
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}

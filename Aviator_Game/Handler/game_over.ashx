<%@ WebHandler Language="C#" Class="game_over" %>

using System;
using System.Web;
using System.Data;
using System.Web.Script.Serialization;
using System.Collections.Generic;

public class game_over : IHttpHandler
{
    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public static string RoundNo = "", CrashMulti, userId;
    public DynamicDtls objgdb = new DynamicDtls();
    public DataSet ds;

    public class ResponseModel
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public int is_win { get; set; }
        public int Bet_1 { get; set; }
        public int Bet_0 { get; set; }
    }

    public class Bet
    {
        public string bet_type { get; set; }
        public string bet_amount { get; set; }
        public int section_no { get; set; }
        public int RoundNo { get; set; }
    }

    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        response.ContentType = "application/json";

        JavaScriptSerializer serializer = new JavaScriptSerializer();
        ResponseModel res = new ResponseModel();

        if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        {
            try
            {
                RoundNo = request["game_id"];
                CrashMulti = request["last_time"];
                string betJson = request["Bet"];
                userId = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();

                List<Bet> bets = serializer.Deserialize<List<Bet>>(betJson);
                res = recordCrash(bets);
            }
            catch (Exception ex)
            {
                res.Success = false;
                res.Message = "Exception: " + ex.Message;
                res.is_win = 0;
            }
        }
        else
        {
            res.Success = false;
            res.Message = "LoginID missing.";
            res.is_win = 0;
        }

        response.Write(serializer.Serialize(res));
    }

    public ResponseModel recordCrash(List<Bet> bets)
    {
        ResponseModel res = new ResponseModel();
        try
        {
            if (bets != null && bets.Count > 0)
            {
                foreach (var bet in bets)
                {
                    ds = objgdb.ByProcedure("[Avtr_ProRecordBetPlay_new]", new string[]
                    { "Action", "MemId", "RoundNo", "Bet", "BetAmount", "Multi", "Result_Status"
                    },
                    new string[]
                    { "CloseRound",(!string.IsNullOrEmpty(userId)) ? userId : "",
                    RoundNo,bet != null ? bet.section_no.ToString() : "", "0", "", ""},
                    "das");
                }
            }
            else
            {
                ds = objgdb.ByProcedure("[Avtr_ProRecordBetPlay_new]", new string[] {
             "Action", "MemId", "RoundNo", "Bet", "BetAmount", "Multi", "Result_Status"  },
            new string[] { "CloseRound",  "", RoundNo, "", "0", "", "" }, "das");
            }


            if (ds != null && ds.Tables[0].Rows.Count > 0)
            {
                res.Message = ds.Tables[0].Rows[0]["msg"].ToString();
                res.Success = Convert.ToBoolean(ds.Tables[0].Rows[0]["Success"]);
                res.is_win = Convert.ToInt16(ds.Tables[0].Rows[0]["is_win"]);
                res.Bet_0 = Convert.ToInt16(ds.Tables[0].Rows[0]["Bet_0"]);
                res.Bet_1 = Convert.ToInt16(ds.Tables[0].Rows[0]["Bet_1"]);
            }
            else
            {
                res.Message = "Round closed.";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            res.Success = false;
            res.Message = "Sorry, something went wrong.";
            res.is_win = 0;
        }
        finally
        {
            if (ds != null) ds.Dispose();
        }

        return res;
    }

    public bool IsReusable
    {
        get { return false; }
    }
}



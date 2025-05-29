<%@ WebHandler Language="C#" Class="cash_out" %>

using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Net.Mail;
using System.IO;
using System.Data;
public class cash_out : IHttpHandler
{


    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc;
    public static string msg, Msgs, dtl, RtnRlt, error = "", amount = "", result = "", AutoWithNo = "", strJson, UserID = "", BetType = "", BetAction = "", Memid = "", RoundNo = "";
    public string multiplier = "";
    public float BetAmount = 0, CrashMulti = 0;
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;

    public class test
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public string detail { get; set; }
        public string aid { get; set; }
        public string ReqAmt { get; set; }
        public string Emenpjd { get; set; }
        public test(bool sc, string msg, string dtl, string aaid, string Amt, string emgk)
        {
            Success = sc;
            Message = msg;
            detail = dtl;
            ReqAmt = Amt;
            aid = aaid;
            Emenpjd = emgk;
        }
    }

    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";

        if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        {
            UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();
           // float.TryParse(context.Request["betAmount"].Trim(), out BetAmount);
            BetType = context.Request["section_no"].Trim();
            RoundNo = context.Request["game_id"].Trim();
                float.TryParse(context.Request["betAmount"].Trim(), out BetAmount);
            multiplier = context.Request["win_multiplier"];
            float.TryParse(multiplier.Trim(), out CrashMulti);
            BetAction = "Cashout";
            CashoutBetAction();
        }
        else
        {
            context.Response.End();
        }
    }
    public void writeJson(object _object)
    {
        JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
        string jsondata = javaScriptSerializer.Serialize(_object);
        writeRaw(jsondata);
    }

    public void writeRaw(string text)
    {
        context.Response.Write(text);
    }
    public void CashoutBetAction()
    {
        try
        {
            ds = objgdb.ByProcedure("[Avtr_ProRecordBetPlay]", new string[] {
            "Action","MemId","RoundNo","Bet","BetAmount" ,"Multi","Result_Status"
            }, new string[] { BetAction,UserID,RoundNo,
                BetType.ToString(),BetAmount.ToString() ,CrashMulti.ToString(),"WIN" }, "das");
            bool success = Convert.ToBoolean(ds.Tables[0].Rows[0]["Success"]);

            if (success)
            {
                sc = true;
                msg = ds.Tables[0].Rows[0]["Msg"].ToString();
            }
            else
            {
                sc = false;
                msg = ds.Tables[0].Rows[0]["Msg"].ToString();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = "Sorry, Something is wrong please try later !";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
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
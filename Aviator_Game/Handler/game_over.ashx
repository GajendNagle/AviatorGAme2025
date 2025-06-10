<%@ WebHandler Language="C#" Class="game_over" %>

using System;
using System.Web;
using System.Data;
using System.Web.Script.Serialization;

public class game_over : IHttpHandler
{
    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc;
    public static string msg = "", RoundStatus = "", RoundNo = "", CrashMulti;
    public float crashMultiplier;
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;

    public class ResponseModel
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public int is_win { get; set; }
        public string bet0 { get; set; }
        public string bet { get; set; }
    }

    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        response.ContentType = "application/json";


        var serializer = new JavaScriptSerializer();
        ResponseModel res = new ResponseModel();
        if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        {
            try
            {
                RoundNo = request["game_id"];
                CrashMulti = request["last_time"];
                res = recordCrash();
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

    public ResponseModel recordCrash()
    {
        ResponseModel res = new ResponseModel();
        try
        {

            ds = objgdb.ByProcedure("[Avtr_ProRecordBetPlay]", new string[]
            { "Action", "MemId", "RoundNo", "Bet", "BetAmount", "Multi", "Result_Status" }, new string[]
            { "CloseRound", "", RoundNo, "", "0",CrashMulti.ToString() , ""}, "das");

            // Safe check for "Rlt" in Table[0]
            bool isRltOkTable0 = ds.Tables.Count > 0 &&
                                 ds.Tables[0].Rows.Count > 0 &&
                                 ds.Tables[0].Columns.Contains("Rlt") &&
                                 ds.Tables[0].Rows[0]["Rlt"].ToString() == "IsOk";

            // Safe check for "Rlt" in Table[1]
            bool isRltOkTable1 = ds.Tables.Count > 1 &&
                                 ds.Tables[1].Rows.Count > 0 &&
                                 ds.Tables[1].Columns.Contains("Rlt") &&
                                 ds.Tables[1].Rows[0]["Rlt"].ToString() == "IsOk";

            if (isRltOkTable0 || isRltOkTable1)
            {
                res.Success = true;
                if (ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0 && ds.Tables[1].Columns.Contains("msg"))
                    res.Message = ds.Tables[1].Rows[0]["msg"].ToString();
                res.is_win = 2;
            }
            else
            {
                res.Success = true;
                if (ds.Tables.Count > 1 && ds.Tables[1].Rows.Count > 0 && ds.Tables[1].Columns.Contains("msg"))
                    res.Message = ds.Tables[1].Rows[0]["msg"].ToString();
                res.is_win = 2;
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = "Sorry, something went wrong. Please try later.";
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
        get
        {
            return false;
        }
    }
}

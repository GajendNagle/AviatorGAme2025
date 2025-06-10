﻿<%@ WebHandler Language="C#" Class="Dashboard_game_index" %>

using System;
using System.Data;
using System.Text;
using System.Web;

public class Dashboard_game_index : IHttpHandler
{

    public HttpContext context; public HttpRequest request; public HttpResponse response;
    public bool sc;
    public string msg, dtl, strJson, DisPos, DipsType;
    public static string UserID = "", RsltNum = "";
    DynamicDtls objgdb = new DynamicDtls(); DataSet ds; DataTable dt;
    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";
        //context.Response.ContentType = "text/html";
        UserID = "";
//if (context.Request.Cookies["Tap190Nvw92mst"] != null && context.Request.QueryString["Vs"] != null)
        //{

            /////////
          //  UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value);
            /////////
           DisPos = context.Request.QueryString["Vs"].ToString();

            if (DisPos == "winninginfo")
            {
                this.winninginfo();
            }
            if (DisPos == "todaysrankinfo")
            {
                this.todaysrankinfo();
            }

       // }
        //else
        //{
        //    //context.Response.Write("<script>window.open('../../login.html','_top');</script>");
        //}
    }
    private void winninginfo()
    {
        try
        {

            ds = objgdb.ByProcedure("dbo.Game_proWinnInfo_RankInc", new string[] { "Flag", "RptType", "MemID" },
                   new string[] { "WinningInfo", UserID.ToString(), "" }, "");

            StringBuilder jsonBuilder = new StringBuilder("");
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {



                        jsonBuilder.Append("<div class='row my-2 rowchange pt-2  pb-2 bg-light-black cards-shadow d-flex align-items-center'>");
                        jsonBuilder.Append("<div class='col-2 pl-md-3 d-inline-block'>");
                        jsonBuilder.Append("<img src='../" + dt.Rows[i]["ProImg"].ToString() + "' class='luckyWinners-img' />");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='col-3 px-0 d-inline-block'>");
                        jsonBuilder.Append("<p class='mb-0 pl-1 ml-0 profile-text'>" + dt.Rows[i]["ShowMemID"].ToString() + "</p>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='col-3 pl-3 d-inline-block'>");
                        jsonBuilder.Append("<img src='game-img/winning-details/" + dt.Rows[i]["GameType"].ToString() + ".png' class='luckyWinners-img2' />");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='col-4  px-0 d-inline-block' style=' font-size: 10px;'>");
                        jsonBuilder.Append("<span class='ab'>Receive " + dt.Rows[i]["WinningAmt"].ToString() + " " + dt.Rows[i]["AmtCurrency"].ToString() + "</span>");
                        jsonBuilder.Append("<p class='text-muted mb-0 pb-0 ab2'>Winning Amount</p>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }

                }
                else
                {
                    jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found !</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
                }
            }
            else
            {
                jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found!</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
            }
            response.Write(jsonBuilder);

        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }
    private void todaysrankinfo()
    {
        try
        {

            ds = objgdb.ByProcedure("dbo.Game_proWinnInfo_RankInc", new string[] { "Flag", "RptType", "MemID"},
                   new string[] { "RankingIncome", "", ""}, "");

            StringBuilder jsonBuilder = new StringBuilder("");
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        if (i + 1 == 1) {
                            jsonBuilder.Append("<div class='row'>");
                            jsonBuilder.Append("<div class='col-3 px-0 grid1'>");
                            jsonBuilder.Append("<div class='row'>");
                            jsonBuilder.Append("<div class='col-12 pro-img profrank1'>");
                            jsonBuilder.Append("<img src='" + dt.Rows[i]["ProImg"].ToString() + "' class='profile-img back1' />");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("<div class='col-12'>");
                            jsonBuilder.Append("<img src='game-img/todays-ranking-income/crown1.png' class='crown' />");
                            jsonBuilder.Append("<img src='game-img/todays-ranking-income/place1.png' class='place' />");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("<div class='col-12 rank-ids'>" + dt.Rows[i]["ShowMemID"].ToString() + "</div>");
                            jsonBuilder.Append("<div class='col-11 rank-tnx3'>" + dt.Rows[i]["WinningAmt"].ToString() + " " + dt.Rows[i]["AmtCurrency"].ToString() + "</div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");
                        }
                        if (i + 1 == 2) {
                            jsonBuilder.Append("<div class='col-3 px-0 grid3'>");
                            jsonBuilder.Append("<div class='row'>");
                            jsonBuilder.Append("<div class='col-12 pro-img profrank3'>");
                            jsonBuilder.Append("<img src='" + dt.Rows[i]["ProImg"].ToString() + "' class='profile-img back3' />");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("<div class='col-12'>");
                            jsonBuilder.Append("<img src='game-img/todays-ranking-income/crown2.png' class='crown' />");
                            jsonBuilder.Append("<img src='game-img/todays-ranking-income/place2.png' class='place' />");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("<div class='col-12 rank-ids'>" + dt.Rows[i]["ShowMemID"].ToString() + "</div>");
                            jsonBuilder.Append("<div class='col-11 rank-tnx'>" + dt.Rows[i]["WinningAmt"].ToString() + " " + dt.Rows[i]["AmtCurrency"].ToString() + "</div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");
                        }
                        if (i + 1 == 3) {
                            jsonBuilder.Append("<div class='col-3 px-0 grid2'>");
                            jsonBuilder.Append("<div class='row'>");
                            jsonBuilder.Append("<div class='col-12 pro-img profrank2'>");
                            jsonBuilder.Append("<img src='" + dt.Rows[i]["ProImg"].ToString() + "' class='profile-img back2' />");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("<div class='col-12'>");
                            jsonBuilder.Append("<img src='game-img/todays-ranking-income/crown3.png' class='crown'/>");
                            jsonBuilder.Append("<img src='game-img/todays-ranking-income/place3.png' class='place' />");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("<div class='col-12 rank-ids'>" + dt.Rows[i]["ShowMemID"].ToString() + "</div>");
                            jsonBuilder.Append("<div class='col-11 rank-tnx2'>" + dt.Rows[i]["WinningAmt"].ToString() + " " + dt.Rows[i]["AmtCurrency"].ToString() + "</div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");
                        }
                        if (i + 1 == 4) {
                            jsonBuilder.Append("<div class='row rank45'>");
                            jsonBuilder.Append("<div class='col-12 m-auto bg-black cards-shadow'>");
                            jsonBuilder.Append("<div class='row py-1 row45 d-flex align-items-center'>");
                            jsonBuilder.Append("<div class='col-1'><span class='text45'>4</span></div>");
                            jsonBuilder.Append("<div class='col-2'>");
                            jsonBuilder.Append("<img src='" + dt.Rows[i]["ProImg"].ToString() + "' class='profile-img45' />");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("<div class='col-4'><span class='ids452'>" + dt.Rows[i]["ShowMemID"].ToString() + "</span></div>");
                            jsonBuilder.Append("<div class='col-4 text-align-right px-0'><span class='rank-tnx45'>" + dt.Rows[i]["WinningAmt"].ToString() + " " + dt.Rows[i]["AmtCurrency"].ToString() + "</span></div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");
                        }
                        if (i + 1 == 5) {
                            jsonBuilder.Append("<div class='col-12 bg-light-black cards-shadow my-2'>");
                            jsonBuilder.Append("<div class='row py-1 row45 d-flex align-items-center'>");
                            jsonBuilder.Append("<div class='col-1'><span class='text45'>5</span></div>");
                            jsonBuilder.Append("<div class='col-2'>");
                            jsonBuilder.Append("<img src='" + dt.Rows[i]["ProImg"].ToString() + "' class='profile-img45' />");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("<div class='col-4'><span class='ids452'>" + dt.Rows[i]["ShowMemID"].ToString() + "</span></div>");
                            jsonBuilder.Append("<div class='col-4 text-align-right px-0'><span class='rank-tnx45'>" + dt.Rows[i]["WinningAmt"].ToString() + " " + dt.Rows[i]["AmtCurrency"].ToString() + "</span></div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");
                        }
                    }
                }
                else
                {
                    jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found !</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
                }
            }
            else
            {
                jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found!</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
            }
            response.Write(jsonBuilder);

        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }
    public static string DataTable2Json(DataTable dt)
    {
        StringBuilder jsonBuilder = new StringBuilder();

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            jsonBuilder.Append("{");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                jsonBuilder.Append("\"");
                jsonBuilder.Append(dt.Columns[j].ColumnName);
                jsonBuilder.Append("\":\"");
                jsonBuilder.Append(dt.Rows[i][j].ToString());
                jsonBuilder.Append("\",");
            }
            if (dt.Columns.Count > 0)
            {
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            }
            jsonBuilder.Append("},");
        }
        if (dt.Rows.Count > 0)
        {
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
        }

        return jsonBuilder.ToString();
    }
    public static string Dataset2Json(DataSet ds, int total)
    {
        StringBuilder json = new StringBuilder();

        foreach (DataTable dt in ds.Tables)
        {
            json.Append("[");
            json.Append(DataTable2Json(dt));
            json.Append("]");
        }
        return json.ToString();
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


}
﻿<%@ WebHandler Language="C#" Class="new_game_generated" %>

using System;
using System.Web;
using System.Web.Script.Serialization;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.SessionState;

public class new_game_generated : IHttpHandler, IRequiresSessionState
{
    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    DataSet ds = new DataSet();
    float WalletBlnc;
    string UserId;
    DataTable dt;
    public float BetAPending;
    public float BetBPending;
     DynamicDtls objgdb = new DynamicDtls();

    public string ConDB = ConfigurationManager.ConnectionStrings["Conn"].ConnectionString;

    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";

        /////////
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

            WriteJsonResponse(false, "ERror :" + ex.Message);
        }

    }

    private void BindResult()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(ConDB))
            using (SqlCommand cmd = new SqlCommand("dbo.Avtr_ProStartNewRound", con))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Memid", UserId.ToString());
                //cmd.Parameters.AddWithValue("Round_Status", "Closed");
                SqlParameter outputParam = new SqlParameter("@NewRoundNo", SqlDbType.VarChar, 25);
                outputParam.Direction = ParameterDirection.Output;
                cmd.Parameters.Add(outputParam);
                con.Open();
                SqlDataAdapter sda = new SqlDataAdapter(cmd);
                ds.Clear();
                sda.Fill(ds);

                if (ds.Tables.Count > 0)
                {
                    dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            string CurrentRound = dt.Rows[0]["CurrentRound"].ToString();

                            if (!string.IsNullOrEmpty(CurrentRound))
                            {
                                BetAPending = float.Parse(dt.Rows[0]["Bet_A"].ToString());
                                BetBPending = float.Parse(dt.Rows[0]["Bet_B"].ToString());
                                WalletBlnc = float.Parse(dt.Rows[0]["GameWalletB"].ToString());
                                WriteJsonResponse(true, "New Round Started", CurrentRound, UserId, BetAPending, BetBPending,WalletBlnc);
                            }
                            else
                            {
                                WriteJsonResponse(false, "No round information found.");
                            }
                        }

                    }
                }
            }
        }
        catch (Exception ex)
        {
            WriteJsonResponse(false, "Error: " + ex.Message, UserId: UserId);
        }
    }


    private void WriteJsonResponse(bool success, string message, string roundNo = "", string UserId = "", float BetA = 0, float BetB = 0,float WalletBlnc=0)
    {
        var result = new
        {
            Success = success,
            Message = message,
            id = roundNo,
            UserId = UserId,
            PendingBetA = BetA,
            PendingBetB = BetB,
            Walletblnc=WalletBlnc
        };
        string json = new JavaScriptSerializer().Serialize(result);
        response.Write(json);
    }

    public bool IsReusable
    {
        get { return false; }
    }
}
<%@ WebHandler Language="C#" Class="get_round_history" %>
using System;
using System.Text;
using System.Web;
using System.Data;
using System.Collections.Generic;
using System.Web.Script.Serialization;

public class get_round_history : IHttpHandler {
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;
    string UserId;

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";


        try
        {
            ds = objgdb.ByProcedure("[Avtr_ProBetHistory]", new string[]
            {
                "BetHistorytype", "MemId"
            }, new string[] { "RoundHistryUpdate", "" }, "das");

             List<string> multipliers = new List<string>();

            foreach (DataRow row in ds.Tables[0].Rows)
            {
                multipliers.Add(row["Round_Multi"].ToString());
            }

            var resultObj = new
            {
                result = multipliers
            };

            string json = new JavaScriptSerializer().Serialize(resultObj);
            context.Response.Write(json); 
        }
        catch (Exception ex)
        {
            context.Response.Write("{\"result\": "+ex.Message);
        }

    }

    public bool IsReusable
    {
        get { return false; }
    }
}

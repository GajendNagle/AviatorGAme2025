<%@ WebHandler Language="C#" Class="Get_Jackpot_Member" %>

using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.IO;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public class Get_Jackpot_Member : IHttpHandler
{
    public HttpContext context; public HttpRequest request; public HttpResponse response;
    public bool sc;
    public string Type;
    public static string msg, dtl, strJson, SKey, paymentmode;
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds; DataTable dt;

    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";
        if (context.Request.Cookies["Tap190Nvw92mst"] != null && context.Request.QueryString["type"] != null)
        {
            Type = context.Request.QueryString["type"].ToString();
            if (Type == "fastparity")
            {
                this.CheckJackpotInfo();
            }
            if (Type == "Parity")
            {
                this.CheckParityInfo();
            }
        }
        else
        {
            context.Response.Write("<script>window.open('../login.html','_top');</script>");
        }
    }

    private void CheckJackpotInfo()
    {
        int TotalRows = 0;

        try
        {
            ds = objgdb.ByProcedure("dbo.JackpotUpdatesSp", new string[] { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                    "ParticipateTotAmt","FromTime","ToTime" },
            new string[] { "0", "", "", "", "", "", "", "", "", "", "" }, "ByDataset");

            TotalRows = Convert.ToInt32(ds.Tables[0].Rows.Count.ToString());

            if (TotalRows > 0)
            {
                dt = ds.Tables[0];
                int count = TotalRows;
                string strJson = Dataset2Json(ds, count);
                context.Response.Write(strJson);
                context.ApplicationInstance.CompleteRequest();
            }

            //if (ds.Tables[0].Rows[0]["JackpotNo"].ToString() != "0")
            //{
            //    context.Response.Cookies["Jakcptno"].Value = ds.Tables[0].Rows[0]["JackpotNo"].ToString();
            //    context.Response.Cookies["Jakcptno"].Expires = DateTime.Now.AddHours(1);
            //}
            //else
            //{
            //    context.Response.Cookies["Jakcptno"].Expires = DateTime.Now.AddDays(-1);          
            //}
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
    //////
    private void CheckParityInfo()
    {
        int TotalRows = 0;

        try
        {
            ds = objgdb.ByProcedure("dbo.ParityUpdatesSp", new string[] { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                    "ParticipateTotAmt","FromTime","ToTime" },
            new string[] { "0", "", "", "", "", "", "", "", "", "", "" }, "ByDataset");

            TotalRows = Convert.ToInt32(ds.Tables[0].Rows.Count.ToString());

            if (TotalRows > 0)
            {
                dt = ds.Tables[0];
                int count = TotalRows;
                string strJson = Dataset2Json(ds, count);
                context.Response.Write(strJson);
                context.ApplicationInstance.CompleteRequest();
            }

            //if (ds.Tables[0].Rows[0]["JackpotNo"].ToString() != "0")
            //{
            //    context.Response.Cookies["Jakcptno"].Value = ds.Tables[0].Rows[0]["JackpotNo"].ToString();
            //    context.Response.Cookies["Jakcptno"].Expires = DateTime.Now.AddHours(1);
            //}
            //else
            //{
            //    context.Response.Cookies["Jakcptno"].Expires = DateTime.Now.AddDays(-1);          
            //}
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
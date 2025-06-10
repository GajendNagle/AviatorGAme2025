<%@ WebHandler Language="C#" Class="Getcount_Timer" %>

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

public class Getcount_Timer : IHttpHandler
{

    public HttpContext context; public HttpRequest request; public HttpResponse response;
    public bool sc;
    public string Type;
    public static string msg, dtl, strJson, SKey, paymentmode;
    DynamicDtls objgdb = new DynamicDtls(); DataSet ds; DataTable dt;
    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";
        /////////
        if (context.Request.QueryString["type"] != null)
        {
            Type = context.Request.QueryString["type"].ToString();
            int TotalRows = 0;
            if (Type == "fastparity")
            {
                TotalRows = this.BindfastparityResult(1);
            }
            if (Type == "Parity")
            {
                TotalRows = this.BindparityResult(1);
            }
            if(Type == "Parity5min")
            {
                TotalRows = this.Bindparity5minResult(1);
            }
            if(Type == "Parity10min")
            {
                TotalRows = this.Bindparity10minResult(1);
            }
        }
        /////////
    }
    private int BindfastparityResult(int currentPage)
    {
        int TotalRows = 0;
        try
        {
            ds = new DataSet();
            ds = objgdb.ByProcedure("dbo.GetParityListTime_1min", new string[] { "memID", "AcType" },
             new string[] { "", "PHTime" }, "ByDataset");
            TotalRows = Convert.ToInt32(ds.Tables[0].Rows.Count.ToString());
            if (TotalRows > 0)
            {
                dt = ds.Tables[0];
                int count = TotalRows;
                string strJson = Dataset2Json(ds, count);
                context.Response.Write(strJson);
                context.ApplicationInstance.CompleteRequest();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
        return TotalRows;
    }
    private int BindparityResult(int currentPage)
    {
        int TotalRows = 0;
        try
        {
            ds = new DataSet();
            ds = objgdb.ByProcedure("dbo.GetParityListTime_3min", new string[] { "memID", "AcType" },
             new string[] { "", "PHTime" }, "ByDataset");

            TotalRows = Convert.ToInt32(ds.Tables[0].Rows.Count.ToString());
            if (TotalRows > 0)
            {
                dt = ds.Tables[0];
                int count = TotalRows;
                string strJson = Dataset2Json(ds, count);
                context.Response.Write(strJson);
                context.ApplicationInstance.CompleteRequest();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
        return TotalRows;
    }
    private int Bindparity5minResult(int currentPage)
    {
        int TotalRows = 0;
        try
        {
            ds = new DataSet();
            ds = objgdb.ByProcedure("dbo.GetParityListTime_5min", new string[] { "memID", "AcType" },
             new string[] { "", "PHTime" }, "ByDataset");

            TotalRows = Convert.ToInt32(ds.Tables[0].Rows.Count.ToString());
            if (TotalRows > 0)
            {
                dt = ds.Tables[0];
                int count = TotalRows;
                string strJson = Dataset2Json(ds, count);
                context.Response.Write(strJson);
                context.ApplicationInstance.CompleteRequest();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
        return TotalRows;
    }
         private int Bindparity10minResult(int currentPage)
    {
        int TotalRows = 0;
        try
        {
            ds = new DataSet();
            ds = objgdb.ByProcedure("dbo.GetParityListTime_10min", new string[] { "memID", "AcType" },
             new string[] { "", "PHTime" }, "ByDataset");

            TotalRows = Convert.ToInt32(ds.Tables[0].Rows.Count.ToString());
            if (TotalRows > 0)
            {
                dt = ds.Tables[0];
                int count = TotalRows;
                string strJson = Dataset2Json(ds, count);
                context.Response.Write(strJson);
                context.ApplicationInstance.CompleteRequest();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
        return TotalRows;
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
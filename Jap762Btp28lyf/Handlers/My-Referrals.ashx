<%@ WebHandler Language="C#" Class="My_Referrals" %>
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

public class My_Referrals : IHttpHandler {
    public HttpContext context; public HttpRequest request; public HttpResponse response;
    public bool sc;
    string msg, dtl, strJson, UserID = "", SrchTxt = "ALL", Psize = "25", FrmDt = "", ToDt = "", Pos = "", Status = "", Lvl = "",Rank="";
    int Pno = 1, Dwn = 0;
    DynamicDtls objgdb = new DynamicDtls(); DataSet ds; DataTable dt;
    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";
        if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        {
            if (context.Request.QueryString["p"] != null)
            {
                Pno = Convert.ToInt32(context.Request.QueryString["p"].ToString());
                Psize = context.Request.QueryString["s"].ToString();
                FrmDt = request.QueryString["frdt"].ToString();
                ToDt = request.QueryString["todt"].ToString();
                Status = request.QueryString["sts"].ToString();
                Pos = request.QueryString["Pos"].ToString();
                Rank= request.QueryString["lvl"].ToString();
                Lvl = "1";/* request.QueryString["lvl"].ToString();*/
            }
            ////////
            if (context.Request.QueryString["u"] == "undefined" || context.Request.QueryString["u"] == null)
            {
                SrchTxt = "ALL";
            }
            else
            {
                SrchTxt = context.Request.QueryString["u"].ToString();
            }
            ////////
            UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();
            /////////
            Dwn = Dwn + 1;
            int TotalRows = this.BindResult(Pno);

        }
        else
        {
            context.Response.Write("<script>window.open('../login.html','_top');</script>");
        }
        /////////
    }
    private int BindResult(int currentPage)
    {
        int TotalRows = 0;
        try
        {
            ds = objgdb.ByProcedure("[ProDirectReffFill_New]", new string[] { "MemId", "Search", "intPageSize", "intCurrentPage", "FormDate", "ToDate", "Rank", "Sts", "Pos", "Package" },
                new string[] { UserID.ToString().Trim(), SrchTxt.Trim(), Psize, Pno.ToString(), FrmDt, ToDt,Rank, Status, Pos, Lvl }, "intTotalRecords", out TotalRows, "ByDataset");
            //ds = objgdb.ByProcedure("[ProDirectReffFill]", new string[] { "MemId", "Search", "intPageSize", "intCurrentPage", "FormDate", "ToDate", "Rank", "Sts" },
            //     new string[] { UserID.ToString().Trim(), SrchTxt, Psize, Pno.ToString(), FrmDt, ToDt,  rank, Status }, "intTotalRecords", out TotalRows, "ByDataset");
            //if (TotalRows > 0)
            //{
            dt = ds.Tables[0];
            int count = TotalRows;
            string strJson = Dataset2Json(ds, count);
            context.Response.Write(strJson);
            context.ApplicationInstance.CompleteRequest();
            //}
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            //Msg = objgdb.ErrorMsg("Records not available !");
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
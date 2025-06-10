<%@ WebHandler Language="C#" Class="getMessage" %>

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

public class getMessage : IHttpHandler {
    public HttpContext context; public HttpRequest request; public HttpResponse response;
    public bool sc; public string msg, dtl, strJson, UserID, OrderId;
    DynamicDtls objgdb = new DynamicDtls(); DataSet ds; DataTable dt;

    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";
            /////////
        if (context.Request.QueryString["email"] != null && context.Request.QueryString["orderId"] != null)
        {
            UserID = context.Request.QueryString["email"].ToString();
            OrderId = context.Request.QueryString["orderId"].ToString();
            //context.Response.Write(ds.Tables[0]);
            this.BindResult();
            /////////
        }
        else
        {
            response.Write("<br/>SORRY NO RECORD FOUND !!<br/><br/>"); 
        }
    }
    private void BindResult()
    {
        try
        {
            ds = objgdb.ByProcedure("dbo.tkt_ProcMessageOnRequest", new string[] { "AdsId", "Username", "Comment", "Imagepath", "SenderType", "type" },
                 new string[] { OrderId, UserID, "", "", "", "2" }, "ByDataset");
            if (ds.Tables[0].Rows.Count > 0)
            {               
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0 && UserID != "" && OrderId != "")
                {
                    StringBuilder jsonBuilder = new StringBuilder("");
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        jsonBuilder.Append("<div class='messageview'><b>");
                        jsonBuilder.Append(dt.Rows[i]["Frm"].ToString());
                        jsonBuilder.Append("</b><br/>");
                        jsonBuilder.Append("<p>" + dt.Rows[i]["Comment"].ToString() + "<br/><i>" + dt.Rows[i]["PostDate"].ToString() + "</i></p>");
                        //jsonBuilder.Append("<a target='_blank' href='" + dt.Rows[i]["AttachmentUrl"].ToString() + "'/>");
                        if (dt.Rows[i]["AttachmentUrl"].ToString() != "#")
                        {
                            //jsonBuilder.Append("<a target='_blank' href='" + dt.Rows[i]["AttachmentUrl"].ToString() + "'/><img  src='../participant/pics/file.png' /></a>");
                            jsonBuilder.Append("<a href='" + dt.Rows[i]["AttachmentUrl"].ToString() + "' target='_blank'><img  src='" + dt.Rows[i]["AttachmentUrl"].ToString() + "' width='100' height='50' /></a>");
                        }
                        jsonBuilder.Append("</div>");
                    }

                    response.Write(jsonBuilder);
                }
                else
                {
                    response.Write("<br/>SORRY NO RECORD FOUND !!<br/><br/>");
                }
            }                
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ds != null) { ds.Dispose(); dt.Dispose(); }
        }
    }
    //public static string DataTable2Json(DataTable dt)
    //{
    //    StringBuilder jsonBuilder = new StringBuilder();

    //    for (int i = 0; i < dt.Rows.Count; i++)
    //    {
    //        jsonBuilder.Append("{");
    //        for (int j = 0; j < dt.Columns.Count; j++)
    //        {
    //            jsonBuilder.Append("\"");
    //            jsonBuilder.Append(dt.Columns[j].ColumnName);
    //            jsonBuilder.Append("\":\"");
    //            jsonBuilder.Append(dt.Rows[i][j].ToString());
    //            jsonBuilder.Append("\",");
    //        }
    //        if (dt.Columns.Count > 0)
    //        {
    //            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
    //        }
    //        jsonBuilder.Append("},");
    //    }
    //    if (dt.Rows.Count > 0)
    //    {
    //        jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
    //    }

    //    return jsonBuilder.ToString();
    //}
    //public static string Dataset2Json(DataSet ds, int total)
    //{
    //    StringBuilder json = new StringBuilder();

    //    foreach (DataTable dt in ds.Tables)
    //    {
    //        ////{"total":5,"rows":[
    //        //json.Append("{\"total\":");
    //        //if (total == -1)
    //        //{
    //        //    json.Append(dt.Rows.Count);
    //        //}
    //        //else
    //        //{
    //        //    json.Append(total);
    //        //}
    //        json.Append("[");
    //        json.Append(DataTable2Json(dt));
    //        json.Append("]");
    //    }
    //    return json.ToString();
    //}

    public bool IsReusable {
        get {
            return false;
        }
    }

}
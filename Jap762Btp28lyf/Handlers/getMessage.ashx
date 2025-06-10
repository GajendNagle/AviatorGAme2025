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

        if (context.Request.Cookies["Tap190Nvw92mst"] != null && context.Request.QueryString["orderId"] != null)
        {
            /////////
            UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();
            OrderId = context.Request.QueryString["orderId"].ToString();
            /////////
            //context.Response.Write(ds.Tables[0]);
            this.BindResult();
        }
        else
        {
            context.Response.Write("<script>window.open('../login.html','_top');</script>");
        }
        /////////
    }
    private void BindResult()
    {
        try
        {
            ds = objgdb.ByProcedure("dbo.ProcMessageOnRequest", new string[] { "AdsId", "Username", "Comment", "Rate", "LikeAds", "PostDate", "type" },
                 new string[] { OrderId, UserID,"", "", "", "", "2" }, "ByDataset");
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    StringBuilder jsonBuilder = new StringBuilder("");
                    jsonBuilder.Append("<table cellpadding='0' cellspacing='0' class='ImgCommenttab2'>");
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        jsonBuilder.Append("<tr>");
                        jsonBuilder.Append("<td valign='top' style='width: 32px; padding: 5px 0px 5px  5px;'>");
                        jsonBuilder.Append("<img id='imgPicUser' src='../User_Panel_Pictures/Profile_Pic.png' style='height:31px;width:32px;border-width:0px;'>");
                        jsonBuilder.Append("</td>");
                        jsonBuilder.Append("<td align='justify' style='padding: 6px' >");
                        jsonBuilder.Append("<span class='ImgCommentName'>" + dt.Rows[i]["MName"].ToString() + "</span>");
                        jsonBuilder.Append("<span class='ImgCommentComm'>: " + dt.Rows[i]["Comment"].ToString() + "</span><br/><span class='ImgCommentCommTime'>" + dt.Rows[i]["PostDate"].ToString() + "</span>");
                        jsonBuilder.Append("</br>" + dt.Rows[i]["ImagePath"].ToString());
                        jsonBuilder.Append("</td></tr><tr><td colspan='2' class='msgSeparator'></td></tr>");
                        //jsonBuilder.Append("<div class='messageview'><b>");
                        //jsonBuilder.Append(dt.Rows[i]["MName"].ToString());
                        //jsonBuilder.Append("</b><br/>");
                        //jsonBuilder.Append("<p>" + dt.Rows[i]["Comment"].ToString() + "<br/><i>" + dt.Rows[i]["PostDate"].ToString() + "</i></p>");
                        //if (dt.Rows[i]["ImagePath"].ToString() != "")
                        //{
                        //    jsonBuilder.Append("<a target='_blank' href='" + dt.Rows[i]["AttachmentUrl"].ToString() + "'/><img  src='../participant/pics/file.png' /></a>");
                        //    jsonBuilder.Append(dt.Rows[i]["ImagePath"].ToString());
                        //}
                        //jsonBuilder.Append("</div>");
                    }
                    jsonBuilder.Append("</table>");
                    response.Write(jsonBuilder);
                }
            }
            else
            {
                response.Write("<span style='width: 32px; padding: 5px 0px 5px  5px; color:#7CB70B;'>Let's chat on Link communication!</span>");
            }              
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ds != null) { ds.Dispose(); if (dt != null) { dt.Dispose(); } }
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
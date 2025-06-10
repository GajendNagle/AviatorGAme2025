<%@ WebHandler Language="C#" Class="GetPopupNews" %>
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

public class GetPopupNews : IHttpHandler
{
    public HttpContext context; public HttpRequest request; public HttpResponse response;
    public bool sc;
    public string msg, dtl, strJson, DisPos;
    public static string UserID = "";
    DynamicDtls objgdb = new DynamicDtls(); DataSet ds; DataTable dt;
    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";
        /////////
        this.BindResult();
        //this.populateList(TotalRows);
        //if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        //{
        //    /////////
        //    UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();

        //}
        //else
        //{
        //    context.Response.Write("<script>window.open('../login.html','_top');</script>");
        //}
        /////////
        //handleRequest();
    }


    private void BindResult()
    {
        StringBuilder jsonBuilder = new StringBuilder("");
        try
        {
            ds = objgdb.ByProcedure("PROC_ADMIN_NEWS", new string[] { "id", "txtheading", "txtnews", "fdate", "edate", "typ", "News_Type", "News_For", "Image_Path", "Video_Path", "Audio_Path" }, new string[] { "", "", "", "", "", "GET_popup", "", "", "", "", "" }, "GET");
            if (ds.Tables[0].Rows.Count > 0)
            {

                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        //jsonBuilder.Append("<div  class='row'>");
                        //jsonBuilder.Append("<div  class='col-md-3'>");


                        //jsonBuilder.Append("</div>");
                        //jsonBuilder.Append("<div  class='col-md-9 text-left'>");
                        jsonBuilder.Append("<div  class='news-main-section' id='style-4'>");
                        jsonBuilder.Append("<h5 class='news-heading-sucses text-center'><span class='news-heding-prt'>" + dt.Rows[i]["Heading"].ToString() + "</span></h5>");
                        jsonBuilder.Append("<p class='text-center fs-little mt-2 mb-0'>Posted on : " + dt.Rows[i]["StartDate"].ToString() + "</p></br>");

                        //jsonBuilder.Append("<h1 class='news-heading-sucses'><span class='news-heding-prt'>" + dt.Rows[i]["Heading"].ToString() + "</span></h1>");
                        jsonBuilder.Append("<div  class='news-dscriptsn'>");
                        jsonBuilder.Append("<p >" + dt.Rows[i]["News"].ToString() + "</p></div>");
                        //jsonBuilder.Append("</div>");
                        //jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div  class='news-image-prt'>");

                        if (dt.Rows[i]["Image_Path"].ToString() != "")
                        {
                            jsonBuilder.Append(dt.Rows[i]["Image_Path"].ToString());
                        }
                        if (dt.Rows[i]["Video_Path"].ToString() != "")
                        {
                            jsonBuilder.Append("<iframe class='embed-responsive embed-responsive-16by9'  src='" + dt.Rows[i]["Video_Path"].ToString() + "' height='auto' border='0'></iframe>");
                        }
                        if (dt.Rows[i]["Audio_Path"].ToString() != "")
                        {
                            jsonBuilder.Append(dt.Rows[i]["Audio_Path"].ToString());
                        }
                        jsonBuilder.Append("<div><hr style='border-top: 1px solid rgb(209 212 209 / 8%)'></div>");

                    }

                    response.Write(jsonBuilder);

                }

            }
            else
            {
                jsonBuilder.Append("");
                response.Write(jsonBuilder);
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
<%@ WebHandler Language="C#" Class="GetTicketList" %>
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
public class GetTicketList : IHttpHandler {

    public HttpContext context; public HttpRequest request; public HttpResponse response;
    public bool sc; public string msg, dtl, strJson, UserID="", OrderId;
    DynamicDtls objgdb = new DynamicDtls(); DataSet ds; DataTable dt;

    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";
        ////////////
        if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        {
            UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString().Trim();
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
        int TotalRows = 0;
        try
        {
            ds = objgdb.ByProcedure("dbo.GetSupportMessages", new string[] { "intPageSize", "intCurrentPage", "FromDt", "Todt", "Searchtype", "SearchValue" },
                 new string[] { "300", "1", "01/06/1983", "", "FromUser", UserID.ToString() }, "intTotalRecords", out TotalRows, "ByDataset");
            if (TotalRows > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    StringBuilder jsonBuilder = new StringBuilder("");


                    for (int i = 0; i < dt.Rows.Count; i++)
                    {

                        jsonBuilder.Append("<tr class='unread p-0 m-0'>");
                        jsonBuilder.Append("<td style='width:40px'>");
                        jsonBuilder.Append("<div class='checkbox'>");
                        jsonBuilder.Append("<input type='checkbox' id='" + dt.Rows[i]["TicketNo"].ToString() + "' name='" + dt.Rows[i]["TicketNo"].ToString() + "' class='product-list checkboxi' value='" + dt.Rows[i]["TicketNo"].ToString() + "' onclick=clk('" + dt.Rows[i]["TicketNo"].ToString() + "')>");
                        jsonBuilder.Append("<label for='" + dt.Rows[i]["TicketNo"].ToString() + "'></label>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</td>");

                        jsonBuilder.Append("<td class='hidden-xs-down m-0 px-0' onclick=Showticketdetails('" + dt.Rows[i]["TicketNo"].ToString() + "')> <span style='font-weight:700;'>"+ dt.Rows[i]["MsgTopic"].ToString() + "</span></br><span style='font-size:13px;'>TICKET : <span class='text-theme'>" + dt.Rows[i]["TicketNo"].ToString() + "</span></span></td>");

                        //jsonBuilder.Append("<td class='max-texts p-4'> <a href='inbox.html?msg=" + dt.Rows[i]["TicketNo"].ToString() + "'>");

                        jsonBuilder.Append(" </a></td>");
                        jsonBuilder.Append("<td class='text-right p-4' style='font-size:10px;'> " + dt.Rows[i]["TktDate"].ToString() + " </td>");
                        jsonBuilder.Append("</tr>");
                    }

                    response.Write(jsonBuilder);
                }

            }
            else
            {
                response.Write("<span style='margin-left:10px;'>You have no message !!<br/></span>");
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
            if (dt != null) { dt.Dispose(); }
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
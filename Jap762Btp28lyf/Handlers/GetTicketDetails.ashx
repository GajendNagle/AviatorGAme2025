<%@ WebHandler Language="C#" Class="GetTicketDetails" %>
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

public class GetTicketDetails : IHttpHandler {

    public HttpContext context; public HttpRequest request; public HttpResponse response;
    public bool sc; public string msg, dtl, strJson, UserID, OrderId;
    DynamicDtls objgdb = new DynamicDtls(); DataSet ds; DataTable dt;

    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";

        if (context.Request.Cookies["Tap190Nvw92mst"] != null )
        {
            if (context.Request.Cookies["Tap190Nvw92mst"] != null)
            {
                UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();
            }

            if (context.Request.QueryString["orderId"].ToString() != null)
            {
                OrderId = context.Request.QueryString["orderId"].ToString();
            }
            else
            {
                OrderId="";
            }
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
            ds = objgdb.ByProcedure("dbo.tkt_ProcMessageOnRequest", new string[] { "AdsId", "Username", "Comment", "Imagepath", "SenderType", "type" },
                new string[] { OrderId, UserID, "UTDls", "", "", "200" }, "ByDataset");
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    StringBuilder jsonBuilder = new StringBuilder("");


                    jsonBuilder.Append("<div class='card-body p-0'>");
                    jsonBuilder.Append("<p class='card-title p-0 m-0'style='font-weight: 800;color: #2d2929;'>" + dt.Rows[0]["MsgTopic"].ToString() + "</p>");
                    jsonBuilder.Append("<span class='text-muted'style='font-size:13px;'>TICKET : <span class='text-theme'>" + dt.Rows[0]["Tno"].ToString() + "</span></span></br>");
                    jsonBuilder.Append("<span class='text-muted'style='font-size:13px;'>SUBJECT : <span class='text-theme'>" + dt.Rows[0]["msg"].ToString() + "</span></span>");
                    jsonBuilder.Append("</div>");
                    jsonBuilder.Append("<div>");
                    jsonBuilder.Append("<hr class='m-t-0'>");
                    jsonBuilder.Append("</div>");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        jsonBuilder.Append("<div class='card-body' style='padding:0px;'>");
                        jsonBuilder.Append("<div class='d-flex m-b-40'>");
                        jsonBuilder.Append("<div st>");
                        jsonBuilder.Append("<a href='javascript:void(0)' class='mr-2'><img src='../" + dt.Rows[i]["MemPic"].ToString() + "' alt='user' width='40' class='img-circle' /></a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='p-l-10'>");
                        jsonBuilder.Append("<p class='m-0 p-0 text-theme' style='font-weight: 500;'>" + dt.Rows[i]["Frm"].ToString() + "</p>");
                        jsonBuilder.Append("<small class='text-muted'>" + dt.Rows[i]["PostDate"].ToString() + "</small>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");

                        jsonBuilder.Append("</div>");

                        jsonBuilder.Append("<div class='card-body' style='padding:0px;'>");
                        jsonBuilder.Append("<div  class='repcomment my-3'>");
                        jsonBuilder.Append("<p>" + dt.Rows[i]["Comment"].ToString() + "</p>");
                        if (dt.Rows[i]["AttachmentUrl"].ToString() != "#")
                        {
                            //jsonBuilder.Append("<p><i class='fa fa-paperclip m-r-10 m-b-10 '></i> Attachments <span></span></p>");
                            jsonBuilder.Append("<div class='row'>");
                            jsonBuilder.Append("<div class='col-md-2'>");
                            jsonBuilder.Append("<a href='" + dt.Rows[i]["AttachmentUrl"].ToString() + "' target='_blank'> <img class='' style='width:100%;' alt='attachment' src='" + dt.Rows[i]["AttachmentUrl"].ToString() + "'> </a>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("<div class='col-md-2'>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("<div class='col-md-2'>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");
                        }
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div>");
                        //jsonBuilder.Append("<hr class='m-t-0' style='margin-top: 5px;'>");
                        jsonBuilder.Append("</div>");

                    }


                    jsonBuilder.Append("<div class='b-all m-t-20 p-20' id='DvRep'>");
                    jsonBuilder.Append("<p class='p-b-20 text-muted'>click here to <button data-toggle='modal' data-target='#myModal' class='model_img btn btn-theme p-1' style='font-weight: 600;' onclick='placeGiveHelpOrder()'>Reply</button></p>");
                    jsonBuilder.Append("</div>");
                    jsonBuilder.Append("</div>");



                    jsonBuilder.Append("<div id='myModal' class='pt-4 pt-md-0 modal fade' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true' style='background: #2f2b2b9c'>");
                    jsonBuilder.Append("<div class='modal-dialog'>");
                    jsonBuilder.Append("<div class='modal-content col-md-3 m-auto'>");
                    jsonBuilder.Append("<div class='modal-header'>");
                    jsonBuilder.Append("<h4 class=' ml-0 pl-0' id='myModalLabel'>Reply Ticket</h4>");

                    jsonBuilder.Append("<button type='button'class='close' data-dismiss='modal' aria-label='Close'><span aria-hidden='true'>&times;</span></button>");
                    //jsonBuilder.Append("<button type='button' class='close' data-dismiss='modal fade modal-backdrop' aria-hidden='true'><i class='fa-solid fa-xmark'></i></button>");
                    jsonBuilder.Append("</div>");
                    jsonBuilder.Append("<div class='modal-body px-0 mx-0'>");
                    jsonBuilder.Append("<small class='m-3'><span style='font-weight:700;font-size:14px;'>" + dt.Rows[0]["MsgTopic"].ToString() + "</span><br><span class='m-3'> TICKET : <span class='text-theme'>" + OrderId.ToString() +"</span></span><br><span class='m-3'> SUBJECT : "   + dt.Rows[0]["msg"].ToString() + "</span></small>");
                    jsonBuilder.Append("<textarea class='textarea_editor form-control my-2' rows='10' placeholder='Enter Message...' id='ReIssueDetails' name='ReIssueDetails' required></textarea>");
                    jsonBuilder.Append("</div>");
                    jsonBuilder.Append("<div class='row modal-footer m-0 px-0'>");
                    jsonBuilder.Append("<input type='file' class='col-12 bg-grey' name='RemsgFile' id='RemsgFile' style='margin-bottom: 9px; font-size: 14px;' /><button type='button' id='btnSendRe' class='col-12 btn btn-theme p-1' onclick=ticketsaddMessageRe('" + OrderId.ToString() + "')><i class='fa fa-envelope'></i> Send</button>");
                    jsonBuilder.Append("</div>");
                    jsonBuilder.Append("</div>");
                    jsonBuilder.Append("</div>");

                    jsonBuilder.Append("</div>");




                    response.Write(jsonBuilder);
                }
                else
                {
                    response.Write("SORRY NO RECORD FOUND !!<br/><br/>");
                }
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
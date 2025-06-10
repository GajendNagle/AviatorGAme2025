<%@ WebHandler Language="C#" Class="Game_Common_Values" %>

using System;
using System.Data;
using System.Text;
using System.Web;

public class Game_Common_Values : IHttpHandler
{

    public HttpContext context; public HttpRequest request; public HttpResponse response;
    public bool sc;
    public string msg, dtl, strJson, DisPos, DipsType;
    public static int PageNo=0, PageSize=0;
    public static string UserID = "", RsltNum = "";
    DynamicDtls objgdb = new DynamicDtls(); DataSet ds; DataTable dt;
    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";
        UserID = "";
        if (context.Request.Cookies["Tap190Nvw92mst"] != null && context.Request.QueryString["Vs"] != null)
        {
            if (context.Request.QueryString["p"] != null && context.Request.QueryString["s"] != null)
            {
                PageNo = Convert.ToInt32(context.Request.QueryString["p"].ToString());
                PageSize = Convert.ToInt32(context.Request.QueryString["s"].ToString());
            }
            objgdb.FillWebSiteEmailCompany();
            /////////
            UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value);
            /////////
            DisPos = context.Request.QueryString["Vs"].ToString();

            if (DisPos == "jackpotwindd")
            {
                this.TradingListResultdd();
            }
            if (DisPos == "Everyonsorder")
            {
                this.Everyonesorder();
            }
            if (DisPos == "Everyonsorder3min")
            {
                this.Everyonesorder3min();
            }
            if (DisPos == "Everyonsorder5min")
            {
                this.Everyonesorder5min();
            }
            if (DisPos == "Everyonsorder10min")
            {
                this.Everyonesorder10min();
            }


            if (DisPos == "Myorder")
            {
                this.Mysorder();
            }
            if (DisPos == "Myorder3min")
            {
                this.Mysorder3min();
            }
            if (DisPos == "Myorder5min")
            {
                this.Mysorder5min();
            }
            if (DisPos == "Myorder10min")
            {
                this.Mysorder10min();
            }


            if (DisPos == "MyResult1min")
            {
                this.MyResult();
            }
            if (DisPos == "MyResult3min")
            {
                this.MyResult3min();
            }
            if (DisPos == "MyResult5min")
            {
                this.MyResult5min();
            }
            if (DisPos == "MyResult10min")
            {
                this.MyResult10min();
            }



            if (DisPos == "carouselwinId")
            {
                this.carouselwinId();
            }
            if (DisPos == "carouselwinIdscnd")
            {
                this.carouselwinIdscnd();
            }
        }
        else
        {
            context.Response.Write("<script>window.open('../../login.html','_top');</script>");
            //context.Response.Redirect("../amp.html","_top");
        }
    }
    private void TradingListResultdd()
    {
        try
        {
            ds = objgdb.ByProcedure("dbo.ParityUpdatesSp_1min", new string[]
            { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                "ParticipateTotAmt","FromTime","ToTime" },
            new string[] { "8", "", "", "", "", "", "", "", "", "", "" }, "");
            StringBuilder jsonBuilder = new StringBuilder("");
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    //jsonBuilder.Append("<div id='fastparityrslt'>");
                    jsonBuilder.Append("<div class='circle-group-result clrs py-2 d-none'>");
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        jsonBuilder.Append("<span class='rsltbox'>");
                        jsonBuilder.Append("<span class= 'rsltnum''>" + ds.Tables[0].Rows[i]["JackpotNo"].ToString() + "</span>");
                        if (ds.Tables[0].Rows[i]["TradeResultNum"].ToString() == "1" || ds.Tables[0].Rows[i]["TradeResultNum"].ToString() == "3" || ds.Tables[0].Rows[i]["TradeResultNum"].ToString() == "7" || ds.Tables[0].Rows[i]["TradeResultNum"].ToString() == "9")
                        {
                            jsonBuilder.Append("<span data-value='even'>" + ds.Tables[0].Rows[i]["TradeResultNum"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNum"].ToString() == "2" || ds.Tables[0].Rows[i]["TradeResultNum"].ToString() == "4" || ds.Tables[0].Rows[i]["TradeResultNum"].ToString() == "6" || ds.Tables[0].Rows[i]["TradeResultNum"].ToString() == "8")
                        {
                            jsonBuilder.Append("<span data-value='odd'>" + ds.Tables[0].Rows[i]["TradeResultNum"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNum"].ToString() == "5")
                        {
                            jsonBuilder.Append("<span data-value='5'>" + ds.Tables[0].Rows[i]["TradeResultNum"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNum"].ToString() == "0")
                        {
                            jsonBuilder.Append("<span data-value='0'>" + ds.Tables[0].Rows[i]["TradeResultNum"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNum"].ToString() == "N")
                        {
                            jsonBuilder.Append("<span data-value='num'>" + ds.Tables[0].Rows[i]["TradeResultNum"].ToString() + "</span>");
                        }
                        else
                        {
                            jsonBuilder.Append("<span data-value='next'>?</span>");
                        }
                        jsonBuilder.Append("</span>");
                        //jsonBuilder.Append("<td>" + ds.Tables[0].Rows[i]["Date"].ToString() + "</td>");
                        //jsonBuilder.Append("</tr>");
                    }
                    jsonBuilder.Append("</div>");
                    //jsonBuilder.Append("</div>");
                    //jsonBuilder.Append("</table>");
                }
                else
                {
                    jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found !</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
                }
            }
            else
            {
                jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found!</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
            }
            response.Write(jsonBuilder);

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
    private void Everyonesorder()
    {
        try
        {

            ds = objgdb.ByProcedure("dbo.ParityUpdatesSp_1min", new string[] { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                    "ParticipateTotAmt","FromTime","ToTime" },
                   new string[] { "9", "", "", "", "", "", "", "", "", PageNo.ToString(), PageSize.ToString() }, "");

            StringBuilder jsonBuilder = new StringBuilder("");
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {

                    //jsonBuilder.Append("<div class='row dropin align-items-center'>");



                    jsonBuilder.Append("<div class='row my-2 mx-0 bottom-table'>");
                    jsonBuilder.Append("<p class='col-3 p-0 mt-3 fs-md text-white'>Period</p>");
                    jsonBuilder.Append("<p class='col-3 p-0 mt-3 fs-md text-white'>Number</p>");
                    jsonBuilder.Append("<p class='col-3 p-0 mt-3 fs-md text-white'>Big-Small</p>");
                    jsonBuilder.Append("<p class='col-3 p-0 mt-3 fs-md text-white'>Color</p>");
                    jsonBuilder.Append("</div>");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        jsonBuilder.Append("<div class='row py-1 px-3 align-items-center'>");
                        jsonBuilder.Append("<div class='col-3 p-0 '>" + ds.Tables[0].Rows[i]["JackpotNo"].ToString() + "</div>");

                        jsonBuilder.Append("<div class='col-3 p-0 danger numsty'>");
                        if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "1")
                        {
                            jsonBuilder.Append("<img src='img/image123/one.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "2")
                        {
                            jsonBuilder.Append("<img src='img/image123/two.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "3")
                        {
                            jsonBuilder.Append("<img src='img/image123/three.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "4")
                        {
                            jsonBuilder.Append("<img src='img/image123/four.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "5")
                        {
                            jsonBuilder.Append("<img src='img/image123/five.png' height='18px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "6")
                        {
                            jsonBuilder.Append("<img src='img/image123/six.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "7")
                        {
                            jsonBuilder.Append("<img src='img/image123/seven.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "8")
                        {
                            jsonBuilder.Append("<img src='img/image123/eight.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "9")
                        {
                            jsonBuilder.Append("<img src='img/image123/nine.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "0")
                        {
                            jsonBuilder.Append("<img src='img/image123/zero.png' height='18px' />");
                        }
                        jsonBuilder.Append(" </div>");

                        jsonBuilder.Append(" <div class='col-3 p-0 clrs'>");
                        if (ds.Tables[0].Rows[i]["BigSmall"].ToString() == "BIG")
                        {
                            jsonBuilder.Append("Big");
                        }
                        else if (ds.Tables[0].Rows[i]["BigSmall"].ToString() == "SMALL")
                        {
                            jsonBuilder.Append("Small");
                        }
                        jsonBuilder.Append(" </div>");

                        jsonBuilder.Append(" <div class='col-3 p-0'>");
                        if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "GREEN")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color:rgb(0, 194, 130);' aria-hidden='true'></i>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "RED")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color:rgb(250, 60, 9);' aria-hidden='true'></i>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "VIOLET")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color: rgb(102, 85, 211);' aria-hidden='true'></i>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "RED & VIOLET")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color:rgb(250, 60, 9);' aria-hidden='true'></i> <i class='fa-solid fa-circle' style='color:rgb(102, 85, 211);' aria-hidden='true'></i>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "GREEN & VIOLET")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color:rgb(0, 194, 130);' aria-hidden='true'></i> <i class='fa-solid fa-circle' style='color: rgb(102, 85, 211);' aria-hidden='true'></i>");
                        }
                        jsonBuilder.Append(" </div>");

                        jsonBuilder.Append(" </div>");
                    }
                    if (PageNo.ToString() == "1" && PageNo.ToString() == dt.Rows[0]["TotalPages"].ToString()) {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Everyonsordr("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link disabled' onclick='Everyonsordr("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else if (PageNo.ToString() == "1") {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Everyonsordr("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link' onclick='Everyonsordr("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else if (PageNo.ToString() == dt.Rows[0]["TotalPages"].ToString()) {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link' onclick='Everyonsordr("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link disabled' onclick='Everyonsordr("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link' onclick='Everyonsordr("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link' onclick='Everyonsordr("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                }
                else
                {
                    jsonBuilder.Append("<div class='alert text-dangerw-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found !</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
                }
            }
            else
            {
                jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found!</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
            }
            response.Write(jsonBuilder);

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

    private void Everyonesorder3min()
    {
        try
        {

            ds = objgdb.ByProcedure("dbo.ParityUpdatesSp_3min", new string[] { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                    "ParticipateTotAmt","FromTime","ToTime" },
                   new string[] { "9", "", "", "", "", "", "", "", "", PageNo.ToString(), PageSize.ToString() }, "");

            StringBuilder jsonBuilder = new StringBuilder("");
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {

                    //jsonBuilder.Append("<div class='row dropin align-items-center'>");



                    jsonBuilder.Append("<div class='row my-2 mx-0 bottom-table'>");
                    jsonBuilder.Append("<p class='col-3 p-0 mt-3 fs-md text-white'>Period</p>");
                    jsonBuilder.Append("<p class='col-3 p-0 mt-3 fs-md text-white'>Number</p>");
                    jsonBuilder.Append("<p class='col-3 p-0 mt-3 fs-md text-white'>Big-Small</p>");
                    jsonBuilder.Append("<p class='col-3 p-0 mt-3 fs-md text-white'>Color</p>");
                    jsonBuilder.Append("</div>");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        jsonBuilder.Append("<div class='row py-1 px-3 align-items-center'>");
                        jsonBuilder.Append("<div class='col-3 p-0 '>" + ds.Tables[0].Rows[i]["JackpotNo"].ToString() + "</div>");

                        jsonBuilder.Append("<div class='col-3 p-0 danger numsty'>");
                        if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "1")
                        {
                            jsonBuilder.Append("<img src='img/image123/one.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "2")
                        {
                            jsonBuilder.Append("<img src='img/image123/two.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "3")
                        {
                            jsonBuilder.Append("<img src='img/image123/three.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "4")
                        {
                            jsonBuilder.Append("<img src='img/image123/four.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "5")
                        {
                            jsonBuilder.Append("<img src='img/image123/five.png' height='18px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "6")
                        {
                            jsonBuilder.Append("<img src='img/image123/six.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "7")
                        {
                            jsonBuilder.Append("<img src='img/image123/seven.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "8")
                        {
                            jsonBuilder.Append("<img src='img/image123/eight.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "9")
                        {
                            jsonBuilder.Append("<img src='img/image123/nine.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "0")
                        {
                            jsonBuilder.Append("<img src='img/image123/zero.png' height='18px' />");
                        }
                        jsonBuilder.Append(" </div>");

                        jsonBuilder.Append(" <div class='col-3 p-0 clrs'>");
                        if (ds.Tables[0].Rows[i]["BigSmall"].ToString() == "BIG")
                        {
                            jsonBuilder.Append("Big");
                        }
                        else if (ds.Tables[0].Rows[i]["BigSmall"].ToString() == "SMALL")
                        {
                            jsonBuilder.Append("Small");
                        }
                        jsonBuilder.Append(" </div>");

                        jsonBuilder.Append(" <div class='col-3 p-0'>");
                        if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "GREEN")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color:rgb(0, 194, 130);' aria-hidden='true'></i>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "RED")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color:rgb(250, 60, 9);' aria-hidden='true'></i>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "VIOLET")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color: rgb(102, 85, 211);' aria-hidden='true'></i>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "RED & VIOLET")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color:rgb(250, 60, 9);' aria-hidden='true'></i> <i class='fa-solid fa-circle' style='color:rgb(102, 85, 211);' aria-hidden='true'></i>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "GREEN & VIOLET")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color:rgb(0, 194, 130);' aria-hidden='true'></i> <i class='fa-solid fa-circle' style='color: rgb(102, 85, 211);' aria-hidden='true'></i>");
                        }
                        jsonBuilder.Append(" </div>");

                        jsonBuilder.Append(" </div>");

                    }
                    if (PageNo.ToString() == "1" && PageNo.ToString() == "1" && PageNo.ToString() == dt.Rows[0]["TotalPages"].ToString()) {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Everyonsordr3min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link disabled' onclick='Everyonsordr3min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else if (PageNo.ToString() == "1") {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Everyonsordr3min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link' onclick='Everyonsordr3min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else if (PageNo.ToString() == "1" && PageNo.ToString() == dt.Rows[0]["TotalPages"].ToString()) {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Everyonsordr3min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link disabled' onclick='Everyonsordr3min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link' onclick='Everyonsordr3min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link' onclick='Everyonsordr3min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }

                }
                else
                {
                    jsonBuilder.Append("<div class='alert text-dangerw-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found !</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
                }
            }
            else
            {
                jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found!</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
            }
            response.Write(jsonBuilder);

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

    private void Everyonesorder5min()
    {
        try
        {

            ds = objgdb.ByProcedure("dbo.ParityUpdatesSp_5min", new string[] { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                    "ParticipateTotAmt","FromTime","ToTime" },
                   new string[] { "9", "", "", "", "", "", "", "", "", PageNo.ToString(), PageSize.ToString() }, "");

            StringBuilder jsonBuilder = new StringBuilder("");
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {

                    jsonBuilder.Append("<div class='row my-2 mx-0 bottom-table'>");
                    jsonBuilder.Append("<p class='col-3 p-0 mt-3 fs-md text-white'>Period</p>");
                    jsonBuilder.Append("<p class='col-3 p-0 mt-3 fs-md text-white'>Number</p>");
                    jsonBuilder.Append("<p class='col-3 p-0 mt-3 fs-md text-white'>Big-Small</p>");
                    jsonBuilder.Append("<p class='col-3 p-0 mt-3 fs-md text-white'>Color</p>");
                    jsonBuilder.Append("</div>");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        jsonBuilder.Append("<div class='row py-1 px-3 align-items-center'>");
                        jsonBuilder.Append("<div class='col-3 p-0 '>" + ds.Tables[0].Rows[i]["JackpotNo"].ToString() + "</div>");

                        jsonBuilder.Append("<div class='col-3 p-0 danger numsty'>");
                        if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "1")
                        {
                            jsonBuilder.Append("<img src='img/image123/one.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "2")
                        {
                            jsonBuilder.Append("<img src='img/image123/two.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "3")
                        {
                            jsonBuilder.Append("<img src='img/image123/three.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "4")
                        {
                            jsonBuilder.Append("<img src='img/image123/four.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "5")
                        {
                            jsonBuilder.Append("<img src='img/image123/five.png' height='18px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "6")
                        {
                            jsonBuilder.Append("<img src='img/image123/six.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "7")
                        {
                            jsonBuilder.Append("<img src='img/image123/seven.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "8")
                        {
                            jsonBuilder.Append("<img src='img/image123/eight.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "9")
                        {
                            jsonBuilder.Append("<img src='img/image123/nine.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "0")
                        {
                            jsonBuilder.Append("<img src='img/image123/zero.png' height='18px' />");
                        }
                        jsonBuilder.Append(" </div>");

                        jsonBuilder.Append(" <div class='col-3 p-0 clrs'>");
                        if (ds.Tables[0].Rows[i]["BigSmall"].ToString() == "BIG")
                        {
                            jsonBuilder.Append("Big");
                        }
                        else if (ds.Tables[0].Rows[i]["BigSmall"].ToString() == "SMALL")
                        {
                            jsonBuilder.Append("Small");
                        }
                        jsonBuilder.Append(" </div>");

                        jsonBuilder.Append(" <div class='col-3 p-0'>");
                        if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "GREEN")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color:rgb(0, 194, 130);' aria-hidden='true'></i>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "RED")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color:rgb(250, 60, 9);' aria-hidden='true'></i>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "VIOLET")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color: rgb(102, 85, 211);' aria-hidden='true'></i>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "RED & VIOLET")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color:rgb(250, 60, 9);' aria-hidden='true'></i> <i class='fa-solid fa-circle' style='color:rgb(102, 85, 211);' aria-hidden='true'></i>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "GREEN & VIOLET")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color:rgb(0, 194, 130);' aria-hidden='true'></i> <i class='fa-solid fa-circle' style='color: rgb(102, 85, 211);' aria-hidden='true'></i>");
                        }
                        jsonBuilder.Append(" </div>");

                        jsonBuilder.Append(" </div>");

                    }
                    if (PageNo.ToString() == "1" && PageNo.ToString() == dt.Rows[0]["TotalPages"].ToString()) {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Everyonsord5min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link disabled' onclick='Everyonsord5min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else if (PageNo.ToString() == "1") {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Everyonsord5min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link' onclick='Everyonsord5min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else if (PageNo.ToString() == dt.Rows[0]["TotalPages"].ToString()) {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link' onclick='Everyonsord5min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link disabled' onclick='Everyonsord5min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link' onclick='Everyonsord5min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link' onclick='Everyonsord5min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }

                }
                else
                {
                    jsonBuilder.Append("<div class='alert text-dangerw-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found !</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
                }
            }
            else
            {
                jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found!</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
            }
            response.Write(jsonBuilder);

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

    private void Everyonesorder10min()
    {
        try
        {

            ds = objgdb.ByProcedure("dbo.ParityUpdatesSp_10min", new string[] { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                    "ParticipateTotAmt","FromTime","ToTime" },
                   new string[] { "9", "", "", "", "", "", "", "", "", PageNo.ToString(), PageSize.ToString() }, "");

            StringBuilder jsonBuilder = new StringBuilder("");
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {

                    //jsonBuilder.Append("<div class='row dropin align-items-center'>");



                    jsonBuilder.Append("<div class='row my-2 mx-0 bottom-table'>");
                    jsonBuilder.Append("<p class='col-3 p-0 mt-3 fs-md text-white'>Period</p>");
                    jsonBuilder.Append("<p class='col-3 p-0 mt-3 fs-md text-white'>Number</p>");
                    jsonBuilder.Append("<p class='col-3 p-0 mt-3 fs-md text-white'>Big-Small</p>");
                    jsonBuilder.Append("<p class='col-3 p-0 mt-3 fs-md text-white'>Color</p>");
                    jsonBuilder.Append("</div>");

                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        jsonBuilder.Append("<div class='row py-1 px-3 align-items-center'>");
                        jsonBuilder.Append("<div class='col-3 p-0 '>" + ds.Tables[0].Rows[i]["JackpotNo"].ToString() + "</div>");

                        jsonBuilder.Append("<div class='col-3 p-0 danger numsty'>");
                        if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "1")
                        {
                            jsonBuilder.Append("<img src='img/image123/one.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "2")
                        {
                            jsonBuilder.Append("<img src='img/image123/two.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "3")
                        {
                            jsonBuilder.Append("<img src='img/image123/three.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "4")
                        {
                            jsonBuilder.Append("<img src='img/image123/four.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "5")
                        {
                            jsonBuilder.Append("<img src='img/image123/five.png' height='18px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "6")
                        {
                            jsonBuilder.Append("<img src='img/image123/six.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "7")
                        {
                            jsonBuilder.Append("<img src='img/image123/seven.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "8")
                        {
                            jsonBuilder.Append("<img src='img/image123/eight.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "9")
                        {
                            jsonBuilder.Append("<img src='img/image123/nine.png' height='22px' />");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeResultNumber"].ToString() == "0")
                        {
                            jsonBuilder.Append("<img src='img/image123/zero.png' height='18px' />");
                        }
                        jsonBuilder.Append(" </div>");

                        jsonBuilder.Append(" <div class='col-3 p-0 clrs'>");
                        if (ds.Tables[0].Rows[i]["BigSmall"].ToString() == "BIG")
                        {
                            jsonBuilder.Append("Big");
                        }
                        else if (ds.Tables[0].Rows[i]["BigSmall"].ToString() == "SMALL")
                        {
                            jsonBuilder.Append("Small");
                        }
                        jsonBuilder.Append(" </div>");

                        jsonBuilder.Append(" <div class='col-3 p-0'>");
                        if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "GREEN")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color:rgb(0, 194, 130);' aria-hidden='true'></i>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "RED")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color:rgb(250, 60, 9);' aria-hidden='true'></i>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "VIOLET")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color: rgb(102, 85, 211);' aria-hidden='true'></i>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "RED & VIOLET")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color:rgb(250, 60, 9);' aria-hidden='true'></i> <i class='fa-solid fa-circle' style='color:rgb(102, 85, 211);' aria-hidden='true'></i>");
                        }
                        else if (ds.Tables[0].Rows[i]["TradeIncome"].ToString() == "GREEN & VIOLET")
                        {
                            jsonBuilder.Append("<i class='fa-solid fa-circle' style='color:rgb(0, 194, 130);' aria-hidden='true'></i> <i class='fa-solid fa-circle' style='color: rgb(102, 85, 211);' aria-hidden='true'></i>");
                        }
                        jsonBuilder.Append(" </div>");

                        jsonBuilder.Append(" </div>");

                    }
                    if (PageNo.ToString() == "1" && PageNo.ToString() == dt.Rows[0]["TotalPages"].ToString()) {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Everyonsordr10min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link disabled' onclick='Everyonsordr10min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else if (PageNo.ToString() == "1") {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Everyonsordr10min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link' onclick='Everyonsordr10min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else if (PageNo.ToString() == dt.Rows[0]["TotalPages"].ToString()) {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link' onclick='Everyonsordr10min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link disabled' onclick='Everyonsordr10min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link' onclick='Everyonsordr10min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link' onclick='Everyonsordr10min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }

                }
                else
                {
                    jsonBuilder.Append("<div class='alert text-dangerw-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found !</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
                }
            }
            else
            {
                jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found!</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
            }
            response.Write(jsonBuilder);

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




    private void Mysorder()
    {
        try
        {

            ds = objgdb.ByProcedure("dbo.ParityUpdatesSp_1min", new string[] { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                    "ParticipateTotAmt","FromTime","ToTime" },
                   new string[] { "10", UserID.ToString(), "", "", "", "", "", "", "", PageNo.ToString(), PageSize.ToString() }, "");

            StringBuilder jsonBuilder = new StringBuilder("");
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    //transID      JackpotNo	        MemID	               Selecttype	    JackpotPlayAmt      Dedamt    plyAmt	   Point	 Status	   ReslColor	RsltNumber	RsltBigSmall	PlayDate
                    //4654765          1098121	      Leno88374227              GREEN	                                tax       10	    10       LOSS	     RED	           4	      SMALL	     2024-03-20 12:29:46.290
                    for (int i = 0; i < dt.Rows.Count; i++){

                        jsonBuilder.Append("<div class='d-flex align-items-center' onclick='opendetails(" + ds.Tables[0].Rows[i]["transID"].ToString() + ")'>");

                        jsonBuilder.Append("<div class='col-2 p-0 py-1 clrs d-inline-block'>");
                        if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "GREEN")
                        {
                            jsonBuilder.Append("<span class='rgreen'></span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "RED")
                        {
                            jsonBuilder.Append("<span class='rred'></span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "VIOLET")
                        {
                            jsonBuilder.Append("<span class='rviolet'></span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "0")
                        {
                            jsonBuilder.Append("<span class='rredvioletmh' style='font-size:30px;padding:3px;'>0</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "1")
                        {
                            jsonBuilder.Append("<span class='rgreen'style='font-size:30px;padding:3px;'>1</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "2")
                        {
                            jsonBuilder.Append("<span class='rred'style='font-size:30px;padding:3px;'>2</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "3")
                        {
                            jsonBuilder.Append("<span class='rgreen'style='font-size:30px;padding:3px;'>3</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "4")
                        {
                            jsonBuilder.Append("<span class='rred'style='font-size:30px;padding:3px;'>4</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "5")
                        {
                            jsonBuilder.Append("<span class='rgreenvioletmh' style='font-size:30px;padding:3px;'>5</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "6")
                        {
                            jsonBuilder.Append("<span class='rred'style='font-size:30px;padding:3px;'>6</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "7")
                        {
                            jsonBuilder.Append("<span class='rgreen'style='font-size:30px;padding:3px;'>7</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "8")
                        {
                            jsonBuilder.Append("<span class='rred'style='font-size:30px;padding:3px;'>8</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "9")
                        {
                            jsonBuilder.Append("<span class='rgreen'style='font-size:30px;padding:3px;'>9</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "BIG")
                        {
                            jsonBuilder.Append("<span class='ryellow' style='padding: 14px 0 0 0;font-size: 14px;'>Big</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "SMALL")
                        {
                            jsonBuilder.Append("<span class='skyblue' style='padding: 14px 0 0 0;font-size: 14px;'>Small</span>");
                        }
                        jsonBuilder.Append("</div>");


                        jsonBuilder.Append("<div class='col-6 pr-0 py-1 text-left d-inline-block'>");
                        jsonBuilder.Append("<p class='mb-0 Pfont'><b>" + ds.Tables[0].Rows[i]["JackpotNo"].ToString() + "</b></p>");
                        jsonBuilder.Append("<span class='timesty'>" + ds.Tables[0].Rows[i]["PlayDate"].ToString() + "</span>");
                        jsonBuilder.Append("</div>");

                        jsonBuilder.Append("<div class='col-4 p-1 text-right success d-inline-block'>");
                        jsonBuilder.Append("<p class='pmagin'>");
                        if (ds.Tables[0].Rows[i]["Status"].ToString() == "LOSS")
                        {
                            jsonBuilder.Append("<span class='bord px-3' style='border: 1px solid red;color:red;'>Failed</span></p>");
                            jsonBuilder.Append("<p class='mb-0' style='color:red;font-size:12px;'> <span>-</span> " + ds.Tables[0].Rows[i]["Point"].ToString() + " $ </p>");
                        }
                        else if (ds.Tables[0].Rows[i]["Status"].ToString() == "WIN")
                        {
                            jsonBuilder.Append("<span class='bord px-3' style='border: 1px solid green;color:green;'>Success</span></p>");
                            jsonBuilder.Append("<p class='mb-0' style='color:green;font-size:12px;'> <span>+</span> " + ds.Tables[0].Rows[i]["Point"].ToString() + " $ </p>");
                        }

                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");



                        jsonBuilder.Append("<hr class='my-1' />");


                        jsonBuilder.Append("<div class='child' id='c" + ds.Tables[0].Rows[i]["transID"].ToString() + "'>");
                        jsonBuilder.Append("<h4 class='detailsalgns pl-2'>Details</h4>");
                        jsonBuilder.Append("<ul class='m-0 p-0'> <li class='row detailitem lgc '><div class='col-6 m-0 p-0 detailsalgns'>Order Number</div><div class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["transID"].ToString() + "</div></li>");
                        jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Period</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["JackpotNo"].ToString() + "</span></li>");
                        jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-7 m-0 p-0 detailsalgns'>Play Amount</span><span class='col-5 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["plyAmt"].ToString() + ".00 </span></li>");
                        jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Quantity</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["plyAmt"].ToString() + "</span></li>");
                        jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-6 m-0 p-0 detailsalgns'>Tax</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["Dedamt"].ToString() + "</span></li>");
                        jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Amount after tax</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["JackpotPlayAmt"].ToString() + "</span></li>");
                        jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-4 m-0 p-0 detailsalgns'>Result</span><span class='col-8 m-0 p-0 detailsalgne'>"  + ds.Tables[0].Rows[i]["RsltNumber"].ToString() );

                        if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "GREEN")
                        {
                            jsonBuilder.Append(" <span class='DEgreen'>"+ ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "RED")
                        {
                            jsonBuilder.Append(" <span class='DEred'>"+ ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "VIOLET")
                        {
                            jsonBuilder.Append(" <span class='DEviolet'>" + ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "RED & VIOLET")
                        {
                            jsonBuilder.Append(" <span class='DEredviolet'>"+ ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "GREEN & VIOLET")
                        {
                            jsonBuilder.Append(" <span class='DEgreenviolet'>" + ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }

                        if (ds.Tables[0].Rows[i]["RsltBigSmall"].ToString() == "BIG")
                        {
                            jsonBuilder.Append(" <span class='DEyellow'>"+ ds.Tables[0].Rows[i]["RsltBigSmall"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["RsltBigSmall"].ToString() == "SMALL")
                        {
                            jsonBuilder.Append(" <span class='DEskyblue'>"+ ds.Tables[0].Rows[i]["RsltBigSmall"].ToString() + "</span>");
                        }
                        jsonBuilder.Append("</span></li>");

                        jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Select</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["Selecttype"].ToString() + "</span></li>");

                        if (ds.Tables[0].Rows[i]["Status"].ToString() == "LOSS")
                        {
                            jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-6 m-0 p-0 detailsalgns'>Status</span><span class='col-6 m-0 p-0 detailsalgne text-danger'>" + ds.Tables[0].Rows[i]["Status"].ToString() + "</span></li>");
                        }
                        else if (ds.Tables[0].Rows[i]["Status"].ToString() == "WIN")
                        {
                            jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-6 m-0 p-0 detailsalgns'>Status</span><span class='col-6 m-0 p-0 detailsalgne DEgreen'>" + ds.Tables[0].Rows[i]["Status"].ToString() + "</span></li>");
                        }


                        if (ds.Tables[0].Rows[i]["Status"].ToString() == "LOSS")
                        {
                            jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Win/lose Amount</span><span class='col-6 m-0 p-0 detailsalgne text-danger'> - " + ds.Tables[0].Rows[i]["Point"].ToString() + "</span></li>");
                        }
                        else if (ds.Tables[0].Rows[i]["Status"].ToString() == "WIN")
                        {
                            jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Win/lose Amount</span><span class='col-6 m-0 p-0 detailsalgne DEgreen'> + " + ds.Tables[0].Rows[i]["Point"].ToString() + "</span></li>");
                        }

                        jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-4 m-0 p-0 detailsalgns'>Order time</span><span class='col-8 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["PlayDate"].ToString() + "</span></li> </ul> ");
                        jsonBuilder.Append(" </div>");

                        jsonBuilder.Append("</div>");

                    }
                    if (PageNo.ToString() == "1" && PageNo.ToString() == dt.Rows[0]["TotalPages"].ToString()) {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Myorder("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link disabled' onclick='Myorder("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else if (PageNo.ToString() == "1") {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Myorder("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link' onclick='Myorder("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else if (PageNo.ToString() == dt.Rows[0]["TotalPages"].ToString()) {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link' onclick='Myorder("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link disabled' onclick='Myorder("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link' onclick='Myorder("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link' onclick='Myorder("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }

                }
                else
                {
                    jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found !</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
                }
            }
            else
            {
                jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found!</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
            }
            response.Write(jsonBuilder);

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
    private void Mysorder3min()
    {
        try
        {

            ds = objgdb.ByProcedure("dbo.ParityUpdatesSp_3min", new string[] { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                    "ParticipateTotAmt","FromTime","ToTime" },
                   new string[] { "10", UserID.ToString(), "", "", "", "", "", "", "", PageNo.ToString(), PageSize.ToString() }, "");

            StringBuilder jsonBuilder = new StringBuilder("");
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    //transID      JackpotNo	        MemID	               Selecttype	    JackpotPlayAmt      Dedamt    plyAmt	   Point	 Status	   ReslColor	RsltNumber	RsltBigSmall	PlayDate
                    //4654765          1098121	      Leno88374227              GREEN	                                tax       10	    10       LOSS	     RED	           4	      SMALL	     2024-03-20 12:29:46.290
                    for (int i = 0; i < dt.Rows.Count; i++){
                        jsonBuilder.Append("<div class='d-flex align-items-center' onclick='opendetails(" + ds.Tables[0].Rows[i]["transID"].ToString() + ")'>");

                        jsonBuilder.Append("<div class='col-2 p-0 py-1 clrs d-inline-block'>");
                        if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "GREEN")
                        {
                            jsonBuilder.Append("<span class='rgreen'></span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "RED")
                        {
                            jsonBuilder.Append("<span class='rred'></span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "VIOLET")
                        {
                            jsonBuilder.Append("<span class='rviolet'></span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "0")
                        {
                            jsonBuilder.Append("<span class='rredvioletmh' style='font-size:30px;padding:3px;'>0</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "1")
                        {
                            jsonBuilder.Append("<span class='rgreen'style='font-size:30px;padding:3px;'>1</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "2")
                        {
                            jsonBuilder.Append("<span class='rred'style='font-size:30px;padding:3px;'>2</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "3")
                        {
                            jsonBuilder.Append("<span class='rgreen'style='font-size:30px;padding:3px;'>3</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "4")
                        {
                            jsonBuilder.Append("<span class='rred'style='font-size:30px;padding:3px;'>4</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "5")
                        {
                            jsonBuilder.Append("<span class='rgreenvioletmh' style='font-size:30px;padding:3px;'>5</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "6")
                        {
                            jsonBuilder.Append("<span class='rred'style='font-size:30px;padding:3px;'>6</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "7")
                        {
                            jsonBuilder.Append("<span class='rgreen'style='font-size:30px;padding:3px;'>7</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "8")
                        {
                            jsonBuilder.Append("<span class='rred'style='font-size:30px;padding:3px;'>8</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "9")
                        {
                            jsonBuilder.Append("<span class='rgreen'style='font-size:30px;padding:3px;'>9</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "BIG")
                        {
                            jsonBuilder.Append("<span class='ryellow' style='padding: 14px 0 0 0;font-size: 14px;'>Big</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "SMALL")
                        {
                            jsonBuilder.Append("<span class='skyblue' style='padding: 14px 0 0 0;font-size: 14px;'>Small</span>");
                        }
                        jsonBuilder.Append("</div>");


                        jsonBuilder.Append("<div class='col-6 pr-0 py-1 text-left d-inline-block'>");
                        jsonBuilder.Append("<p class='mb-0 Pfont'><b>" + ds.Tables[0].Rows[i]["JackpotNo"].ToString() + "</b></p>");
                        jsonBuilder.Append("<span class='timesty'>" + ds.Tables[0].Rows[i]["PlayDate"].ToString() + "</span>");
                        jsonBuilder.Append("</div>");

                        jsonBuilder.Append("<div class='col-4 p-1 text-right success d-inline-block'>");
                        jsonBuilder.Append("<p class='pmagin'>");
                        if (ds.Tables[0].Rows[i]["Status"].ToString() == "LOSS")
                        {
                            jsonBuilder.Append("<span class='bord px-3' style='border: 1px solid red;color:red;'>Failed</span></p>");
                            jsonBuilder.Append("<p class='mb-0' style='color:red;font-size:12px;'> <span>-</span> " + ds.Tables[0].Rows[i]["Point"].ToString() + " $ </p>");
                        }
                        else if (ds.Tables[0].Rows[i]["Status"].ToString() == "WIN")
                        {
                            jsonBuilder.Append("<span class='bord px-3' style='border: 1px solid green;color:green;'>Success</span></p>");
                            jsonBuilder.Append("<p class='mb-0' style='color:green;font-size:12px;'> <span>+</span> " + ds.Tables[0].Rows[i]["Point"].ToString() + " $ </p>");
                        }

                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");



                        jsonBuilder.Append("<hr class='my-1' />");


                        jsonBuilder.Append("<div class='child' id='c" + ds.Tables[0].Rows[i]["transID"].ToString() + "'>");
                        jsonBuilder.Append("<h4 class='detailsalgns pl-2'>Details</h4>");
                        jsonBuilder.Append("<ul class='m-0 p-0'> <li class='row detailitem lgc '><div class='col-6 m-0 p-0 detailsalgns'>Order Number</div><div class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["transID"].ToString() + "</div></li>");
                        jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Period</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["JackpotNo"].ToString() + "</span></li>");
                        jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-7 m-0 p-0 detailsalgns'>Play Amount</span><span class='col-5 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["plyAmt"].ToString() + ".00 </span></li>");
                        jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Quantity</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["plyAmt"].ToString() + "</span></li>");
                        jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-6 m-0 p-0 detailsalgns'>Tax</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["Dedamt"].ToString() + "</span></li>");
                        jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Amount after tax</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["JackpotPlayAmt"].ToString() + "</span></li>");
                        jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-4 m-0 p-0 detailsalgns'>Result</span><span class='col-8 m-0 p-0 detailsalgne'>"  + ds.Tables[0].Rows[i]["RsltNumber"].ToString() );

                        if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "GREEN")
                        {
                            jsonBuilder.Append(" <span class='DEgreen'>"+ ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "RED")
                        {
                            jsonBuilder.Append(" <span class='DEred'>"+ ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "VIOLET")
                        {
                            jsonBuilder.Append(" <span class='DEviolet'>" + ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "RED & VIOLET")
                        {
                            jsonBuilder.Append(" <span class='DEredviolet'>"+ ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "GREEN & VIOLET")
                        {
                            jsonBuilder.Append(" <span class='DEgreenviolet'>" + ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }

                        if (ds.Tables[0].Rows[i]["RsltBigSmall"].ToString() == "BIG")
                        {
                            jsonBuilder.Append(" <span class='DEyellow'>"+ ds.Tables[0].Rows[i]["RsltBigSmall"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["RsltBigSmall"].ToString() == "SMALL")
                        {
                            jsonBuilder.Append(" <span class='DEskyblue'>"+ ds.Tables[0].Rows[i]["RsltBigSmall"].ToString() + "</span>");
                        }
                        jsonBuilder.Append("</span></li>");

                        jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Select</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["Selecttype"].ToString() + "</span></li>");

                        if (ds.Tables[0].Rows[i]["Status"].ToString() == "LOSS")
                        {
                            jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-6 m-0 p-0 detailsalgns'>Status</span><span class='col-6 m-0 p-0 detailsalgne text-danger'>" + ds.Tables[0].Rows[i]["Status"].ToString() + "</span></li>");
                        }
                        else if (ds.Tables[0].Rows[i]["Status"].ToString() == "WIN")
                        {
                            jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-6 m-0 p-0 detailsalgns'>Status</span><span class='col-6 m-0 p-0 detailsalgne DEgreen'>" + ds.Tables[0].Rows[i]["Status"].ToString() + "</span></li>");
                        }


                        if (ds.Tables[0].Rows[i]["Status"].ToString() == "LOSS")
                        {
                            jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Win/lose Amount</span><span class='col-6 m-0 p-0 detailsalgne text-danger'> - " + ds.Tables[0].Rows[i]["Point"].ToString() + "</span></li>");
                        }
                        else if (ds.Tables[0].Rows[i]["Status"].ToString() == "WIN")
                        {
                            jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Win/lose Amount</span><span class='col-6 m-0 p-0 detailsalgne DEgreen'> + " + ds.Tables[0].Rows[i]["Point"].ToString() + "</span></li>");
                        }

                        jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-4 m-0 p-0 detailsalgns'>Order time</span><span class='col-8 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["PlayDate"].ToString() + "</span></li> </ul> ");
                        jsonBuilder.Append(" </div>");

                        jsonBuilder.Append("</div>");
                    }
                    if (PageNo.ToString() == "1" && PageNo.ToString() == dt.Rows[0]["TotalPages"].ToString()) {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Myorder3min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link disabled' onclick='Myorder3min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else if (PageNo.ToString() == "1") {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Myorder3min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link' onclick='Myorder3min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else if (PageNo.ToString() == dt.Rows[0]["TotalPages"].ToString()) {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link' onclick='Myorder3min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link disabled' onclick='Myorder3min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link' onclick='Myorder3min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link' onclick='Myorder3min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }

                }
                else
                {
                    jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found !</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
                }
            }
            else
            {
                jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found!</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
            }
            response.Write(jsonBuilder);

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
    private void Mysorder5min()
    {
        try
        {

            ds = objgdb.ByProcedure("dbo.ParityUpdatesSp_5min", new string[] { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                    "ParticipateTotAmt","FromTime","ToTime" },
                   new string[] { "10", UserID.ToString(), "", "", "", "", "", "", "", PageNo.ToString(), PageSize.ToString() }, "");

            StringBuilder jsonBuilder = new StringBuilder("");
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    //transID      JackpotNo	        MemID	               Selecttype	    JackpotPlayAmt      Dedamt    plyAmt	   Point	 Status	   ReslColor	RsltNumber	RsltBigSmall	PlayDate
                    //4654765          1098121	      Leno88374227              GREEN	                                tax       10	    10       LOSS	     RED	           4	      SMALL	     2024-03-20 12:29:46.290
                    for (int i = 0; i < dt.Rows.Count; i++){
                        jsonBuilder.Append("<div class='d-flex align-items-center' onclick='opendetails(" + ds.Tables[0].Rows[i]["transID"].ToString() + ")'>");

                        jsonBuilder.Append("<div class='col-2 p-0 py-1 clrs d-inline-block'>");
                        if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "GREEN")
                        {
                            jsonBuilder.Append("<span class='rgreen'></span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "RED")
                        {
                            jsonBuilder.Append("<span class='rred'></span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "VIOLET")
                        {
                            jsonBuilder.Append("<span class='rviolet'></span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "0")
                        {
                            jsonBuilder.Append("<span class='rredvioletmh' style='font-size:30px;padding:3px;'>0</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "1")
                        {
                            jsonBuilder.Append("<span class='rgreen'style='font-size:30px;padding:3px;'>1</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "2")
                        {
                            jsonBuilder.Append("<span class='rred'style='font-size:30px;padding:3px;'>2</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "3")
                        {
                            jsonBuilder.Append("<span class='rgreen'style='font-size:30px;padding:3px;'>3</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "4")
                        {
                            jsonBuilder.Append("<span class='rred'style='font-size:30px;padding:3px;'>4</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "5")
                        {
                            jsonBuilder.Append("<span class='rgreenvioletmh' style='font-size:30px;padding:3px;'>5</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "6")
                        {
                            jsonBuilder.Append("<span class='rred'style='font-size:30px;padding:3px;'>6</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "7")
                        {
                            jsonBuilder.Append("<span class='rgreen'style='font-size:30px;padding:3px;'>7</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "8")
                        {
                            jsonBuilder.Append("<span class='rred'style='font-size:30px;padding:3px;'>8</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "9")
                        {
                            jsonBuilder.Append("<span class='rgreen'style='font-size:30px;padding:3px;'>9</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "BIG")
                        {
                            jsonBuilder.Append("<span class='ryellow' style='padding: 14px 0 0 0;font-size: 14px;'>Big</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "SMALL")
                        {
                            jsonBuilder.Append("<span class='skyblue' style='padding: 14px 0 0 0;font-size: 14px;'>Small</span>");
                        }
                        jsonBuilder.Append("</div>");


                        jsonBuilder.Append("<div class='col-6 pr-0 py-1 text-left d-inline-block'>");
                        jsonBuilder.Append("<p class='mb-0 Pfont'><b>" + ds.Tables[0].Rows[i]["JackpotNo"].ToString() + "</b></p>");
                        jsonBuilder.Append("<span class='timesty'>" + ds.Tables[0].Rows[i]["PlayDate"].ToString() + "</span>");
                        jsonBuilder.Append("</div>");

                        jsonBuilder.Append("<div class='col-4 p-1 text-right success d-inline-block'>");
                        jsonBuilder.Append("<p class='pmagin'>");
                        if (ds.Tables[0].Rows[i]["Status"].ToString() == "LOSS")
                        {
                            jsonBuilder.Append("<span class='bord px-3' style='border: 1px solid red;color:red;'>Failed</span></p>");
                            jsonBuilder.Append("<p class='mb-0' style='color:red;font-size:12px;'> <span>-</span> " + ds.Tables[0].Rows[i]["Point"].ToString() + " $ </p>");
                        }
                        else if (ds.Tables[0].Rows[i]["Status"].ToString() == "WIN")
                        {
                            jsonBuilder.Append("<span class='bord px-3' style='border: 1px solid green;color:green;'>Success</span></p>");
                            jsonBuilder.Append("<p class='mb-0' style='color:green;font-size:12px;'> <span>+</span> " + ds.Tables[0].Rows[i]["Point"].ToString() + " $ </p>");
                        }

                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");



                        jsonBuilder.Append("<hr class='my-1' />");


                        jsonBuilder.Append("<div class='child' id='c" + ds.Tables[0].Rows[i]["transID"].ToString() + "'>");
                        jsonBuilder.Append("<h4 class='detailsalgns pl-2'>Details</h4>");
                        jsonBuilder.Append("<ul class='m-0 p-0'> <li class='row detailitem lgc '><div class='col-6 m-0 p-0 detailsalgns'>Order Number</div><div class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["transID"].ToString() + "</div></li>");
                        jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Period</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["JackpotNo"].ToString() + "</span></li>");
                        jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-7 m-0 p-0 detailsalgns'>Play Amount</span><span class='col-5 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["plyAmt"].ToString() + ".00 </span></li>");
                        jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Quantity</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["plyAmt"].ToString() + "</span></li>");
                        jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-6 m-0 p-0 detailsalgns'>Tax</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["Dedamt"].ToString() + "</span></li>");
                        jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Amount after tax</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["JackpotPlayAmt"].ToString() + "</span></li>");
                        jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-4 m-0 p-0 detailsalgns'>Result</span><span class='col-8 m-0 p-0 detailsalgne'>"  + ds.Tables[0].Rows[i]["RsltNumber"].ToString() );

                        if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "GREEN")
                        {
                            jsonBuilder.Append(" <span class='DEgreen'>"+ ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "RED")
                        {
                            jsonBuilder.Append(" <span class='DEred'>"+ ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "VIOLET")
                        {
                            jsonBuilder.Append(" <span class='DEviolet'>" + ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "RED & VIOLET")
                        {
                            jsonBuilder.Append(" <span class='DEredviolet'>"+ ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "GREEN & VIOLET")
                        {
                            jsonBuilder.Append(" <span class='DEgreenviolet'>" + ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }

                        if (ds.Tables[0].Rows[i]["RsltBigSmall"].ToString() == "BIG")
                        {
                            jsonBuilder.Append(" <span class='DEyellow'>"+ ds.Tables[0].Rows[i]["RsltBigSmall"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["RsltBigSmall"].ToString() == "SMALL")
                        {
                            jsonBuilder.Append(" <span class='DEskyblue'>"+ ds.Tables[0].Rows[i]["RsltBigSmall"].ToString() + "</span>");
                        }
                        jsonBuilder.Append("</span></li>");

                        jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Select</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["Selecttype"].ToString() + "</span></li>");

                        if (ds.Tables[0].Rows[i]["Status"].ToString() == "LOSS")
                        {
                            jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-6 m-0 p-0 detailsalgns'>Status</span><span class='col-6 m-0 p-0 detailsalgne text-danger'>" + ds.Tables[0].Rows[i]["Status"].ToString() + "</span></li>");
                        }
                        else if (ds.Tables[0].Rows[i]["Status"].ToString() == "WIN")
                        {
                            jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-6 m-0 p-0 detailsalgns'>Status</span><span class='col-6 m-0 p-0 detailsalgne DEgreen'>" + ds.Tables[0].Rows[i]["Status"].ToString() + "</span></li>");
                        }


                        if (ds.Tables[0].Rows[i]["Status"].ToString() == "LOSS")
                        {
                            jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Win/lose Amount</span><span class='col-6 m-0 p-0 detailsalgne text-danger'> - " + ds.Tables[0].Rows[i]["Point"].ToString() + "</span></li>");
                        }
                        else if (ds.Tables[0].Rows[i]["Status"].ToString() == "WIN")
                        {
                            jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Win/lose Amount</span><span class='col-6 m-0 p-0 detailsalgne DEgreen'> + " + ds.Tables[0].Rows[i]["Point"].ToString() + "</span></li>");
                        }

                        jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-4 m-0 p-0 detailsalgns'>Order time</span><span class='col-8 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["PlayDate"].ToString() + "</span></li> </ul> ");
                        jsonBuilder.Append(" </div>");

                        jsonBuilder.Append("</div>");
                    }
                    if (PageNo.ToString() == "1" && PageNo.ToString() == dt.Rows[0]["TotalPages"].ToString()) {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Myorder5min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link disabled' onclick='Myorder5min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else if (PageNo.ToString() == "1") {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Myorder5min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link' onclick='Myorder5min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else if (PageNo.ToString() == dt.Rows[0]["TotalPages"].ToString()) {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link' onclick='Myorder5min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link disabled' onclick='Myorder5min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link' onclick='Myorder5min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link' onclick='Myorder5min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }

                }
                else
                {
                    jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found !</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
                }
            }
            else
            {
                jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found!</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
            }
            response.Write(jsonBuilder);

        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    } private void Mysorder10min()
    {
        try
        {

            ds = objgdb.ByProcedure("dbo.ParityUpdatesSp_10min", new string[] { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                    "ParticipateTotAmt","FromTime","ToTime" },
                   new string[] { "10", UserID.ToString(), "", "", "", "", "", "", "", PageNo.ToString(), PageSize.ToString() }, "");

            StringBuilder jsonBuilder = new StringBuilder("");
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {
                    //transID      JackpotNo	        MemID	               Selecttype	    JackpotPlayAmt      Dedamt    plyAmt	   Point	 Status	   ReslColor	RsltNumber	RsltBigSmall	PlayDate
                    //4654765          1098121	      Leno88374227              GREEN	                                tax       10	    10       LOSS	     RED	           4	      SMALL	     2024-03-20 12:29:46.290
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        jsonBuilder.Append("<div class='d-flex align-items-center' onclick='opendetails(" + ds.Tables[0].Rows[i]["transID"].ToString() + ")'>");

                        jsonBuilder.Append("<div class='col-2 p-0 py-1 clrs d-inline-block'>");
                        if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "GREEN")
                        {
                            jsonBuilder.Append("<span class='rgreen'></span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "RED")
                        {
                            jsonBuilder.Append("<span class='rred'></span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "VIOLET")
                        {
                            jsonBuilder.Append("<span class='rviolet'></span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "0")
                        {
                            jsonBuilder.Append("<span class='rredvioletmh' style='font-size:30px;padding:3px;'>0</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "1")
                        {
                            jsonBuilder.Append("<span class='rgreen'style='font-size:30px;padding:3px;'>1</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "2")
                        {
                            jsonBuilder.Append("<span class='rred'style='font-size:30px;padding:3px;'>2</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "3")
                        {
                            jsonBuilder.Append("<span class='rgreen'style='font-size:30px;padding:3px;'>3</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "4")
                        {
                            jsonBuilder.Append("<span class='rred'style='font-size:30px;padding:3px;'>4</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "5")
                        {
                            jsonBuilder.Append("<span class='rgreenvioletmh' style='font-size:30px;padding:3px;'>5</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "6")
                        {
                            jsonBuilder.Append("<span class='rred'style='font-size:30px;padding:3px;'>6</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "7")
                        {
                            jsonBuilder.Append("<span class='rgreen'style='font-size:30px;padding:3px;'>7</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "8")
                        {
                            jsonBuilder.Append("<span class='rred'style='font-size:30px;padding:3px;'>8</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "9")
                        {
                            jsonBuilder.Append("<span class='rgreen'style='font-size:30px;padding:3px;'>9</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "BIG")
                        {
                            jsonBuilder.Append("<span class='ryellow' style='padding: 14px 0 0 0;font-size: 14px;'>Big</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["Selecttype"].ToString() == "SMALL")
                        {
                            jsonBuilder.Append("<span class='skyblue' style='padding: 14px 0 0 0;font-size: 14px;'>Small</span>");
                        }
                        jsonBuilder.Append("</div>");


                        jsonBuilder.Append("<div class='col-6 pr-0 py-1 text-left d-inline-block'>");
                        jsonBuilder.Append("<p class='mb-0 Pfont'><b>" + ds.Tables[0].Rows[i]["JackpotNo"].ToString() + "</b></p>");
                        jsonBuilder.Append("<span class='timesty'>" + ds.Tables[0].Rows[i]["PlayDate"].ToString() + "</span>");
                        jsonBuilder.Append("</div>");

                        jsonBuilder.Append("<div class='col-4 p-1 text-right success d-inline-block'>");
                        jsonBuilder.Append("<p class='pmagin'>");
                        if (ds.Tables[0].Rows[i]["Status"].ToString() == "LOSS")
                        {
                            jsonBuilder.Append("<span class='bord px-3' style='border: 1px solid red;color:red;'>Failed</span></p>");
                            jsonBuilder.Append("<p class='mb-0' style='color:red;font-size:12px;'> <span>-</span> " + ds.Tables[0].Rows[i]["Point"].ToString() + " $ </p>");
                        }
                        else if (ds.Tables[0].Rows[i]["Status"].ToString() == "WIN")
                        {
                            jsonBuilder.Append("<span class='bord px-3' style='border: 1px solid green;color:green;'>Success</span></p>");
                            jsonBuilder.Append("<p class='mb-0' style='color:green;font-size:12px;'> <span>+</span> " + ds.Tables[0].Rows[i]["Point"].ToString() + " $ </p>");
                        }

                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");



                        jsonBuilder.Append("<hr class='my-1' />");


                        jsonBuilder.Append("<div class='child' id='c" + ds.Tables[0].Rows[i]["transID"].ToString() + "'>");
                        jsonBuilder.Append("<h4 class='detailsalgns pl-2'>Details</h4>");
                        jsonBuilder.Append("<ul class='m-0 p-0'> <li class='row detailitem lgc '><div class='col-6 m-0 p-0 detailsalgns'>Order Number</div><div class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["transID"].ToString() + "</div></li>");
                        jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Period</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["JackpotNo"].ToString() + "</span></li>");
                        jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-7 m-0 p-0 detailsalgns'>Play Amount</span><span class='col-5 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["plyAmt"].ToString() + ".00 </span></li>");
                        jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Quantity</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["plyAmt"].ToString() + "</span></li>");
                        jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-6 m-0 p-0 detailsalgns'>Tax</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["Dedamt"].ToString() + "</span></li>");
                        jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Amount after tax</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["JackpotPlayAmt"].ToString() + "</span></li>");
                        jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-4 m-0 p-0 detailsalgns'>Result</span><span class='col-8 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["RsltNumber"].ToString());

                        if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "GREEN")
                        {
                            jsonBuilder.Append(" <span class='DEgreen'>" + ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "RED")
                        {
                            jsonBuilder.Append(" <span class='DEred'>" + ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "VIOLET")
                        {
                            jsonBuilder.Append(" <span class='DEviolet'>" + ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "RED & VIOLET")
                        {
                            jsonBuilder.Append(" <span class='DEredviolet'>" + ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["ReslColor"].ToString() == "GREEN & VIOLET")
                        {
                            jsonBuilder.Append(" <span class='DEgreenviolet'>" + ds.Tables[0].Rows[i]["ReslColor"].ToString() + "</span>");
                        }

                        if (ds.Tables[0].Rows[i]["RsltBigSmall"].ToString() == "BIG")
                        {
                            jsonBuilder.Append(" <span class='DEyellow'>" + ds.Tables[0].Rows[i]["RsltBigSmall"].ToString() + "</span>");
                        }
                        else if (ds.Tables[0].Rows[i]["RsltBigSmall"].ToString() == "SMALL")
                        {
                            jsonBuilder.Append(" <span class='DEskyblue'>" + ds.Tables[0].Rows[i]["RsltBigSmall"].ToString() + "</span>");
                        }
                        jsonBuilder.Append("</span></li>");

                        jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Select</span><span class='col-6 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["Selecttype"].ToString() + "</span></li>");

                        if (ds.Tables[0].Rows[i]["Status"].ToString() == "LOSS")
                        {
                            jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-6 m-0 p-0 detailsalgns'>Status</span><span class='col-6 m-0 p-0 detailsalgne text-danger'>" + ds.Tables[0].Rows[i]["Status"].ToString() + "</span></li>");
                        }
                        else if (ds.Tables[0].Rows[i]["Status"].ToString() == "WIN")
                        {
                            jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-6 m-0 p-0 detailsalgns'>Status</span><span class='col-6 m-0 p-0 detailsalgne DEgreen'>" + ds.Tables[0].Rows[i]["Status"].ToString() + "</span></li>");
                        }


                        if (ds.Tables[0].Rows[i]["Status"].ToString() == "LOSS")
                        {
                            jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Win/lose Amount</span><span class='col-6 m-0 p-0 detailsalgne text-danger'> - " + ds.Tables[0].Rows[i]["Point"].ToString() + "</span></li>");
                        }
                        else if (ds.Tables[0].Rows[i]["Status"].ToString() == "WIN")
                        {
                            jsonBuilder.Append(" <li class='row detailitem glc'><span class='col-6 m-0 p-0 detailsalgns'>Win/lose Amount</span><span class='col-6 m-0 p-0 detailsalgne DEgreen'> + " + ds.Tables[0].Rows[i]["Point"].ToString() + "</span></li>");
                        }

                        jsonBuilder.Append(" <li class='row detailitem lgc'><span class='col-4 m-0 p-0 detailsalgns'>Order time</span><span class='col-8 m-0 p-0 detailsalgne'>" + ds.Tables[0].Rows[i]["PlayDate"].ToString() + "</span></li> </ul> ");
                        jsonBuilder.Append(" </div>");

                        jsonBuilder.Append("</div>");
                    }
                    if (PageNo.ToString() == "1" && PageNo.ToString() == dt.Rows[0]["TotalPages"].ToString()) {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Myorder10min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link disabled' onclick='Myorder10min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else if (PageNo.ToString() == "1") {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link disabled' onclick='Myorder10min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link' onclick='Myorder10min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else if (PageNo.ToString() == dt.Rows[0]["TotalPages"].ToString()) {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link' onclick='Myorder10min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link disabled' onclick='Myorder10min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme disabled'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }
                    else {
                        jsonBuilder.Append("<div id='pagination-controls' class='pagination' style='display:flex;justify-content:center'>");
                        jsonBuilder.Append("<div class='paginate_button page-item previous mr-3'>");
                        jsonBuilder.Append("<button id='prev-page' class='page-link' onclick='Myorder10min("+(PageNo-1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-left chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item active'>");
                        jsonBuilder.Append("<a href='' aria-controls='example23' data-dt-idx='2' tabindex='0' class='page-link'>" + PageNo.ToString() + "/" + dt.Rows[0]["TotalPages"].ToString() + "</a>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("<div class='paginate_button page-item next ml-3'>");
                        jsonBuilder.Append("<button id='next-page' class='page-link' onclick='Myorder10min("+(PageNo+1)+","+(PageSize)+")'><i class='fa-solid fa-circle-chevron-right chevpagin text-theme'></i></button>");
                        jsonBuilder.Append("</div>");
                        jsonBuilder.Append("</div>");
                    }

                }
                else
                {
                    jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found !</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
                }
            }
            else
            {
                jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found!</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
            }
            response.Write(jsonBuilder);

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
    //////////////////////////////////////////////////////   
    private void MyResult()
    {
        int TotalRows = 0;
        try
        {

            ds = objgdb.ByProcedure("dbo.ParityUpdatesSp_1min", new string[] { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                    "ParticipateTotAmt","FromTime","ToTime" },
                   new string[] { "11", UserID.ToString(), "", "", "", "", "", "", "", "", "" }, "");

            TotalRows = Convert.ToInt32(ds.Tables[0].Rows.Count.ToString());
            /////
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
    }
    /////////////////
    private void MyResult3min()
    {
        int TotalRows = 0;
        try
        {

            ds = objgdb.ByProcedure("dbo.ParityUpdatesSp_3min", new string[] { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                    "ParticipateTotAmt","FromTime","ToTime" },
                   new string[] { "11", UserID.ToString(), "", "", "", "", "", "", "", "", "" }, "");

            TotalRows = Convert.ToInt32(ds.Tables[0].Rows.Count.ToString());
            /////
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
    }
    /////////////////
    /////////////////
    private void MyResult5min()
    {
        int TotalRows = 0;
        try
        {

            ds = objgdb.ByProcedure("dbo.ParityUpdatesSp_5min", new string[] { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                    "ParticipateTotAmt","FromTime","ToTime" },
                   new string[] { "11", UserID.ToString(), "", "", "", "", "", "", "", "", "" }, "");

            TotalRows = Convert.ToInt32(ds.Tables[0].Rows.Count.ToString());
            /////
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
    }
    /////////////////

    /////////////////
    private void MyResult10min()
    {
        int TotalRows = 0;
        try
        {

            ds = objgdb.ByProcedure("dbo.ParityUpdatesSp_10min", new string[] { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                    "ParticipateTotAmt","FromTime","ToTime" },
                   new string[] { "11", UserID.ToString(), "", "", "", "", "", "", "", "", "" }, "");

            TotalRows = Convert.ToInt32(ds.Tables[0].Rows.Count.ToString());
            /////
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
    }
    /////////////////
    private void carouselwinId()
    {
        try
        {

            ds = objgdb.ByProcedure("dbo.ParityUpdatesSp_1min", new string[] { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                    "ParticipateTotAmt","FromTime","ToTime" },
                   new string[] { "12", "", "", "", "", "", "", "", "", "", "" }, "");

            StringBuilder jsonBuilder = new StringBuilder("");
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {

                    //for (int i = 1; i < dt.Rows.Count; i++)
                    //{
                    // jsonBuilder.Append("<div class='carousel-item active'>");
                    jsonBuilder.Append("<div class='d-flex align-items-center'>");
                    jsonBuilder.Append("<img src='img/UserProfile_Pic.jpg' style='width: 34px; height: 34px; border-radius: 18px; object-fit: cover;'/> ");
                    jsonBuilder.Append("<div class='text-white' style='margin-left: 14px; font-size: 14px;'>");
                    jsonBuilder.Append("<span>" + ds.Tables[0].Rows[0]["MemID"].ToString() + " wins <span style= 'color: rgb(0, 194, 130);'>" + ds.Tables[0].Rows[0]["WinAmt"].ToString() + "</span> in " + ds.Tables[0].Rows[0]["PlayGame"].ToString() + "</span>");
                    jsonBuilder.Append("</div >");
                    jsonBuilder.Append("</div >");
                    // jsonBuilder.Append("</div >");
                    //jsonBuilder.Append("<div class='carousel-item '>");
                    //jsonBuilder.Append("<div class='d-flex align-items-center'>");
                    //jsonBuilder.Append("<img src='../game/img/UserProfile_Pic.jpg' style='width: 34px; height: 34px; border-radius: 18px; object-fit: cover;'/> ");
                    //jsonBuilder.Append("<div class='text-white' style='margin-left: 14px; font-size: 14px;'>");
                    //jsonBuilder.Append("<span>" + ds.Tables[0].Rows[1]["MemID"].ToString() + " wins <span style= 'color: rgb(0, 194, 130);'>" + ds.Tables[0].Rows[1]["WinAmt"].ToString()+"</span> in " + ds.Tables[0].Rows[1]["PlayGame"].ToString() +"</span>");
                    //jsonBuilder.Append("</div >");
                    //jsonBuilder.Append("</div >");
                    //jsonBuilder.Append("</div >");
                    //}
                }
                else
                {
                    jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found !</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
                }
            }
            else
            {
                jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found!</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
            }
            response.Write(jsonBuilder);

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
    private void carouselwinIdscnd()
    {
        try
        {

            ds = objgdb.ByProcedure("dbo.ParityUpdatesSp_1min", new string[] { "Flag", "JackpotNo", "FromDate", "ToDate", "JackpotAmt", "Status", "JockpotWinnerID", "JockpotWinAmt",
                    "ParticipateTotAmt","FromTime","ToTime" },
                   new string[] { "12", "", "", "", "", "", "", "", "", "", "" }, "");

            StringBuilder jsonBuilder = new StringBuilder("");
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                if (dt.Rows.Count > 0)
                {

                    //for (int i = 1; i < dt.Rows.Count; i++)
                    //{
                    // jsonBuilder.Append("<div class='carousel-item active'>");
                    jsonBuilder.Append("<div class='d-flex align-items-center'>");
                    jsonBuilder.Append("<img src='img/UserProfile_Pic.jpg' style='width: 34px; height: 34px; border-radius: 18px; object-fit: cover;'/> ");
                    jsonBuilder.Append("<div class='text-white' style='margin-left: 14px; font-size: 14px;'>");
                    jsonBuilder.Append("<span>" + ds.Tables[0].Rows[1]["MemID"].ToString() + " wins <span style= 'color: rgb(0, 194, 130);'>" + ds.Tables[0].Rows[1]["WinAmt"].ToString() + "</span> in " + ds.Tables[0].Rows[1]["PlayGame"].ToString() + "</span>");
                    jsonBuilder.Append("</div >");
                    jsonBuilder.Append("</div >");
                    // jsonBuilder.Append("</div >");
                    //jsonBuilder.Append("<div class='carousel-item '>");
                    //jsonBuilder.Append("<div class='d-flex align-items-center'>");
                    //jsonBuilder.Append("<img src='../game/img/UserProfile_Pic.jpg' style='width: 34px; height: 34px; border-radius: 18px; object-fit: cover;'/> ");
                    //jsonBuilder.Append("<div class='text-white' style='margin-left: 14px; font-size: 14px;'>");
                    //jsonBuilder.Append("<span>" + ds.Tables[0].Rows[1]["MemID"].ToString() + " wins <span style= 'color: rgb(0, 194, 130);'>" + ds.Tables[0].Rows[1]["WinAmt"].ToString()+"</span> in " + ds.Tables[0].Rows[1]["PlayGame"].ToString() +"</span>");
                    //jsonBuilder.Append("</div >");
                    //jsonBuilder.Append("</div >");
                    //jsonBuilder.Append("</div >");
                    //}
                }
                else
                {
                    jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found !</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
                }
            }
            else
            {
                jsonBuilder.Append("<div class='alert text-danger w-100' role='alert' style='text-decoration-line: underline; text-decoration-color: #009688;'><div class='iq-alert-icon'><i class='ri-information-line'></i></div><div class='iq-alert-text'>Sorry, record not found!</div><button type='button' class='close' data-dismiss='alert' aria-label='Close'><i class='ri-close-line'></i></button></div></div>");
            }
            response.Write(jsonBuilder);

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
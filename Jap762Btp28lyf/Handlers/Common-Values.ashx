<%@ WebHandler Language="C#" Class="Common_Values" %>
using System;
using System.Data;
using System.Text;
using System.Web;

public class Common_Values : IHttpHandler
{
    public HttpContext context; public HttpRequest request; public HttpResponse response;
    public bool sc;
    public string msg, dtl, strJson, DisPos, DipsType;
    public static string UserID = "";
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
            objgdb.FillWebSiteEmailCompany();
            /////////
            UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value);
            /////////
            DisPos = context.Request.QueryString["Vs"].ToString();
            ////////
            if (DisPos == "CheckCookies")
            {                
            }  
            if (DisPos == "TopJngs")
            {
                this.BindResult();
            }
            if (DisPos == "News")
            {
                this.BindResultN();
            }

            if (DisPos == "RgtCrnr")
            {
                this.InnerGetReferralLink();
            }
            if (DisPos == "RefLink")
            {
                GetReferralLink();
            }
            if (DisPos == "RefLinkHome")
            {
                GetReferralLinkHm();
            }
            if (DisPos == "JngLink")
            {
                CreatNewAccount();
            }
            if (DisPos == "WithList")
            {
                WithdrawalList();
            }
            if (DisPos == "OnlineUsr")
            {
                OnlineUserList();
            }
            if (DisPos == "ActDrcts")
            {
                ActiveDirects();
            }
            if (DisPos == "DepostHtry")
            {
                DipsType = "DepostHtry";
                DepostHtry();
            }
            if (DisPos == "GetDepostHtry")
            {
                DipsType = "GetDepostHtry";
                DepostHtry();
            }
            if (DisPos == "fundDepostHtry")
            {
                DipsType = "fundDepostHtry";

                DepostHtry();
            }
            if (DisPos == "GanefundReqHtry")
            {
                DipsType = "GanefundReqHtry";

                GanefundReqHtry();
            }
            if (DisPos == "DownlineDepost")
            {
                DownlineDepost();
            }
            if (DisPos == "RecAct")
            {
                BindResultRAct();
            }
            if (DisPos == "RefLink1")
            {
                GetReferralLinkforpreview();
            }
            if (DisPos == "RefLink3")
            {
                GetReferralLinkforpreview1();
            }
            if (DisPos == "RefLink2")
            {
                GetReferralLinkforcopy();
            }
            if (DisPos == "ShareSM")
            {
                GetReferralLinkHmSM();
            }
            if (DisPos == "AddRef")
            {
                AddReferralLink();
            }
            if (DisPos == "HowToEarn")
            {
                HowToEarnLink();
            }
            if (DisPos == "DashFlag")
            {
                DashFlag();
            }


        }
        else
        {
            context.Response.Write("<script>window.open('../login.html','_top');</script>");
            //context.Response.Redirect("../amp.html","_top");
        }
    }
    private void GetReferralLink()
    {
        StringBuilder jsonBuilder = new StringBuilder("");
        //jsonBuilder.Append("<a href='http://" + DynamicDtls.WebSite2 + "/" + UserID + "' target='_blank'>");
        //jsonBuilder.Append("http://" + DynamicDtls.WebSite2 + "/" + UserID + "</a>");
        jsonBuilder.Append("<a href='http://" + DynamicDtls.WebSite2 + "/login.html?ref=" + UserID + "' target='_blank'>");
        jsonBuilder.Append("http://" + DynamicDtls.WebSite2 + "/ref/" + UserID + "</a>");
        response.Write(jsonBuilder);

        //StringBuilder jsonBuilder = new StringBuilder("");
        //jsonBuilder.Append("<a href='http://" + DynamicDtls.WebSite2 + "/signup.html?rf=" + UserID + "' target='_blank'>");
        //jsonBuilder.Append("http://" + DynamicDtls.WebSite2 + "/signup.html?rf=" + UserID + "</a>");
        //response.Write(jsonBuilder);
    }
    private void InnerGetReferralLink()
    {
        try
        {

            ds = objgdb.ByProcedure("Inst_DashBoardSummary", new string[] { "MemID" }, new string[] { UserID }, "");
            StringBuilder jsonBuilder = new StringBuilder("");
            jsonBuilder.Append("<div class='media-body'>");
            jsonBuilder.Append("<div class='media' id='top-menu'>");
            jsonBuilder.Append("<div class='pull-left tm-icon'>");
            jsonBuilder.Append("<a data-drawer='messages' class='drawer-toggle' href='Inbox.html'>");
            jsonBuilder.Append("<i class='sa-top-message'></i>");
            jsonBuilder.Append("<i class='n-count animated'>" + ds.Tables[0].Rows[0]["Msg_Cunt"].ToString() + "</i>");
            jsonBuilder.Append("<span>Messages</span>");
            jsonBuilder.Append("</a>");
            jsonBuilder.Append("</div>");
            jsonBuilder.Append("<div class='pull-left tm-icon'>");
            jsonBuilder.Append("<a data-drawer='notifications' class='drawer-toggle' href='#'>");
            jsonBuilder.Append("<i class='sa-top-updates'></i>");
            jsonBuilder.Append("<i class='n-count animated'>" + ds.Tables[0].Rows[0]["Msg_Cunt"].ToString() + "</i>");
            jsonBuilder.Append("<span>Updates</span>");
            jsonBuilder.Append("</a>");
            jsonBuilder.Append(" </div>");



            jsonBuilder.Append("<div id='time' class='pull-right'>");
            jsonBuilder.Append("<span id='hours'></span>");
            jsonBuilder.Append(":");
            jsonBuilder.Append("<span id='min'></span>");
            jsonBuilder.Append(":");
            jsonBuilder.Append("<span id='sec'></span>");
            jsonBuilder.Append("</div>");

            jsonBuilder.Append("<div class='media-body'>");
            jsonBuilder.Append("<div class='main-search' style='font-size:13px; padding-top:7px;'>");
            jsonBuilder.Append("<a href='http://" + DynamicDtls.WebSite2 + "/ref/" + UserID + "' target='_blank'>");
            jsonBuilder.Append("http://" + DynamicDtls.WebSite2 + "/ref/" + UserID + "</a>");
            jsonBuilder.Append("</div>");
            jsonBuilder.Append("</div>");
            jsonBuilder.Append("</div>");
            jsonBuilder.Append("</div>");
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
    private void GetReferralLinkHmSM()
    {
        StringBuilder jsonBuilder = new StringBuilder("");
        //jsonBuilder.Append("<div class='jumbotron bg-white m-b-20'>");
        //jsonBuilder.Append("<h2>REFER PEOPLE BY GIVING THEM THE FOLLOWING LINKS !</h2>");
        //jsonBuilder.Append("<p style='border:1px dashed #000; padding:10px;'>Referral Link: <a href='http://" + DBConnectHP.WebSite + "/rf/" + UserID + "' target='_blank'>");
        //jsonBuilder.Append("http://" + DBConnectHP.WebSite + "/rf/" + UserID + "</a>");
        //jsonBuilder.Append("</p><p>");
        jsonBuilder.Append("<div style='padding-left:0px' class='addthis_toolbox addthis_default_style' addthis:url=http://" + DynamicDtls.WebSite + " addthis:title='Global Trend - Cryptocurrency Expert Trading Centre !! !'>");
        jsonBuilder.Append("<a class='addthis_button_facebook_like' fb:''like:''layout='button_count'></a>");
        jsonBuilder.Append("<a class='addthis_button_tweet'></a> <a class='addthis_button_google_plusone' g:''plusone:''size='medium'></a>");
        jsonBuilder.Append("<a class='addthis_counter addthis_pill_style'></a>");
        jsonBuilder.Append("</div>");
        jsonBuilder.Append("<script type='text/javascript' src='//s7.addthis.com/js/250/addthis_widget.js#pubid=ra-4e7d7dd92609da70'></script>");
        jsonBuilder.Append("</p></div>");
        response.Write(jsonBuilder);
    }
    private void GetReferralLinkforpreview()
    {
        StringBuilder jsonBuilder = new StringBuilder("");
        //jsonBuilder.Append("<a href='http://" + DynamicDtls.WebSite2 + "/R/" + UserID + "' target='_blank'>");
        jsonBuilder.Append("<a href='http://" + DynamicDtls.WebSite2 + "/login.html?ref=" + UserID + "' target='_blank' style='color:#fff;'>+</a>");
        //jsonBuilder.Append("Add New User");
        response.Write(jsonBuilder);
    }

    private void GetReferralLinkforpreview1()
    {
        StringBuilder jsonBuilder = new StringBuilder("");
        //jsonBuilder.Append("<a href='http://" + DynamicDtls.WebSite2 + "/R/" + UserID + "' target='_blank'>");
        jsonBuilder.Append("<a href='http://" + DynamicDtls.WebSite2 + "/login.html?ref=" + UserID + "' target='_blank' style='color:#009efb;'>");
        jsonBuilder.Append("http://" + DynamicDtls.WebSite2 + "/ref/" + UserID + "</a>");

        //jsonBuilder.Append("Add New User");
        response.Write(jsonBuilder);
    }
    private void AddReferralLink()
    {
        StringBuilder jsonBuilder = new StringBuilder("");
        //jsonBuilder.Append("<a href='http://" + DynamicDtls.WebSite2 + "/R/" + UserID + "' target='_blank'>");
        jsonBuilder.Append("<a href='http://" + DynamicDtls.WebSite2 + "/login.html?ref=" + UserID + "' target='_blank'>");
        jsonBuilder.Append("+ Create New Referral</a>");
        response.Write(jsonBuilder);
    }
    private void GetReferralLinkforcopy()
    {
        StringBuilder jsonBuilder = new StringBuilder("");
        jsonBuilder.Append("http://" + DynamicDtls.WebSite2 + "/ref/" + UserID);

        response.Write(jsonBuilder);
    }
    private void GetReferralLinkHm()
    {
        StringBuilder jsonBuilder = new StringBuilder("");
        jsonBuilder.Append("Referral Link: <a href='http://" + DynamicDtls.WebSite2 + "/m7r9ow/omp.html?ref=" + UserID + "' target='_blank'>");
        jsonBuilder.Append("http://" + DynamicDtls.WebSite2 + "/m7r9ow/omp.html?ref=" + UserID + "</a>");
        response.Write(jsonBuilder);
    }
    private void CreatNewAccount()
    {
        StringBuilder jsonBuilder = new StringBuilder("");
        jsonBuilder.Append("<a href='omp.html?ref=" + UserID + "' target='_blank'><i class='fa fa-medkit'></i><span>Registration</span></a>");
        response.Write(jsonBuilder);
    }
    private void BindResult()
    {
        try
        {

            //    ds = objgdb.ByProcedure("[DailyNews_Jng]", new string[] { "MemID", "Type" }, new string[] { UserID, "TopJngs" }, "");
            //    if (ds.Tables[0].Rows.Count > 0)
            //    {
            //        StringBuilder jsonBuilder = new StringBuilder("");
            //        if (ds.Tables[0].Rows.Count > 0)
            //        {
            //            dt = ds.Tables[0];
            //            if (dt.Rows.Count > 0)
            //            {

            //                jsonBuilder.Append("<ul class='signups'>");
            //                for (int i = 0; i < dt.Rows.Count; i++)
            //                {
            //                    jsonBuilder.Append("<li>");
            //                    jsonBuilder.Append("<div class='user pull-left'>");
            //                    jsonBuilder.Append("<img src='" + ds.Tables[0].Rows[i]["MemPic"].ToString() + "' alt='user'>");
            //                    jsonBuilder.Append("</div>");
            //                    jsonBuilder.Append("<div class='info'>");
            //                    jsonBuilder.Append("<h6>" + ds.Tables[0].Rows[i]["MName"].ToString() + "</h6>");
            //                    jsonBuilder.Append("<p class='designation'>" + ds.Tables[0].Rows[i]["DownID"].ToString() + "</p>");
            //                    jsonBuilder.Append("<small>Sign-up on: " + ds.Tables[0].Rows[i]["doj"].ToString() + "</small>");
            //                    jsonBuilder.Append("</div></li>");

            //                }
            //                jsonBuilder.Append("</ul>");
            //                //jsonBuilder.Append("</table>");
            //            }
            //        }
            //        response.Write(jsonBuilder);
            //    }
            //}
            //catch (Exception ex)
            //{
            //    DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            //}
            //finally
            //{
            //    if (ds != null) { ds.Dispose(); }
            //}



            ds = objgdb.ByProcedure("[DailyNews_Jng]", new string[] { "MemID", "Type" }, new string[] { UserID, "TopJngs" }, "");
            StringBuilder jsonBuilder = new StringBuilder("");
            if (ds.Tables[0].Rows.Count > 0)
            {
                //StringBuilder jsonBuilder = new StringBuilder("");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {

                        //jsonBuilder.Append("<ul class='list-task todo-list list-group m-b-0' data-role='tasklist'>");
                        //for (int i = 0; i < dt.Rows.Count; i++)
                        //{
                        //    jsonBuilder.Append("<li class='list-group-item' data-role='task'>");
                        //    jsonBuilder.Append("<div class='checkbox checkbox-info'>");
                        //    jsonBuilder.Append("<input type='checkbox' id='inputSchedule"+i.ToString() +"' name='inputCheckboxesSchedule'>");
                        //    jsonBuilder.Append("<label for='inputSchedule" + i.ToString() + "' class=''><span>" + ds.Tables[0].Rows[i]["DownID"].ToString() + " - " + ds.Tables[0].Rows[i]["MName"].ToString() + "</span> </label>");
                        //    jsonBuilder.Append("</div>");

                        //    jsonBuilder.Append("<ul class='assignedto'>");
                        //    jsonBuilder.Append("<li><img src='" + ds.Tables[0].Rows[i]["MemPic"].ToString() + "' alt='user' data-toggle='tooltip' data-placement='top' title='' data-original-title='Steave'>  Sign-up on: " + ds.Tables[0].Rows[i]["doj"].ToString() + "</li>");
                        //    jsonBuilder.Append("</ul>");
                        //    jsonBuilder.Append("</li>");




                        //    //jsonBuilder.Append("<div class='user pull-left'>");
                        //    //jsonBuilder.Append("<img src='" + ds.Tables[0].Rows[i]["MemPic"].ToString() + "' alt='user'>");
                        //    //jsonBuilder.Append("</div>");
                        //    //jsonBuilder.Append("<div class='info'>");
                        //    //jsonBuilder.Append("<h6>" + ds.Tables[0].Rows[i]["MName"].ToString() + "</h6>");
                        //    //jsonBuilder.Append("<p class='designation'>" + ds.Tables[0].Rows[i]["DownID"].ToString() + "</p>");
                        //    //jsonBuilder.Append("<small>Sign-up on: " + ds.Tables[0].Rows[i]["doj"].ToString() + "</small>");
                        //    //jsonBuilder.Append("</div></li>");

                        //}
                        //jsonBuilder.Append("</ul>");
                        ////jsonBuilder.Append("</table>");




                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            jsonBuilder.Append("<div class='py-3 px-2 border-bottom d-block text-decoration-none'>");
                            jsonBuilder.Append("<div class='user-img position-relative d-inline-block mr-2'>");
                            jsonBuilder.Append("<img src='" + ds.Tables[0].Rows[i]["MemPic"].ToString() + "' class='rounded-circle'  width='50'> ");
                            if (ds.Tables[0].Rows[i]["Status"].ToString().ToUpper() == "GREEN")
                            {
                                jsonBuilder.Append("<span class='profile-status pull-right d-inline-block position-absolute bg-success rounded-circle'> </span>");
                            }
                            else
                            {
                                jsonBuilder.Append("<span class='profile-status pull-right d-inline-block position-absolute bg-danger rounded-circle'> </span>");
                            }



                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("<div class='mail-contnet d-inline-block align-middle'>");
                            jsonBuilder.Append("<h5  style='text-transform:capitalize;'class='my-1'>" + ds.Tables[0].Rows[i]["MName"].ToString() + "</h5><small class='text-muted'>DOJ -" + ds.Tables[0].Rows[i]["doj"].ToString() + "</small></div>");

                            jsonBuilder.Append("<div class='mail-contnet d-inline-block align-middle side-txtd' style=' border-left: 1px solid #ececec;padding-left:15px;'>");
                            jsonBuilder.Append("<h5 class='my-1' style='font-weight:600;'> " + ds.Tables[0].Rows[i]["DownID"].ToString() + "</h5><span class='mail-desc font-12 text-truncate overflow-hidden text-nowrap d-block'><img alt='" + ds.Tables[0].Rows[i]["Country"].ToString() + "' src='../Country-Flag/" + ds.Tables[0].Rows[i]["Country"].ToString() + ".png' class='profile-pic' style='width:25px; height:25px;' /> " + ds.Tables[0].Rows[i]["Country"].ToString() + " </span></div>");
                            jsonBuilder.Append("</div>");

                            jsonBuilder.Append("</div>");




                        }

                        //jsonBuilder.Append("</table>");


                    }


                }
                //response.Write(jsonBuilder);
            }
            else
            {
                jsonBuilder.Append("<div style='color:#ffffff80;'>Sorry, Record not found..!</div>");
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
    private void BindResultRAct()
    {
        try
        {
            ds = objgdb.ByProcedure("[Recent_Activities]", new string[] { "MemID" }, new string[] { UserID }, "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                StringBuilder jsonBuilder = new StringBuilder("");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {

                        //jsonBuilder.Append("<ul class='feeds'>");
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            jsonBuilder.Append("<div class='d-flex flex-row comment-row' style='margin-bottom: 0px; margin-top: 0px; padding-bottom:0px; padding-top:0px;'>");
                            jsonBuilder.Append("<div class='p-2'>" + ds.Tables[0].Rows[i]["ActImg"].ToString() + "</div>");

                            jsonBuilder.Append("<div class='comment-text w-100'>");



                            if (ds.Tables[0].Rows[i]["ActivityName"].ToString().Trim() == "Login Detail")
                            {
                                jsonBuilder.Append("<h5>" + ds.Tables[0].Rows[i]["ActivityName"].ToString() + " <a class='label label-primary' href='IP-History.html' title='Activity on this account'>History!</a></h5>");
                            }
                            else if (ds.Tables[0].Rows[i]["ActivityName"].ToString().Trim() == "My Referrals")
                            {

                                jsonBuilder.Append("<h5>" + ds.Tables[0].Rows[i]["ActivityName"].ToString() + " <a class='label label-success' href='MyReferrals.html' title='My Referrals'>View All</a></h5>");
                            }
                            else if (ds.Tables[0].Rows[i]["ActivityName"].ToString().Trim() == "Account Status")
                            {
                                //if (ds.Tables[0].Rows[i]["Activity"].ToString().Trim() == "Account Actived")
                                //{

                                jsonBuilder.Append("<h5>" + ds.Tables[0].Rows[i]["ActivityName"].ToString() + " <a class='label label-info' href='Deposit-History.html' title='Account Status'>Deposit History</a></h5>");
                                //}
                                //else
                                //{
                                //jsonBuilder.Append("<div class='comment-footer'> <span class='text-muted pull-right'>" + ds.Tables[0].Rows[i]["ActTime"].ToString() + "</span> <span class='label label-danger'>Not Actived</span> <span class='action-icons'>");
                                //}

                            }
                            else if (ds.Tables[0].Rows[i]["ActivityName"].ToString().Trim() == "Membership")
                            {

                                jsonBuilder.Append("<h5>" + ds.Tables[0].Rows[i]["ActivityName"].ToString() + " <a class='label label-danger' href='My-Profile.html' title='Activity on this account'>My Profile</a></h5>");
                            }
                            else if (ds.Tables[0].Rows[i]["ActivityName"].ToString().Trim() == "Withdrawal")
                            {

                                jsonBuilder.Append("<h5>" + ds.Tables[0].Rows[i]["ActivityName"].ToString() + " <a class='label label-warning' href='Withdrawal-History.html' title='Withdrawal History on this account'>History!</a></h5>");
                            }
                            else if (ds.Tables[0].Rows[i]["ActivityName"].ToString().Trim() == "Deposit")
                            {

                                jsonBuilder.Append("<h5>" + ds.Tables[0].Rows[i]["ActivityName"].ToString() + " <a class='label label-primary' href='Deposit-Now.html' title='Deposit on this account'>Top-Up Now</a></h5>");
                            }
                            else
                            {

                                jsonBuilder.Append("<h5>" + ds.Tables[0].Rows[i]["ActivityName"].ToString() + " <a class='label label-primary' href='#' title=''>" + ds.Tables[0].Rows[i]["ActivityName"].ToString() + "</a></h5>");
                            }

                            jsonBuilder.Append("<p class='m-b-5'>" + ds.Tables[0].Rows[i]["Activity"].ToString() + ".<span class='text-muted pull-right'>" + ds.Tables[0].Rows[i]["ActTime"].ToString() + "</span></p>");
                            //jsonBuilder.Append("</span>");
                            //jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");



                            //jsonBuilder.Append("<a href='javascript:;'>");
                            //if (i == 0)
                            //{
                            //    jsonBuilder.Append("<div class='icon bg-info-light'><i class='fa fa-check'></i></div>");
                            //}
                            //if (i == 1)
                            //{
                            //    jsonBuilder.Append("<div class='icon bg-success-light'><i class='fa fa-info-circle'></i></div>");
                            //}
                            //if (i == 2)
                            //{
                            //    jsonBuilder.Append("<div class='icon bg-warning-light'><i class='fa fa-file-text'></i></div>");
                            //}
                            //if (i == 3)
                            //{
                            //    jsonBuilder.Append("<div class='icon bg-danger-light'><i class='fa fa-hdd-o'></i></div>");
                            //}
                            //if (i == 4)
                            //{
                            //    jsonBuilder.Append("<div class='icon bg-grey-light'><i class='fa fa-bell'></i></div>");
                            //}
                            //if (i == 5)
                            //{
                            //    jsonBuilder.Append("<div class='icon bg-grey-light'><i class='fa fa-bug'></i></div>");
                            //}
                            //if (i == 6)
                            //{
                            //    jsonBuilder.Append("<div class='icon bg-success-light'><i class='fa fa-plus'></i></div>");
                            //}
                            //if (i == 7)
                            //{
                            //    jsonBuilder.Append("<div class='icon bg-success-light'><i class='fa fa-check'></i></div>");
                            //}
                            //if (i == 8)
                            //{
                            //    jsonBuilder.Append("<div class='icon bg-info-light'><i class='fa fa-info-circle'></i></div>");
                            //}
                            //jsonBuilder.Append("<div class='time'>" + ds.Tables[0].Rows[i]["ActTime"].ToString() + "</div>");
                            //jsonBuilder.Append("<div class='desc'>" + ds.Tables[0].Rows[i]["Activity"].ToString() + "</div>");
                            //jsonBuilder.Append("</a>");
                            //jsonBuilder.Append("</li>");


                        }
                        //jsonBuilder.Append("</ul>");
                    }
                }
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
    private void DashFlag()
    {
        try
        {
            ds = objgdb.ByProcedure("[DailyNews_Jng]", new string[] { "MemID", "Type" }, new string[] { UserID, "DashFlag" }, "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                dt = ds.Tables[0];
                int count = ds.Tables[0].Rows.Count;
                string strJson = Dataset2Json(ds, count);
                context.Response.Write(strJson);
                context.Response.End();

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
    private void HowToEarnLink()
    {
        try
        {
            ds = objgdb.ByProcedure("[Inst_Dash_Ref_Link]", new string[] { "ID", "Memid", "LinkType", "Link", "Type", "intPageSize", "intCurrentPage", "intTotalRecords", "FormDate", "ToDate", "Column", "SearchTxt" }, new string[] { "", UserID.ToString(), "", "", "DASHVIEW", "", "", "", "", "", "", "" }, "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                StringBuilder jsonBuilder = new StringBuilder("");
                dt = ds.Tables[0];
                for (int i = 0; i < dt.Rows.Count; i++)
                {

                    jsonBuilder.Append("<li class='list-group-item' data-role='task'>");
                    jsonBuilder.Append("<div class='checkbox checkbox-info'>");
                    jsonBuilder.Append("<input type='checkbox' id='" + dt.Rows[i]["LinkType"].ToString() + "' name='inputCheckboxesBook'>");
                    jsonBuilder.Append("<label for='" + dt.Rows[i]["LinkType"].ToString() + "' class=''> <span>" + dt.Rows[i]["LinkType"].ToString() + " </span>");
                    if (i == 0)
                    {
                        jsonBuilder.Append("<span class='label label-danger'>" + dt.Rows[i]["Date"].ToString() + "</span>");
                    }
                    if (i == 1)
                    {
                        jsonBuilder.Append("<span class='label label-info'>" + dt.Rows[i]["Date"].ToString() + "</span>");
                    }
                    if (i == 2)
                    {
                        jsonBuilder.Append("<span class='label label-success'>" + dt.Rows[i]["Date"].ToString() + "</span>");
                        jsonBuilder.Append("<span class='label label-danger' style='margin-left:3px;' data-toggle='modal' data-target='#rfLinkmodel' >Add Referral Link</span>");
                    }
                    if (i == 3)
                    {
                        jsonBuilder.Append("<span class='label label-primary'>" + dt.Rows[i]["Date"].ToString() + "</span>");
                    }
                    if (i == 4)
                    {
                        jsonBuilder.Append("<span class='label label-warning'>" + dt.Rows[i]["Date"].ToString() + "</span>");

                    }
                    if (i == 5)
                    {
                        jsonBuilder.Append("<span class='label label-danger'>" + dt.Rows[i]["Date"].ToString() + "</span>");
                    }
                    if (i == 6)
                    {
                        jsonBuilder.Append("<span class='label label-primary'>" + dt.Rows[i]["Date"].ToString() + "</span>");
                    }
                    if (i == 7)
                    {
                        jsonBuilder.Append("<span class='label label-success'>" + dt.Rows[i]["Date"].ToString() + "</span>");
                    }
                    if (i == 8)
                    {
                        jsonBuilder.Append("<span class='label label-info'>" + dt.Rows[i]["Date"].ToString() + "</span>");
                    }
                    if (i == 9)
                    {
                        jsonBuilder.Append("<span class='label label-warning'>" + dt.Rows[i]["Date"].ToString() + "</span>");
                    }
                    if (dt.Rows[i]["LinkType"].ToString().Trim() == "Ad Mob")
                    {
                        //jsonBuilder.Append("&nbsp;<span class='label label-success'>Add Units</span>"); btn waves-effect waves-light btn-xs btn-info
                        jsonBuilder.Append("&nbsp;<button class='pull-right btn waves-effect waves-light btn-xs btn-success' data-toggle='modal' data-target='#myModal'>Add Units</button>");
                    }
                    jsonBuilder.Append("</label>");
                    jsonBuilder.Append("</div>");
                    jsonBuilder.Append("<ul class='assignedto'> ");
                    jsonBuilder.Append("<li><a href='" + dt.Rows[i]["Link"].ToString() + "' target='_blank'>" + dt.Rows[i]["Link"].ToString() + "</a></li>");
                    jsonBuilder.Append("</ul>");
                    jsonBuilder.Append("</li>");



                }
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
    private void DownlineDepost()
    {
        int TotalRows = 0;
        try
        {

            ds = objgdb.ByProcedure("dbo.[Downline_Deposits]", new string[] { "intPageSize", "intCurrentPage", "memid", "Filter" },
                 new string[] { "10", "1", UserID.ToString().Trim(), "" }, "intTotalRecords", out TotalRows, "ByDataset");
            if (ds.Tables[0].Rows.Count > 0)
            {
                StringBuilder jsonBuilder = new StringBuilder("");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        //jsonBuilder.Append("<ul class='imp-messages'>");
                        jsonBuilder.Append("<table class='table stylish-table' id='example'>");
                        jsonBuilder.Append("<thead>");
                        jsonBuilder.Append("<tr>");
                        jsonBuilder.Append("<th colspan='2'>Name</th>");
                        jsonBuilder.Append("<th>MemberID</th>");
                        //jsonBuilder.Append("<th>Priority</th>");
                        jsonBuilder.Append("<th>Deposit Amount</th>");
                        jsonBuilder.Append("</tr>");
                        jsonBuilder.Append("</thead>");
                        jsonBuilder.Append("<tbody>");


                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            jsonBuilder.Append("<tr>");
                            jsonBuilder.Append("<td style='width:50px;'>" + ds.Tables[0].Rows[i]["Mem Pic"].ToString() + "</td>");
                            jsonBuilder.Append("<td>");
                            jsonBuilder.Append("<h6>" + ds.Tables[0].Rows[i]["User Name"].ToString() + "</h6></td>");
                            jsonBuilder.Append("<td>" + ds.Tables[0].Rows[i]["MemID"].ToString() + "</td>");
                            jsonBuilder.Append("<td>" + ds.Tables[0].Rows[i]["Deposit Amt"].ToString() + "</td>");
                            jsonBuilder.Append("</tr>");

                        }

                        jsonBuilder.Append(" </tbody>");
                        jsonBuilder.Append(" </table>");
                    }
                }
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
    private void GanefundReqHtry()
    {
        try
        {

            ds = objgdb.ByProcedure("[DailyNews_Jng]", new string[] { "MemID", "Type" }, new string[] { UserID, DipsType }, "");
            StringBuilder jsonBuilder = new StringBuilder("");
            if (ds.Tables[0].Rows.Count > 0)
            {
                //StringBuilder jsonBuilder = new StringBuilder("");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        //jsonBuilder.Append("<ul class='imp-messages'>");
                        for (int i = 0; i < dt.Rows.Count; i++) //<span style='font-weight:500'>"+ Orjson[i].SrNo+".</span>
                        {
                            jsonBuilder.Append("<div class='sl-item'>");
                            jsonBuilder.Append("<div class='sl-left'> <img src='../UserProfileImg/" + ds.Tables[0].Rows[i]["AcType"].ToString() + ".png' alt='PaymentMode' class='img-circle' /> </div>");
                            jsonBuilder.Append("<div class='sl-right'>");
                            jsonBuilder.Append("<div> <a href='#' class='link' >Request By " + ds.Tables[0].Rows[i]["AcType"].ToString() + "</a> <span class='sl-date'> Requested On : " + ds.Tables[0].Rows[i]["ReqDate"].ToString() + "</span>");
                            //Request-No: " + ds.Tables[0].Rows[i]["PaymentID"].ToString() + "
                            jsonBuilder.Append("<p>Payment transaction no was <a href='#'> " + ds.Tables[0].Rows[i]["PaymentID"].ToString() + "</a></p>");
                            jsonBuilder.Append("<div class='m-t-20 row'>");
                            if (ds.Tables[0].Rows[i]["AcType"].ToString() == "BANK")
                            {
                                jsonBuilder.Append("<div class='col-md-2 col-xs-12'><a href='../Receipt/ACC/" + ds.Tables[0].Rows[i]["ReceiptPath"].ToString() + "' ><img src='../Receipt/ACC/" + ds.Tables[0].Rows[i]["ReceiptPath"].ToString() + "' alt='Receipt' class='img-responsive radius' style='width:150px; height:100px;' /></a></div>");
                            }
                            if (ds.Tables[0].Rows[i]["Status"].ToString() == "APPROVED")
                            {
                                jsonBuilder.Append("<div class='col-md-2 col-xs-12'><img src='../UserProfileImg/COMPLETED.png' alt='Receipt' class='img-responsive radius' style='width:150px; height:100px;' /></div>");
                            }
                            else
                            {
                                jsonBuilder.Append("<div class='col-md-2 col-xs-12'><img src='../UserProfileImg/PENDING.jpg' alt='Receipt' class='img-responsive radius' style='width:150px; height:100px;' /></div>");

                            }

                            if (ds.Tables[0].Rows[i]["AcType"].ToString() == "BTC")
                            {
                                //jsonBuilder.Append("<div class='col-md-2 col-xs-12'><a href='../Receipt/BTC/" + ds.Tables[0].Rows[i]["ReceiptPath"].ToString() + "' ><img src='../Receipt/BTC/" + ds.Tables[0].Rows[i]["ReceiptPath"].ToString() + "' alt='Receipt' class='img-responsive radius' style='width:150px; height:100px;' /></a></div>");
                            }
                            if (ds.Tables[0].Rows[i]["AcType"].ToString() == "PAYTM")
                            {
                                jsonBuilder.Append("<div class='col-md-2 col-xs-12'><a href='../Receipt/PAY/" + ds.Tables[0].Rows[i]["ReceiptPath"].ToString() + "' ><img src='../Receipt/PAY/" + ds.Tables[0].Rows[i]["ReceiptPath"].ToString() + "' alt='Receipt' class='img-responsive radius' style='width:150px; height:100px;'/></a></div>");
                            }
                            if (ds.Tables[0].Rows[i]["AcType"].ToString() == "UPI")
                            {
                                jsonBuilder.Append("<div class='col-md-2 col-xs-12'><a href='../Receipt/UPI/" + ds.Tables[0].Rows[i]["ReceiptPath"].ToString() + "' ><img src='../Receipt/UPI/" + ds.Tables[0].Rows[i]["ReceiptPath"].ToString() + "' alt='Receipt' class='img-responsive radius' style='width:150px; height:100px;'/></a></div>");
                            }
                            jsonBuilder.Append("<div class='col-md-9 col-xs-12'>");
                            if (ds.Tables[0].Rows[i]["Status"].ToString() == "APPROVED")
                            {
                                jsonBuilder.Append("<p style='color:#ffffff80'> " + ds.Tables[0].Rows[i]["AcType"].ToString() + " <br/>" + ds.Tables[0].Rows[i]["ReceiverBTC"].ToString() + "</p> <a href='#' class='btn btn-success' style='border-radius:3px!important;'>" + ds.Tables[0].Rows[i]["Status"].ToString() + "</a>");
                            }
                            else if (ds.Tables[0].Rows[i]["Status"].ToString() == "")
                            {
                                jsonBuilder.Append("<p style='color:#ffffff80'> " + ds.Tables[0].Rows[i]["AcType"].ToString() + " <br/>" + ds.Tables[0].Rows[i]["ReceiverBTC"].ToString() + "</p> <a href='#' class='btn btn-warning' style='border-radius:3px!important;'>Pending</a>");
                            }
                            else
                            {
                                jsonBuilder.Append("<p style='color:#ffffff80'> " + ds.Tables[0].Rows[i]["AcType"].ToString() + " <br/>" + ds.Tables[0].Rows[i]["ReceiverBTC"].ToString() + "</p> <a href='#' class='btn btn-warning' style='border-radius:3px!important;'>" + ds.Tables[0].Rows[i]["Status"].ToString() + "</a>");
                            }

                            jsonBuilder.Append("<span class='btn btn-warning TyFuReq' >Type : " + ds.Tables[0].Rows[i]["ReqType"].ToString() + "</span></div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("<div class='like-comm m-t-20'> <a href='javascript:void(0)' class='link m-r-10'>$" + ds.Tables[0].Rows[i]["PlanAmt"].ToString() + " <span style='font-size:12px; color:#455a64'> Request Amount</span></a> <a href='javascript:void(0)' class='link m-r-10'><i class='fa fa-calendar text-danger'></i><span style='font-size:12px; color:#455a64'> Payment Date </span>" + ds.Tables[0].Rows[i]["PaymentDate"].ToString() + "</a> </div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("<hr>");

                        }
                        //jsonBuilder.Append(" </ul>");

                    }

                }

                // response.Write(jsonBuilder);
            }
            else
            {
                jsonBuilder.Append("<div style='color:#ffffff80; margin-left:-60px;'>Sorry, record not found...!</div>");
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
    private void DepostHtry()
    {
        try
        {

            ds = objgdb.ByProcedure("[DailyNews_Jng]", new string[] { "MemID", "Type" }, new string[] { UserID, DipsType }, "");
            StringBuilder jsonBuilder = new StringBuilder("");
            if (ds.Tables[0].Rows.Count > 0)
            {
                //StringBuilder jsonBuilder = new StringBuilder("");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        //jsonBuilder.Append("<ul class='imp-messages'>");
                        for (int i = 0; i < dt.Rows.Count; i++) //<span style='font-weight:500'>"+ Orjson[i].SrNo+".</span>
                        {
                            jsonBuilder.Append("<div class='sl-item'>");
                            jsonBuilder.Append("<div class='sl-left'> <img src='../UserProfileImg/" + ds.Tables[0].Rows[i]["AcType"].ToString() + ".png' alt='PaymentMode' class='img-circle' /> </div>");
                            jsonBuilder.Append("<div class='sl-right'>");
                            jsonBuilder.Append("<div> <a href='#' class='link' >Request By " + ds.Tables[0].Rows[i]["AcType"].ToString() + "</a> <span class='sl-date'> Requested On : " + ds.Tables[0].Rows[i]["ReqDate"].ToString() + "</span>");
                            //Request-No: " + ds.Tables[0].Rows[i]["PaymentID"].ToString() + "
                            jsonBuilder.Append("<p>Payment transaction no was <a href='#'> " + ds.Tables[0].Rows[i]["PaymentID"].ToString() + "</a></p>");
                            jsonBuilder.Append("<div class='m-t-20 row'>");
                            if (ds.Tables[0].Rows[i]["AcType"].ToString() == "BANK")
                            {
                                jsonBuilder.Append("<div class='col-md-2 col-xs-12'><a href='../Receipt/ACC/" + ds.Tables[0].Rows[i]["ReceiptPath"].ToString() + "' ><img src='../Receipt/ACC/" + ds.Tables[0].Rows[i]["ReceiptPath"].ToString() + "' alt='Receipt' class='img-responsive radius' style='width:150px; height:100px;' /></a></div>");
                            }
                            if (ds.Tables[0].Rows[i]["Status"].ToString() == "APPROVED")
                            {
                                jsonBuilder.Append("<div class='col-md-2 col-xs-12'><img src='../UserProfileImg/COMPLETED.png' alt='Receipt' class='img-responsive radius' style='width:150px; height:100px;' /></div>");
                            }
                            else
                            {
                                jsonBuilder.Append("<div class='col-md-2 col-xs-12'><img src='../UserProfileImg/PENDING.jpg' alt='Receipt' class='img-responsive radius' style='width:150px; height:100px;' /></div>");

                            }

                            if (ds.Tables[0].Rows[i]["AcType"].ToString() == "BTC")
                            {
                                //jsonBuilder.Append("<div class='col-md-2 col-xs-12'><a href='../Receipt/BTC/" + ds.Tables[0].Rows[i]["ReceiptPath"].ToString() + "' ><img src='../Receipt/BTC/" + ds.Tables[0].Rows[i]["ReceiptPath"].ToString() + "' alt='Receipt' class='img-responsive radius' style='width:150px; height:100px;' /></a></div>");
                            }
                            if (ds.Tables[0].Rows[i]["AcType"].ToString() == "PAYTM")
                            {
                                jsonBuilder.Append("<div class='col-md-2 col-xs-12'><a href='../Receipt/PAY/" + ds.Tables[0].Rows[i]["ReceiptPath"].ToString() + "' ><img src='../Receipt/PAY/" + ds.Tables[0].Rows[i]["ReceiptPath"].ToString() + "' alt='Receipt' class='img-responsive radius' style='width:150px; height:100px;'/></a></div>");
                            }
                            if (ds.Tables[0].Rows[i]["AcType"].ToString() == "UPI")
                            {
                                jsonBuilder.Append("<div class='col-md-2 col-xs-12'><a href='../Receipt/UPI/" + ds.Tables[0].Rows[i]["ReceiptPath"].ToString() + "' ><img src='../Receipt/UPI/" + ds.Tables[0].Rows[i]["ReceiptPath"].ToString() + "' alt='Receipt' class='img-responsive radius' style='width:150px; height:100px;'/></a></div>");
                            }


                            jsonBuilder.Append("<div class='col-md-9 col-xs-12'>");
                            if (ds.Tables[0].Rows[i]["Status"].ToString() == "APPROVED")
                            {
                                jsonBuilder.Append("<p style='color:#ffffff80'> " + ds.Tables[0].Rows[i]["AcType"].ToString() + " <br/>" + ds.Tables[0].Rows[i]["ReceiverBTC"].ToString() + "</p> <a href='#' class='btn btn-success' style='border-radius:3px!important;'>" + ds.Tables[0].Rows[i]["Status"].ToString() + "</a>");
                            }
                            else if (ds.Tables[0].Rows[i]["Status"].ToString() == "")
                            {
                                jsonBuilder.Append("<p style='color:#ffffff80'> " + ds.Tables[0].Rows[i]["AcType"].ToString() + " <br/>" + ds.Tables[0].Rows[i]["ReceiverBTC"].ToString() + "</p> <a href='#' class='btn btn-warning' style='border-radius:3px!important;'>Pending</a>");
                            }
                            else
                            {
                                jsonBuilder.Append("<p style='color:#ffffff80'> " + ds.Tables[0].Rows[i]["AcType"].ToString() + " <br/>" + ds.Tables[0].Rows[i]["ReceiverBTC"].ToString() + "</p> <a href='#' class='btn btn-warning' style='border-radius:3px!important;'>" + ds.Tables[0].Rows[i]["Status"].ToString() + "</a>");
                            }

                            jsonBuilder.Append("<span class='btn btn-warning TyFuReq' >Type : " + ds.Tables[0].Rows[i]["ReqType"].ToString() + "</span></div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("<div class='like-comm m-t-20'> <a href='javascript:void(0)' class='link m-r-10'>$" + ds.Tables[0].Rows[i]["PlanAmt"].ToString() + " <span style='font-size:12px; color:#455a64'> Request Amount</span></a> <a href='javascript:void(0)' class='link m-r-10'><i class='fa fa-calendar text-danger'></i><span style='font-size:12px; color:#455a64'> Payment Date </span>" + ds.Tables[0].Rows[i]["PaymentDate"].ToString() + "</a> </div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("<hr>");





                            //if (ds.Tables[0].Rows[i]["Status"].ToString() == "Confirm")
                            //{
                            //    jsonBuilder.Append("<img src='../UserPanel_Icon/confirm.png' class='avatar' alt='Avatar'>");
                            //}
                            //else
                            //{
                            //    jsonBuilder.Append("<img src='../UserPanel_Icon/pending.png' class='avatar' alt='Avatar'>");
                            //}
                            //jsonBuilder.Append("<div class='message-date'>");
                            //jsonBuilder.Append("<h3 class='date text-info'>$" + ds.Tables[0].Rows[i]["PlanAmt"].ToString() + "</h3>");
                            //jsonBuilder.Append("<p class='month'>Plan Amt.</p>");
                            //jsonBuilder.Append("</div>");
                            //jsonBuilder.Append("<div class='message-wrapper'>");
                            //jsonBuilder.Append("<h4 class='message-heading'> Request-On: " + ds.Tables[0].Rows[i]["ReqDate"].ToString() + ".Request -Mode:" + ds.Tables[0].Rows[i]["AcType"].ToString() + ". Status Update-On: " + ds.Tables[0].Rows[i]["PaymentDate"].ToString() + ". Status: " + ds.Tables[0].Rows[i]["Status"].ToString() + "</h4>");
                            //jsonBuilder.Append("<blockquote class='message'> <b>" + ds.Tables[0].Rows[i]["SenderBTC"].ToString() + "</b> <img src='../UserPanel_Icon/arrow_right_green.png'> <b>" + ds.Tables[0].Rows[i]["ReceiverBTC"].ToString() + "</b>");
                            //jsonBuilder.Append("</blockquote>");
                            //jsonBuilder.Append("<br>");
                            //jsonBuilder.Append("<p class='url' style='font-size:10px;'>");
                            //jsonBuilder.Append("<span class='fs1 text-info' aria-hidden='true' data-icon='&#xe0c5;'></span>");
                            //jsonBuilder.Append("<a href='https://blockchain.info/tx/" + ds.Tables[0].Rows[i]["TxnHas"].ToString() + "' target='_blank'>" + ds.Tables[0].Rows[i]["TxnHas"].ToString() + "</a>");
                            //jsonBuilder.Append("</p");
                            //jsonBuilder.Append(" </div>");
                            //jsonBuilder.Append(" </li>");
                            //jsonBuilder.Append("<li>");
                        }
                        //jsonBuilder.Append(" </ul>");

                    }

                }

                // response.Write(jsonBuilder);
            }
            else
            {
                jsonBuilder.Append("<div style='color:#ffffff80; margin-left:-60px;'>Sorry, record not found...!</div>");
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
    private void BindResultN()
    {
        try
        {
            ds = objgdb.ByProcedure("[DailyNews_Jng]", new string[] { "MemID", "Type" }, new string[] { UserID, "News" }, "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                StringBuilder jsonBuilder = new StringBuilder("");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        //jsonBuilder.Append("<ul class='todo-list'>");
                        //for (int i = 0; i < dt.Rows.Count; i++)
                        //{
                        //    jsonBuilder.Append("<li>");
                        //    //jsonBuilder.Append("<span class='new'></span>");
                        //    jsonBuilder.Append("<label for='1' style='padding-left:10px'>");
                        //    jsonBuilder.Append("<b>"+ds.Tables[0].Rows[i]["Heading"].ToString()+"</b></br>");
                        //    jsonBuilder.Append(ds.Tables[0].Rows[i]["News"].ToString());
                        //    jsonBuilder.Append("<span class='date'>" + ds.Tables[0].Rows[i]["StartDate"].ToString() + "</span>");
                        //    jsonBuilder.Append("</label>");

                        //    jsonBuilder.Append(" </li>");
                        //}
                        //jsonBuilder.Append(" </ul>");


                        //jsonBuilder.Append("<p class='m-t-20 m-b-20' >");
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            jsonBuilder.Append("<div class='row'><div class='col-md-4'><div class='blog-image'><img src='../assets/images/big/News.jpg' alt='img' class='img-responsive' /></div></div>");
                            jsonBuilder.Append("<div class='col-md-8'><h3 class='news-heading'>" + ds.Tables[0].Rows[i]["Heading"].ToString() + "</h3>");
                            jsonBuilder.Append("<label class='label label-rounded label-success'>" + ds.Tables[0].Rows[i]["StartDate"].ToString() + "</label>");

                            jsonBuilder.Append("<p class='m-t-20 m-b-20' style='font-size:  14px;margin: 5px;'>");
                            jsonBuilder.Append(ds.Tables[0].Rows[i]["News"].ToString());
                            jsonBuilder.Append("</p>");
                            jsonBuilder.Append("<div class='d-flex'>");
                            //jsonBuilder.Append("<div class='read'><a href='javascript:void(0)' class='link font-medium'>Read More</a></div>");
                            jsonBuilder.Append("<div class='read'><a href='Detail-News.html' class='link font-medium' style='color:#009efb'>Read More</a></div>");
                            jsonBuilder.Append("<div class='ml-auto'>");
                            jsonBuilder.Append("<a href='javascript:void(0)' class='link m-r-10 ' data-toggle='tooltip' title='Like'><i class='mdi mdi-heart-outline'></i></a> <a href='javascript:void(0)' class='link' data-toggle='tooltip' title='Share'><i class='mdi mdi-share-variant'></i></a>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");
                            jsonBuilder.Append("</div>");


                            //jsonBuilder.Append("<p class='m-t-20 m-b-20' >");
                            ////jsonBuilder.Append("<span class='new'></span>");
                            //jsonBuilder.Append("<label for='1' style='padding-left:10px'>");
                            //jsonBuilder.Append("<b></b></br>");
                            //jsonBuilder.Append(ds.Tables[0].Rows[i]["News"].ToString());
                            //jsonBuilder.Append("</br><span class='item-date'></span>");
                            //jsonBuilder.Append("</label>");

                            //jsonBuilder.Append(" </p>");
                        }
                        //jsonBuilder.Append(" </ul>");

                    }
                }
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
    private void WithdrawalList()
    {
        try
        {

            ds = objgdb.ByProcedure("[DailyNews_Jng]", new string[] { "MemID", "Type" }, new string[] { UserID, "WithList" }, "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                StringBuilder jsonBuilder = new StringBuilder("");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {

                        for (int i = 0; i < dt.Rows.Count; i++)
                        {

                            jsonBuilder.Append("<tr>");
                            jsonBuilder.Append("<td class=''>");
                            jsonBuilder.Append(i + 1);
                            jsonBuilder.Append(" </td>");
                            jsonBuilder.Append("<td>");
                            jsonBuilder.Append(ds.Tables[0].Rows[i]["TransMode"].ToString());
                            jsonBuilder.Append(" </td>");
                            jsonBuilder.Append("<td class=''>");
                            jsonBuilder.Append(ds.Tables[0].Rows[i]["RequestDate"].ToString());
                            jsonBuilder.Append("</td>");
                            jsonBuilder.Append("<td class=''>");
                            jsonBuilder.Append(ds.Tables[0].Rows[i]["Amount"].ToString());
                            jsonBuilder.Append(" </td>");
                            jsonBuilder.Append(" <td class=''>");
                            if (ds.Tables[0].Rows[i]["Status"].ToString() == "Sent")
                            {
                                jsonBuilder.Append("<span class='badge badge-success'>");
                                jsonBuilder.Append(ds.Tables[0].Rows[i]["Status"].ToString());
                                jsonBuilder.Append("</span>");
                            }
                            if (ds.Tables[0].Rows[i]["Status"].ToString() == "Processing")
                            {
                                jsonBuilder.Append("<span class='badge badge-info'>");
                                jsonBuilder.Append(ds.Tables[0].Rows[i]["Status"].ToString());
                                jsonBuilder.Append("</span>");
                            }
                            //jsonBuilder.Append(" </td>");
                            //jsonBuilder.Append(" <td rowspan='5' class='center-align-text'>");
                            //jsonBuilder.Append("<div class='chart' id='spark_6'></div>");
                            //jsonBuilder.Append("</td>");
                            jsonBuilder.Append("<td class=''>");
                            jsonBuilder.Append("<div>" + ds.Tables[0].Rows[i]["UpdateDate"].ToString() + "</div>");
                            jsonBuilder.Append("</td>");
                            jsonBuilder.Append("</tr>");
                        }
                    }
                }
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
    private void OnlineUserList()
    {
        try
        {
            ds = objgdb.ByProcedure("[DailyNews_Jng]", new string[] { "MemID", "Type" }, new string[] { UserID, "OnlineUsr" }, "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                StringBuilder jsonBuilder = new StringBuilder("");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        jsonBuilder.Append("<ul>");
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            jsonBuilder.Append("<li>");
                            jsonBuilder.Append("<a href='' data-lastname='Srinu Basava' data-status='online'>");
                            jsonBuilder.Append("<span style='text-transform:capitalize;'>" + ds.Tables[0].Rows[i]["MemID"].ToString() + "</span>");
                            jsonBuilder.Append("<div class='user-status online'></div>");
                            jsonBuilder.Append(" </a>");
                            jsonBuilder.Append(" </li>");
                        }
                        jsonBuilder.Append("</ul>");
                    }
                }
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
    private void ActiveDirects()
    {
        try
        {
            ds = objgdb.ByProcedure("[DailyNews_Jng]", new string[] { "MemID", "Type" }, new string[] { UserID, "ActDrcts" }, "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                StringBuilder jsonBuilder = new StringBuilder("");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        jsonBuilder.Append("<ul>");
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            jsonBuilder.Append("<li>");
                            jsonBuilder.Append("<a href='#' class='designation' style='text-transform:capitalize;'>" + ds.Tables[0].Rows[i]["MemID"].ToString() + "</a>");
                            jsonBuilder.Append("</li>");
                        }
                        jsonBuilder.Append("</ul>");
                    }
                }
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
    private void BindResult1()
    {
        try
        {

            ds = ds = objgdb.ByProcedure("Inst_DashBoardSummary", new string[] { "MemID" }, new string[] { UserID }, "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                StringBuilder jsonBuilder1 = new StringBuilder("");
                jsonBuilder1.Append("<a href='javascript:;' class='dropdown-toggle' data-toggle='dropdown'>");
                jsonBuilder1.Append("<span class='image'><img src='../UserProfileImg/" + ds.Tables[0].Rows[0]["Mem_Profl_Pic"].ToString() + "' alt='''' id='rightCrPImg' /></span>");
                jsonBuilder1.Append("<span class='hidden-xs'>" + ds.Tables[0].Rows[0]["Mem_Name"].ToString() + "</span> <b class='caret'></b>");
                jsonBuilder1.Append("</a>");
                jsonBuilder1.Append("<ul class='dropdown-menu pull-right'>");
                jsonBuilder1.Append("<li><a href='Settings.html'>Edit Profile</a></li>");
                jsonBuilder1.Append("<li><a href='javascript:;'><span class='badge badge-danger pull-right'>" + ds.Tables[0].Rows[0]["Msg_Cunt"].ToString() + "</span> Inbox</a></li>");
                jsonBuilder1.Append("<li class='divider'></li>");
                jsonBuilder1.Append("<li><a href='Sign-Out.aspx'>Log Out</a></li>");
                jsonBuilder1.Append("</ul>");
                response.Write(jsonBuilder1);
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
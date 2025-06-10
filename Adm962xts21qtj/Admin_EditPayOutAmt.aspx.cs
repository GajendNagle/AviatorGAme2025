using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Net;
using System.IO;
using System.Text;
using System.Net.Mail;

public partial class ControlSection_Admin_EditPayOutAmt : System.Web.UI.Page
{
    DynamicDtls objDynamicDtls = new DynamicDtls();
    SqlConnection cn; SqlDataAdapter da; DataSet ds, sds, ssds, spds;
    string TodayDt = Convert.ToString(DateTime.Now.ToShortDateString().ToString());
    SqlCommand cmd;
    public bool sc;

    public static string email = "", MName = "", accno = "";

    string Rep_ID, Req_ID, Amount, IssueBy, Status;
    string Remrk, RemrkRej, RemrkFrmPEW;
    string MemID, ID, FromMobiUSD, Frommobno;
    int r; string Format = "";
    SqlDataReader drGetSt;
    //MailSenderByEmail objSendMail = new MailSenderByEmail();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Khbfy897ft36Gv"] != null)
        {
            Req_ID = Request.QueryString["ID"].ToString();
            //MemID = Request.QueryString["MemID"].ToString();
            //Remrk = "Completed Credit Request " + Req_ID + " Of Amt:" + txtAmount.Text.Trim();

            if (!IsPostBack)
            {
                GetCreditRequestSt();
            }
        }
        else
        {
            Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
        }
    }
    private void GetCreditRequestSt()
    {
        try
        {
            ds = new DataSet();
            ds = methods(Req_ID, "", "", "", "", "", "FILL_RECORD", "", "");
            if (ds.Tables[0].Rows.Count > 0)
            {
                txtMemID.Text = ds.Tables[0].Rows[0]["MemID"].ToString();
                ddlStatus.Items.FindByText(ds.Tables[0].Rows[0]["Status"].ToString()).Selected = true;
                txtRemark.Text = ds.Tables[0].Rows[0]["Remark"].ToString();
                txtAmount.Text = ds.Tables[0].Rows[0]["NetAmt"].ToString();
                txtDate.Text = ds.Tables[0].Rows[0]["UpdateDate"].ToString();
                txtChkNo.Text = ds.Tables[0].Rows[0]["TransID"].ToString();

                email = ds.Tables[0].Rows[0]["Email"].ToString();
                MName = ds.Tables[0].Rows[0]["MName"].ToString();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Sorry, Something is wrong please try later !";
        }
        finally
        {
            ds.Dispose();
        }
    }
    protected void TextPwd_Validate(object source, ServerValidateEventArgs args)
    {
        if (ddlStatus.SelectedItem.Text.Trim().ToUpper() == "REJECTED")
        {
            string v = TxtAPwd.Text;
            if (v == string.Empty)
            {
                args.IsValid = false;  // field is empty
            }
            else
            {
                args.IsValid = true;
            }
        }
        else
        {
            args.IsValid = true;
        }
    }
    private void SendSMSFrom()
    {
        ds = new DataSet();
        ds = methods("", txtMemID.Text.Trim().ToUpper(), "", "", "", "", "GET_MOBILE", "", "");
        if (ds.Tables[0].Rows.Count > 0)
        {
            Frommobno = ds.Tables[0].Rows[0]["mobile"].ToString();
        }

        //FromMobiUSD = "91" + Frommobno;
        //string TextFrom = "Dear, " + txtMemID.Text.Trim().ToUpper() + " Your Fund Issue Request No :" + Req_ID + " of Amount :" + txtAmount.Text.Trim() + " Has Been " + ddlStatus.SelectedItem.Text.Trim().ToUpper() + " Plz Check ur Acc For Detail.";
        //string createdURLFrom = "http://www.smswave.in/panel/sendsms.php?user=Hlp89Pro87&password=Pro)(8^%KHlt&sender=HLTPRO&PhoneNumber=" + FromMobiUSD + "&Text=" + TextFrom;

        //HttpWebRequest myReqfrm = (HttpWebRequest)WebRequest.Create(createdURLFrom);
        //myReqfrm.Method = "POST";
        //// myReq.ContentLength = Text.Length;
        //byte[] byteArrayfrm = Encoding.UTF8.GetBytes(TextFrom);
        //// Set the ContentType property of the WebRequest.
        //myReqfrm.ContentType = "application/x-www-form-urlencoded";
        //// Set the ContentLength property of the WebRequest.
        //myReqfrm.ContentLength = byteArrayfrm.Length;
        //// Get the request stream.
        //Stream dataStreamfrm = myReqfrm.GetRequestStream();
        //// Write the data to the request stream.
        //dataStreamfrm.Write(byteArrayfrm, 0, byteArrayfrm.Length);
        //// Close the Stream object.
        //dataStreamfrm.Close();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        sds = new DataSet();
        sds = methods(Req_ID, "", "", "", "", "", "GET_STATUS", "", "");
        if (sds.Tables[0].Rows.Count > 0)
        {
            if (sds.Tables[0].Rows[0]["STATUS"].ToString() == "PENDING")
            {
                submit();
            }
            else
            {
                submit2();
            }
        }
    }
    public void submit()
    {
        string IconPath = "", ExtStatus = "NOTOK", ErrorMess = "", CheckIconName = "", FilePath = "";

        if (ddlStatus.SelectedItem.Text.Trim().ToUpper() == "PENDING")
        { }
        else
        {
            try
            {

                FilePath = "";
                if (ddlStatus.SelectedItem.Text.Trim().ToUpper() == "COMPLETED")
                {
                    ds = methods(Req_ID, txtMemID.Text.Trim().ToUpper(), txtDate.Text.Trim(), FilePath, ddlStatus.SelectedItem.Text, txtChkNo.Text, "COMPLETE_IMG", txtRemark.Text.Trim(), "");
                    //objSendMail.MailFormat("BankPayout", txtMemID.Text.Trim(), txtMemID.Text.Trim(), txtAmount.Text, Req_ID);
                    lblMsg.Visible = true;
                    string Message124 =
                      @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: #009688;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table><table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='50'></td> </tr> <tr> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td> <h3 style=' font-size:29px;margin: 0; text-align: center; '> <span style='color: #009688; font-weight: bolder'>Hi,</span> " + MName + "</h3> <br><p style=' text-align: center; font-size: 17px;margin: 5px;font-family: sans-serif;'>Congratulations !!!</p> <p style=' text-align: center;font-size: 17px;margin: 5px;font-family: sans-serif;'>Your Withdrawal Request for <b><span style='color: #e85038;'>" + txtAmount.Text + "</span></b>  has been Completed. </p> </div><br> </td> </tr> </tbody> </table> </td>  </tr> <tr> </tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr bgcolor='#009688'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: white;text-align: center'>Copyright &copy; 2024.&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                    //@"<div style='margin: 0;padding: 0;'><div style='width: 100%;height: 100%;background-color:#fafafa ;'> <div style='margin:0 auto; width:600px; height:100%; font-family:verdana;'><div style='background-color: #fafafa; padding: 15px 0 15px;'><img src='http://" + DynamicDtls.WebSite2 + "/website-logo/logo1.svg' alt='logo' style=' margin-left: 10px; height: auto; width: 150px; '/> <strong style='float: right;padding-right: 10px;'>For 24/7 support </strong> <div style=' padding: 0 10px 0px; margin-top: -20px; text-align: right; font-family: sans-serif;'>" + DynamicDtls.Email + "</div></div><div style=' width: 100%; background-color: white; border-top: 11px solid #57ab57; padding: 20px 0 20px; '> <h3 style=' font-size:29px;margin: 0; text-align: center; '> <span style='color:Green;font-weight:bolder'>Hi,</span> " + MName + "</h3><p style=' text-align: center; font-size: 18px;margin: 5px;font-family: sans-serif;'>Congratulations !!!<br />Your Withdrawal request for <b>$" + txtAmount.Text + " </b> has been Completed.</p></div><div style=' background-color:#058205;width:100%; padding: 20px 0 20px; text-align:left; '> <p style='font-family:Verdana;font-size: 19px; color:white; margin-left:22px;'>Thanks & Regards <br/> Support Team " + DynamicDtls.WebSite2 + "</p></div></div><div style='background-color: #E9E9E9; margin-top: -12px'> <div style='margin:0 auto; width:600px; height:100%; font-family:verdana; text-align:center;'><div><p style=' color: gray; font-size: 12px;    padding-top: 10px; '> Please do not reply to this email. Email send to this address will not be answered.</p></div></div></div></div></div>";
                    this.SendEmailToUser(email, "Withdrawal Request Completed ", Message124);
                    //SendEmailMsg();
                    //lblMsg.Text = new DB().UpdateMessage(ds.Tables[0].Rows[0]["MSG"].ToString());
                    ClientScript.RegisterStartupScript(this.GetType(), "Redirect", "<script type='text/javascript'>redirectPage('" + ds.Tables[0].Rows[0]["MSG"].ToString() + "'); </script>");

                }
                else if (ddlStatus.SelectedItem.Text.Trim().ToUpper() == "REJECTED")
                {
                    //ds = methods(Req_ID, txtMemID.Text.Trim().ToUpper(), txtDate.Text.Trim(), FilePath, ddlStatus.SelectedItem.Text, txtChkNo.Text, "REJECT_IMG", txtRemark.Text.Trim(), "");
                    ds = objDynamicDtls.ByProcedure("AdminPasswordVerification", new string[] { "investid", "Password", "Flag" }, new string[] { txtMemID.Text.Trim(), TxtAPwd.Text, "WITHDRWAL" }, "Methode");
                    //////SendSMSFrom();

                    string Message123 =
                      @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: #000000;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table><table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='50'></td> </tr> <tr> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td> <h3 style=' font-size:29px;margin: 0; text-align: center; '> <span style='color: #ee9d28; font-weight: bolder'>Hi,</span> " + MName + "</h3> <br><p style=' text-align: center; font-size: 17px;margin: 5px;font-family: sans-serif;'>Congratulations !!!</p> <p style=' text-align: center;font-size: 17px;margin: 5px;font-family: sans-serif;'>Your Withdrawal Request for <b><span style='color: #e85038;'>" + txtAmount.Text + "</span></b>  has been Rejected. </p><br> </td> </tr> </tbody> </table> </td>  </tr> <tr> </tbody> </table><table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr bgcolor='#000000'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: white;text-align: center'>Copyright &copy; 2024.&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";

                    //@"<div style='margin: 0;padding: 0;'><div style='width: 100%;height: 100%;background-color:#fafafa ;'> <div style='margin:0 auto; width:600px; height:100%; font-family:verdana;'><div style='background-color: #fafafa; padding: 15px 0 15px;'><img src='http://" + DynamicDtls.WebSite2 + "/website-logo/logo1.svg' alt='logo' style=' margin-left: 10px; height: auto; width: 150px; '/> <strong style='float: right;padding-right: 10px;'>For 24/7 support </strong> <div style=' padding: 0 10px 0px; margin-top: -20px; text-align: right; font-family: sans-serif;'>" + DynamicDtls.Email + "</div></div><div style=' width: 100%; background-color: white; border-top: 11px solid #57ab57; padding: 20px 0 20px; '> <h3 style=' font-size:29px;margin: 0; text-align: center; '> <span style='color:Green;font-weight:bolder'>Hi,</span> " + MName + "</h3><p style=' text-align: center; font-size: 18px;margin: 5px;font-family: sans-serif;'>Your Withdrawal request for <b>$" + txtAmount.Text + " </b> has been Rejected. </p></div><div style=' background-color:#058205;width:100%; padding: 20px 0 20px; text-align:left; '> <p style='font-family:Verdana;font-size: 19px; color:white; margin-left:22px;'>Thanks & Regards <br/> Support Team " + DynamicDtls.WebSite2 + "</p></div></div><div style='background-color: #E9E9E9; margin-top: -12px'> <div style='margin:0 auto; width:600px; height:100%; font-family:verdana; text-align:center;'><div><p style=' color: gray; font-size: 12px;    padding-top: 10px; '> Please do not reply to this email. Email send to this address will not be answered.</p></div></div></div></div></div>";
                    this.SendEmailToUser(email, "Withdrawal Request Rejected ", Message123);

                    lblMsg.Text = new DB().UpdateMessage(ds.Tables[0].Rows[0]["ErrMsg"].ToString());
                    ClientScript.RegisterStartupScript(this.GetType(), "Redirect", "<script type='text/javascript'>redirectPage('" + ds.Tables[0].Rows[0]["ErrMsg"].ToString() + "'); </script>");
                }
                else
                { }
            }
            catch (Exception ex)
            {
                DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
                lblMsg.Visible = true; lblMsg.Text = "Sorry, Something is wrong please try later !";
            }
        }

    }
    public void submit2()
    {
        string IconPath = "", ExtStatus = "NOTOK", ErrorMess = "", CheckIconName = "", FilePath = "";

        if (ddlStatus.SelectedItem.Text.Trim().ToUpper() == "PENDING")
        { }
        else
        {
            try
            {

                FilePath = "";
                if (ddlStatus.SelectedItem.Text.Trim().ToUpper() == "COMPLETED")
                {
                    ds = methods(Req_ID, txtMemID.Text.Trim().ToUpper(), txtDate.Text.Trim(), FilePath, ddlStatus.SelectedItem.Text, txtChkNo.Text, "COMPLETE_AGAIN", txtRemark.Text.Trim(), "");
                    //objSendMail.MailFormat("BankPayout", txtMemID.Text.Trim(), txtMemID.Text.Trim(), txtAmount.Text, Req_ID);
                    lblMsg.Visible = true;
                    string Message125 =
                    @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: #009688;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table><table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='50'></td> </tr> <tr> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td> <h3 style=' font-size:29px;margin: 0; text-align: center; '> <span style='color: #009688; font-weight: bolder'>Hi,</span> " + MName + "</h3> <br><p style=' text-align: center; font-size: 17px;margin: 5px;font-family: sans-serif;'>Congratulations !!!</p> <p style=' text-align: center;font-size: 17px;margin: 5px;font-family: sans-serif;'>Your Withdrawal Request for <b><span style='color: #e85038;'>" + txtAmount.Text + "</span></b>  has been Completed. </p> </div><br> </td> </tr> </tbody> </table> </td>  </tr> <tr> </tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr bgcolor='#009688'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: white;text-align: center'>Copyright &copy; 2024.&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                    //@"<div style='margin: 0;padding: 0;'><div style='width: 100%;height: 100%;background-color:#fafafa ;'> <div style='margin:0 auto; width:600px; height:100%; font-family:verdana;'><div style='background-color: #fafafa; padding: 15px 0 15px;'><img src='http://" + DynamicDtls.WebSite2 + "/website-logo/logo1.svg' alt='logo' style=' margin-left: 10px; height: auto; width: 150px; '/> <strong style='float: right;padding-right: 10px;'>For 24/7 support </strong> <div style=' padding: 0 10px 0px; margin-top: -20px; text-align: right; font-family: sans-serif;'>" + DynamicDtls.Email + "</div></div><div style=' width: 100%; background-color: white; border-top: 11px solid #57ab57; padding: 20px 0 20px; '> <h3 style=' font-size:29px;margin: 0; text-align: center; '> <span style='color:Green;font-weight:bolder'>Hi,</span> " + MName + "</h3><p style=' text-align: center; font-size: 18px;margin: 5px;font-family: sans-serif;'>Congratulations !!!<br />Your Withdrawal request for <b>$" + txtAmount.Text + " </b> has been Completed.</p></div><div style=' background-color:#058205;width:100%; padding: 20px 0 20px; text-align:left; '> <p style='font-family:Verdana;font-size: 19px; color:white; margin-left:22px;'>Thanks & Regards <br/> Support Team " + DynamicDtls.WebSite2 + "</p></div></div><div style='background-color: #E9E9E9; margin-top: -12px'> <div style='margin:0 auto; width:600px; height:100%; font-family:verdana; text-align:center;'><div><p style=' color: gray; font-size: 12px;    padding-top: 10px; '> Please do not reply to this email. Email send to this address will not be answered.</p></div></div></div></div></div>";
                    this.SendEmailToUser(email, "Withdrawal Request Completed ", Message125);
                    //SendEmailMsg();
                    //lblMsg.Text = new DB().UpdateMessage(ds.Tables[0].Rows[0]["MSG"].ToString());
                    ClientScript.RegisterStartupScript(this.GetType(), "Redirect", "<script type='text/javascript'>redirectPage('" + ds.Tables[0].Rows[0]["MSG"].ToString() + "'); </script>");
                }
                else if (ddlStatus.SelectedItem.Text.Trim().ToUpper() == "REJECTED")
                {
                    //ds = methods(Req_ID, txtMemID.Text.Trim().ToUpper(), txtDate.Text.Trim(), FilePath, ddlStatus.SelectedItem.Text, txtChkNo.Text, "REJECT_AGAIN", txtRemark.Text.Trim(), "");
                    ////SendSMSFrom();
                    string Message123 =
                        @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: #009688;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table><table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='50'></td> </tr> <tr> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td> <h3 style=' font-size:29px;margin: 0; text-align: center; '> <span style='color: #009688; font-weight: bolder'>Hi,</span> " + MName + "</h3> <br><p style=' text-align: center; font-size: 17px;margin: 5px;font-family: sans-serif;'>Congratulations !!!</p> <p style=' text-align: center;font-size: 17px;margin: 5px;font-family: sans-serif;'>Your Withdrawal Request for <b><span style='color: #e85038;'>" + txtAmount.Text + "</span></b>  has been Rejected. </p> </div><br> </td> </tr> </tbody> </table> </td>  </tr> <tr> </tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr bgcolor='#009688'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: white;text-align: center'>Copyright &copy; 2024.&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                    // @"<div style='margin: 0;padding: 0;'><div style='width: 100%;height: 100%;background-color:#fafafa ;'> <div style='margin:0 auto; width:600px; height:100%; font-family:verdana;'><div style='background-color: #fafafa; padding: 15px 0 15px;'><img src='http://" + DynamicDtls.WebSite2 + "/website-logo/logo1.svg' alt='logo' style=' margin-left: 10px; height: auto; width: 150px; '/> <strong style='float: right;padding-right: 10px;'>For 24/7 support </strong> <div style=' padding: 0 10px 0px; margin-top: -20px; text-align: right; font-family: sans-serif;'>" + DynamicDtls.Email + "</div></div><div style=' width: 100%; background-color: white; border-top: 11px solid #57ab57; padding: 20px 0 20px; '> <h3 style=' font-size:29px;margin: 0; text-align: center; '> <span style='color:Green;font-weight:bolder'>Hi,</span> " + MName + "</h3><p style=' text-align: center; font-size: 18px;margin: 5px;font-family: sans-serif;'>Your Withdrawal request for <b>$" + txtAmount.Text + " </b> has been Rejected. </p></div><div style=' background-color:#058205;width:100%; padding: 20px 0 20px; text-align:left; '> <p style='font-family:Verdana;font-size: 19px; color:white; margin-left:22px;'>Thanks & Regards <br/> Support Team " + DynamicDtls.WebSite2 + "</p></div></div><div style='background-color: #E9E9E9; margin-top: -12px'> <div style='margin:0 auto; width:600px; height:100%; font-family:verdana; text-align:center;'><div><p style=' color: gray; font-size: 12px;    padding-top: 10px; '> Please do not reply to this email. Email send to this address will not be answered.</p></div></div></div></div></div>";
                    this.SendEmailToUser(email, "Withdrawal Request Rejected ", Message123);

                    ds = objDynamicDtls.ByProcedure("AdminPasswordVerification", new string[] { "investid", "Password", "Flag" }, new string[] { txtMemID.Text.Trim(), TxtAPwd.Text, "WITHDRWAL" }, "Methode");
                    lblMsg.Text = new DB().UpdateMessage(ds.Tables[0].Rows[0]["ErrMsg"].ToString());
                    ClientScript.RegisterStartupScript(this.GetType(), "Redirect", "<script type='text/javascript'>redirectPage('" + ds.Tables[0].Rows[0]["ErrMsg"].ToString() + "'); </script>");
                }
                else
                { }
            }
            catch (Exception ex)
            {
                DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
                lblMsg.Visible = true; lblMsg.Text = "Sorry, Something is wrong please try later !";
            }
        }

    }
    private void SendEmailMsg()
    {
        Format = @"<html <div >
                    Dear User,<br />
                Your Request has been sucessfully approved and you can expect the funds in your
                bank account in the next 3 working days.
           <br /> Thanks<br />Admin
            </div></html>";

        lblMsg.Text = "";
        try
        {
            objDynamicDtls.ByProcedure("Gladulas_InsertEmailMsg", new string[] { "FromUser", "ToUser", "MsgSubject", "MsgText", "MsgSendType" }, new string[] { "ADMIN", txtMemID.Text.Trim().ToUpper(), "approval Fund Request", Format, "" }, "EMail");
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Sorry, Something is wrong please try later !";
        }
    }
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    { }
    public DataSet methods(string Req_ID, string memid, string transdt, string UplodeFile, string status, string TransId, string Type, string txtRemarkp, string IncTypeM)
    {
        try
        {
            ds = new DataSet();
            ds = objDynamicDtls.ByProcedure("PROC_RESPONSE_WITHDRAWAL_REQ", new string[] { "Req_ID", "memid", "transdt", "UplodeFile", "status", "TransId", "Type", "txtRemarkp", "inctype" }, new string[] { Req_ID, memid, transdt, UplodeFile, status, TransId, Type, txtRemarkp, IncTypeM }, "Methode");
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Sorry, Something is wrong please try later !";
        }
        finally
        {
            ds.Dispose();
        }
        return ds;
    }

    protected void SendEmailToUser(string EmailId, string Subjects, string Message)
    {
        objDynamicDtls.FillWebSiteEmailCompany();
        MailSenderByEmail mailsend = new MailSenderByEmail();

        try
        {
            mailsend.SendMailMessage(DynamicDtls.Email, Subjects, Message, EmailId);
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
}

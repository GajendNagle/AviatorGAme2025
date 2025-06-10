<%@ WebHandler Language="C#" Class="Verify_Account" %>
using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Net.Mail;
using System.IO;
using System.Data;
using System.Web.SessionState;
public class Verify_Account : IHttpHandler {
    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc;
    public string msg, Msgs, dtl, RtnRlt, strJson,MName,Email,Mobile,MemId,Pwd,TrnsPwd,txtVerifCode = "";
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;
    public class test
    {
        public bool Success { get;set;}
        public string Message { get;set;}
        public string detail { get;set;}
        public string aid { get; set; }
        public test(bool sc, string msg, string dtl)
        {
            Success = sc;
            Message = msg;
            detail = dtl;
        }
    }

    public void handleRequest()
    {
        writeJson(new test(sc, msg, dtl));
    }

    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";
        /////////
        txtVerifCode = context.Request["txtVerifCode"].Trim();
        /////////
        GiveHelpOrder();
        ////////
        handleRequest();
    }
    public void writeJson(object _object)
    {
        JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
        string jsondata = javaScriptSerializer.Serialize(_object);
        writeRaw(jsondata);
    }

    public void writeRaw(string text)
    {
        context.Response.Write(text);
    }

    public void GiveHelpOrder()
    {
        try
        {
            if (txtVerifCode != "")
            {
                ds = objgdb.ByProcedure("CA_CreatAccount_New", new string[] { "Pwd","MName","Email","CountryCode","Mobile",
                "SpID","City","state","MemID","Country","Rtype","verifyCode","securityPWD","DnPos"},
               new string[] { "", "", "", "", "", "", "", "", txtVerifCode.ToString(), "", "Verified", txtVerifCode.ToString(), "", "" }, "ds");
                if (ds.Tables[0].Rows[0]["ExecStu"].ToString() == "1")
                {
                    sc = true;
                    //msg = "<span style='color:#5AAD08; font-wight:bold; font-size:30px;'> <h1>Congratulations!</h1> Your bizzevo.me account active now !</span><br/>";
                    // msg = "Your account was successfully confirmed ! ";
                    //msg = "<span style='font-size:25px; font-weight:bold;'>Account Creation Successful ! </span><br /><a href='Login-Your-Account.html'>Click to access account</a>, here !";
                    //msg = "<img src='UserProfileImg/success.png' /><br /><span style='font-size:25px; font-weight:bold;'>Account Creation Successful ! </span><br /><a href='Login-Your-Account.html' style='color:orange;'>Click to access account</a>, here !";
                    MemId = ds.Tables[0].Rows[0]["MID"].ToString();
                    MName = ds.Tables[0].Rows[0]["Mname"].ToString();
                    Mobile = ds.Tables[0].Rows[0]["mobile"].ToString();
                    Email = ds.Tables[0].Rows[0]["EmailId"].ToString();
                    Pwd = ds.Tables[0].Rows[0]["pwd"].ToString();
                    TrnsPwd = ds.Tables[0].Rows[0]["ewalletpwd"].ToString();
                    msg = "<div style='text-align:center;background-color:#fff;border-radius:20px;padding:20px;'><img src='UserProfileImg/success.png' style='width:20%'<br><p style='font-size:15px;font-weight:500;color:#4bec1e'>Your Account Has Been Verified Successfully</p><table class='msg-tab' style='text-align:left;margin-top:30px;margin-bottom:30px'><tr><div style='color:#000;font-size:1rem;padding-left:10px;text-align: left;'><h6>e-Mail</h6></div><div style='color:#000;font-size:1rem;padding-left:10px;text-align: left;'><p>" + Email.Trim() + "</p></div></tr><tr><div style='color:#000;font-size:1rem;padding-left:10px;text-align: left;'><h6>Mobile</h6></div><div style='color:#000;font-size:1rem;padding-left:10px;text-align: left;'><p>" + Mobile.Trim() + "</p></div></tr><tr><div style='color:#000;font-size:1rem;padding-left:10px;text-align: left;'><h6>Login Password</h6></div><div style='color:#000;font-size:1rem;padding-left:10px;text-align: left;'><p>" + Pwd.Trim() + "</p></div></tr><tr><div style='color:#000;font-size:1rem;padding-left:10px;text-align: left;'><h6>Txn-Password</h6></div><div style='color:#000;font-size:1rem;padding-left:10px;text-align: left;'><p>" + TrnsPwd.Trim() + "</p></div></tr></table><button class='btns-theme btn-block mt-2'><a href='login.html' style='color:#fff'>Click Here to access Account</a></button></div>";
                    //string VerifyAcc = objgdb.GetCredentialAPI(MName.ToUpper().Trim(), MemId.Trim(), Pwd.ToString().Trim(), TrnsPwd.ToString().Trim(), "RegistrationText");
                    //new SendSms().SponserSendSMSToUserIDMob(VerifyAcc, Mobile.Trim());
                    this.SendEmailToUser(Email, MName);
                }
                else
                {
                    sc = false;
                    //msg = "<span style='color:#FF0000; font-wight:bold; font-size:30px;'> " + ds.Tables[0].Rows[0]["ErrorMsg"].ToString() + "</span><br/>";
                    //msg = ds.Tables[0].Rows[0]["ErrorMsg"].ToString() ;
                    // msg = "<span style='color:#ffd46e; font-wight:bold; font-size:18px;magin-bottom:20px;'> Your verification link is expired !</span>";
                    msg = "<div style='text-align: center; background-color: white; border-radius: 20px; padding: 20px;'><img style='width:60px; margin-top:20px;' src='UserProfileImg/exclamation.png' /><br /><br><span style='color:#FF0000; font-wight:500; font-size:15px;'> Correct Verification Code is required !</span><br><br><br></div>";
                }
            }
            else
            {
                sc = false;
                msg = "The Verification Code field is required !";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            //msg = "<span style='color:#FF0000; font-wight:bold; font-size:13px;'> " + ex.Message + "</span><br/>";
            msg =  ex.Message.ToString()  ;
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
    protected void SendEmailToUser(string EmailId, string SponserName)
    {
        string Message =
                 @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: #009688;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='50'></td></tr><tr> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='15'></td><td> <h1 style='font-size:24px;font-weight:normal;text-align:center;line-height:26px;margin-top:0;margin-bottom:15px'>Verified Mail</h1> <p style='font-size:16px;font-weight:300;text-align:center;line-height:26px;margin:0;padding:0'>Your Account has been verified with " + DynamicDtls.CompName + "<p> <p style='font-size:16px;font-weight:300;text-align:center;line-height:15px;margin:0;padding:0'>Please check below details for login to Personal Area. </p></td><td width='15'></td></tr></tbody> </table> </td></tr><tr> <td height='20'></td></tr><tr> <td align='center'> <table style='font-size:18px;text-align:center;color:#fff' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <table> <tbody> <tr> <td align='center' style='border-radius:50%' bgcolor='#0AAD2E' height='115' width='115'> <div style='text-align:center;max-width:570px;'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/check.png' alt='success' /> </div></td></tr></tbody> </table> </td></tr><tr> <td height='8'> <img src='' width='1' height='1' alt='' style='display:block'> </td></tr><tr> <td align='center'> <div style='text-align:center;height:8px;width:60px;background:#ebebeb;border-radius:50%'></div></td></tr><tr> <td height='25'> <img src='' alt='' width='1' height='1' style='display:block'> </td></tr></tbody> </table> </td></tr><tr> <td> <div style='text-align:left;font-size:16px;max-width: 570px;margin:0 auto'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div style='font-size:16px;text-align:left;line-height: 24px'> <p style='margin:0;padding:0;font-weight:600'>Dear&nbsp;" + MName + ",</p><p style='margin-bottom:11px;margin-top:0'> <strong style='font-size:12px;font-weight:400;line-height:18px'>e-Mail</strong> <span style='display:block;font-weight:400'>" + Email + "</span> </p><p style='margin-bottom:11px;margin-top:14px'> <strong style='font-size:12px;font-weight:400;line-height:18px'>Mobile</strong> <span style='display:block;font-weight:400'>" + Mobile + "</span> </p><p style='margin-bottom:11px;margin-top:0'> <strong style='font-size:12px;font-weight:400;line-height:18px'>Login Password</strong> <span style='display:block;font-weight:400'>" + Pwd + "</span> </p><p style='margin-bottom:11px;margin-top:0'> <strong style='font-size:12px;font-weight:400;line-height: 18px'>Txn-Password</strong> <span style='display:block;font-weight:400'>" + TrnsPwd + "</span> </p><p style='margin-bottom:0;margin-top:0'> <strong style='font-size:16px;font-weight:400;line-height:18px'>Please do not share this login credential with anyone.</strong> </p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td></tr><tr> <td align='left' valign='top'> <div style='margin:0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px; text-decoration: none; text-align: justify; margin: 0; padding: 0; font-weight: 300;line-height:26px;'> Best Regards, <br>"+ DynamicDtls.CompName +" Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompWeb + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='30' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody> </table> </td><td width='15'></td></tr></tbody> </table> </div></td></tr></tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr bgcolor='#009688'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'> <table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'> <table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: white;text-align: center'>Copyright &copy; 2024.&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
          string Subjects = "Your account details";

        objgdb.FillWebSiteEmailCompany();
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
<%@ WebHandler Language="C#" Class="Register_Now" %>
using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Net.Mail;
using System.IO;
using System.Data;
using System.Web.SessionState;
//using smtpout.secureserver.net
//using AE.Net.Mail.Imap;
//using System.imapsecureserver.net;

public class Register_Now : IHttpHandler {

    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc;
    public string msg, Msgs, dtl, RtnRlt, strJson, MemID, txtSponserID="", DDLPos="", txtEmailID="", ddlCountry="",
        txtMobiUSD = "", txtFirstName = "", txtPasswordSU = "", txtsecurityPWD = "",txtdoj="",txtunderid="",
        txtUserID = "", MNumber, emailSMS, VCode, MngrDtl = "", txtVeriCode = "", CountryName="", varificationCode = "",
        CountryCode = "", Country_input="";
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
        txtSponserID = context.Request["invite_input"].Trim();
        //DDLPos = context.Request["DDLPos"].Trim();
        txtEmailID = context.Request["email_input"].Trim();
        //ddlCountry = context.Request["ddlCountry"].Trim();
        txtMobiUSD = context.Request["phone_input"].Trim();
        txtFirstName = context.Request["firstname_input"].Trim();
        txtPasswordSU = context.Request["password_input"].Trim();
        txtsecurityPWD = context.Request["password_Sec"].Trim();
        CountryCode = context.Request["CountryCode"].Trim();
        Country_input = context.Request["Country_input"].Trim();
        varificationCode = GetPassword();
        //if (context.Request["txtmmid"] != null && context.Request["txtmmid"] != "" && context.Request["txtmmid"] != "undefined")
        //{
        //    txtUserID = context.Request["txtmmid"].Trim();
        //}
        //else
        //{
        //txtUserID = "USD" + varificationCode;
        txtUserID = varificationCode;
        //}
        //if (context.Request["txtmmdoj"] != null && context.Request["txtmmdoj"] != "" && context.Request["txtmmid"] != "undefined")
        //{
        //    txtdoj = context.Request["txtmmdoj"].Trim();
        //}
        //if (context.Request["txtunderid"] != null && context.Request["txtunderid"] != "" && context.Request["txtmmid"] != "undefined")
        //{
        //    txtunderid = context.Request["txtunderid"].Trim();
        //}


        //CountryName = context.Request["CountryName"].Trim();
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
            if (txtFirstName.Trim() != "" && txtEmailID.Trim() != "" /*&& txtMobiUSD.Trim() != ""*/ )
            {
                ds = objgdb.ByProcedure("CA_CreatAccount_New", new string[] { "Pwd","MName","Email","CountryCode","Mobile",
                "SpID","City","state","MemID","Country","Rtype","verifyCode","securityPWD","DnPos"},
                new string[]{txtPasswordSU.Trim(),txtFirstName.Trim(),txtEmailID.Trim(),CountryCode.Trim(),
                txtMobiUSD.Trim(),txtSponserID.Trim(),txtdoj.Trim() ,txtunderid.Trim(),txtUserID.Trim(),
                Country_input.Trim(),"Un-Verified",varificationCode,txtsecurityPWD.Trim(), DDLPos.Trim()}, "ds");
                if (ds.Tables[0].Rows[0]["ExecStu"].ToString() == "1")
                {
                    MemID = ds.Tables[0].Rows[0]["MID"].ToString(   );
                    //MngrDtl = ds.Tables[0].Rows[0]["MngrDtl"].ToString();
                    //sc = true;
                    //msg = "Verification.html?acc=" + varificationCode.Trim();

                    //string VerifyAcc = objgdb.GetCredentialAPI(txtFirstName.ToUpper().Trim(), txtUserID.Trim(), MemID.Trim(), "VerifyText");
                    //new SendSms().SponserSendSMSToUserIDMob(VerifyAcc, txtMobileNo.Trim());

                    //string VerifyAcc = objgdb.GetCredentialAPI(txtFirstName.ToUpper().Trim(), MemID.Trim(), txtPasswordSU.ToString().Trim(), txtsecurityPWD.ToString().Trim(), "RegistrationText");
                    //new SendSms().SponserSendSMSToUserIDMob(VerifyAcc, txtMobileNo.Trim());
                    if (ds.Tables[0].Rows[0]["Mailvarify"].ToString() == "1")
                    {
                        try
                        {
                            this.SendEmailToUser(txtEmailID.Trim(), varificationCode, txtFirstName.ToUpper().Trim());
                            sc = true;
                            msg = "login.html";
                            //msg = ds.Tables[0].Rows[0]["ErrorMsg"].ToString();
                        }
                        catch { }
                    }
                    else if (ds.Tables[0].Rows[0]["Mailvarify"].ToString() == "0")
                    {
                        sc = true;
                        msg = "Verification.html?acc=" + varificationCode.Trim();
                    }
                   // msg = "Verification.html?acc=" + varificationCode.Trim();
                    //msg = "Verification.html?vrm=" + MemID.Trim();
                }
                else
                {
                    sc = false;
                    //msg = "<span style='color:#FF0000; font-wight:bold; font-size:18px;'> " + ds.Tables[0].Rows[0]["ErrorMsg"].ToString() + "</span><br/>";
                    msg =  ds.Tables[0].Rows[0]["ErrorMsg"].ToString() ;
                }

            }
            else
            {
                sc = false;
                //msg = "<span style='color:#FF0000; font-wight:bold; font-size:18px;'> Please fill required fields in registration form !</span>";
                msg = "Please fill required fields in registration form !";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            //msg = "<span style='color:#FF0000; font-wight:bold; font-size:18px;'> " + ex.Message + "</span>";
            msg = ex.Message.ToString ();
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
    //public static string GetPassword()
    //{
    //    int result = 0;
    //    Random rand = new Random();
    //    //result = rand.Next(0, 99999999);
    //    result = rand.Next(0, 99999999);

    //    return result.ToString();
    //}

    public static string GetPassword()
    {
        string result = "";
        Random randm = new Random();

        int r1 = randm.Next(1, 9);
        int r2 = randm.Next(1, 9);
        int r3 = randm.Next(1, 9);
        int r4 = randm.Next(1, 9);
        int r5 = randm.Next(1, 9);
        int r6 = randm.Next(1, 9);
        int r7 = randm.Next(1, 9);
        int r8 = randm.Next(1, 9);


        result = r1 + "" + r2 + "" + r3 + "" + r4 + "" + r5 + "" + r6; //+ "" + r7 + "" + r8;
        return result.ToString();
    }

    protected void SendEmailToUser(string EmailId, string Code, string SponserName)
    {
        
        string Message =
     @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color:transparent;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff' > <tbody> <tr> <td height='50'></td> </tr> <tr> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='padding:0px 25px;'> <tbody> <tr> <td> <h3 style=' font-size:20px;margin: 0; '> <span style='color: #ee9d28; font-weight: bolder'>Welcome,</span> " + txtFirstName + " {" + txtUserID + "}</h3> <br> <h4 style=' font-size: 17px;margin: 5px 0px;font-family: sans-serif;'>Thank you for registration with us!</h4><br /><p style='font-size: 17px; margin: 5px 0px; font-family: sans-serif; '>Please make sure that you have entered a valid details in the sign-up form.</p><p style=' font-size: 17px;margin: 5px 0px;font-family: sans-serif;'>Please use below OTP for mail Verification.</p><p style=' font-size: 16px;'><b>Your one-time password is: <span style='color:blue'>"+ varificationCode.Trim() +"</span></b></p><div style=' padding-bottom: 20px; font-size: 12px;'>If you didn't request this code, you can safely ignore this email. Someone else might have typed your email address by mistake.</div></td></tr></tbody> </table> </td>  </tr> <tr> </tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr style='background-color: transparent;'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr><tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'> <table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'> <table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'> <tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: #000000;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";

        objgdb.FillWebSiteEmailCompany();
        MailSenderByEmail mailsend = new MailSenderByEmail();

        try
        {
            mailsend.SendMailMessage(DynamicDtls.Email, "Account Verify mail", Message, EmailId);
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
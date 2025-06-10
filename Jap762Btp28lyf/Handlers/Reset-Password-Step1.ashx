<%@ WebHandler Language="C#" Class="Reset_Password_Step1" %>
using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Net.Mail;
using System.IO;
using System.Data;
using System.Web.SessionState;

public class Reset_Password_Step1 : IHttpHandler {
    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc;
    public string msg, Msgs, dtl, RtnRlt, strJson, recovery_email = "", RecCode = "", EmaiAdd = "", MName = "", recovery_memid = "";
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
        recovery_email = context.Request["recovery_email"].Trim();
        recovery_memid = context.Request["recovery_memid"].Trim();
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
            if (recovery_email != "")
            {
                ds = objgdb.ByProcedure("dbo.Pro_PasswordRecovery", new string[] { "MemID","EmlMbl", "RecCode", "NewPWD", "RType" },
                    new string[] { recovery_memid,recovery_email.Trim(), "", "", "RecCode" }, "ByDataset");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    RtnRlt = ds.Tables[0].Rows[0]["RtnRlt"].ToString();
                    Msgs = ds.Tables[0].Rows[0]["Msgs"].ToString();

                }
                if (RtnRlt.ToString().Trim() == "IsOk")
                {
                    RecCode = ds.Tables[0].Rows[0]["RecCode"].ToString();
                    EmaiAdd = ds.Tables[0].Rows[0]["EmaiAdd"].ToString();
                    MName = ds.Tables[0].Rows[0]["MName"].ToString();

                    sc = true;
                    msg =  Msgs;
                    //msg = "<span style='color:#60C630; font-wight:bold; font-size:16px;'> " + Msgs + "</span><br/>";
                    try
                    {
                        this.SendEmailToUser(EmaiAdd);
                    }
                    catch
                    { }
                }
                else
                {
                    sc = false;
                    msg = Msgs ;
                    //msg = "<span style='color:#f6a821; font-wight:bold; font-size:16px;'> " +Msgs + "</span><br/>";
                }
            }
            else
            {
                sc = false;
                msg = "Please fill required fields in form !";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = ex.Message ;
            //msg = "<span style='color:#f6a821; font-wight:bold; font-size:16px;'> " + ex.Message + "</span><br/>";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }

    }
    protected void SendEmailToUser(string EmailId)
    {
        string Message =
        @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color:transparent;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='20'></td> </tr> <tr> <td> <table border='0' cellspacing='0' cellpadding='0' style='margin: 0px 20px; width: 100% !important;' > <tbody> <tr> <td> <h3 style=' font-size:20px;margin: 0;'> <span style='color: #ee9d28; font-weight: bolder'>Dear,</span> " + MName.Trim() + " {" + recovery_memid + "}</h3>  <br>  <p style='font-size: 17px;margin: 5px 0px;font-family: sans-serif;'>We received a request to reset the password for your account.</p><p style=' font-size: 17px;margin: 5px 0px;font-family: sans-serif;'> If you requested a reset for " + EmaiAdd + ", click the button below. <br> If you didn't make this request, please ignore this email.</p> <br/> <p style='font-size: 14px;text-align: justify; margin: 10px 0px ; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p> <div style='padding: 20px 0 20px; text-align: center;'> <a href='http://" + DynamicDtls.WebSite2 + "/reset.html?token=" + RecCode + "' style='text-align: center; font-weight: 700; color: white; background-color: #e85038; padding: 10px 17px; text-decoration: none; '> Reset Password</a></div></div><br> </td> </tr> </tbody> </table> </td>  </tr> <tr> </tbody> </table><table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr style='background-color:transparent;'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color:#000000;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
        objgdb.FillWebSiteEmailCompany();
        MailSenderByEmail mailsend = new MailSenderByEmail();

        try
        {
            mailsend.SendMailMessage(DynamicDtls.Email, "Reset Password", Message, EmailId);
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
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
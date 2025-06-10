<%@ WebHandler Language="C#" Class="Transfer_f_Wallet" %>
using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Net.Mail;
using System.IO;
using System.Data;
using System.Web.SessionState;

public class Transfer_f_Wallet : IHttpHandler
{

    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc;
    public static string msg, Msgs, dtl, RtnRlt, strJson, ReType = "", UserID = "", txtDepositAmount = "", txttxnpwd = "", txtTxnHas = "", type = "", ReqDate = "", OtpUser = "", otpflag = "",
        fname, chkfileEx, SDbFilePath = "", AcFileName, FileNameDB, MName, Email;
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds; DataTable dt;
    public class test
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public string detail { get; set; }
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
        if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        {
            UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();
            //////

            txtDepositAmount = context.Request["txtDepositAmount"].Trim();
            txttxnpwd = context.Request["txttxnpwd"].Trim();
            type = context.Request["type"].Trim();
            OtpUser = context.Request["txtOtp"].Trim();
            if (type == "PsI")
            {
                type = "1";
            }
            //else if (type == "LvI")
            //{
            //    type = "3";
            //}
            //else if (type == "BdI")
            //{
            //    type = "4";
            //}
            //else if (type == "Ryt")
            //{
            //    type = "2";
            //}

            SaveBankFundReq();


            handleRequest();


        }
        else
        {
            context.Response.Write("<script>window.open('../login.html','_top');</script>");
        }
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




    public void SaveBankFundReq()
    {
        try
        {
            if (txtDepositAmount != "" && type != "")
            {
                ds = objgdb.ByProcedure("[TransferToFWallet_NEW]", new string[] { "MemId", "Amt", "DeductPer", "Mode", "Type", "OtpUser" }
                            , new string[] { UserID, txtDepositAmount.Trim(), "", txttxnpwd.Trim(), type, OtpUser }, "das");

                if (ds.Tables[0].Rows[0]["Sts"].ToString() == "Ok")
                {
                    sc = true;
                    //msg = "<span style='color:#2E962E;'> " + ds.Tables[0].Rows[0]["Msg"].ToString() + "</span>";
                    msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                    MName = ds.Tables[0].Rows[0]["MName"].ToString();
                    Email = ds.Tables[0].Rows[0]["Email"].ToString();
                    otpflag = ds.Tables[0].Rows[0]["otpflag"].ToString();
                    dtl = ds.Tables[0].Rows[0]["Rslt"].ToString();
                    //try
                    //{
                    if (dtl == Convert.ToString(200))
                    {
                        string Message123 =@"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color:transparent'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table><table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='30'></td> </tr> <tr> <td> <table border='0' cellspacing='0' cellpadding='0' style='margin:0px 20px;'> <tbody> <tr> <td> <h3 style=' font-size:20px;margin: 0; '> <span style='color: #ee9d28; font-weight: bolder'>Dear,</span> " +  MName  + " {" + UserID + "}</h3> <br><p style=' font-size: 17px;margin: 5px 0px;font-family: sans-serif;'>The one time password (OTP) is <strong>" + otpflag + "</strong> for Growth Wallet To Main Wallet Fund Transfer Request.</p> <p style=' font-size: 17px;margin: 5px 0px;font-family: sans-serif;'>If it is not done by you, Please login and Check your sensitive Transaction.. !</p><br> </td> </tr> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr> </tbody> </table> </td>  </tr> <tr> </tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr style='background-color:transparent'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: #000000;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";

                        this.SendEmailToUser(Email, "Your otp password for Growth Wallet To Main Wallet Fund Transfer Request", Message123);
                    }
                    else if (dtl == Convert.ToString(1))
                    {
                        string Message1234 =
                              @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans;  color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color:transparent'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:block' target='_blank'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style=' padding: 15px 0 0;' border='0'> </a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='20'></td></tr> <tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px;max-width: 570px; margin: 0 auto'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <h3 style='margin:0;padding:0;font-size:20px;'><span style='color: #ee9d28; font-weight: bolder'>Dear,</span> " +  MName  + " {" + UserID + "}</h3><div style='height:20px'></div><p style='margin:0;padding:0'>Congratulations !!!</p><p style='margin-bottom:15px;margin-top:30px'> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>Your have been successfully transferred of</strong> <span style='display:block;font-weight:400'>" + txtDepositAmount.Trim() + "</span> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>from your Wallet.</strong> </p><p style='margin-top:0;margin-bottom:11px'> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px;color:red'><sup>*</sup>&nbsp;If you didn't make this transfer, Please contact to support team.</strong> </p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td align='left' valign='top'> <div style='margin:10px 0 0 0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='30' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody> </table> </td><td width='15'></td></tr></tbody> </table> </div></td></tr></tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr style='background-color:transparent'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: #000000;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                        this.SendEmailToUser(Email, "Growth Wallet To Main Wallet Fund Transfer Confirmation !", Message1234);
                    }
                }
                else
                {
                    sc = false;
                    //msg = "<span style='color:#FF8A00;'> " + ds.Tables[0].Rows[0]["Msg"].ToString() + "</span>";
                    msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                }
            }
            else
            {
                sc = false;
                //msg = "<span style='color:#FF8A00;'>Please fill required fields !</span>";
                msg = "Please fill required fields !";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = "<span style='color:#FF8A00;'>" + ex.Message + "</span>";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }
    protected void SendEmailToUser(string EmailId, string Subjects, string Message)
    {
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
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


}
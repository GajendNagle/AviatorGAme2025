   <%@ WebHandler Language="C#" Class="Account_Settings" %>
using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Net.Mail;
using System.IO;
using System.Data;
using System.Web.SessionState;

public class Account_Settings : IHttpHandler
{

    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    bool sc;
    string msg, Msgs, dtl, RtnRlt, strJson;
    string UserID = "", Mname, Email, Mobile,
       txtAccFName = "", txtBakName = "", txtAccountNo = "", ddlAccType = "", txtIFSCode = "", txtPanCard = "", txtbankotp = "",
       txtFirstName = "", txtEmailid = "", txtMobileNo = "", txtPinCode="" ,txtCity = "", ddlcountry = "", txtAdrs ="", txtGender="", txtDob="",
       txtPerfect = "", txtoldpass = "", txtnewpass = "", txtoldsecPWD = "", txtNewsecPWD = "", referencecode = "", CURDT = "",txtState="",
       txtupiAddress = "", txtpaytmid = "", txtBitcoinAddress = "", txtEthereumAddress = "", txtTronAddress = "", txtTrxOtp = "", txtBinanceAddress = "", txtBnbOtp = "", txtEthOtp = "", txtBtcOtp = "", otpflag = "", fname,
       chkfileEx, SDbFilePath = "", AcFileName, FileNameDB,txtPassOtp = "",RecCode = "",
       txtbrokerName = "", txtAccNo = "", txttrdgpass = "", txtinvstpass = "", ddlserver = "", txtdpamt = "", txtdpdate = "", txtremark = "",txtsecpwd = "";
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;
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
            if (context.Request.QueryString["SaveTp"].ToString() == "BankInfo")
            {
                txtAccFName = context.Request["txtAccFName"].Trim();
                txtBakName = context.Request["txtBakName"].Trim();
                txtAccountNo = context.Request["txtAccountNo"].Trim();
                ddlAccType = context.Request["ddlAccType"].Trim();
                txtIFSCode = context.Request["txtIFSCode"].Trim();
                txtPanCard = context.Request["txtPanCard"].Trim();
                txtbankotp = context.Request["txtbankotp"].Trim();
                //if (context.Request.Files.Count > 0)
                //{
                //    UploadProfileImg("BANK");
                //}
                //else
                //{
                //    msg = "Please upload bank proof !";
                SaveBankInfo();
                //}
            }
            else if (context.Request.QueryString["SaveTp"].ToString() == "BankPrf")
            {
                if (context.Request.Files.Count > 0)
                {
                    UploadProfileImg("BANK");
                }
                else
                {
                    msg = "Please upload bank proof !";
                    //SaveBankInfo();
                }
            }
            else if (context.Request.QueryString["SaveTp"].ToString() == "PerInfo")
            {
                txtFirstName = context.Request["txtFirstName"].Trim();
                txtEmailid = context.Request["txtEmailid"].Trim();
                txtMobileNo = context.Request["txtMobiUSD"].Trim();
                txtGender = ""; //context.Request["txtGender"].Trim();
                txtDob = "";//context.Request["txtDob"].Trim();
                txtPinCode = "";//context.Request["txtPinCode"].Trim();
                txtAdrs = "";//context.Request["txtAdrs"].Trim();
                txtCity = context.Request["txtCity"].Trim();
                ddlcountry = context.Request["ddlcountry"].Trim();
                txtState = "";//context.Request["txtState"].Trim();
                //referencecode = context.Request["referencecode"].Trim();
                SavePerInfo();
            }



            //////////////////////////////////////
            else if (context.Request.QueryString["SaveTp"].ToString() == "KYCInfo")
            {
                txtFirstName = context.Request["txtkycid"].Trim();
                txtEmailid = context.Request["txtkycidno"].Trim();

                if (context.Request.Files.Count > 0)
                {
                    UploadProfileImg("KYC");
                }
                else
                {
                    SaveKYCInfo("KYC");
                }

            }
            else if (context.Request.QueryString["SaveTp"].ToString() == "KYCAddInfo")
            {
                txtFirstName = context.Request["txtkycid"].Trim();

                if (context.Request.Files.Count > 0)
                {
                    UploadProfileImg("ADD");
                }
                else
                {
                    SaveKYCInfo("ADD");
                }

            }
            else if (context.Request.QueryString["SaveTp"].ToString() == "PorInfo")
            {
                txtFirstName = context.Request["txtkycid"].Trim();
                txtEmailid = context.Request["txtkycidno"].Trim();

                if (context.Request.Files.Count > 0)
                {
                    UploadProfileImg("ADD");
                }
                else
                {
                    SaveKYCInfo("ADD");
                }
            }

            else if (context.Request.QueryString["SaveTp"].ToString() == "PorInfo6")
            {
                txtFirstName = context.Request["txtkycidno"].Trim();

                if (context.Request.Files.Count > 0)
                {
                    UploadProfileImg("BANK");
                }
                else
                {
                    SaveKYCInfo("BANK");
                }

            }

            else if (context.Request.QueryString["SaveTp"].ToString() == "FaceIdInfo")
            {
                txtFirstName = context.Request["txtkycid"].Trim();

                if (context.Request.Files.Count > 0)
                {
                    UploadProfileImg("FaceId");
                }
                else
                {
                    SaveKYCInfo("FaceId");
                }

            }
            //////////////////////////////////////      
            else if (context.Request.QueryString["SaveTp"].ToString() == "PMInfo")
            {
                txtPerfect = context.Request["txtPerfect"].Trim();
                SavePMInfo();
            }
            else if (context.Request.QueryString["SaveTp"].ToString() == "BTCInfo")
            {
                txtBitcoinAddress = context.Request["txtBitcoinAddress"].Trim();
                txtBtcOtp = context.Request["txtBtcOtp"].Trim();
                SaveBTCInfo();
            }
            else if (context.Request.QueryString["SaveTp"].ToString() == "ETHInfo")
            {
                txtEthereumAddress = context.Request["txtEthereumAddress"].Trim();
                txtEthOtp = context.Request["txtEthOtp"].Trim();
                SaveETHInfo();
            }
            else if (context.Request.QueryString["SaveTp"].ToString() == "TRXInfo")
            {
                txtTronAddress = context.Request["txtTronAddress"].Trim();
                txtTrxOtp = context.Request["txtTrxOtp"].Trim();
                SaveTRXInfo();
            }
            else if (context.Request.QueryString["SaveTp"].ToString() == "BNBInfo")
            {
                txtBinanceAddress = context.Request["txtBinanceAddress"].Trim();
                txtBnbOtp = context.Request["txtBnbOtp"].Trim();
                SaveBNBInfo();
            }
            else if (context.Request.QueryString["SaveTp"].ToString() == "SvPTM")
            {
                txtpaytmid = context.Request["txtpaytmid"].Trim();
                SavePaytmInfo();
            }
            else if (context.Request.QueryString["SaveTp"].ToString() == "SvUPI")
            {
                txtupiAddress = context.Request["txtupiAddress"].Trim();
                SaveUPIInfo();
            }
            else if (context.Request.QueryString["SaveTp"].ToString() == "SLgPWD")
            {
                txtoldpass = context.Request["txtoldpass"].Trim();
                txtnewpass = context.Request["txtnewpass"].Trim();
                if (txtoldpass != "" && txtnewpass != "")
                {
                    UpdatePassword(UserID, "Login", txtoldpass.Trim().Trim(), txtnewpass.Trim().Trim(), "TransPassword");
                }
                else
                {
                    sc = false;
                    msg = "Please fill correct required fields in form !";
                }
            }
            else if (context.Request.QueryString["SaveTp"].ToString() == "SSecPWD")
            {
                txtoldsecPWD = context.Request["txtoldsecPWD"].Trim();
                txtNewsecPWD = context.Request["txtNewsecPWD"].Trim();
                if (txtoldsecPWD != "" && txtNewsecPWD != "")
                {
                    UpdatePassword(UserID, "Transaction", txtoldsecPWD.Trim(), txtNewsecPWD.Trim(), "ChangePassword");
                }
                else
                {
                    sc = false;
                    msg = "<span style='color:#FF8A00;'>Please fill correct required fields in form !</span>";
                }
            }
            else if (context.Request.QueryString["SaveTp"].ToString() == "MTInfo")
            {
                txtbrokerName = context.Request["txtbrokerName"].Trim();
                txtAccNo = context.Request["txtAccountNo"].Trim();
                txttrdgpass = context.Request["txttrdpass"].Trim();
                txtinvstpass = context.Request["txtinvstpass"].Trim();
                ddlserver = context.Request["ddlserver"].Trim();
                txtdpamt = "";//context.Request["txtdpamt"].Trim();
                txtdpdate = "";// context.Request["txtdpdate"].Trim();
                txtremark = "";//context.Request["txtrmrk"].Trim();

                SaveMtInfo();
            }
            else if (context.Request.QueryString["SaveTp"].ToString() == "Addinvest")
            {
                txtbrokerName = context.Request["txtbrokerName"].Trim();
                txtAccNo = context.Request["txtAccountNo"].Trim();
                txtdpamt = context.Request["txtdpamt"].Trim();
                txtdpdate = context.Request["txtdpdate"].Trim();
                txtremark = context.Request["txtrmrk"].Trim();
                txtsecpwd = context.Request["txtsecpwd"].Trim();
                invstinfo();
            }
            else if (context.Request.QueryString["SaveTp"].ToString() == "fgSSecPWD")
            {

                FgsecPassword(UserID, "RecCode", "", "", "");

            }
            /////////
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

    public void SavePerInfo()
    {
        try
        {
            if (txtFirstName != "" && txtEmailid != "" && txtMobileNo != "" && ddlcountry != "" && txtMobileNo !="")
            {
                ds = objgdb.ByProcedure("pro_Account_Setting", new string[] { "MemID", "BankName", "BranchName", "AccNo",
        "AccName","MicarCode","IFSC","pan","PerfectMoneyAccNM","PerfectMoneyAccNo","NetellerName","NetellerNo",
        "UPDATEBLOCK","Mname","gender","dob","Address","State","City","Distrinct","Pin", "Phone","Email", "Occupation","FName",
        "RelCode","Nominee","NomRel","Mobile","Status"
        }, new string[] { UserID,"","","","","","","","","","","","Personal Data",txtFirstName.Trim(),txtGender.Trim(),txtDob.Trim(),txtAdrs.Trim(),
            txtState.Trim(),txtCity.Trim(),ddlcountry.Trim(),txtPinCode.Trim(),"",txtEmailid.Trim(),"","","","","",txtMobileNo.Trim(),txtMobileNo.Trim(),""
        }, "ds");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    sc = true;
                    msg = "" + ds.Tables[0].Rows[0]["Msg"].ToString() + "";
                    Mname = ds.Tables[0].Rows[0]["MName"].ToString();
                    Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();
                    CURDT = ds.Tables[0].Rows[0]["CURDT"].ToString();

                    try
                    {
                        string Message123 =
                        @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='left' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: transparent;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table><table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='20'></td> </tr> <tr> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%' style=' padding:0px 25px;'> <tbody> <tr> <td> <h3 style=' font-size: 20px; margin: 0; > <span style='color: #ee9d28; font-weight: bolder'>Dear,</span> " + Mname.Trim() + " {" + UserID + "}</h3> <br><p style=' font-size: 17px;margin: 5px 0px;font-family: sans-serif;'>Your personal information has been updated successfully in profile section.</p> <br><p style=' font-size: 17px;margin: 5px 0px;font-family: sans-serif;'>Best Regards, <br>" + DynamicDtls.CompName + " Team </br> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompWeb + "</a> </p><br> </td> </tr> </tbody> </table> </td>  </tr> <tr> </tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr style='background-color:transparent;'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: #000000;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                        this.SendEmailToUser(Email, " Your Profile Recently Updated !", Message123);
                    }
                    catch { }
                }
                else
                {
                    sc = false;
                    msg = "" + ds.Tables[0].Rows[0]["Msg"].ToString() + "";
                }

            }
            else
            {
                sc = false;
                msg = "Please fill correct required fields in form !";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = "Something went wrong. Sorry, we have let our engineers know. Try again!";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }
    public void SaveBankProofInfo()
    {
        try
        {
            ds = objgdb.ByProcedure("pro_Account_Setting_OTP", new string[] { "MemID", "BankName", "BranchName", "AccNo",
        "AccName","MicarCode","IFSC","pan","PerfectMoneyAccNM","PerfectMoneyAccNo","NetellerName","NetellerNo",
        "UPDATEBLOCK","Mname","gender","dob","Address","State","City","Distrinct","Pin", "Phone","Email", "Occupation","FName",
        "RelCode","Nominee","NomRel","Mobile" ,"Status","OtpUser"
        }, new string[] { UserID, FileNameDB, "", "", "", "", "", "", "", "", "", "", "BANK PROOF", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", txtbankotp.Trim() }, "ds");
            if (ds.Tables[0].Rows.Count > 0)
            {
                sc = true;
                msg = ds.Tables[0].Rows[0]["Msg"].ToString();
            }
            else
            {
                sc = false;
                msg = ds.Tables[0].Rows[0]["Msg"].ToString();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace + "\n  Website");
            sc = false;
            msg = "Sorry, Something is wrong please try later !";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }
    public void SaveBankInfo()
    {
        try
        {
            if (txtAccFName != "" && txtBakName != "" && txtAccountNo.Length >= 6 && txtIFSCode != "")
            {
                ds = objgdb.ByProcedure("pro_Account_Setting_OTP", new string[] { "MemID", "BankName", "BranchName", "AccNo",
        "AccName","MicarCode","IFSC","pan","PerfectMoneyAccNM","PerfectMoneyAccNo","NetellerName","NetellerNo",
        "UPDATEBLOCK","Mname","gender","dob","Address","State","City","Distrinct","Pin", "Phone","Email", "Occupation","FName",
        "RelCode","Nominee","NomRel","Mobile" ,"Status","OtpUser"
        }, new string[] { UserID,txtBakName.Trim(),ddlAccType.Trim(),txtAccountNo.Trim(),txtAccFName.Trim(),
        "",txtIFSCode.Trim(),txtPanCard.Trim(),"","","","","BANK DETAIL","","","","","","","","","","","","","","","","","",txtbankotp.Trim()
        }, "ds");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    sc = true;
                    msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                    Mname = ds.Tables[0].Rows[0]["MName"].ToString();
                    Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();


                    otpflag = ds.Tables[0].Rows[0]["otpflag"].ToString();
                    RtnRlt = ds.Tables[0].Rows[0]["Rslt"].ToString();
                    dtl = ds.Tables[0].Rows[0]["Rslt"].ToString();
                    if (RtnRlt == Convert.ToString(200))
                    {

                        string Message127 =
                        @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: transparent;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:block' target='_blank'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style=' padding: 15px 0 0;' border='0'> </a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='20'></td></tr><tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px; margin: 0 20px'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <h3 style='margin:0;padding:0;font-size:20px;'><span style='color: #ee9d28; font-weight: bolder'>Dear,</span> &nbsp;" + Mname.Trim() + " {" + UserID + "}</h3> <p style='margin-bottom:15px;margin-top:15px'> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>The one time password (OTP) is</strong> <span style='display:block;font-weight:400'>" + otpflag + "</span> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>for update your Account.</strong> </p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td></tr><tr> <td align='left' valign='top'> <div style='margin:0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='30' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody> </table> </td><td width='15' style='display:none'></td></tr></tbody> </table> </div></td></tr></tbody> </table><table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr background-color: transparent;> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: #000000;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                        this.SendEmailToUser(Email, " Your OTP password for Bank account update !", Message127);
                    }
                    else if (dtl == Convert.ToString(1))
                    {
                        try
                        {
                            string Message123 =
                            @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: transparent;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table><table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='20'></td></tr> <tr> <td height='20'></td></tr> <tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px; margin: 0 20px'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <h3 style='margin:0;padding:0;font-size:20px;'><span style='color: #ee9d28; font-weight: bolder'>Dear,</span>&nbsp;" + Mname.Trim() + " {" + UserID + "}</h3><div style='height:20px'></div><p style='margin:0 0 15px 0;padding:0'>Your Login Password updated successfully in profile section.</p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td></tr><tr> <td align='left' valign='top'> <div style='margin:0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='30' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody> </table> </td><td width='15'></td></tr></tbody> </table> </div></td></tr></tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr style='background-color:transparent;'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: #000000;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                            this.SendEmailToUser(Email, " Your bank details in Profile Recently Updated !", Message123);
                        }
                        catch { }
                    }

                }
                else
                {
                    sc = false;
                    msg = "<span style='color:#FF8A00;'> " + ds.Tables[0].Rows[0]["Msg"].ToString() + "</span>";
                }

            }
            else
            {
                sc = false;
                msg = "<span style='color:#FF8A00;'>Please fill correct required fields in form !</span>";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = "Something went wrong. Sorry, we have let our engineers know. Try again!";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }
    public void SaveMtInfo()
    {
        try
        {
            if (txtbrokerName != "" && txtAccNo.Length >= 6 && txttrdgpass != "" && txtinvstpass != "")
            {
                ds = objgdb.ByProcedure("pro_Account_Setting", new string[] { "MemID", "BankName", "BranchName", "AccNo",
        "AccName","MicarCode","IFSC","pan","PerfectMoneyAccNM","PerfectMoneyAccNo","NetellerName","NetellerNo",
        "UPDATEBLOCK","Mname","gender","dob","Address","State","City","Distrinct","Pin", "Phone","Email", "Occupation","FName",
        "RelCode","Nominee","NomRel","Mobile" ,"Status"
        }, new string[] { UserID,"","",txtAccNo.Trim(),"",
        "","","","","","","","MT DETAIL",txtbrokerName.Trim(),txttrdgpass.Trim(),txtinvstpass.Trim(),ddlserver.Trim(),
            "","","","","","","","","","","",txtdpamt.Trim(),txtdpdate.Trim(),txtremark.Trim()}, "ds");
                if (ds.Tables[0].Rows[0]["RtrnRslt"].ToString() == "1")
                {
                    sc = true;
                    msg = " " + ds.Tables[0].Rows[0]["Msg"].ToString() + " ";
                    Mname = ds.Tables[0].Rows[0]["MName"].ToString();
                    Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();
                    try
                    {
                        string Message123 =
                        @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: transparent;'> <tbody> <tr> <td style='padding-bottom:11px; text-align:center;'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table><table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='30'></td> </tr> <tr> <td> <table style='margin:0px 20px;' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr>  <td> <h3 style=' font-size:20px;margin: 0;'> <span style='color: #ee9d28; font-weight: bolder'>Dear,</span> " + Mname.Trim() + " {" + UserID + "}</h3> <br><p style='font-size: 17px;margin: 5px;font-family: sans-serif;'>Warning!!! Your Profile recently updated.</p> <p style=' font-size: 17px;margin: 5px;font-family: sans-serif;'>If it is not done by you, Please login and Check your sensitive Transaction.. !</p> <br> </td> </tr> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr> </tbody> </table> </td>  </tr> <tr> </tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr style='background-color: transparent;'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: #000000;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                        //this.SendEmailToUser(Email, "Your Broker details in Profile Recently Updated !", Message123);
                    }
                    catch { }
                }
                else
                {
                    sc = false;
                    msg = " " + ds.Tables[0].Rows[0]["Msg"].ToString() + " ";
                }

            }
            else
            {
                sc = false;
                msg = " Please fill correct required fields in form !";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = ex.Message;
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }
    public void invstinfo()
    {
        try
        {
            if (txtbrokerName != "" && txtAccNo.Length >= 6 && txtdpamt != "")
            {
                ds = objgdb.ByProcedure("pro_Account_SettingAdd Invest", new string[] { "MemID","AccNo","Date", "Amount","Remark",
                                        "UPDATEBLOCK","Mname","Secpin"},
                new string[] { UserID,txtAccNo.Trim(),txtdpdate.Trim(),txtdpamt.Trim(),txtremark.Trim(),"Add Invest",txtbrokerName.Trim(),txtsecpwd.Trim()}, "ds");
                if (ds.Tables[0].Rows[0]["RtrnRslt"].ToString() == "1")
                {
                    sc = true;
                    msg = " " + ds.Tables[0].Rows[0]["Msg"].ToString() + " ";
                    Mname = ds.Tables[0].Rows[0]["MName"].ToString();
                    Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();
                    try
                    {
                        string Message123 =
                        @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: transparent'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table><table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='20'></td> </tr> <tr> <td> <table border='0' cellspacing='0' cellpadding='0' style='margin:0px 20px;'> <tbody> <tr> <td> <h3 style=' font-size:20px;margin: 0; '> <span style='color: #ee9d28; font-weight: bolder'>Dear,</span> " + Mname.Trim() + " {" + UserID + "}</h3> <br><p style=' font-size: 17px;margin: 5px;font-family: sans-serif;'>Warning!!! Your Profile recently updated.</p> <p style=' font-size: 17px;margin: 5px;font-family: sans-serif;'>If it is not done by you, Please login and Check your sensitive Transaction.. !</p><br> </td> </tr> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr> </tbody> </table> </td>  </tr> <tr> </tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr style='background-color: transparent'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: #000000;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                        //this.SendEmailToUser(Email, "Your Broker details in Profile Recently Updated !", Message123);
                    }
                    catch { }
                }
                else
                {
                    sc = false;
                    msg = " " + ds.Tables[0].Rows[0]["Msg"].ToString() + " ";
                }

            }
            else
            {
                sc = false;
                msg = " Please fill correct required fields in form !";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = ex.Message;
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }
    public void SavePMInfo()
    {
        try
        {
            if (txtPerfect != "")
            {
                ds = objgdb.ByProcedure("pro_Account_Setting", new string[] { "MemID", "BankName", "BranchName", "AccNo",
        "AccName","MicarCode","IFSC","pan","PerfectMoneyAccNM","PerfectMoneyAccNo","NetellerName","NetellerNo",
        "UPDATEBLOCK","Mname","gender","dob","Address","State","City","Distrinct","Pin", "Phone","Email", "Occupation","FName",
        "RelCode","Nominee","NomRel","Mobile" ,"Status"
        }, new string[] { UserID,"","","","",
        "","","","",txtPerfect.Trim(),"","","PM DETAIL","","","","","","","","","","","","","","","","","",""
        }, "ds");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    sc = true;
                    msg = "<span style='color:#2E962E;'> " + ds.Tables[0].Rows[0]["Msg"].ToString() + "</span>";
                    Mname = ds.Tables[0].Rows[0]["MName"].ToString();
                    Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();
                    try
                    {
                        string Message123 =
                        @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: transparent;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:block' target='_blank'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style=' padding: 15px 0 0;' border='0'> </a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='20'></td></tr> <tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px; margin: 0px 20px'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <h3 style=' font-size:20px;margin: 0;'> <span style='color: #ee9d28; font-weight: bolder'>Dear,</span> " + Mname.Trim() + " {" + UserID + "}</h3><div style='height:20px'></div><p style='margin:0;padding:0'><span style='color:red'>Warning!!!</span>&nbsp;&nbsp;Your Profile recently updated.</p><p style='margin-bottom:15px'> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>If it is not done by you</strong> <span style='display:block;font-weight:400'>Please login and Check your sensitive Transaction..</span> </p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td></tr><tr> <td align='left' valign='top'> <div style='margin:0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='30' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody></table> </td><td width='15'></td></tr></tbody> </table> </div></td></tr></tbody> </table><table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr style='background-color: transparent;'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: #000000;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                        // this.SendEmailToUser(Email, "...: Your Pay Money Address in Profile Recently Updated !", Message123);
                    }
                    catch { }
                }
                else
                {
                    sc = false;
                    msg = "<span style='color:#FF8A00;'> " + ds.Tables[0].Rows[0]["Msg"].ToString() + "</span>";
                }

            }
            else
            {
                sc = false;
                msg = "<span style='color:#FF8A00;'>Please fill correct required fields in form !</span>";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = "Something went wrong. Sorry, we have let our engineers know. Try again!";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }

    public void SavePaytmInfo()
    {
        try
        {
            if (txtpaytmid != "")
            {
                ds = objgdb.ByProcedure("pro_Account_Setting", new string[] { "MemID", "BankName", "BranchName", "AccNo",
        "AccName","MicarCode","IFSC","pan","PerfectMoneyAccNM","PerfectMoneyAccNo","NetellerName","NetellerNo",
        "UPDATEBLOCK","Mname","gender","dob","Address","State","City","Distrinct","Pin", "Phone","Email", "Occupation","FName",
        "RelCode","Nominee","NomRel","Mobile" ,"Status"
        }, new string[] { UserID,"","","","","","","","","","",txtpaytmid.Trim () ,"PAYTM DETAIL","","","","","","","","","","","","","","","","","",""
        }, "ds");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    sc = true;
                    msg = "<span style='color:#2E962E;'> " + ds.Tables[0].Rows[0]["Msg"].ToString() + "</span>";
                    Mname = ds.Tables[0].Rows[0]["MName"].ToString();
                    Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();
                    try
                    {
                        string Message123 =
                        @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: transparent;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:block' target='_blank'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style=' padding: 15px 0 0;' border='0'> </a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr></tr> <tr> <td height='20'></td></tr> <tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px; margin: 0 20px;'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <h3 style=' font-size:20px;margin: 0;'> <span style='color: #ee9d28; font-weight: bolder'>Dear,</span> " + Mname.Trim() + " {" + UserID + "}</h3><div style='height:20px'></div><p style='margin:0;padding:0'><span style='color:red'>Warning!!!</span>&nbsp;&nbsp;Your Profile recently updated.</p><p style='margin-bottom:15px'> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>If it is not done by you</strong> <span style='display:block;font-weight:400'>Please login and Check your sensitive Transaction..</span> </p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td></tr><tr> <td align='left' valign='top'> <div style='margin:0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='30' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody> </table> </td><td width='15'></td></tr></tbody> </table> </div></td></tr></tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr style='background-color: transparent;'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: #000000;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                        this.SendEmailToUser(Email, " Your Paytm Address in Profile Recently Updated !", Message123);
                    }
                    catch { }
                }
                else
                {
                    sc = false;
                    msg = "<span style='color:#FF8A00;'> " + ds.Tables[0].Rows[0]["Msg"].ToString() + "</span>";
                }

            }
            else
            {
                sc = false;
                msg = "<span style='color:#FF8A00;'>Please fill correct required fields in form !</span>";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = "Something went wrong. Sorry, we have let our engineers know. Try again!";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }

    public void SaveUPIInfo()
    {
        try
        {
            if (txtupiAddress != "")
            {
                ds = objgdb.ByProcedure("pro_Account_Setting", new string[] { "MemID", "BankName", "BranchName", "AccNo",
        "AccName","MicarCode","IFSC","pan","PerfectMoneyAccNM","PerfectMoneyAccNo","NetellerName","NetellerNo",
        "UPDATEBLOCK","Mname","gender","dob","Address","State","City","Distrinct","Pin", "Phone","Email", "Occupation","FName",
        "RelCode","Nominee","NomRel","Mobile" ,"Status"
        }, new string[] { UserID,"","","","","","","","","","",txtupiAddress.Trim ()  ,"UPI DETAIL","","","","","","","","","","","","","","","","","",""
        }, "ds");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    sc = true;
                    msg = "<span style='color:#2E962E;'> " + ds.Tables[0].Rows[0]["Msg"].ToString() + "</span>";
                    Mname = ds.Tables[0].Rows[0]["MName"].ToString();
                    Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();
                    try
                    {
                        string Message123 =
                        @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: #009688;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:block' target='_blank'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style=' padding: 15px 0 0;' border='0'> </a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='50'></td></tr><tr> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='15'></td><td> <h1 style='font-size: 24px; font-weight: normal; text-align: center; line-height: 28px; margin-top: 0; margin-bottom: 15px'>Profile Updated</h1> </td><td width='15'></td></tr></tbody> </table> </td></tr><tr> <td height='20'></td></tr><tr> <td align='center'> <table style='font-size: 18px; text-align: center; color: #fff' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <table> <tbody> <tr> <td align='center' style='border-radius:50%' bgcolor='#0AAD2E' height='115' width='115'> <div style='text-align:center;max-width:570px;'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/check.png' alt='success' /> </div></td></tr></tbody> </table> </td></tr><tr> <td height='8'> <img src='' width='1' height='1' alt='' style='display:block'> </td></tr><tr> <td align='center'> <div style='text-align:center;height:8px;width:60px;background:#ebebeb;border-radius:50%'></div></td></tr><tr> <td height='25'> <img src='' alt='' width='1' height='1' style='display:block'> </td></tr></tbody> </table> </td></tr><tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px;max-width: 570px; margin: 0 auto'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <p style='margin:0;padding:0;font-weight:600;'>Hi,&nbsp;&nbsp;" + Mname.Trim() + "</p><div style='height:20px'></div><p style='margin:0;padding:0'><span style='color:red'>Warning!!!</span>&nbsp;&nbsp;Your Profile recently updated.</p><p style='margin-bottom:15px'> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>If it is not done by you</strong> <span style='display:block;font-weight:400'>Please login and Check your sensitive Transaction..</span> </p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td></tr><tr> <td align='left' valign='top'> <div style='margin:0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='30' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody> </table> </td><td width='15'></td></tr></tbody> </table> </div></td></tr></tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr bgcolor='#009688'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: white;text-align: center'>CopyrightCopyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                        this.SendEmailToUser(Email, " Your UPI address in Profile Recently Updated !", Message123);
                    }
                    catch { }
                }
                else
                {
                    sc = false;
                    msg = "<span style='color:#FF8A00;'> " + ds.Tables[0].Rows[0]["Msg"].ToString() + "</span>";
                }

            }
            else
            {
                sc = false;
                msg = "<span style='color:#FF8A00;'>Please fill correct required fields in form !</span>";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = "Something went wrong. Sorry, we have let our engineers know. Try again!";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }

    public void SaveBTCInfo()
    {
        try
        {
            if (txtBitcoinAddress != "")
            {
                ds = objgdb.ByProcedure("pro_Account_Setting_OTP", new string[] { "MemID", "BankName", "BranchName", "AccNo",
        "AccName","MicarCode","IFSC","pan","PerfectMoneyAccNM","PerfectMoneyAccNo","NetellerName","NetellerNo",
        "UPDATEBLOCK","Mname","gender","dob","Address","State","City","Distrinct","Pin", "Phone","Email", "Occupation","FName",
        "RelCode","Nominee","NomRel","Mobile" ,"Status","OtpUser"
        }, new string[] { UserID,"","","","","","","","","","",txtBitcoinAddress.Trim(),"Bitcoin DETAIL","","","","","","","","","","","","","","","","","",txtBtcOtp.ToString().Trim()
        }, "ds");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    sc = true;
                    msg = " " + ds.Tables[0].Rows[0]["Msg"].ToString() + "";
                    Mname = ds.Tables[0].Rows[0]["MName"].ToString();
                    Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();
                    //CURDT = ds.Tables[0].Rows[0]["CURDT"].ToString();

                    otpflag = ds.Tables[0].Rows[0]["otpflag"].ToString();
                    RtnRlt = ds.Tables[0].Rows[0]["Rslt"].ToString();
                    dtl = ds.Tables[0].Rows[0]["Rslt"].ToString();
                    if (RtnRlt == Convert.ToString(200))
                    {

                        string Message127 =
                                @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: #009688;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:block' target='_blank'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style=' padding: 15px 0 0;' border='0'> </a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='50'></td></tr><tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px;max-width: 570px; margin: 0 auto'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <p style='margin:0;padding:0;font-weight:600;'>Dear,&nbsp;&nbsp;" + Mname.Trim() + "{" + UserID + "}</p><div style='height:20px'></div><p style='margin-bottom:15px;margin-top:15px'> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>The one time password (OTP) is</strong> <span style='display:block;font-weight:400'>" + otpflag + "</span> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>for update your Account.</strong> </p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td></tr><tr> <td align='left' valign='top'> <div style='margin:0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='30' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody> </table> </td><td width='15' style='display:none'></td></tr></tbody> </table> </div></td></tr></tbody> </table><table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr bgcolor='#009688'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: white;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                        this.SendEmailToUser(Email, " Your OTP password for BTC account update !", Message127);
                    }
                    else if (dtl == Convert.ToString(1))
                    {
                        try
                        {
                            string Message123 =
                                    @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: #009688;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table><table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='50'></td></tr><tr> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='15'></td><td> <h1 style='font-size: 24px; font-weight: normal; text-align: center; line-height: 28px; margin-top: 0; margin-bottom: 15px'>Profile Updated</h1> </td><td width='15'></td></tr></tbody> </table> </td></tr><tr> <td height='20'></td></tr><tr> <td align='center'> <table style='font-size: 18px; text-align: center; color: #fff' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <table> <tbody> <tr> <td align='center' style='border-radius:50%' bgcolor='#0AAD2E' height='115' width='115'> <div style='text-align:center;max-width:570px;'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/check.png' alt='success' /> </div></td></tr></tbody> </table> </td></tr><tr> <td height='8'> <img src='' width='1' height='1' alt='' style='display:block'> </td></tr><tr> <td align='center'> <div style='text-align:center;height:8px;width:60px;background:#ebebeb;border-radius:50%'></div></td></tr><tr> <td height='25'> <img src='' alt='' width='1' height='1' style='display:block'> </td></tr></tbody> </table> </td></tr><tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px;max-width: 570px; margin: 0 auto'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <p style='margin:0;padding:0;font-weight:600;'>Dear,&nbsp;&nbsp;" + Mname.Trim() + "{" + UserID + "}</p><div style='height:20px'></div><p style='margin:0 0 15px 0;padding:0'>Your Wallet address updated successfully in profile section.</p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td></tr><tr> <td align='left' valign='top'> <div style='margin:0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='30' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody> </table> </td><td width='15'></td></tr></tbody> </table> </div></td></tr></tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr bgcolor='#009688'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: white;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                            this.SendEmailToUser(Email, " Your Profile recently updated", Message123);
                        }
                        catch { }
                    }
                }
                else
                {
                    sc = false;
                    msg = "" + ds.Tables[0].Rows[0]["Msg"].ToString() + "";
                }

            }
            else
            {
                sc = false;
                msg = "Please fill correct required fields in form !";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = "Something went wrong. Sorry, we have let our engineers know. Try again!";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }


    public void SaveETHInfo()
    {
        try
        {
            if (txtEthereumAddress != "")
            {
                ds = objgdb.ByProcedure("pro_Account_Setting_OTP", new string[] { "MemID", "BankName", "BranchName", "AccNo",
        "AccName","MicarCode","IFSC","pan","PerfectMoneyAccNM","PerfectMoneyAccNo","NetellerName","NetellerNo",
        "UPDATEBLOCK","Mname","gender","dob","Address","State","City","Distrinct","Pin", "Phone","Email", "Occupation","FName",
        "RelCode","Nominee","NomRel","Mobile" ,"Status","OtpUser"
        }, new string[] { UserID,"","","","","","","","","","",txtEthereumAddress.Trim(),"Ethereum DETAIL","","","","","","","","","","","","","","","","","",txtEthOtp.ToString().Trim()
        }, "ds");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    sc = true;
                    msg = "" + ds.Tables[0].Rows[0]["Msg"].ToString() + "";
                    Mname = ds.Tables[0].Rows[0]["MName"].ToString();
                    Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();

                    //CURDT = ds.Tables[0].Rows[0]["CURDT"].ToString();

                    otpflag = ds.Tables[0].Rows[0]["otpflag"].ToString();
                    RtnRlt = ds.Tables[0].Rows[0]["Rslt"].ToString();
                    dtl = ds.Tables[0].Rows[0]["Rslt"].ToString();
                    //if (RtnRlt == Convert.ToString(200))
                    //{

                    //    string Message127 =
                    //    @"<div style='background-color: #E6E4E4; padding: 20px; font-size:14px; line-height: 1.43; font-family:Helvetica Neue, Segoe UI, Helvetica, Arial, sans-serif;'><div style='max-width: 600px; margin: 10px auto 20px; font-size: 12px; color: #A5A5A5; text-align: center;'>If you are unable to see this message, <a href='#' style='color: #A5A5A5; text-decoration: underline;'>click here to view in browser </a></div><div style='max-width: 600px; margin: 0px auto; background-color: #fff; box-shadow: 0px 20px 50px rgba(0,0,0,0.05);'><table style=' width: 100%; background: #9AFFE1;'><tr><td style='background-color: #9AFFE1;'> <img alt='' src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/....-logo-1.svg' style='padding: 20px'></td></tr></table><div style='padding: 60px 70px; border-top: 1px solid rgba(0,0,0,0.05);'><div style='color: #636363; font-size: 14px;'><p>Hi, <strong>" + Mname.Trim() + " </strong><br /> <br />The one time password (OTP) is " + otpflag + " for update your ETH Account..<br/><br/><br/>Thanks for connecting with us.</p></div><br /><h2>Best Regards</h2><br />Procurement Department<br />[Cresta Solutions Limited]<br />Manchester, United Kingdom<h4 style='margin-bottom: 10px;'>Need Help?</h4><div style='color: #A5A5A5; font-size: 12px;'><p>If you have any questions you can simply reply to this email or find our contact information below. Also contact us at <a href='#' style='text-decoration: underline; color: #4B72FA;'>support@skymeta.world </a></p></div></div><div style='background-color: #9affe1; padding: 30px 0 0; text-align: center;'><div style='margin-bottom: 20px;'> <a href='#' style='display: inline-block;margin: 0px 10px;background: linear-gradient(to right, #3decb9, #96cebc); border-radius: 100%; padding: 6px;'> <img alt='twitter' src='http://" + DynamicDtls.WebSite2 + "/email-image/twitter1.png' style='width: 24px;'> </a> <a href='#' style='display: inline-block;margin: 0px 10px;background: linear-gradient(to right, #3decb9, #96cebc); border-radius: 100%; padding: 6px;'> <img alt='facebook' src='http://" + DynamicDtls.WebSite2 + "/email-image/facebook1.png' style='width: 24px;'> </a> <a href='#' style='display: inline-block;margin: 0px 10px;background: linear-gradient(to right, #3decb9, #96cebc); border-radius: 100%; padding: 6px;'> <img alt='linked' src='http://" + DynamicDtls.WebSite2 + "/email-image/linkedin1.png' style='width: 24px;'> </a> <a href='#' style='display: inline-block;margin: 0px 10px;background: linear-gradient(to right, #3decb9, #96cebc); border-radius: 100%; padding: 6px;'> <img alt='insta' src='http://" + DynamicDtls.WebSite2 + "/email-image/google1.png' style='width: 24px;'> </a> <a href='#' style='display: inline-block;margin: 0px 10px;background: linear-gradient(to right, #3decb9, #96cebc); border-radius: 100%; padding: 6px;'> <img alt='insta' src='http://" + DynamicDtls.WebSite2 + "/email-image/pinterest1.png' style='width: 24px;'> </a></div><div style='margin-bottom: 20px;'> <a href='#' style='text-decoration: underline; font-size: 14px; letter-spacing: 1px; margin: 0px 15px; color: #261D1D;'>Contact Us </a><div style='color: #A5A5A5; font-size: 12px; margin-bottom: 20px; padding: 0px 50px;'>You are receiving this email because you signed up for ... Admin. We use ... Admin to send our emails</div></div><div style='background-color: #11d296; padding: 0 0 30px; text-align: center;'><div style='margin-top: 0px; padding-top: 20px; border-top: 1px solid rgba(0,0,0,0.05);'><div style='color: #fff; font-size: 10px; margin-bottom: 5px;'>Company Number 09889864, Fernhills Business Centre Foerster Chambers, Todd Street, Bury, Gtr Manchester, United Kingdom, BL9 5BJ</div><div style='color: #fff; font-size: 10px;'>Copyright © 2015-2018 - <a href='#' style='text-decoration: underline; color: #6f8cf1;'> <b>Cresta Solutions Limited </b></a> All rights reserved.</div></div></div></div></div></div>";
                    //    this.SendEmailToUser(Email, "...: Your OTP password for ETH account update !", Message127);
                    //}
                    //else if (dtl == Convert.ToString(1))
                    //{
                    //    try
                    //    {
                    //        string Message123 =
                    //        @"<div style='background-color: #E6E4E4; padding: 20px; font-size:14px; line-height: 1.43; font-family:Helvetica Neue, Segoe UI, Helvetica, Arial, sans-serif;'><div style='max-width: 600px; margin: 10px auto 20px; font-size: 12px; color: #A5A5A5; text-align: center;'>If you are unable to see this message, <a href='#' style='color: #A5A5A5; text-decoration: underline;'>click here to view in browser </a></div><div style='max-width: 600px; margin: 0px auto; background-color: #fff; box-shadow: 0px 20px 50px rgba(0,0,0,0.05);'><table style=' width: 100%; background: #9AFFE1;'><tr><td style='background-color: #9AFFE1;'> <img alt='' src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/....-logo-1.svg' style='padding: 20px'></td></tr></table><div style='padding: 60px 70px; border-top: 1px solid rgba(0,0,0,0.05);'><div style='color: #636363; font-size: 14px;'><p>Hi, <strong>" + Mname.Trim() + " </strong><br /> <br />Your profile has been updated successfully on " + CURDT.Trim() + ". You are request to login your account for further details.<br/><br/><br/>Thanks for connecting with us.</p></div><br /><h2>Best Regards</h2><br />Procurement Department<br />[Cresta Solutions Limited]<br />Manchester, United Kingdom<h4 style='margin-bottom: 10px;'>Need Help?</h4><div style='color: #A5A5A5; font-size: 12px;'><p>If you have any questions you can simply reply to this email or find our contact information below. Also contact us at <a href='#' style='text-decoration: underline; color: #4B72FA;'>support@skymeta.world </a></p></div></div><div style='background-color: #9affe1; padding: 30px 0 0; text-align: center;'><div style='margin-bottom: 20px;'> <a href='#' style='display: inline-block;margin: 0px 10px;background: linear-gradient(to right, #3decb9, #96cebc); border-radius: 100%; padding: 6px;'> <img alt='twitter' src='http://" + DynamicDtls.WebSite2 + "/email-image/twitter1.png' style='width: 24px;'> </a> <a href='#' style='display: inline-block;margin: 0px 10px;background: linear-gradient(to right, #3decb9, #96cebc); border-radius: 100%; padding: 6px;'> <img alt='facebook' src='http://" + DynamicDtls.WebSite2 + "/email-image/facebook1.png' style='width: 24px;'> </a> <a href='#' style='display: inline-block;margin: 0px 10px;background: linear-gradient(to right, #3decb9, #96cebc); border-radius: 100%; padding: 6px;'> <img alt='linked' src='http://" + DynamicDtls.WebSite2 + "/email-image/linkedin1.png' style='width: 24px;'> </a> <a href='#' style='display: inline-block;margin: 0px 10px;background: linear-gradient(to right, #3decb9, #96cebc); border-radius: 100%; padding: 6px;'> <img alt='insta' src='http://" + DynamicDtls.WebSite2 + "/email-image/google1.png' style='width: 24px;'> </a> <a href='#' style='display: inline-block;margin: 0px 10px;background: linear-gradient(to right, #3decb9, #96cebc); border-radius: 100%; padding: 6px;'> <img alt='insta' src='http://" + DynamicDtls.WebSite2 + "/email-image/pinterest1.png' style='width: 24px;'> </a></div><div style='margin-bottom: 20px;'> <a href='#' style='text-decoration: underline; font-size: 14px; letter-spacing: 1px; margin: 0px 15px; color: #261D1D;'>Contact Us </a><div style='color: #A5A5A5; font-size: 12px; margin-bottom: 20px; padding: 0px 50px;'>You are receiving this email because you signed up for ... Admin. We use ... Admin to send our emails</div></div><div style='background-color: #11d296; padding: 0 0 30px; text-align: center;'><div style='margin-top: 0px; padding-top: 20px; border-top: 1px solid rgba(0,0,0,0.05);'><div style='color: #fff; font-size: 10px; margin-bottom: 5px;'>Company Number 09889864, Fernhills Business Centre Foerster Chambers, Todd Street, Bury, Gtr Manchester, United Kingdom, BL9 5BJ</div><div style='color: #fff; font-size: 10px;'>Copyright © 2015-2018 - <a href='#' style='text-decoration: underline; color: #6f8cf1;'> <b>Cresta Solutions Limited </b></a> All rights reserved.</div></div></div></div></div></div>";
                    //        this.SendEmailToUser(Email, "...– Your Profile recently updated", Message123);
                    //    }
                    //    catch { }
                    //}
                }
                else
                {
                    sc = false;
                    msg = " " + ds.Tables[0].Rows[0]["Msg"].ToString() + "";
                }

            }
            else
            {
                sc = false;
                msg = "Please fill correct required fields in form !";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = "Something went wrong. Sorry, we have let our engineers know. Try again!";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }
    public void SaveTRXInfo()
    {
        try
        {
            if (txtTronAddress != "")
            {
                ds = objgdb.ByProcedure("pro_Account_Setting_OTP", new string[] { "MemID", "BankName", "BranchName", "AccNo",
        "AccName","MicarCode","IFSC","pan","PerfectMoneyAccNM","PerfectMoneyAccNo","NetellerName","NetellerNo",
        "UPDATEBLOCK","Mname","gender","dob","Address","State","City","Distrinct","Pin", "Phone","Email", "Occupation","FName",
        "RelCode","Nominee","NomRel","Mobile" ,"Status","OtpUser"
        }, new string[] { UserID,"","","","","","","","","","",txtTronAddress.Trim(),"TRON DETAIL","","","","","","","","","","","","","","","","","", txtTrxOtp.ToString().Trim()
        }, "ds");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    sc = true;
                    msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                    Mname = ds.Tables[0].Rows[0]["MName"].ToString();
                    Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();

                    otpflag = ds.Tables[0].Rows[0]["otpflag"].ToString();
                    RtnRlt = ds.Tables[0].Rows[0]["Rslt"].ToString();
                    dtl = ds.Tables[0].Rows[0]["Rslt"].ToString();
                    if (RtnRlt == Convert.ToString(200))
                    {
                        string Message127 =
                        @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: transparent;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:block' target='_blank'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style=' padding: 15px 0 0;' border='0'> </a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='20'></td></tr><tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px; margin: 0px 20px'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <h3 style=' font-size:20px;margin: 0;'> <span style='color: #ee9d28; font-weight: bolder'>Dear,</span> " + Mname.Trim() + " {" + UserID + "}</h3><div style='height:20px'></div><p style='margin-bottom:15px;margin-top:15px'> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>The one time password (OTP) is</strong> <span style='display:block;font-weight:400'>" + otpflag + "</span> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>for update your Account.</strong> </p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td></tr><tr> <td align='left' valign='top'> <div style='margin:0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='20' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody> </table> </td><td width='15' style='display:none'></td></tr></tbody> </table> </div></td></tr></tbody> </table><table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr style='background-color: transparent;'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: #000000;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                        this.SendEmailToUser(Email, "Your OTP password for TRX account update !", Message127);
                    }
                    else if (dtl == Convert.ToString(1))
                    {
                        try
                        {
                            string Message123 =
                            //@"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: #009688;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:block' target='_blank'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style=' width: 200px; padding: 15px 0 0;' border='0'> </a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='50'></td></tr><tr> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='15'></td><td> <h1 style='font-size: 24px; font-weight: normal; text-align: center; line-height: 28px; margin-top: 0; margin-bottom: 15px'>Profile Updated</h1> </td><td width='15'></td></tr></tbody> </table> </td></tr><tr> <td height='20'></td></tr><tr> <td align='center'> <table style='font-size: 18px; text-align: center; color: #fff' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <table> <tbody> <tr> <td align='center' style='border-radius:50%' bgcolor='#0AAD2E' height='115' width='115'> <div style='text-align:center;max-width:570px;'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/check.png' alt='success' /> </div></td></tr></tbody> </table> </td></tr><tr> <td height='8'> <img src='' width='1' height='1' alt='' style='display:block'> </td></tr><tr> <td align='center'> <div style='text-align:center;height:8px;width:60px;background:#ebebeb;border-radius:50%'></div></td></tr><tr> <td height='25'> <img src='' alt='' width='1' height='1' style='display:block'> </td></tr></tbody> </table> </td></tr><tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px;max-width: 570px; margin: 0 auto'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <p style='margin:0;padding:0;font-weight:600;'>Hi,&nbsp;&nbsp;" + Mname.Trim() + "</p><div style='height:20px'></div><p style='margin:0;padding:0'><span style='color:red'>Warning!!!</span>&nbsp;&nbsp;Your Profile recently updated.</p><p style='margin-bottom:15px'> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>If it is not done by you</strong> <span style='display:block;font-weight:400'>Please login and Check your sensitive Transaction..</span> </p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td></tr><tr> <td align='left' valign='top'> <div style='margin:0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='30' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody></table> </td><td width='15'></td></tr></tbody> </table> </div></td></tr></tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr bgcolor='#009688'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td height='23'> <img src='' width='1' height='1' alt='' style='display: block;' /> </td></tr><tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'> <table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'> <table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'> <tbody> <tr> <td style='padding: 3px 0 6px; border-collapse: collapse' colspan='4' align='center' valign='top' width='100%'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 0; height: auto !important; outline: none; text-decoration: none' border='0'> </td></tr><tr> <td style='border-collapse:collapse' colspan='4' height='10' width='100%'></td></tr><tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: white;text-align: center'>Copyright &copy; 2024.&nbsp;All Rights Reserved. </font> </td></tr><tr> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'></td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr><tr> <td height='30'> <img src='' width='1' height='1' alt='' style='display: block;' /> </td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                            @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: #009688;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table><table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='50'></td></tr><tr> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='15'></td><td> <h1 style='font-size: 24px; font-weight: normal; text-align: center; line-height: 28px; margin-top: 0; margin-bottom: 15px'>Profile Updated</h1> </td><td width='15'></td></tr></tbody> </table> </td></tr><tr> <td height='20'></td></tr><tr> <td align='center'> <table style='font-size: 18px; text-align: center; color: #fff' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <table> <tbody> <tr> <td align='center' style='border-radius:50%' bgcolor='#0AAD2E' height='115' width='115'> <div style='text-align:center;max-width:570px;'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/check.png' alt='success'/> </div></td></tr></tbody> </table> </td></tr><tr> <td height='8'> <img src='' width='1' height='1' alt='' style='display:block'> </td></tr><tr> <td align='center'> <div style='text-align:center;height:8px;width:60px;background:#ebebeb;border-radius:50%'></div></td></tr><tr> <td height='25'> <img src='' alt='' width='1' height='1' style='display:block'> </td></tr></tbody> </table> </td></tr><tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px;max-width: 570px; margin: 0 auto'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <p style='margin:0;padding:0;font-weight:600;'>Dear,&nbsp;&nbsp;" + Mname.Trim() + "{" + UserID + "}</p><div style='height:20px'></div><p style='margin:0 0 15px 0;padding:0'>Your Wallet address updated successfully in profile section.</p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td></tr><tr> <td align='left' valign='top'> <div style='margin:0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='30' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody> </table> </td><td width='15'></td></tr></tbody> </table> </div></td></tr></tbody> </table><table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr bgcolor='#009688'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: white;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                            this.SendEmailToUser(Email, "Your TRON address in Profile Recently Updated ", Message123);
                        }
                        catch { }
                    }
                    if (RtnRlt == Convert.ToString(0))
                    {
                        sc = false;
                    }
                }
                else
                {
                    sc = false;
                    msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                }

            }
            else
            {
                sc = false;
                msg = "Please fill correct required fields in form !";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = ex.Message;
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }

    public void SaveBNBInfo()
    {
        try
        {
            if (txtBinanceAddress != "")
            {
                ds = objgdb.ByProcedure("pro_Account_Setting_OTP", new string[] { "MemID", "BankName", "BranchName", "AccNo",
        "AccName","MicarCode","IFSC","pan","PerfectMoneyAccNM","PerfectMoneyAccNo","NetellerName","NetellerNo",
        "UPDATEBLOCK","Mname","gender","dob","Address","State","City","Distrinct","Pin", "Phone","Email", "Occupation","FName",
        "RelCode","Nominee","NomRel","Mobile" ,"Status","OtpUser"
        }, new string[] { UserID,"","","","","","","","","","",txtBinanceAddress.Trim(),"Binance DETAIL","","","","","","","","","","","","","","","","","",txtBnbOtp.ToString().Trim()
        }, "ds");
                //if (ds.Tables[0].Rows.Count > 0)
                if (ds.Tables[0].Rows[0]["Rslt"].ToString() == "1")
                {
                    sc = true;
                    msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                    Mname = ds.Tables[0].Rows[0]["MName"].ToString();
                    Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();

                    otpflag = ds.Tables[0].Rows[0]["otpflag"].ToString();
                    RtnRlt = ds.Tables[0].Rows[0]["Rslt"].ToString();
                    dtl = ds.Tables[0].Rows[0]["Rslt"].ToString();

                    if (RtnRlt == Convert.ToString(200))
                    {

                        string Message127 =
                        @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: #009688;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:block' target='_blank'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style=' padding: 15px 0 0;' border='0'> </a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='50'></td></tr><tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px;max-width: 570px; margin: 0 auto'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <p style='margin:0;padding:0;font-weight:600;'>Dear,&nbsp;&nbsp;" + Mname.Trim() + "{" + UserID + "}</p><div style='height:20px'></div><p style='margin-bottom:15px;margin-top:15px'> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>The one time password (OTP) is</strong> <span style='display:block;font-weight:400'>" + otpflag + "</span> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>for update your Account.</strong> </p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td></tr><tr> <td align='left' valign='top'> <div style='margin:0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='30' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody> </table> </td><td width='15' style='display:none'></td></tr></tbody> </table> </div></td></tr></tbody> </table><table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr bgcolor='#009688'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: white;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                        this.SendEmailToUser(Email, " Your OTP password for Binance account update !", Message127);
                    }
                    else if (dtl == Convert.ToString(1))
                    {
                        try
                        {
                            string Message123 =
                            @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: #009688;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:block' target='_blank'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style=' padding: 15px 0 0;' border='0'> </a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='50'></td></tr><tr> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='15'></td><td> <h1 style='font-size: 24px; font-weight: normal; text-align: center; line-height: 28px; margin-top: 0; margin-bottom: 15px'>Profile Updated</h1> </td><td width='15'></td></tr></tbody> </table> </td></tr><tr> <td height='20'></td></tr><tr> <td align='center'> <table style='font-size: 18px; text-align: center; color: #fff' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <table> <tbody> <tr> <td align='center' style='border-radius:50%' bgcolor='#0AAD2E' height='115' width='115'> <div style='text-align:center;max-width:570px;'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/check.png' alt='success' /> </div></td></tr></tbody> </table> </td></tr><tr> <td height='8'> <img src='' width='1' height='1' alt='' style='display:block'> </td></tr><tr> <td align='center'> <div style='text-align:center;height:8px;width:60px;background:#ebebeb;border-radius:50%'></div></td></tr><tr> <td height='25'> <img src='' alt='' width='1' height='1' style='display:block'> </td></tr></tbody> </table> </td></tr><tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px;max-width: 570px; margin: 0 auto'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <p style='margin:0;padding:0;font-weight:600;'>Hi,&nbsp;&nbsp;" + Mname.Trim() + "</p><div style='height:20px'></div><p style='margin:0;padding:0'><span style='color:red'>Warning!!!</span>&nbsp;&nbsp;Your Profile recently updated.</p><p style='margin-bottom:15px'> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>If it is not done by you</strong> <span style='display:block;font-weight:400'>Please login and Check your sensitive Transaction..</span> </p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td></tr><tr> <td align='left' valign='top'> <div style='margin:0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='30' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody></table> </td><td width='15'></td></tr></tbody> </table> </div></td></tr></tbody> </table><table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr bgcolor='#009688'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: white;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                            this.SendEmailToUser(Email, " Your Binance address in Profile Recently Updated !", Message123);
                        }
                        catch { }
                    }
                }
                else
                {
                    sc = false;
                    msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                }

            }
            else
            {
                sc = false;
                msg = " Please fill correct required fields in form !";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = ex.Message;
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }






    private void UpdatePassword(string MemID, string PwdType, string OldLoginPWD, string NewLoginPWD, string MailTYpe)
    {

        try
        {
            ds = objgdb.ByProcedure("UpdateLoginPWD_New", new string[] { "MemID", "PwdType", "OldLoginPWD", "NewLoginPWD"
        }, new string[] { MemID, PwdType, OldLoginPWD, NewLoginPWD }, "ds");
            if (ds.Tables[0].Rows[0]["Rst"].ToString() == "1")
            {
                sc = true;
                msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                Mname = ds.Tables[0].Rows[0]["MName"].ToString();
                Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();

                CURDT = ds.Tables[0].Rows[0]["CURDT"].ToString();
                try
                {
                    string Message123 =
                    @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color:transparent;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table><table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='20'></td></tr>   <tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px; margin: 0px 20px'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <h3 style=' font-size:20px;margin: 0;'> <span style='color: #ee9d28; font-weight: bolder'>Dear,</span> " + Mname.Trim() + " {" + UserID + "}</h3><div style='height:20px'></div><p style='margin:0 0 15px 0;padding:0'>Your Password updated successfully in profile section.</p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td></tr><tr> <td align='left' valign='top'> <div style='margin:0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='30' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody> </table> </td><td width='15'></td></tr></tbody> </table> </div></td></tr></tbody> </table><table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr style='background-color:transparent;'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: #000000;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                    this.SendEmailToUser(Email, "Your password has been changed successfully ", Message123);
                }
                catch { }
            }
            else
            {
                sc = false;
                msg = ds.Tables[0].Rows[0]["Msg"].ToString();
            }

        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = "Something went wrong. Sorry, we have let our engineers know. Try again!";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }

    }



    public void SaveKYCInfo(string KYType)
    {
        try
        {
            if (KYType == "KYC")
            {

                if (txtFirstName != "" && txtEmailid != "")
                {
                    ds = objgdb.ByProcedure("pro_Account_Setting_OTP", new string[] { "MemID", "BankName", "BranchName", "AccNo",
        "AccName","MicarCode","IFSC","pan","PerfectMoneyAccNM","PerfectMoneyAccNo","NetellerName","NetellerNo",
        "UPDATEBLOCK","Mname","gender","dob","Address","State","City","Distrinct","Pin", "Phone","Email", "Occupation","FName",
        "RelCode","Nominee","NomRel","Mobile","Status","OtpUser"
        }, new string[] { UserID, FileNameDB, "", txtFirstName.Trim(), "", "", "", "", "", "", "", "", "KYC Data", "", "", "", "", "", "", "", "", "", "", "", "", "", txtEmailid.Trim(), "", "", "", "" }, "ds");



                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sc = true;
                        //msg = "<span style='color:#2E962E;'> " + ds.Tables[0].Rows[0]["Msg"].ToString() + "</span>";
                        msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                        /////////
                        Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();
                        Mname = ds.Tables[0].Rows[0]["MName"].ToString();
                        /////////
                        try
                        {

                        }
                        catch { }
                        /////////
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
                    //msg = "<span style='color:#FF8A00;'>Please fill required fields in transfer form !</span>";
                    msg = "Please fill required fields !";
                }
            }


            //
            //    if (KYType == "ADD")
            //    {

            //        if (txtFirstName != "" && txtEmailid != "") //&& txtEmailid != ""
            //        {
            //            ds = objgdb.ByProcedure("pro_Account_Setting_OTP", new string[] { "MemID", "BankName", "BranchName", "AccNo",
            //"AccName","MicarCode","IFSC","pan","PerfectMoneyAccNM","PerfectMoneyAccNo","NetellerName","NetellerNo",
            //"UPDATEBLOCK","Mname","gender","dob","Address","State","City","Distrinct","Pin", "Phone","Email", "Occupation","FName",
            //"RelCode","Nominee","NomRel","Mobile","Status","OtpUser"
            //}, new string[] { UserID, "", "", txtFirstName.Trim(), "", "", "", "", FileNameDB, "", "", "", "ADD Data", "", "", "", "", "", "", "", "", "", "", "", "", "", txtEmailid.Trim(), "", "", "", "" }, "ds");



            //            if (ds.Tables[0].Rows.Count > 0)
            //            {
            //                sc = true;
            //                //msg = "<span style='color:#2E962E;'> " + ds.Tables[0].Rows[0]["Msg"].ToString() + "</span>";
            //                msg = ds.Tables[0].Rows[0]["Msg"].ToString();
            //                /////////
            //                Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();
            //                Mname = ds.Tables[0].Rows[0]["MName"].ToString();
            //                /////////
            //                try
            //                {

            //                }
            //                catch { }
            //                /////////
            //            }
            //            else
            //            {
            //                sc = false;
            //                //msg = "<span style='color:#FF8A00;'> " + ds.Tables[0].Rows[0]["Msg"].ToString() + "</span>";
            //                msg = ds.Tables[0].Rows[0]["Msg"].ToString();
            //            }

            //        }
            //        else
            //        {
            //            sc = false;
            //            //msg = "<span style='color:#FF8A00;'>Please fill required fields in transfer form !</span>";
            //            msg = "Please fill required fields !";
            //        }
            //    }




            else if (KYType == "FaceId")
            {

                if (txtFirstName != "")
                {

                    ds = objgdb.ByProcedure("pro_Account_Setting_OTP", new string[] { "MemID", "BankName", "BranchName", "AccNo",
        "AccName","MicarCode","IFSC","pan","PerfectMoneyAccNM","PerfectMoneyAccNo","NetellerName","NetellerNo",
        "UPDATEBLOCK","Mname","gender","dob","Address","State","City","Distrinct","Pin", "Phone","Email", "Occupation","FName",
        "RelCode","Nominee","NomRel","Mobile","Status","OtpUser"
        }, new string[] { UserID,"","","","",txtFirstName.Trim(),"","",FileNameDB,"","","","FaceId Data","","","","",
            "","","","","","","","","","","","","",""
        }, "ds");


                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sc = true;
                        //msg = "<span style='color:#2E962E;'> " + ds.Tables[0].Rows[0]["Msg"].ToString() + "</span>";
                        msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                        /////////
                        Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();
                        Mname = ds.Tables[0].Rows[0]["MName"].ToString();
                        /////////
                        try
                        {

                        }
                        catch { }
                        /////////
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
                    //msg = "<span style='color:#FF8A00;'>Please fill required fields in transfer form !</span>";
                    msg = "Please fill required fields !";
                }
            }



            else
            {
                if (txtFirstName != "")
                {
                    ds = objgdb.ByProcedure("pro_Account_Setting_OTP", new string[] { "MemID", "BankName", "BranchName", "AccNo",
        "AccName","MicarCode","IFSC","pan","PerfectMoneyAccNM","PerfectMoneyAccNo","NetellerName","NetellerNo",
        "UPDATEBLOCK","Mname","gender","dob","Address","State","City","Distrinct","Pin", "Phone","Email", "Occupation","FName",
        "RelCode","Nominee","NomRel","Mobile","Status","OtpUser"
        }, new string[] { UserID,"","","","",txtFirstName.Trim(),"","",FileNameDB,"","","","ADD Data","","","","",
            "","","","","","","","","","","","","",""
        }, "ds");
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        sc = true;
                        //msg = "<span style='color:#2E962E;'> " + ds.Tables[0].Rows[0]["Msg"].ToString() + "</span>";
                        msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                        /////////
                        Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();
                        Mname = ds.Tables[0].Rows[0]["MName"].ToString();
                        /////////
                        try
                        {

                        }
                        catch { }
                        /////////
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
                    //msg = "<span style='color:#FF8A00;'>Please fill required fields in transfer form !</span>";
                    msg = "Please fill required fields !";
                }
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = "Something went wrong. Sorry, we have let our engineers know. Try again!";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }


    public static string GenerateRandomUsername()
    {
        string str = Path.GetRandomFileName(); //This method returns a random file name of 11 characters
        str = str.Replace(".", "");
        return str;
    }


    private void UploadProfileImg(string UType)
    {
        if (context.Request.Files.Count > 0)
        {
            HttpFileCollection files = context.Request.Files;
            for (int i = 0; i < files.Count; i++)
            {
                HttpPostedFile file = files[i];
                if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE" || HttpContext.Current.Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
                {
                    string[] testfiles = file.FileName.Split(new char[] { '\\' });
                    fname = testfiles[testfiles.Length - 1];
                }
                else
                {
                    fname = file.FileName;
                }
                chkfileEx = Path.GetExtension(fname).ToLower();
                if (chkfileEx.ToString().Trim() == ".jpg" || chkfileEx.ToString().Trim() == ".gif" ||
                  chkfileEx.ToString().Trim() == ".bmp" || chkfileEx.ToString().Trim() == ".jpeg" ||
                  chkfileEx.ToString().Trim() == ".png" || chkfileEx.ToString().Trim() == ".pdf")
                {
                    AcFileName = GenerateRandomUsername();
                    if (UType == "KYC")
                    {
                        SDbFilePath = "uploads/KYC/" + AcFileName + chkfileEx;
                        fname = Path.Combine(context.Server.MapPath("~/uploads/KYC/"), AcFileName + chkfileEx);
                        file.SaveAs(fname);
                        FileNameDB = AcFileName + chkfileEx;
                        SaveKYCInfo(UType);
                    }
                    else if (UType == "ADD")
                    {
                        SDbFilePath = "uploads/ADD/" + AcFileName + chkfileEx;
                        fname = Path.Combine(context.Server.MapPath("~/uploads/ADD/"), AcFileName + chkfileEx);
                        file.SaveAs(fname);
                        FileNameDB = AcFileName + chkfileEx;
                        SaveKYCInfo(UType);
                    }
                    else if (UType == "FaceId")
                    {
                        SDbFilePath = "uploads/ADD/" + AcFileName + chkfileEx;
                        fname = Path.Combine(context.Server.MapPath("~/uploads/FaceId/"), AcFileName + chkfileEx);
                        file.SaveAs(fname);
                        FileNameDB = AcFileName + chkfileEx;
                        SaveKYCInfo(UType);
                    }

                    else if (UType == "BANK")
                    {
                        SDbFilePath = "uploads/BANK/" + AcFileName + chkfileEx;
                        fname = Path.Combine(context.Server.MapPath("~/uploads/BANK/"), AcFileName + chkfileEx);
                        file.SaveAs(fname);
                        FileNameDB = AcFileName + chkfileEx;
                        // SaveBankInfo();
                        SaveBankProofInfo();
                    }

                }
                else
                {
                    msg = "Only GIF, JPEG, PNG, BMP & PDF files are allowed !";
                    sc = false;
                }
            }
            //////
        }
        else
        {
            msg = "Only GIF, JPEG, PNG, BMP & PDF files are allowed !";
            sc = false;
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
    private void FgsecPassword(string MemID, string PwdType, string OldLoginPWD, string NewLoginPWD, string MailTYpe)
    {

        try
        {
            ds = objgdb.ByProcedure("UpdateLoginPWD_New", new string[] { "MemID", "PwdType", "OldLoginPWD", "NewLoginPWD"}, new string[] { MemID, PwdType, "", "" }, "ds");
            if (ds.Tables[0].Rows.Count > 0)
            {
                sc = true;
                msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                Mname = ds.Tables[0].Rows[0]["MName"].ToString();
                Email = ds.Tables[0].Rows[0]["EMAIL"].ToString();
                //otpflag = ds.Tables[0].Rows[0]["otpflag"].ToString();
                //RtnRlt = ds.Tables[0].Rows[0]["Rst"].ToString();
                //dtl = ds.Tables[0].Rows[0]["Rst"].ToString();
                RecCode = ds.Tables[0].Rows[0]["RecCode"].ToString();
                dtl = "1";
                //if (RtnRlt == Convert.ToString(200))
                //{
                string Message127 =
                @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: #009688;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:block' target='_blank'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style=' padding: 15px 0 0;' border='0'> </a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='50'></td></tr><tr> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='15'></td><td> <h1 style='font-size: 24px; font-weight: normal; text-align: center; line-height: 28px; margin-top: 0; margin-bottom: 15px'>Reset transaction password</h1> </td><td width='15'></td></tr></tbody> </table> </td></tr><tr> <td height='20'></td></tr><tr> <td align='center'> <table style='font-size: 18px; text-align: center; color: #fff' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <table> <tbody> <tr> <td align='center' style='border-radius:50%' bgcolor='#0AAD2E' height='115' width='115'> <div style='text-align:center;max-width:570px;'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/check.png' alt='success' /> </div></td></tr></tbody> </table> </td></tr><tr> <td height='8'> <img src='' width='1' height='1' alt='' style='display:block'> </td></tr><tr> <td align='center'> <div style='text-align:center;height:8px;width:60px;background:#ebebeb;border-radius:50%'></div></td></tr><tr> <td height='25'> <img src='' alt='' width='1' height='1' style='display:block'> </td></tr></tbody> </table> </td></tr><tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px;max-width: 570px; margin: 0 auto'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <p style='margin:0;padding:0;font-weight:600;'>Hi,&nbsp;&nbsp;" + Mname + "</p><div style='height:20px'></div><p style='margin:0;padding:0'>We received a request to reset the transaction password for your account.</p><p style='margin: 0 0 30px 0; padding: 0'> If you requested a reset for &nbsp;<b>"+ Email +"</b> </p><p style='margin-top:0;margin-bottom:11px'> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>Please click the button below.</strong> </p><p style='margin-top:15px'> <a href='http://" + DynamicDtls.WebSite2 + "/Reset-Transaction-Password.html?token=" + RecCode + "' style='text-align: center; font-weight: 400; color: white; background-color: #e85038; padding: 10px 15px; text-decoration: none; '>Reset transaction password</a> </p><p style='margin-top:25px;margin-bottom:11px'> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px;color:red'><sup>*</sup>&nbsp;If you didn't make this request, please ignore this email.</strong> </p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td></tr><tr> <td align='left' valign='top'> <div style='margin:0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>"+ DynamicDtls.CompName +" Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='30' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody> </table> </td><td width='15'></td></tr></tbody> </table> </div></td></tr></tbody> </table><table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr bgcolor='#009688'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: white;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                this.SendEmailToUser(Email, "Reset your transaction password!", Message127);
                //}
                //else if (dtl == Convert.ToString(1) && Email != "")
                //{
                //    try
                //    {
                //        string Message123 =
                //        @"<div style='margin: 0;padding: 0;'><div style='width: 100%;height: 100%;background-color:#fafafa ;'><div style='margin:0 auto; width:600px; height:100%; font-family:verdana;'><div style='background-color: #1d1d1d; padding: 15px 0 10px;'> <img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo-Black.png?v=1.1' alt='logo' style=' margin-left: 10px; height: auto; width: auto; ' /> <span style='float: right; margin-top: 15px; color: #fff;'><strong style='padding-right: 10px;font-size: 15px;margin-top: 6px;'>For 24/7 support </strong><br /><span style='margin-top: -20px;text-align: right;font-family: sans-serif;font-size: 14px;'>" + DynamicDtls.Email + "</span></span></div><div style=' width: 100%; background-color: white; border-top: 3px solid #f1951c; padding: 20px 0 25px; '><h3 style=' font-size:29px;margin: 0; text-align: center; '> <span style='color: #ed224e; font-weight: bolder'>Hi,</span> " + Mname.Trim() + "</h3><p style=' text-align: center; font-size: 17px;margin: 5px;font-family: sans-serif;'>Your Password has been changed successfully.</p><p style=' text-align: center;font-size: 17px;margin: 5px;font-family: sans-serif;'>If it is not done by you, Please login and Check your sensitive Transaction.. !</p></div><div style=' background-color: #ed224e; width: 100%; padding: 5px 0 5px; text-align: left; '><p style='font-family:Verdana;font-size: 15px; color:#fff; margin-left:22px;'> Thanks & Regards <br /> Support Team " + DynamicDtls.CompName + " <br> <small style='font-size:11px;'> Please do not reply to this email. Email send to this address will not be answered. </small></p></div></div><div style='display:none;background-color: #E9E9E9; margin-top: -12px;padding: 5px;width: 592px;margin: 0px auto;'><div style='margin:0 auto; width:600px; height:100%; font-family:verdana; text-align:center;'><div><p style=' color: gray; font-size: 12px; padding-top: 10px; '> Please do not reply to this email. Email send to this address will not be answered.</p></div></div></div></div></div>";
                //        this.SendEmailToUser(Email, "Your Password changed Successfully !", Message123);
                //    }
                //    catch { }
                //}
                //else
                //{
                //    sc = true;
                //    msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                //}

            }
            else
            {
                sc = false;
                msg = " " + ds.Tables[0].Rows[0]["Msg"].ToString() + " ";
            }

        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = ex.Message;
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
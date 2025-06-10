<%@ WebHandler Language="C#" Class="DWallet_Amt_Request" %>
using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Net.Mail;
using System.IO;
using System.Data;
using System.Web.SessionState;
public class DWallet_Amt_Request : IHttpHandler {

    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    bool sc;
    string msg, Msgs, dtl, RtnRlt, strJson;
    string MName, Email, ReType = "", UserID = "",SeqPwd= "",
        ReqAmt = "", txtBTCAddress = "", ChooseTxnMode = "", txtTxnHas = "", PayMode = "", PlnAmt = "", ReqDate = "",Deptype="",PayBy="",
        fname, chkfileEx, SDbFilePath = "", amoumt = "", AcFileName, FileNameDB, RType = "", paidonbankamt = "";
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds; DataTable dt;
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
        if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        {
            UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();

            if (context.Request.QueryString["Save"].ToString() == "BTCInfo")
            {
                txtBTCAddress = context.Request["txtBTCAddress"].Trim();
                txtTxnHas = context.Request["txtTxnHas"].Trim();
                ReqAmt = context.Request["txtReqAmt"].Trim();
                PlnAmt = context.Request["PlnAmt"].Trim();
                ReqDate = context.Request["ReqDate"].Trim();
                ReType = "SubmitWR";
                RType = context.Request["PayType"].Trim();
                Deptype = context.Request["Deptype"].Trim();
                SeqPwd = context.Request["SeqPwd"].Trim();
                /////////                                
                //if (context.Request.Files.Count > 0)
                //{
                //    UploadProfileImg("BTC");
                //}
                //else
                //{
                //    SaveBankFundReq();
                //}
                SaveBankFundReq();

            }
            else if (context.Request.QueryString["Save"].ToString() == "ETHInfo")
            {
                txtBTCAddress = context.Request["txtBTCAddress"].Trim();
                txtTxnHas = context.Request["txtTxnHas"].Trim();
                ReqAmt = context.Request["txtReqAmt"].Trim();
                PlnAmt = context.Request["PlnAmt"].Trim();
                ReqDate = context.Request["ReqDate"].Trim();
                ReType = "SubmitETH";
                /////////                                
                //if (context.Request.Files.Count > 0)
                //{
                //    UploadProfileImg("ETH");
                //}
                //else
                //{
                //    SaveBankFundReq();
                //}
                SaveBankFundReq();

            }
            else
            {
                //txtBTCAddress = context.Request["paidonbankamt"].Trim();
                txtBTCAddress = context.Request["txtBTCAddress"].Trim();
                ChooseTxnMode = context.Request["ChooseTxnMode"].Trim();
                txtTxnHas = context.Request["txtTxnHas"].Trim();
                ReqAmt = context.Request["txtReqAmt"].Trim();
                PlnAmt = context.Request["PlnAmt"].Trim();
                ReqDate = context.Request["ReqDate"].Trim();
                //paidonbankamt = context.Request["paidonbankamt"].Trim();////
                PayMode = context.Request["paymode"].Trim();
                //PayBy = context.Request["PayBy"].Trim();
                if (PayMode == "By Bank")
                {
                    ReType = "SubmitBA";
                    if (context.Request.Files.Count > 0)
                    {
                        UploadProfileImg("ACC");
                    }
                    else
                    {
                        SaveBankFundReq();
                    }
                }
                if (PayMode == "PAYTM")
                {
                    ReType = "SubmitWRPAY";
                    if (context.Request.Files.Count > 0)
                    {
                        UploadProfileImg("PAY");
                    }
                    else
                    {
                        SaveBankFundReq();
                    }
                }
                if (PayMode == "UPI")
                {
                    ReType = "SubmitWRUPI";
                    if (context.Request.Files.Count > 0)
                    {
                        UploadProfileImg("UPI");
                    }
                    else
                    {
                        SaveBankFundReq();
                    }
                }
            }
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


    public static string GenerateRandomUsername()
    {
        string str = Path.GetRandomFileName(); //This method returns a random file name of 11 characters
        str = str.Replace(".", "");
        return str;
    }
    private void UploadProfileImg(string Ttype)
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

                    if (Ttype == "ACC")
                    {
                        SDbFilePath = "Receipt/ACC/" + AcFileName + chkfileEx;
                        fname = Path.Combine(context.Server.MapPath("~/Receipt/ACC/"), AcFileName + chkfileEx);
                        file.SaveAs(fname);
                        FileNameDB = AcFileName + chkfileEx;
                        SaveBankFundReq();
                    }
                    if (Ttype == "BTC")
                    {
                        SDbFilePath = "Receipt/BTC/" + AcFileName + chkfileEx;
                        fname = Path.Combine(context.Server.MapPath("~/Receipt/BTC/"), AcFileName + chkfileEx);
                        file.SaveAs(fname);
                        FileNameDB = AcFileName + chkfileEx;
                        SaveBankFundReq();
                    }
                    if (Ttype == "ETH")
                    {
                        SDbFilePath = "Receipt/ETH/" + AcFileName + chkfileEx;
                        fname = Path.Combine(context.Server.MapPath("~/Receipt/ETH/"), AcFileName + chkfileEx);
                        file.SaveAs(fname);
                        FileNameDB = AcFileName + chkfileEx;
                        SaveBankFundReq();
                    }
                    if (Ttype == "PAY")
                    {
                        SDbFilePath = "Receipt/PAY/" + AcFileName + chkfileEx;
                        fname = Path.Combine(context.Server.MapPath("~/Receipt/PAY/"), AcFileName + chkfileEx);
                        file.SaveAs(fname);
                        FileNameDB = AcFileName + chkfileEx;
                        SaveBankFundReq();
                    }
                    if (Ttype == "UPI")
                    {
                        SDbFilePath = "Receipt/UPI/" + AcFileName + chkfileEx;
                        fname = Path.Combine(context.Server.MapPath("~/Receipt/UPI/"), AcFileName + chkfileEx);
                        file.SaveAs(fname);
                        FileNameDB = AcFileName + chkfileEx;
                        SaveBankFundReq();
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


    public void GiveHelpOrder()
    {
        try
        {
            if (txtTxnHas != "" && txtBTCAddress != "" && ReqAmt != "")
            {
                ds = objgdb.ByProcedure("[DWallet_InsertPaymentReq]", new string[] { "MemID", "TxnHas", "SenderBTC", "Amount", "Type", "PlnAmt" }
                            , new string[] { UserID, txtTxnHas.Trim(), txtBTCAddress.Trim(), ReqAmt.Trim(), ReType, PlnAmt }, "das");

                if (ds.Tables[0].Rows[0]["Rlt"].ToString() == "IsOk")
                {
                    sc = true;
                    msg = "<span style='color:#2E962E;'> " + ds.Tables[0].Rows[0]["Msg"].ToString() + "</span>";

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
                msg = "Please fill required fields !";
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


    public void SaveBankFundReq()
    {
        try
        {
            //if (FileNameDB != null )
            //{
            if (txtTxnHas != "" && txtBTCAddress != "" && ReqAmt != "" && PlnAmt != "" && ChooseTxnMode != "")
            {

                ds = objgdb.ByProcedure("[DWallet_InsertPaymentReq]", new string[] { "MemID", "TxnHas", "SenderBTC", "Amount", "Type", "PlnAmt", "Date", "RecPath", "PaymentBy", "TxnType" }
                        , new string[] { UserID, txtTxnHas.Trim(), txtBTCAddress.Trim(), ReqAmt.Trim(), ReType.Trim(), PlnAmt.Trim(), ReqDate.ToString().Trim(), FileNameDB.Trim(), PayMode.Trim(), ChooseTxnMode.Trim() }, "das");

                if (ds.Tables[0].Rows[0]["Rlt"].ToString() == "IsOk")
                {
                    sc = true;
                    msg = " " + ds.Tables[0].Rows[0]["Msg"].ToString() + "";

                    MName = ds.Tables[0].Rows[0]["MName"].ToString();
                    Email = ds.Tables[0].Rows[0]["Mem_Email"].ToString();
                    amoumt = ds.Tables[0].Rows[0]["amoumt"].ToString();

                    if (Deptype == "Fund Request")
                    {
                        string Message1235 =
                      @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: transparent;'> <tbody> <tr> <td style='padding-bottom:11px; text-align:center;'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='20'></td></tr>   <tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px; margin: 0px 20px'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <h3 style=' font-size:20px;margin: 0;'> <span style='color: #ee9d28; font-weight: bolder'>Dear,</span> " + MName.Trim() + " {" + UserID + "}</h3><div style='height:20px'></div><p style='margin:0;padding:0'>Congratulations !!!</p><p style='margin-bottom:15px;margin-top:30px'> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>Your Fund Request Amount of</strong> <span style='display:block;font-weight:400'>"+ amoumt.Trim() +"</span> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>has been submitted successfully.</strong> </p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td align='left' valign='top'> <div style='margin:10px 0 0 0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>"+ DynamicDtls.CompName +" Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr> </tbody> </table> </td><td width='15'></td></tr></tbody> </table> </div></td></tr></tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr style='background-color:transparent;'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody>  <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'> <table border='0' cellspacing='0' cellpadding='0' style='float: right;width: 100%'> <tbody> <tr> <td height='40px'> <table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'> <tbody>  <tr> <td style='border-collapse:collapse' colspan='4' height='10' width='100%'></td></tr><tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='color: #000000; font-size: 13px'> Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr><tr> <td style='border-collapse:collapse' colspan='4' height='10' width='100%'></td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr> </tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                        this.SendEmailToUser(Email, "Fund Request Submitted  !", Message1235);
                        string VerifyAcc = objgdb.GetCredentialAPI(UserID.Trim(), float.Parse(amoumt.Trim()), MName.ToString().Trim(), "ProvideHlpText", "ProvideHlpText");
                        new SendSms().SendSMSToUserIDMob(VerifyAcc, UserID.Trim());
                    }
                    else
                    {
                        string Message1234 =
                       @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody>  <tr> <td width='100%'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: transparent;'> <tbody> <tr> <td style='padding-bottom:11px; text-align:center;'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='20'></td></tr><tr> <td> <div style='text-align: left; line-height: 26px;font-size: 16px; margin: 0px 20px'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td><td> <div> <h3 style=' font-size:20px;margin: 0;'> <span style='color: #ee9d28; font-weight: bolder'>Dear,</span> " + MName.Trim() + " {" + UserID + "}</h3><div style='height:20px'></div><p style='margin:0;padding:0'>Congratulations !!!</p><p style='margin-bottom:15px;margin-top:30px'> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>Your Fund Request Amount of</strong> <span style='display:block;font-weight:400'>"+ amoumt.Trim() +"</span> <strong style='font-size: 12px;font-weight:400;display: block;line-height:18px'>has been submitted successfully.</strong> </p></div><table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td></tr><tr> <td align='left' valign='top'> <div style='margin:10px 0 0 0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>"+ DynamicDtls.CompName +" Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr></tbody> </table> </div></td></tr><tr> <td height='10' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td></tr></tbody> </table> </td><td width='15'></td></tr></tbody> </table> </div></td></tr></tbody> </table> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr style='background-color:transparent;'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td height='10'> <img src='' width='1' height='1' alt='' style='display: block;' /> </td></tr><tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'> <table border='0' cellspacing='0' cellpadding='0' style='float: right;width: 100%'> <tbody> <tr> <td height='40px'> <table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'> <tbody>  <tr> <td style='border-collapse:collapse' colspan='4' height='10' width='100%'></td></tr><tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='color: #000000; font-size: 13px'> Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr><tr> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'></td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr> </tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                        this.SendEmailToUser(Email, "Invest Request Submitted  !", Message1234);

                        string VerifyAcc = objgdb.GetCredentialAPI(UserID.Trim(), float.Parse(amoumt.Trim()), MName.ToString().Trim(), "ProvideHlpText", "ProvideHlpText");
                        new SendSms().SendSMSToUserIDMob(VerifyAcc, UserID.Trim());
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
                msg = "Please fill required fields !";
            }
            //}
            //else
            //{
            //    sc = false;
            //    msg = "<span style='color:#FF8A00;'>Please upload bank reciept !</span>";
            //}

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
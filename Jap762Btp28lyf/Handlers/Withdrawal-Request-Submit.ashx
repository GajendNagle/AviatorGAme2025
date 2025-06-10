<%@ WebHandler Language="C#" Class="Withdrawal_Request_Submit" %>
using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Net.Mail;
using System.IO;
using System.Data;
using System.Web.SessionState;

public class Withdrawal_Request_Submit : IHttpHandler
{
    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc;
    static string msg, Msgs, dtl, RtnRlt, strJson, amount = "", ReqCurrcy = "", AutoWithNo = "", eMailAddss = "", TRXadd = "", txtOtp = "", otpflag = "";
    string UserID = "", txtTopUpAmount = "", txtSecPwd = "", PaymentMd = "", PaymentMd1 = "", txtDwallet = "", txtSrwallet = "", dateToday = "", dayToday = "",
       Emrgn = "", Accno = "", StopWithdrawDapp = "", txtProfit = "", txtBonus = "", txtRSCval = "", CURDT = "", txtEARval = "", txtCCval = "", Mem_email = "", MName = "", txtProfitSharing = "", txtTeamProfitSharing = "", txtRank = "", WithDrawalRights = "";
    public Double TotWW = 0.00;
    DynamicDtls objgdb = new DynamicDtls();
    TransactionWalletAddress txnWltads = new TransactionWalletAddress();
    DataSet ds;

    //libCoinPaymentsNET.CoinPayments cp = new libCoinPaymentsNET.CoinPayments("005bB5C72daebc8F11520c72d48c9a3D02364487CFDe313d3300be43a42Df4ed", "8ef4b20a6af3e15b5cc5a2fc624485914baa67b87ecda38e1ff359e3535c4a2b"); //private key,public key
    public class test
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public string detail { get; set; }
        public string aid { get; set; }
        public string ReqAmt { get; set; }
        public string Emenpjd { get; set; }
        public string StopWithdrawDapp1 { get; set; }
        public string Accountno { get; set; }
        public test(bool sc, string msg, string dtl, string aaid, string Amt, string emgk, string StopWithdrawDapp, string Accno)
        {
            Success = sc;
            Message = msg;
            detail = dtl;
            ReqAmt = Amt;
            aid = aaid;
            Emenpjd = emgk;
            StopWithdrawDapp1 = StopWithdrawDapp;
            Accountno = Accno;
        }
    }

    public void handleRequest()
    {
        writeJson(new test(sc, msg, dtl, AutoWithNo, amount, Emrgn, StopWithdrawDapp, Accno));
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
            PaymentMd1 = context.Request["PaymentMd"].Trim();

            if (PaymentMd1 == "Withdrawal")
            {
                txtTopUpAmount = context.Request["txtTopUpAmount"].Trim();
                txtSecPwd = context.Request["txtSecPwd"].Trim();
                PaymentMd = context.Request["TxnMode"].Trim();
                //  txtBonus = context.Request["txtBonus"].Trim();
                txtProfitSharing = context.Request["txtTopUpAmount"].Trim();//context.Request["txtProfitSharing"].Trim(); ///profit sharing
                txtTeamProfitSharing = "0";// context.Request["txtTeamProfitSharing"].Trim(); ///level income
                txtRank = "0";//context.Request["txtRank"].Trim();
                txtSrwallet = "0";// context.Request["txtSrwallet"].Trim(); ////Global Pool Bonus
                txtDwallet = "0";// context.Request["txtAmazing"].Trim(); /// board Income
                TRXadd = context.Request["TRXadd"].Trim();
                txtOtp = context.Request["txtOtp"].Trim();

                //txtRSCval = context.Request["txtRSCval"].Trim();
                //txtEARval = context.Request["txtEARval"].Trim();
                //txtCCval = context.Request["txtCCval"].Trim();
                ///////// 
                //DateTime date = DateTime.Now;
                //dateToday = " " + date.ToString("d");
                //DayOfWeek day = DateTime.Now.DayOfWeek;
                //dayToday = " " + day.ToString();
                GiveHelpOrder();
            }
            else if (PaymentMd1 == "UpdateTxnSts")
            {
                TRXadd = context.Request["Txnid"].Trim();
                AutoWithNo = context.Request["WithdID"].Trim();
                BindResultUpdt(AutoWithNo, TRXadd, "PENDING", "");
            }
            else if (PaymentMd1 == "UnWithdrawal")
            {
                AutoWithNo = context.Request["WithdID"].Trim();
                RejectRequest(AutoWithNo);
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
    public void GiveHelpOrder()
    {
        try
        {
            if (txtTopUpAmount != "" && txtSecPwd != "" && PaymentMd != "")
            {
                ds = objgdb.ByProcedure("[ProcWithFromUser_FmUP_New]", new string[] { "Memid", "Amt", "WtihdType", "DlyWlt", "LvlWlt", "ORbitWlt", "RecpWlt", "AddOnWlt", "RoyaltyWlt", "Pm", "OtpUser" }
                                    , new string[] { UserID, txtTopUpAmount.Trim(), txtSecPwd.Trim(), txtProfitSharing.Trim(), txtTeamProfitSharing.Trim(), "", "", txtDwallet.Trim(), txtSrwallet.Trim(), PaymentMd.Trim(), txtOtp.Trim() }, "das");


                if (ds.Tables[0].Rows[0]["Rlt"].ToString() == "IsOk")
                {
                    sc = true;
                    msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                    //msg = "<span style='color:#2E962E;'>" + ds.Tables[0].Rows[0]["Msg"].ToString() + "</span>";
                    /////////
                    Mem_email = ds.Tables[0].Rows[0]["Mem_email"].ToString();
                    MName = ds.Tables[0].Rows[0]["MName"].ToString();
                    otpflag = ds.Tables[0].Rows[0]["otpflag"].ToString();
                    dtl = ds.Tables[0].Rows[0]["Rslt"].ToString();
                    //try
                    //{
                    if (dtl == Convert.ToString(200))
                    {
                        string Message123 =
                        //"For 24/7 support" + DynamicDtls.Email + "<br/><br/>Hi, <br/>" + MName + " <br/> <br/>The one time password (OTP) is " + otpflag + " for Withdrawal Request.If it is not done by you, Please login and Check your sensitive Transaction.. ! <br/><br/>Thanks & Regards <br/><br/> Support Team " + DynamicDtls.CompName + "<br/><br/>Please do not reply to this email. Email send to this address will not be answered.";
                        @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: transparent'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='20'></td> </tr> <tr> <td> <table border='0' cellspacing='0' cellpadding='0' style='margin:0px 20px;'> <tbody> <tr> <td> <h3 style=' font-size:20px;margin: 0;'> <span style='color: #ee9d28; font-weight: bolder'>Dear,</span> " + MName.Trim() + " {" + UserID + "}</h3> <br> <p style='  font-size: 17px;margin: 5px 0px;font-family: sans-serif;'>The one time password (OTP) is <strong>" + otpflag + "</strong> for Withdrawal Request.</p> <p style=' font-size: 17px;margin: 5px 0px;font-family: sans-serif;'> If it is not done by you, Please login and Check your sensitive Transaction.. ! </p> <br> </td> </tr> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr> </tbody> </table> </td>  </tr>  <tr> </tbody> </table><table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr style='background-color: transparent'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: #000000;text-align: center'>Copyright &copy; "+ DynamicDtls.CopyWriteYear +".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";

                        this.SendEmailToUser(Mem_email, "Your otp password for Withdrawal Request", Message123);
         
                    }
                    else if (dtl == Convert.ToString(1))
                    {
                        WithDrawalRights = ds.Tables[0].Rows[0]["WithDrawalRights"].ToString();
                        if (WithDrawalRights == "De-Active")
                        {
                            //Emrgn = txnWltads.getAddress();

                            //context.Response.Cookies["Kdjlwl85soQwk84d"].Value = txnWltads.IssueAddress();
                            //context.Response.Cookies["Kdjlwl85soQwk84d"].Expires = DateTime.Now.AddDays(1);
                            //context.Response.Cookies["Kdjlwl85soQwk84d"].Secure = true;
                            //amount = ds.Tables[0].Rows[0]["Amt"].ToString();
                            //ReqCurrcy = ds.Tables[0].Rows[0]["Pm"].ToString();
                            //Accno = ds.Tables[0].Rows[0]["PaymentAddress"].ToString();
                            //AutoWithNo = ds.Tables[0].Rows[0]["AutoWithNo"].ToString();
                            //eMailAddss = UserID;
                            StopWithdrawDapp = ds.Tables[0].Rows[0]["StopWithdrawDapp"].ToString();
                        }

                        /////////
                        //context.Response.Write(new PaymentGetwayPayout().TransferDlyPayout(mobile_number, amount, beneficiary_name, account_number, ifsc, channel_id, client_id, provider_id));
                    }
                    else
                    {
                        sc = false;
                        //msg = "<div class='alert alert-danger alert-bordered fade in' style='margin:5px;'>" + ds.Tables[0].Rows[0]["Msg"].ToString() + "<span class='close' data-dismiss='alert'>&times;</span></div>";
                        msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                    }

                }
                else
                {
                    sc = false;
                    //msg = "<div class='alert alert-danger alert-bordered fade in' style='margin:5px;'>" + ds.Tables[0].Rows[0]["Msg"].ToString() + "<span class='close' data-dismiss='alert'>&times;</span></div>";
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
            //msg = "<div class='alert alert-danger alert-bordered fade in' style='margin:5px;'>Sorry, Something is wrong please try later !<span class='close' data-dismiss='alert'>&times;</span></div>"; 
            msg = "Something went wrong. Sorry, we have let our engineers know. Try again!";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }
    private void BindResultUpdt(string AutoWithNo, string TxnID, string Status, string currency2Amt)
    {
        try   //Withdrawal_req_status
        {


            //  ds = objgdb.ByProcedure("[PROC_RESPONSE_WITHDRAWAL_REQ]", new string[] { "Req_ID", "memid", "transdt", "UplodeFile", "status", "TransId", "Type", "txtRemarkp", "inctype", "Mobile", "Benfcid" },
            //    new string[] { wid.ToString(), UserID.ToString(), gettime.ToString(), "IMPS", getStatus.ToString(), gettxid.ToString(), "COMPLETE_AGAIN", getdesc.ToString(), "", getmobileno.ToString(), getbeneficiaryid.ToString() }, "");

            ds = objgdb.ByProcedure("[PROC_RESPONSE_WITHDRAWAL_REQ]", new string[] { "Req_ID", "memid", "transdt", "UplodeFile", "status", "TransId", "Type", "txtRemarkp", "inctype" },
               new string[] { AutoWithNo.ToString(), UserID.ToString(), "", "", Status.ToString(), TxnID.ToString(), "COMPLETE_AGAIN", currency2Amt.ToString(), "" }, "");


            if (ds.Tables[0].Rows.Count > 0)
            {
                msg = ds.Tables[0].Rows[0]["MSG"].ToString();
                // context.Response.Write("## Payout Sent Details ## PayoutID:" + PayoutIDs + ", Account-No: " + account_number + ", Status: " + PGStatus + ", Msg: " + PGMessage + ", Amount: " + amount);
                //Console.WriteLine(string.Concat("Hi ", data.FirstName, " " + data.LastName)); 
                ///{"status":2,"status_id":2,"utr":"","report_id":2124545,"orderid":"","message":"FAILURE"}
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            context.Response.Write(ex.Message);
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }
    private void RejectRequest(string AutoWithNo)
    {
        try   //Withdrawal_req_status
        {


            //  ds = objgdb.ByProcedure("[PROC_RESPONSE_WITHDRAWAL_REQ]", new string[] { "Req_ID", "memid", "transdt", "UplodeFile", "status", "TransId", "Type", "txtRemarkp", "inctype", "Mobile", "Benfcid" },
            //    new string[] { wid.ToString(), UserID.ToString(), gettime.ToString(), "IMPS", getStatus.ToString(), gettxid.ToString(), "COMPLETE_AGAIN", getdesc.ToString(), "", getmobileno.ToString(), getbeneficiaryid.ToString() }, "");

            ds = objgdb.ByProcedure("[PROC_RESPONSE_WITHDRAWAL_REQ]", new string[] { "Req_ID", "memid", "transdt", "UplodeFile", "status", "TransId", "Type", "txtRemarkp", "inctype" },
               new string[] { AutoWithNo.ToString(), UserID.ToString(), "", "", "", "", "REJECT_REQUEST", "", "" }, "");


            if (ds.Tables[0].Rows.Count > 0)
            {
                msg = ds.Tables[0].Rows[0]["MSG"].ToString();
                // context.Response.Write("## Payout Sent Details ## PayoutID:" + PayoutIDs + ", Account-No: " + account_number + ", Status: " + PGStatus + ", Msg: " + PGMessage + ", Amount: " + amount);
                //Console.WriteLine(string.Concat("Hi ", data.FirstName, " " + data.LastName)); 
                ///{"status":2,"status_id":2,"utr":"","report_id":2124545,"orderid":"","message":"FAILURE"}
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            context.Response.Write(ex.Message);
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
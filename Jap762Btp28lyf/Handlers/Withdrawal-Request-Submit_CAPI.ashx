<%@ WebHandler Language="C#" Class="Withdrawal_Request_Submit_CAPI" %>

using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Net.Mail;
using System.IO;
using System.Data;
using System.Web.SessionState;
using System.Web.UI.WebControls;
using Nethereum.Web3;
using Nethereum.Web3.Accounts;
using Nethereum.Hex.HexTypes;
using Nethereum.Util;
using System.Numerics;
using Nethereum.ABI.FunctionEncoding.Attributes;
using Nethereum.Contracts;

public class Withdrawal_Request_Submit_CAPI : IHttpHandler
{

    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc;
    public static string msg, Msgs, dtl, dtls1, RtnRlt, error = "", amount = "", result = "", AutoWithNo = "", strJson,
            UserID = "", getStatus = "", ReqCurrcy = "", eMailAddss = "", txtTopUpAmount = "", Pm = "", txtSecPwd = "",
            PaymentMd = "", txtRsbs = "", txtLBbs = "", txtOBValbs = "", txtRCBbs = "", TRXadd = "", txtAOBbs = "",
            Mem_email = "", MName = "", txtMABbs = "", txtLVLbs = "", txtGPIbs = "", Emrgn = "", Emrgn2 = "",
            Widtype = "", WidAmt = "", abi = "", myAdressNo = "", contract_address = "", fromaddress = "", txtOtp = "",
            otpflag = "", paymentAddress = "", Id = "", AutoWith = "", netAmount = "", ChkStpWthAuto = "", txnHash1 = "";
    public Double TotWW = 0.00;
    DynamicDtls objgdb = new DynamicDtls();
    TransactionWalletAddress txnWltads = new TransactionWalletAddress();
    DataSet ds;

    public class test
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public string detail { get; set; }
        public string details1 { get; set; }
        public string aid { get; set; }
        public string ReqAmt { get; set; }
        public string Emenpjd { get; set; }
        public string Emenpjd2 { get; set; }
        public string ChkStpWthAuto { get; set; }
        public test(bool sc, string msg, string dtl, string dtls1, string aaid, string Amt, string emgk, string emgk2, string ChkWthAuto)
        {
            Success = sc;
            Message = msg;
            detail = dtl;
            details1 = dtls1;
            ReqAmt = Amt;
            aid = aaid;
            Emenpjd = emgk;
            Emenpjd2 = emgk2;
            ChkStpWthAuto = ChkWthAuto;
        }
    }

    public void handleRequest()
    {
        writeJson(new test(sc, msg, dtl, dtls1, AutoWithNo, amount, Emrgn, txnHash1, ChkStpWthAuto));
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
            UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value);
            PaymentMd = context.Request["PaymentMd"].Trim();
            Pm = context.Request["memid"].Trim();
            Widtype = context.Request["wtype"].Trim();
            txtSecPwd = context.Request["txtSecPwd"].Trim();
            txtOtp = context.Request["txtOtp"].Trim();

            if (PaymentMd == "Withdrawal")
            {
                WidAmt = context.Request["Amount"].Trim();
                GiveHelpOrder();
            }
            else if (PaymentMd == "UpdateTxnSts")
            {
                TRXadd = context.Request["Txnid"].Trim();
                AutoWithNo = context.Request["WithdID"].Trim();
                BindResultUpdt(AutoWithNo, TRXadd, "PENDING", "");
            }
            else if (PaymentMd == "UnWithdrawal")
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
            ds = objgdb.ByProcedure("[ProcWithFromUser_FmUP_New]", new string[] { "Memid", "Amt", "WtihdType", "DlyWlt", "LvlWlt", "ORbitWlt", "RecpWlt", "AddOnWlt", "RoyaltyWlt", "Pm", "OtpUser" }
                            , new string[] { UserID, WidAmt.ToString().Trim(), txtSecPwd.Trim(), WidAmt.ToString().Trim(), "", "", "", "", "", Pm, txtOtp.Trim() }, "das");

            if (ds.Tables[0].Rows[0]["Rlt"].ToString() == "IsOk")
            {
                sc = true;
                msg = ds.Tables[0].Rows[0]["Msg"].ToString();
                Mem_email = ds.Tables[0].Rows[0]["Mem_email"].ToString();
                MName = ds.Tables[0].Rows[0]["MName"].ToString();
                otpflag = ds.Tables[0].Rows[0]["otpflag"].ToString();
                dtl = ds.Tables[0].Rows[0]["Rslt"].ToString();
                ChkStpWthAuto = ds.Tables[0].Rows[0]["ChkStpWthAuto"].ToString();

                paymentAddress = ds.Tables[0].Rows[0]["PaymentAddress"].ToString();
                Id = ds.Tables[0].Rows[0]["Id"].ToString();
                AutoWith = ds.Tables[0].Rows[0]["AutoWithNo"].ToString();
                netAmount = ds.Tables[0].Rows[0]["netAmount"].ToString();

                if (dtl == Convert.ToString(200))
                {
                    string Message123 =
                    //"For 24/7 support" + DynamicDtls.Email + "<br/><br/>Hi, <br/>" + MName + " <br/> <br/>The one time password (OTP) is " + otpflag + " for Withdrawal Request.If it is not done by you, Please login and Check your sensitive Transaction.. ! <br/><br/>Thanks & Regards <br/><br/> Support Team " + DynamicDtls.CompName + "<br/><br/>Please do not reply to this email. Email send to this address will not be answered.";
                    @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: transparent'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='20'></td> </tr> <tr> <td> <table border='0' cellspacing='0' cellpadding='0' style='margin:0px 20px;'> <tbody> <tr> <td> <h3 style=' font-size:20px;margin: 0;'> <span style='color: #ee9d28; font-weight: bolder'>Dear,</span> " + MName.Trim() + " {" + UserID + "}</h3> <br> <p style='  font-size: 17px;margin: 5px 0px;font-family: sans-serif;'>The one time password (OTP) is <strong>" + otpflag + "</strong> for Withdrawal Request.</p> <p style=' font-size: 17px;margin: 5px 0px;font-family: sans-serif;'> If it is not done by you, Please login and Check your sensitive Transaction.. ! </p> <br> </td> </tr> <tr> <td> <p style='font-size: 14px;text-align: justify; margin: 0; padding: 0; font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p><p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p></td></tr> </tbody> </table> </td>  </tr>  <tr> </tbody> </table><table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr style='background-color: transparent'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: #000000;text-align: center'>Copyright &copy; " + DynamicDtls.CopyWriteYear + ".&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                    this.SendEmailToUser(Mem_email, "Your otp password for Withdrawal Request", Message123);
                }
                else if (dtl == Convert.ToString(1))
                {
                    string Message1234 = @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px;margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans;color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td> </tr> </tbody> </table> </td> <td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='20'></td> </tr> <tr> <td align='center'> <table style='font-size: 18px;text-align: center;color: #fff' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> </td> </tr> <tr> <td height='8'> <img src='' width='1' height='1' alt='' style='display:block'> </td> </tr> <tr> <td height='25'> <img src='' alt='' width='1' height='1' style='display:block'> </td> </tr> </tbody> </table> </td> </tr> <tr> <td> <div style='text-align: left;line-height: 26px;font-size: 16px;max-width: 570px;margin: 0 auto'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td width='15'></td> <td> <div> <p style='margin:0;padding:0;font-weight:600'>Dear,&nbsp;&nbsp;" + MName.Trim() + "&nbsp;&nbsp;" + "{" + UserID + "}" + "</p> <div style='height:20px'></div> <p style='margin: 0;'>Congratulations !!!</p> <p> <span>Your withdrawal of </span> <span><strong>" + WidAmt.Trim() + "</strong></span> has been initiated successfully. It will be credited to your wallet at the earliest.</p> </div> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td height='20' colspan='1'></td> </tr> <tr> <td align='left' valign='top'> <div style='margin:10px 0 0 0;padding:0'> <table border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td> <p style='font-size: 14px;text-align: justify;margin: 0;padding: 0;font-weight: 300'> Best Regards, <br>" + DynamicDtls.CompName + " Team </p> <p style='margin:0;padding-bottom:16px'> <a href='' style='display:inline-block;font-size: 14px;color: #1d92cd;line-height:26px' target='_blank'>" + DynamicDtls.CompEmail + "</a> </p> </td> </tr> </tbody> </table> </div> </td> </tr> <tr> <td height='30' colspan='1'> <img src='' alt='' width='1' height='1' style='display:block' data-image-whitelisted=''> </td> </tr> </tbody> </table> </td> <td width='15'></td> </tr> </tbody> </table> </div> </td> </tr> </tbody> </table><table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody><tr bgcolor='#042a2d'><td><table width='100%' border='0' cellspacing='0' cellpadding='0'><tbody><tr><td height='23'><img src='' width='1' height='1' alt='' style='display: block;' /></td></tr><tr><td valign='top' align='center' width='100%' height='100%'><div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'><tbody><tr><td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody><tr><td style='padding: 3px 0 6px; border-collapse: collapse' colspan='4' align='center' valign='top' width='100%'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/new_footerlogo.svg' alt='logo' style=' padding: 0; height: auto !important; outline: none; text-decoration: none' border='0'></td></tr><tr><td style='border-collapse:collapse' colspan='4' height='10' width='100%'></td></tr><tr style='text-align:center'><td style='border-collapse:collapse' colspan='4' height='20' width='100%'><font style='color: #ccd2d5; font-size: 13px'> Copyright &copy; " + DynamicDtls.CopyWriteYear + ".&nbsp;All Rights Reserved. </font></td></tr><tr><td style='border-collapse:collapse' colspan='4' height='20' width='100%'></td></tr></tbody></table></td></tr></tbody></table></div></td></tr><tr><td height='30'><img src='' width='1' height='1' alt='' style='display: block;' /></td></tr></tbody></table></td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";
                    try
                    {
                        var senderAddress = DynamicDtls.withdraw;
                        var privkey = DynamicDtls.privetkey;
                        var senderPrivateKey = DB.base64Decod(privkey);
                        if (Convert.ToInt32(ChkStpWthAuto) == 0)
                        {
                            //MakeWithdrawal(senderPrivateKey, paymentAddress, netAmount, senderAddress, Id, UserID, AutoWith);
                            TransactionComplete(AutoWith, netAmount, senderAddress, senderPrivateKey, paymentAddress, "Withraw");
                        }

                        this.SendEmailToUser(Mem_email, "Withdrawal Confirmation", Message1234);
                    }
                    catch (Exception ex)
                    {
                        DB.WriteLog(this.ToString() + "\n" + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
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
                msg = ds.Tables[0].Rows[0]["Msg"].ToString();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = "Sorry, Something is wrong please try later !";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }

    private void RejectRequest(string AutoWithNo)
    {
        try
        {
            ds = objgdb.ByProcedure("[PROC_RESPONSE_WITHDRAWAL_REQ]", new string[] { "Req_ID", "memid", "transdt", "UplodeFile", "status", "TransId", "Type", "txtRemarkp", "inctype" },
               new string[] { AutoWithNo.ToString(), UserID.ToString(), "", "", "", "", "REJECT_REQUEST", "", "" }, "");

            if (ds.Tables[0].Rows.Count > 0)
            {
                msg = ds.Tables[0].Rows[0]["MSG"].ToString();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = "Sorry, Something is wrong please try later !";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
            context.Response.Cookies["Kdjlwl85soQwk84d"].Expires = DateTime.Now.AddDays(-1);
        }
    }

    private void BindResultUpdt(string AutoWithNo, string TxnID, string Status, string currency2Amt)
    {
        try
        {
            ds = objgdb.ByProcedure("[PROC_RESPONSE_WITHDRAWAL_REQ]", new string[] { "Req_ID", "memid", "transdt", "UplodeFile", "status", "TransId", "Type", "txtRemarkp", "inctype" },
               new string[] { AutoWithNo.ToString(), UserID.ToString(), "", "", Status.ToString(), TxnID.ToString(), "COMPLETE_AGAIN", currency2Amt.ToString(), "" }, "");

            if (ds.Tables[0].Rows.Count > 0)
            {
                sc = true;
                msg = ds.Tables[0].Rows[0]["MSG"].ToString();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = "Sorry, Something is wrong please try later !";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
            context.Response.Cookies["Kdjlwl85soQwk84d"].Expires = DateTime.Now.AddDays(-1);
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

    private void TransactionComplete(string requestID, string amountStr, string fromAddress, string fromPrivateKey, string toAddress, string widType)
    {
        try
        {
            //string contractAddress_Token = "0xf58b1e9e4fcab71c9a2edd2b7641253e6aa22283";
            //string contractAddress_USDT = "0x55d398326f99059fF775485246999027B3197955";
            //string contractAddress = (Pm == "Token") ? contractAddress_Token : contractAddress_USDT;

            string contractAddress = "0x55d398326f99059fF775485246999027B3197955";

            decimal amountDecimal = Convert.ToDecimal(amountStr);
            string rpcUrl = "https://bsc-dataseed.binance.org/";

            decimal minBNBRequired = 0.002m;
            decimal minTokenRequired = Convert.ToDecimal(amountStr);
            BigInteger maxGasLimit = 300000;
            var account = new Account(fromPrivateKey);
            var web3 = new Web3(account, rpcUrl);
            var bnbBalance = Web3.Convert.FromWei(web3.Eth.GetBalance.SendRequestAsync(account.Address).Result);
            if (bnbBalance < minBNBRequired)
            {
                DB.WriteLog("Insufficient Token Balance: " + bnbBalance + " tokens (need at least " + minBNBRequired + ")");
                return;
            }
            var contractHandler = web3.Eth.GetContractHandler(contractAddress);
            var tokenBalance = contractHandler.QueryAsync<BalanceOfFunction, BigInteger>(new BalanceOfFunction { Owner = account.Address }).Result;
            var tokenBalanceDecimal = Web3.Convert.FromWei(tokenBalance);

            if (tokenBalanceDecimal < minTokenRequired)
            {
                DB.WriteLog("Insufficient Token Balance: " + tokenBalanceDecimal + " tokens (need at least " + minTokenRequired + ")");
                return;
            }
            var gasPriceWei = web3.Eth.GasPrice.SendRequestAsync().Result;
            BigInteger tokenAmount = Web3.Convert.ToWei(amountDecimal);
            var transfer = new TransferFunction
            {
                FromAddress = account.Address,
                To = toAddress,
                TokenAmount = tokenAmount,
                Gas = new HexBigInteger(maxGasLimit),
                GasPrice = new HexBigInteger(gasPriceWei)
            };

            var handler = web3.Eth.GetContractTransactionHandler<TransferFunction>();
            string txnHash = handler.SendRequestAsync(contractAddress, transfer).Result;
            txnHash1 = txnHash;

            //DB.WriteLog(this.ToString() + " Error Msg :" + txnHash + "\n" + "Event Info :" + txnHash);
            BindResultUpdt(requestID, txnHash, "PENDING", "");
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + "Transfer Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace + "Request Id :" + requestID + "From Address :" + fromAddress);
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

[Function("transfer", "bool")]
public class TransferFunction : FunctionMessage
{
    [Parameter("address", "_to", 1)]
    public string To { get; set; }

    [Parameter("uint256", "_value", 2)]
    public BigInteger TokenAmount { get; set; }
}

[Function("balanceOf", "uint256")]
public class BalanceOfFunction : FunctionMessage
{
    [Parameter("address", "_owner", 1)]
    public string Owner { get; set; }
}
<%@ WebHandler Language="C#" Class="Add_Balance_Crypto_api" %>

using System;
using System.IO;
using System.Net;
using System.Web;
using System.Data;
using System.Web.Script.Serialization;
using System.Collections.Generic;
using System.Text;
using Nethereum.Signer;
using System.Collections;

public class Add_Balance_Crypto_api : IHttpHandler {
    
    public HttpContext context; public HttpRequest request; public HttpResponse response;
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;
    public bool sc;
    public int Conf;
    private int statusObj;
    public string ReqCurrcy = "", amount = "", eMailAddss = "", payed_amount = "", account_number = "", ifsc = "",
    channel_id = "", client_id = "", provider_id = "", SKey = "", PayoutIDs = "", PGStatus = "", PGorderid = "", PGUTR = "", PGReportID = "", PGMessage = "", waddress = "", wprivateKey = "", CWallet = "", walletAddress = "";
    string wprivateKey1 = "";
    public static string UserID = "";
    public string msg, msg1, Msgs, dtl, RtnRlt, strJson;
    //libCoinPaymentsNET.CoinPayments cp = new libCoinPaymentsNET.CoinPayments("e3dc997da4C850dF090be6B18a07A2FDeb2e4e85991343b76A49c8046c30933d", "847dbf31ab4769aae2f8b2eef0f8af787887482cc175948f93d284c0fd5d1893");
    
    public class test
    {
        public bool Success { get; set; }
        public string Message { get; set; }
        public string Message1 { get; set; }
        public string detail { get; set; }
        public string aid { get; set; }
        public test(bool sc, string msg, string dtl, string msg1)
        {
            Success = sc;
            Message = msg;
            detail = dtl;
            Message1 = msg1;
        }
    }

    public void handleRequest()
    {
        writeJson(new test(sc, msg, msg1, dtl));
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

    public void ProcessRequest(HttpContext _context)
    {
        context = _context;
        request = _context.Request;
        response = _context.Response;
        context.Response.ContentType = "application/json";
        if (context.Request.Cookies["Tap190Nvw92mst"] != null)
        {
            UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString().Trim();
            amount = context.Request["txtReqAmt"].Trim();
            ReqCurrcy = context.Request["paymode"].Trim();
            eMailAddss = context.Request["eMailAddss"].Trim();
            GiveHelpOrder1();
            handleRequest();
        }
        else
        {
            context.Response.Write("<script>window.open('../login.html','_top');</script>");
        }
    }

  public void GiveHelpOrder1()
    {
        try
        {

            ds = objgdb.ByProcedure("Add_Balance_Request_CAPI", new string[] { "Memid", "Amt", "Comment", "PaymentMode", "InstMode", "PaymentId", "DateAdm", "TransId", "FromMemId" }
                        , new string[] { UserID.Trim(), amount.Trim(), "", ReqCurrcy.Trim(), "By User", "SecPWD", "", "", UserID.Trim() }, "das");
            if (ds.Tables[0].Rows[0]["SubmitStatus"].ToString() == "Ok")
            {
                payed_amount = ds.Tables[0].Rows[0]["Amt"].ToString();
                CWallet = ds.Tables[0].Rows[0]["CWallet"].ToString();
                walletAddress = ds.Tables[0].Rows[0]["walletAddress"].ToString();

                if (Convert.ToInt32(CWallet) == 0)
                {
                    GetWalletAddress();
                }
                BindResultUpdt(waddress, wprivateKey1, payed_amount, "");
                context.Response.Cookies["Gqwerty6Tycb90bh7"].Value = DB.base64Encode("SENDBNB");
                sc = true;
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
            msg = "Sorry, Something is wrong please try later !";
        }

    }
    public void GetWalletAddress()
    {
        try
        {
            var ecKey = EthECKey.GenerateKey(); 
            wprivateKey = ecKey.GetPrivateKey();
            waddress = ecKey.GetPublicAddress();
            wprivateKey1 = DB.base64Encode(wprivateKey);
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            msg = "Sorry, Something is wrong please try later!";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }
    private void BindResultUpdt(string NewBTC, string XpubID, string currency2Amt, string curr)
    {
        try
        {
            ds = objgdb.ByProcedure("GetDepositAddress_CrytoAPI", new string[]
                                  { "NewBTC", "MemID", "AdsIndex", "XpubID", "ReqType", "Deptype", "PlnAmt", "SeqPwd" }
                   , new string[] { NewBTC, UserID.Trim(), "", XpubID, "Fund Request", ReqCurrcy, currency2Amt, "" }, "das");
            if (ds.Tables[0].Rows.Count > 0)
            {
                RtnRlt = ds.Tables[0].Rows[0]["Rlt"].ToString();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            msg = "Sorry, Something is wrong please try later !";
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
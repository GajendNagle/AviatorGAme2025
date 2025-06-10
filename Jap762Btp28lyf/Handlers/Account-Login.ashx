<%@ WebHandler Language="C#" Class="Account_Login" %>

using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Net.Mail;
using System.IO;
using System.Data;
using System.Web.SessionState;

public class Account_Login : IHttpHandler
{

    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc;
    public string msg, Msgs, dtl, RtnRlt, strJson, txtPasswordSU = "",
        txtUserID = "", ErrMsg = "", PlnLnk = "", MemID = "", City = "", Country = "", State = "", txtLoginip = "",loginUserID="";
    Int32 ChkUA;
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
        txtPasswordSU = context.Request["txtPasswordSU"].Trim();
        txtUserID = context.Request["txtUserID"].Trim();
        /////////        
        City = context.Request["txtCity"].Trim();
        Country = context.Request["txtCountry"].Trim();
        State = context.Request["txtRegion"].Trim();
        txtLoginip = context.Request["txtLoginip"].Trim();
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
        //bool UIDIsValidUser = false;
        //bool AIDIsValidUser = false;
        try
        {
            if (txtPasswordSU.Trim() != "" && txtUserID.Trim() != "")
            {
                ds = objgdb.ByProcedure("usp_ValidateUser", new string[] { "UserName", "Password" },
                new string[] { txtUserID.Trim(), txtPasswordSU.Trim() }, "ds");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    ChkUA = Convert.ToInt32(ds.Tables[0].Rows[0]["cnt"].ToString());
                    ErrMsg = ds.Tables[0].Rows[0]["ErrMsg"].ToString();
                    loginUserID = ds.Tables[0].Rows[0]["LoginID"].ToString();
                }
                if (ChkUA == 1)
                {
                    //context.Response.Cookies["Tap190Nvw92mst"].Value = DB.base64Encode(txtUserID.Trim());
                    //context.Response.Cookies["Tap190Nvw92mst"].Expires = DateTime.Now.AddHours(1);
                    ////UIDIsValidUser = true;
                    //sc = true;
                    //msg = "UrsrB8F9HcA/m-Dashboard-s.html";
                    ds.Dispose();
                    GetLoginHistory();
                }
                else if (ChkUA == 2)
                {
                    context.Response.Cookies["Get563lnr43lbt"].Value = DB.base64Encode(loginUserID);
                    context.Response.Cookies["Get563lnr43lbt"].Expires = DateTime.Now.AddDays(1);
                    //AIDIsValidUser = true;
                    sc = true;
                    msg = "Adm962xts21qtj/AdminHome.aspx?mid=Dashboard&sid=Home";
                }
                else
                {
                    sc = false;
                    //msg = "<span style='color:#f6a821; font-wight:bold; font-size:16px;'> " + ErrMsg + "</span><br/>";
                    msg = ErrMsg;
                }
            }
            else
            {
                sc = false;
                msg = "Please fill required fields in form !";
                //msg = "<span style='color:#f6a821; font-wight:bold; font-size:16px;'> Please fill required fields in form !</span><br/>";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            sc = false;
            msg = ex.Message;
            //msg = "<span style='color:#f6a821; font-wight:bold; font-size:16px;'> " + ex.Message + "</span><br/>";
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }

    }
    private void GetLoginHistory()
    {
        try
        {

            ds = objgdb.ByProcedure("tblUserLoginHistory", new string[] { "MemID", "IPAddress", "BrowserUsed", "City", "State", "Country" }, new string[] { txtUserID.Trim(), txtLoginip, context.Request.Browser.Browser + ", " + context.Request.Browser.Version, City, State, Country }, "ds");
            //if (ds.Tables[0].Rows.Count > 0)
            //{
            //RltIP = ds.Tables[0].Rows[0]["Rlt"].ToString();
            //VerifCode = ds.Tables[0].Rows[0]["VerifCode"].ToString();
            //MNames = ds.Tables[0].Rows[0]["MName"].ToString();
            //emailAddrs = ds.Tables[0].Rows[0]["email"].ToString();
            //}
            //if (RltIP == "IsOk")
            //{
            context.Response.Cookies["Tap190Nvw92mst"].Value = DB.base64Encode(loginUserID);
            context.Response.Cookies["Tap190Nvw92mst"].Expires = DateTime.Now.AddDays(1);
            //
            context.Response.Cookies["Yes872mBr81bts"].Value = DB.base64Encode("Succes24!7H1p");
            context.Response.Cookies["Yes872mBr81bts"].Expires = DateTime.Now.AddHours(1);
            //
            sc = true;
            msg = "Jap762Btp28lyf/game-index.html";
            ///
            //}
            //else
            //{

            //    try
            //    {
            //        this.SendEmailToUser(emailAddrs.Trim(), VerifCode, MNames.Trim());
            //    }
            //    catch { }
            //    sc = false;
            //    msg = "IP Verification Required ! Please check your e-Mail for IP Verification Message !";
            //}
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
    private void GetLoginHistory1()
    {
        string result = string.Empty;
        string ip = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
        if (!string.IsNullOrEmpty(ip))
        {
            string[] ipRange = ip.Split(',');
            int le = ipRange.Length - 1;
            result = ipRange[0];
        }
        else
        {
            result = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
        }

        context.Response.Write(context.Request.Browser.Browser + ' ' + context.Request.Browser.Version + ' ' + result);
        try
        {
            ds = objgdb.ByProcedure("tblUserLoginHistory", new string[] { "MemID", "IPAddress", "BrowserUsed" }, new string[] { txtUserID.Trim(), result, context.Request.Browser.Browser + ' ' + context.Request.Browser.Version }, "ds");

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
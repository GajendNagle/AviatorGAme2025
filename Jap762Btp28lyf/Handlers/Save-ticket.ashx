<%@ WebHandler Language="C#" Class="Save_ticket" %>
using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Net.Mail;
using System.IO;
using System.Data;

public class Save_ticket : IHttpHandler {

    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc;
    public string msg, Msgs, dtl, RtnRlt, strJson, UserID, topicId, EmailAddress, FullName,
        PhoneNumber, ext, IssueSummary, IssueDetails, fname, chkfileEx, SDbFilePath = "", AcFileName;
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
        if (context.Request.Cookies["Tap190Nvw92mst"] != null )
        {
            if (context.Request.Cookies["Tap190Nvw92mst"] != null)
            {
                UserID = DB.base64Decod(context.Request.Cookies["Tap190Nvw92mst"].Value).ToString();
            }
            topicId = context.Request["topicId"].Trim();
            EmailAddress = UserID.ToString();
            FullName = UserID.ToString();
            IssueSummary = context.Request["IssueSummary"].Trim();
            IssueDetails = context.Request["IssueDetails"].Trim();
            /////////
            if (context.Request.Files.Count > 0)
            {
                UploadProfileImg();
            }
            else
            {
                GiveHelpOrder();
            }
            ////////
            handleRequest();
        }
        else
        {
            context.Response.Write("<script>window.open('../login.html','_top');</script>");
        }
    }
    public static string GenerateRandomUsername()
    {
        string str = Path.GetRandomFileName(); //This method returns a random file name of 11 characters
        str = str.Replace(".", "");
        return str;
    }
    private void UploadProfileImg()
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
                    SDbFilePath = "uploads/" + AcFileName + chkfileEx;
                    fname = Path.Combine(context.Server.MapPath("~/uploads/"), AcFileName + chkfileEx);
                    file.SaveAs(fname);
                    GiveHelpOrder();
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
            if (topicId != "" && EmailAddress != "" && FullName != "")
            {
                ds = objgdb.ByProcedure("dbo.Tkt_CreateTicket", new string[] { "topicId", "EmailAddress", "FullName", "PhoneNumber", "ext", "IssueSummary", "IssueDetails" },
                    new string[] { topicId, EmailAddress, FullName, "", SDbFilePath, IssueSummary, IssueDetails }, "ByDataset");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Msgs = ds.Tables[0].Rows[0]["Msg"].ToString();
                    RtnRlt = ds.Tables[0].Rows[0]["Rlt"].ToString();
                }
                if (RtnRlt.ToString().Trim() == "IsOk")
                {
                    sc = true;
                    msg = Msgs;
                }
                else
                {
                    sc = false;
                    msg = Msgs;
                }
            }
            else
            {
                sc = false;
                msg = "Please fill required fields in new ticket form !";
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
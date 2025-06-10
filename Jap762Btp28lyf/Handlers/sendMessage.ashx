<%@ WebHandler Language="C#" Class="sendMessage" %>

using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.IO;
using System.Data;

public class sendMessage : IHttpHandler {

    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc; public string msg, Msgs, dtl, strJson, UserID, RtnRlt, message, OrderId,
        fname, chkfileEx,SDbFilePath="",AcFileName;
    Random Rnd = new Random();
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
    public static string GenerateRandomUsername()
    {
        string str = Path.GetRandomFileName(); //This method returns a random file name of 11 characters
        str = str.Replace(".", "");
        return str;
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
            message = context.Request["message"].ToString();
            OrderId = context.Request["OrderId"].ToString();
            /////////
            if (context.Request.Files.Count > 0)
            {
                UploadProfileImg();
            }
            else
            {
                GiveHelpOrder(); 
            }
            /////////
            handleRequest();
        }
        else
        {
            context.Response.Write("<script>window.open('../login.html','_top');</script>");
        }
    }
    public void handleRequest()
    {
        writeJson(new test(sc, msg, dtl));
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
                //if (!UploadRcpt.PostedFile.ContentType.Equals("image/jpeg") && !UploadRcpt.PostedFile.ContentType.Equals("image/pjpeg") && !UploadRcpt.PostedFile.ContentType.Equals("image/gif") && !UploadRcpt.PostedFile.ContentType.Equals("image/x-png") && !UploadRcpt.PostedFile.ContentType.Equals("image/png") && !UploadRcpt.PostedFile.ContentType.Equals("application/pdf"))
                if (chkfileEx.ToString().Trim() == ".jpg" || chkfileEx.ToString().Trim() == ".gif" ||
                    chkfileEx.ToString().Trim() == ".bmp" || chkfileEx.ToString().Trim() == ".jpeg" ||
                    chkfileEx.ToString().Trim() == ".png" || chkfileEx.ToString().Trim() == ".pdf")
                {
                    AcFileName = GenerateRandomUsername();
                    SDbFilePath = "~/uploads/" + AcFileName + chkfileEx;
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
    public void GiveHelpOrder()
    {
        try
        {
            ds = objgdb.ByProcedure("dbo.ProcMessageOnRequestWithImage", new string[] { "AdsId", "Username", "Comment", "Rate", "LikeAds", "PostDate", "Imagepath", "SenderType", "type" },
                new string[] { OrderId, UserID, message,"","","", SDbFilePath, "", "1" }, "ByDataset");
            if (ds.Tables[0].Rows.Count > 0)
            {
                RtnRlt = ds.Tables[0].Rows[0]["Rlt"].ToString();
                Msgs = ds.Tables[0].Rows[0]["Msg"].ToString();
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
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            msg = ex.Message;
            sc = false;
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
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
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


}
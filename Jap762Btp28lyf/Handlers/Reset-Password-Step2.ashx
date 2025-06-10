<%@ WebHandler Language="C#" Class="Reset_Password_Step2" %>
using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Net.Mail;
using System.IO;
using System.Data;
using System.Web.SessionState;
public class Reset_Password_Step2 : IHttpHandler {
    public HttpContext context;
    public HttpRequest request;
    public HttpResponse response;
    public bool sc;
    public string msg, Msgs, dtl, RtnRlt, strJson, recovery_email = "", RecCode = "", EmaiAdd = "",Get_Token="",changing_memid="",
        changing_email = "", changing_code = "", new_password = "";
    DynamicDtls objgdb = new DynamicDtls();
    DataSet ds;
    DataTable dt;

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
        if (context.Request.QueryString["token"] != null)
        {
            /////////
            Get_Token = context.Request.QueryString["token"].ToString();
            GetEmailID();
        }
        else
        {

            changing_email = context.Request["changing_email"].Trim();
            changing_code = context.Request["changing_code"].Trim();
            new_password = context.Request["new_password"].Trim();
            changing_memid = context.Request["changing_memid"].Trim();
            /////////
            GiveHelpOrder();
            ////////
            handleRequest();
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
    public void GetEmailID()
    {
        try
        {
            if (Get_Token != "")
            {
                ds = objgdb.ByProcedure("dbo.Pro_PasswordRecovery", new string[] { "MemID","EmlMbl", "RecCode", "NewPWD", "RType" },
                    new string[] { "","", Get_Token.TrimEnd(), "", "GETEMAIL" }, "ByDataset");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    dt = ds.Tables[0];
                    string strJson = Dataset2Json(ds, Convert.ToInt32(ds.Tables[0].Rows.Count.ToString()));
                    context.Response.Write(strJson);
                    //context.Response.End();
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
            msg = ex.Message;
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }

    }
    public void GiveHelpOrder()
    {
        try
        {
            if (changing_email != "" || changing_code != "" || new_password != "")
            {
                ds = objgdb.ByProcedure("dbo.Pro_PasswordRecovery", new string[] { "MemID", "EmlMbl", "RecCode", "NewPWD", "RType" },
                    new string[] { changing_memid.Trim (), changing_email.Trim(), changing_code.Trim(), new_password.Trim(), "UpdPWD" }, "ByDataset");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    RtnRlt = ds.Tables[0].Rows[0]["RtnRlt"].ToString();
                    Msgs = ds.Tables[0].Rows[0]["Msgs"].ToString();
                }
                if (RtnRlt.ToString().Trim() == "IsOk")
                {
                    sc = true;
                    msg =  Msgs;
                    //msg = "<span style='color:#60C630; font-wight:bold; font-size:16px;'> " + Msgs + "</span><br/>";
                }
                else
                {
                    sc = false;
                    msg =   Msgs;
                    //msg = "<span style='color:#f6a821; font-wight:bold; font-size:16px;'> " + Msgs + "</span><br/>";
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
            msg = ex.Message;
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }

    }
    public static string DataTable2Json(DataTable dt)
    {
        StringBuilder jsonBuilder = new StringBuilder();

        for (int i = 0; i < dt.Rows.Count; i++)
        {
            jsonBuilder.Append("{");
            for (int j = 0; j < dt.Columns.Count; j++)
            {
                jsonBuilder.Append("\"");
                jsonBuilder.Append(dt.Columns[j].ColumnName);
                jsonBuilder.Append("\":\"");
                jsonBuilder.Append(dt.Rows[i][j].ToString());
                jsonBuilder.Append("\",");
            }
            if (dt.Columns.Count > 0)
            {
                jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
            }
            jsonBuilder.Append("},");
        }
        if (dt.Rows.Count > 0)
        {
            jsonBuilder.Remove(jsonBuilder.Length - 1, 1);
        }

        return jsonBuilder.ToString();
    }
    public static string Dataset2Json(DataSet ds, int total)
    {
        StringBuilder json = new StringBuilder();

        foreach (DataTable dt in ds.Tables)
        {
            json.Append("[");
            json.Append(DataTable2Json(dt));
            json.Append("]");
        }
        return json.ToString();
    }
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
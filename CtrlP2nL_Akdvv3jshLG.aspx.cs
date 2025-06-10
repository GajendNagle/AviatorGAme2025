using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;

public partial class CtrlP2nL_Akdvv3jshLG : System.Web.UI.Page
{
    public string msg, Msgs, dtl, RtnRlt, strJson,
       ErrMsg = "", PlnLnk = "", MemID = "", txtEmail = "", otpflag = "";
    Int32 ChkUA, otpchk;
    DataSet ds;
    public string Status, Usercode;
    DynamicDtls objgdb = new DynamicDtls();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
        }
    }

    protected void btnsignin_Click(object sender, EventArgs e)
    {
        try
        {
            ds = objgdb.ByProcedure("[usp_ValidateAdmin]", new string[] { "UserName", "Password", "Type" },
         new string[] { txtUserID.Text.Trim(), txtPasswordSU.Text.Trim(), "ADMIN" }, "ds");
            if (ds.Tables[0].Rows.Count > 0)
            {
                ChkUA = Convert.ToInt32(ds.Tables[0].Rows[0]["cnt"].ToString());
                ErrMsg = ds.Tables[0].Rows[0]["ErrMsg"].ToString();
            }
            if (ChkUA == 2)
            {
                otpchk = Convert.ToInt32(ds.Tables[0].Rows[0]["Rslt"].ToString());
                 if (otpchk == 1)
                {
                    GetLoginHistory();
                }
            }
            else
            {

                lblmsg.Text = "<span style='color:#ee5254; font-size:15px;'> " +
                    ErrMsg + "</span><br/>";
            }

        }
        catch (Exception ex)
        {
            lblmsg.Text = objgdb.ErrorMsg("Sorry, Something is wrong please try later !");
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }
    
    public void GetLoginHistory()
    {
        try
        {
            ds = objgdb.ByProcedure("[tblUserLoginHistory_Admin]", new string[] { "MemID", "IPAddress", "BrowserUsed", "City", "State", "Country", "Type" },
                new string[] { txtUserID.Text.Trim(), txtLoginip.Value, Request.Browser.Browser + ", " + Request.Browser.Version, txtCity.Value, txtRegion.Value, txtCountry.Value, "Admin" }, "ds");
            Session["Khbfy897ft36Gv"] = DB.base64Encode(txtUserID.Text.Trim());
            Response.Redirect("Adm962xts21qtj/AdminHome.aspx?mid=Dashboard&sid=Home", false);
        }
        catch (Exception ex)
        {
            lblmsg.Text = objgdb.ErrorMsg("Sorry, Something is wrong please try later !");
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }

}
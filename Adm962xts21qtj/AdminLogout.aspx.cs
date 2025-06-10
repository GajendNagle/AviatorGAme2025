using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Adm962xts21qtj_AdminLogout : System.Web.UI.Page
{
    DynamicDtls objgdb = new DynamicDtls();
    public string UserID;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["Get563lnr43lbt"] != null)
        {
            UserID = DB.base64Decod(Session["Khbfy897ft36Gv"].ToString());
            try
            {
                objgdb.ByProcedure("OnlineUsersUpdate", new string[] { "MemID", "LgInOut" }, new string[] { UserID, "LOGOUT" }, "bysave");
            }
            catch (Exception ex)
            {
                objgdb.WriteLog(this.Session["Khbfy897ft36Gv"].ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); Response.Write("Your request could not be completed.");
            }
            finally
            {
                Session.Abandon();
                Session.Clear();
                Session.RemoveAll();
                Response.Cookies.Clear();
                FormsAuthentication.SignOut();
                Response.Cookies["Get563lnr43lbt"].Expires = DateTime.Now.AddDays(-1);
                Response.Redirect("../login.html", false);
            }
        }
        else
        {
            Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
        }
    }
}

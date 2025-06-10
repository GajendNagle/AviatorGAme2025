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

public partial class UrsrB8F9HcA_Sign_Out : System.Web.UI.Page
{
    DynamicDtls objgdb = new DynamicDtls();
    public string UserID;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Cookies["Tap190Nvw92mst"] != null)
        {
            UserID = Request.Cookies["Tap190Nvw92mst"].Value;
            try
            {
                objgdb.ByProcedure("OnlineUsersUpdate", new string[] { "MemID", "LgInOut" }, new string[] { UserID, "LOGOUT" }, "bysave");
            }
            catch (Exception ex)
            {
                objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); Response.Write("Your request could not be completed.");
            }
            finally
            {
                Session.Abandon();
                Session.Clear();
                Session.RemoveAll();
                Response.Cookies.Clear();
                FormsAuthentication.SignOut();
                Response.Cookies["Tap190Nvw92mst"].Expires = DateTime.Now.AddDays(-1);
                Response.Redirect("../login.html");
            }
        }
        else
        {
            Response.Redirect("../login.html", false);
        }
    }
}

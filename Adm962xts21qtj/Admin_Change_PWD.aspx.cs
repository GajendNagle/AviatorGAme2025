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
using System.Data.SqlClient;

public partial class Adm962xts21qtj_Admin_Change_PWD : System.Web.UI.Page
{
    DynamicDtls objgdb = new DynamicDtls(); DB objdb = new DB();
    SqlDataAdapter da; DataSet ds;
    SqlCommand cmd;
    string UserID;
    Int32 RtrnRslt;
    MailSenderByEmail objSendMail = new MailSenderByEmail();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Khbfy897ft36Gv"] != null)
        {
            UserID = DB.base64Decod(Session["Khbfy897ft36Gv"].ToString());
            try
            {
                ds = objdb.ByDataSet("select upassword from USERS where Login_ID='" + UserID + "'");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    //txtoldpass.Text = ds.Tables[0].Rows[0]["upassword"].ToString();
                    txtloginid.Text = UserID.ToString();
                    //txtoldpass.ReadOnly = true;
                }
            }
            catch (Exception ex)
            {
                objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
                lblmsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
            }
            finally
            {
                ds.Dispose();
            }
        }
        else
        {
            Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
        }

    }
    protected void btnChangePsw_Click(object sender, EventArgs e)
    {
            this.UpdatePassword();
    }

    private void UpdatePassword()
    {
        using (SqlConnection con = new SqlConnection(new DB().getconnection()))
        {
            try
            {
                cmd = new SqlCommand("dbo.AdminUpdateLoginPWD");
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Login_ID", txtloginid.Text.Trim());
                cmd.Parameters.AddWithValue("@OldLoginPWD", txtoldpass.Text.Trim());
                cmd.Parameters.AddWithValue("@NewLoginPWD", txtnewpass.Text.ToString().Trim());
                cmd.Connection = con;
                da = new SqlDataAdapter(cmd);
                ds = new DataSet();
                da.Fill(ds);
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    RtrnRslt = Convert.ToInt32(dr[0].ToString().Trim());
                }
                if (RtrnRslt == 1)
                {
                    lblmsg.Visible = true;
                    lblmsg.Text = "!! Password Has Been Changed Successfully !!";
                    //objSendMail.MailFormat("ChangePassword", txtloginid.Text.Trim(), txtloginid.Text.Trim(), "", txtnewpass.Text, "");
                }

                if (RtrnRslt == 0)
                {
                    lblmsg.Visible = true;
                    lblmsg.Text = objgdb.UpdateMessage("!! Please, Enter Correct Previous Password !!");
                }
            }
            catch (Exception ex)
            {
                objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
                lblmsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
            }
            finally
            {
                cmd.Dispose();
                ds.Dispose();
                da.Dispose();
                this.clears();
            }

        }
    }

    private void clears()
    {
        txtoldpass.Text = txtnewpass.Text = "";
    }

}

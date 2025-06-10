using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;

public partial class Adm962xts21qtj_AdminChangePassworduser : System.Web.UI.Page
{
    SqlCommand cmd;
    DataSet ds;
    SqlDataAdapter da;
    string UserID;
    public string Status, Usercode;
    Int32 RtrnRslt;
    DynamicDtls objgdb = new DynamicDtls();
    DB objdb = new DB();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Khbfy897ft36Gv"] != null)
        {
            if (!IsPostBack)
            {
                try
                {
                    if (Request.QueryString["MemID"] != null)
                    {
                        ds = new DataSet();
                        ds = objdb.ByDataSet("select pwd,EwalletPwd from memdetail where MemID='" + Request.QueryString["MemID"].ToString() + "'");
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            txtMemID.Text = Request.QueryString["MemID"].ToString();
                            txtOldloginpass.Text = ds.Tables[0].Rows[0]["pwd"].ToString();
                            txtoldTranspass.Text = ds.Tables[0].Rows[0]["EwalletPwd"].ToString();
                            txtNewloginpass.Text = ds.Tables[0].Rows[0]["pwd"].ToString();
                            txtNewTranspass.Text = ds.Tables[0].Rows[0]["EwalletPwd"].ToString();
                        }
                    }
                }
                catch (Exception ex)
                {
                    objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
                    lblMsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
                }
                finally
                {
                    ds.Dispose();
                }

            }
        }
        else
        {
            Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        this.UpdatePassword();
    }

    private void UpdatePassword()
    {
        using (SqlConnection con = new SqlConnection(new DB().getconnection()))
        {
            try
            {
                cmd = new SqlCommand("dbo.UpdateLoginPWD");
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MemID", txtMemID.Text.Trim());
                cmd.Parameters.AddWithValue("@OldLoginPWD", txtOldloginpass.Text.Trim().ToUpper());
                cmd.Parameters.AddWithValue("@NewLoginPWD", txtNewTranspass.Text.ToString().Trim().ToUpper());
                cmd.Parameters.AddWithValue("@EwalletPwd", txtoldTranspass.Text.ToString().Trim().ToUpper());
                cmd.Parameters.AddWithValue("@Type", "TRANS");
                cmd.Connection = con;
                da = new SqlDataAdapter(cmd);
                ds = new DataSet();
                da.Fill(ds);

                cmd = new SqlCommand("dbo.UpdateLoginPWD");
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MemID", txtMemID.Text.Trim());
                cmd.Parameters.AddWithValue("@OldLoginPWD", txtOldloginpass.Text.Trim().ToUpper());
                cmd.Parameters.AddWithValue("@NewLoginPWD", txtNewloginpass.Text.ToString().Trim().ToUpper());
                cmd.Parameters.AddWithValue("@EwalletPwd", txtoldTranspass.Text.ToString().Trim().ToUpper());
                cmd.Parameters.AddWithValue("@Type", "LOGIN");
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
                    lblMsg.Visible = true;
                    lblMsg.Text = "!! Password Has Been Changed Successfully !!";
                    //objSendMail.MailFormat("ChangePassword", txtloginid.Text.Trim(), txtloginid.Text.Trim(), "", txtnewpass.Text,"");
                }
                else if (RtrnRslt == 0)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = objgdb.UpdateMessage("!! Please, Enter Correct Previous Password !!");
                }
                else if (RtrnRslt == 2)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "!! Enter Transaction Password Minimum 6 Digit !!";
                    lblMsg.Focus();
                }
            }
            catch (Exception ex)
            {
                objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
                lblMsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
            }
            finally
            {
                cmd.Dispose();
                ds.Dispose();
                da.Dispose();
            }

        }
    }
}
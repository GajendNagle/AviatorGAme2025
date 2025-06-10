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
public partial class Adm962xts21qtj_AdminEditProfile : System.Web.UI.Page
{
    SqlDataAdapter da; DataSet ds;
    SqlCommand cmd;
    Int32 RtrnRslt;
    string UserID;
    public string Status, Usercode;
    DynamicDtls objgdb = new DynamicDtls();
    DB objdb = new DB();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Khbfy897ft36Gv"] != null)
        {
            objgdb.FillWebSiteEmailCompany();
            UserID = Usercode = Request.QueryString["MemId"].ToString();
            //lblmsg.Text = "";

            if (!IsPostBack)
            {
                this.GetPrePageInfo();
                txtDOB.Text = System.DateTime.Now.ToString("dd/MM/yyyy");

                getUserPassword();
            }
        }
        else
        {
            Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
        }

    }
    public void getUserPassword()
    {
        try
        {
            ds = new DataSet();
            ds = objgdb.ByDataSet("select pwd,EwalletPwd from memdetail where MemID='" + Request.QueryString["MemId"].ToString() + "'");
            if (ds.Tables[0].Rows.Count > 0)
            {
                txtLoginOldPass.Text = ds.Tables[0].Rows[0]["pwd"].ToString();
                txtTransOldPassword.Text = ds.Tables[0].Rows[0]["EwalletPwd"].ToString();
                txtLoginNewPass.Text = ds.Tables[0].Rows[0]["pwd"].ToString();
                txtTransNewpass.Text = ds.Tables[0].Rows[0]["EwalletPwd"].ToString();
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void GetPrePageInfo()
    {
        try
        {
            ds = objgdb.ByProcedure("GetUserProfile", new string[] { "MemID" }, new string[] { UserID }, "BY DATASET");

            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                txtState.Text = dr["state"].ToString();
                txtCity.Text = dr["city"].ToString();
                txtPinCode.Text = dr["pin"].ToString();

                txtDOB.Text = dr["dob"].ToString();
                txtFirstName.Text = dr["mname"].ToString();
                txtEmailid.Text = dr["email"].ToString();
                txtMobiUSD.Text = dr["mobile"].ToString();

                if (dr["gender"].ToString().ToUpper() == "MALE") { rdgender.SelectedIndex = 0; }
                if (dr["gender"].ToString().ToUpper() == "FEMALE") { rdgender.SelectedIndex = 1; }
                try
                {
                    ddlCountryCode.ClearSelection();
                    ddlCountryCode.Items.FindByValue(dr["MobileCode"].ToString()).Selected = true;
                }
                catch { }
                try
                {
                    ddlPosition.ClearSelection();
                    ddlPosition.Items.FindByValue(dr["Position"].ToString().ToUpper()).Selected = true;
                }
                catch { }
                try
                {
                    ddlcountry.ClearSelection();
                    ddlcountry.Items.FindByText(dr["Country"].ToString()).Selected = true;
                }
                catch { }
                try
                {
                    ddlBockRoi.ClearSelection();
                    ddlBockRoi.Items.FindByValue(dr["BlockROI"].ToString().ToUpper()).Selected = true;
                }
                catch { }
                txtAccFName.Text = dr["AccountName"].ToString();
                txtAccLName.Text = dr["AccLName"].ToString();
                txtAccCity.Text = dr["BankCity"].ToString();



                txtBakName.Text = dr["bankname"].ToString();
                txtAccountNo.Text = dr["accno"].ToString();
                txtIFSCode.Text = dr["IFSC"].ToString();
                txtSwiftCode.Text = dr["SwiftCode"].ToString();

                txtPerfect.Text = dr["Bitcoin"].ToString();


                txtCardNo.Text = dr["CardNo"].ToString();



                try
                {
                    ddlDesignation.ClearSelection();
                    ddlDesignation.Items.FindByText(dr["DRANK"].ToString()).Selected = true;
                }
                catch { }

                try
                {
                    ddlAccType.ClearSelection();
                    ddlAccType.Items.FindByText(dr["BnkAccType"].ToString()).Selected = true;
                }
                catch { }

            }

        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblmsg.Text = objgdb.ErrorMsg("Sorry, Something is wrong please try later !");
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            ds = objgdb.ByProcedure("AdminUpdateMemRegDetails", new string[] { "Mname", "MLastName", "Email", "AccName", "BankName", "AccNo", "IFSC", "Mobile", "MemID", "PerfectMoneyId", "Country", "Salutation", "MobileCode", "AccLName", "SwiftCode", "BnkAccType", "AccountName", "BankCity", "COM_PER", "state", "city", "pin", "gender", "dob", "Position", "PAN", "BlockROI", "CardNo", "DRANK" }, new string[] { txtFirstName.Text.Trim(), "", txtEmailid.Text, txtAccFName.Text, txtBakName.Text, txtAccountNo.Text, txtIFSCode.Text.ToUpper(), txtMobiUSD.Text.Trim(), UserID, txtPerfect.Text, ddlcountry.SelectedItem.Text, "", ddlCountryCode.SelectedItem.Value.ToString(), txtAccLName.Text, txtSwiftCode.Text, ddlAccType.SelectedItem.Text, txtAccFName.Text, txtAccCity.Text, "", txtState.Text, txtCity.Text, txtPinCode.Text, rdgender.SelectedItem.Text, txtDOB.Text, ddlPosition.SelectedItem.Text, txtPanCard.Text.Trim(), ddlBockRoi.SelectedItem.Text, txtCardNo.Text.Trim(), ddlDesignation.SelectedItem.Text }, "BY DATASET");


            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                RtrnRslt = Convert.ToInt32(dr[0].ToString().Trim());
            }
            if (RtrnRslt == 1)
            {
                lblmsg.Visible = true;
                lblmsg.Text = new DB().UpdateMessage("Profile Updated Succesffully...");
                lblmsg.ForeColor = System.Drawing.Color.Green;

                //PanelBnkinfo.Visible = false;
                //pnlPerc.Visible = false;
                chkbankWire.Checked = false;
                chkECurcy.Checked = false;

            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblmsg.Text = new DB().ErrorMessage("Sorry, Something is wrong please try later !");
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
            this.GetPrePageInfo();
        }
    }
    protected void chkECurcy_CheckedChanged(object sender, EventArgs e)
    {
        //if (chkECurcy.Checked == true)
        //{
        //    pnlPerc.Visible = true;
        //}
        //else
        //{
        //    pnlPerc.Visible = false;
        //}
    }
    protected void chkbankWire_CheckedChanged(object sender, EventArgs e)
    {
        //if (chkbankWire.Checked == true)
        //{
        //    PanelBnkinfo.Visible = true;
        //}
        //else
        //{
        //    PanelBnkinfo.Visible = false;
        //}
    }
    protected void btnSearchMember_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtSearchbyMemberID.Text.Trim() != "")
            {
                Response.Redirect("AdminEditProfile.aspx?mid=My Account&sid=Edit Profile&MemId=" + txtSearchbyMemberID.Text);
            }
            else
            {
                DB.WriteLog(this.ToString() + "Please Enter Member ID First!");
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblmsg.Text = new DB().ErrorMessage("Sorry, Something is wrong please try later !");
        }
    }
    protected void btnloginPass_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(new DB().getconnection()))
        {
            try
            {
                cmd = new SqlCommand("dbo.UpdateLoginPWD");
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MemID", Request.QueryString["UserId"].ToString());
                cmd.Parameters.AddWithValue("@OldLoginPWD", txtLoginOldPass.Text.Trim().ToUpper());
                cmd.Parameters.AddWithValue("@NewLoginPWD", txtLoginNewPass.Text.ToString().Trim().ToUpper());
                cmd.Parameters.AddWithValue("@EwalletPwd", txtTransOldPassword.Text.ToString().Trim().ToUpper());
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
                    lblmsg.Visible = true;
                    lblmsg.Text = "!! Password Has Been Changed Successfully !!";
                    getUserPassword();
                    //objSendMail.MailFormat("ChangePassword", txtloginid.Text.Trim(), txtloginid.Text.Trim(), "", txtnewpass.Text,"");
                }

                if (RtrnRslt == 0)
                {
                    lblmsg.Visible = true;
                    lblmsg.Text = objgdb.UpdateMessage("!! Please, Enter Correct Previous Password !!");
                }
            }
            catch (Exception ex)
            {
                DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblmsg.Text = new DB().ErrorMessage("Sorry, Something is wrong please try later !");
            }
            finally
            {
                cmd.Dispose();
                ds.Dispose();
                da.Dispose();
            }
        }
    }
    protected void btnTransPass_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(new DB().getconnection()))
        {
            try
            {
                cmd = new SqlCommand("dbo.UpdateLoginPWD");
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MemID", Request.QueryString["MemId"].ToString());
                cmd.Parameters.AddWithValue("@OldLoginPWD", txtLoginOldPass.Text.Trim().ToUpper());
                cmd.Parameters.AddWithValue("@NewLoginPWD", txtTransNewpass.Text.ToString().Trim().ToUpper());
                cmd.Parameters.AddWithValue("@EwalletPwd", txtTransOldPassword.Text.ToString().Trim().ToUpper());
                cmd.Parameters.AddWithValue("@Type", "TRANS");
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
                    getUserPassword();
                    //objSendMail.MailFormat("ChangePassword", txtloginid.Text.Trim(), txtloginid.Text.Trim(), "", txtnewpass.Text,"");
                }

                if (RtrnRslt == 0)
                {
                    lblmsg.Visible = true;
                    lblmsg.Text = objgdb.UpdateMessage("!! Please, Enter Correct Previous Password !!");
                }
            }
            catch (Exception ex)
            {
                DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblmsg.Text = new DB().ErrorMessage("Sorry, Something is wrong please try later !");
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

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
using System.Net.Mail;

public partial class PowerControl_UnverifyUsersReport : System.Web.UI.Page
{
    public int Pagesize = Convert.ToInt16(ConfigurationManager.AppSettings["gridPageSize"]);
    SqlConnection cn;
    public int PageNo;
    DataSet ds, DS;
    public string Mem_email = "", MName = "";

    DataTable dt; SqlDataAdapter sda; SqlCommand cmd;
    MailSenderByEmail objSentMail = new MailSenderByEmail();
    DynamicDtls objgdb = new DynamicDtls();
    ArrayList id = new ArrayList();
    DB objd = new DB();
    SendEmail objSendEmail = new SendEmail();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Khbfy897ft36Gv"] != null)
            {
                if (!IsPostBack)
                {
                    detsdv.Visible = false;
                    ddlJumpToPage.Items.Clear();
                    if (string.IsNullOrWhiteSpace(Request.QueryString["MemId"]))
                    {
                        txtSearch.Text = "";
                    }
                    else
                    {
                        txtSearch.Text = Request.QueryString["MemId"].ToString();
                        DDLFillItems.SelectedItem.Value = "memid";
                        txtSearch.Visible = true;
                    }

                    int TotalRows = this.BindResult(1);
                    this.populateList(TotalRows);
                }
            }
            else
            {
                Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
            }
        }
        catch (Exception ex)
        {
            objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ddlJumpToPage.Items.Clear();
        int TotalRows = this.BindResult(1);
        this.populateList(TotalRows);
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //GridView1.PageIndex = e.NewPageIndex;
        //BindResult();
    }
    private int BindResult(int currentPage)
    {
        string SearchText;
        if (txtSearch.Text == "")
        {
            if (DDLFillItems.Items.Count != 0)
            {
                SearchText = DDLFillItems.SelectedItem.Text;
            }
            else
            {
                SearchText = "";
            }
        }
        else
        {
            SearchText = txtSearch.Text.Trim();
        }
        int TotalRows = 0;
        try
        {
            cn = new SqlConnection(new DB().getconnection());
            dt = new DataTable();
            sda = new SqlDataAdapter();
            cmd = new SqlCommand("procUnvarifyUsers");
            cmd.Parameters.AddWithValue("@FormDate", "");
            cmd.Parameters.AddWithValue("@ToDate", "");
            cmd.Parameters.AddWithValue("@MemId", "");
            cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = "0";
            cmd.Parameters.Add("@intTotalRecords", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.AddWithValue("@intPageSize", Pagesize);
            cmd.Parameters.AddWithValue("@intCurrentPage", currentPage);
            cmd.Parameters.Add("@Column", DDLDownPos.SelectedItem.Text);
            cmd.Parameters.Add("@SearchTxt", SearchText);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = cn;
            sda.SelectCommand = cmd;
            sda.Fill(dt);

            TotalRows = (int)cmd.Parameters["@intTotalRecords"].Value;

            if (TotalRows == 0)
            {
                EmailSend.Visible = false;
                lblMsg.Text = objd.EmptyMessage("Sorry ... No Records found !!");
            }
            else
            {
                EmailSend.Visible = true;
                GridView1.DataSource = dt;
                GridView1.DataBind();
                lblMsg.Visible = false;
            }
            txtEmail.Text = "";
            sda.Dispose();
            cmd.Dispose();
            dt.Dispose();
            cn.Dispose();
        }
        catch (Exception ex)
        {
            objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
        }
        return TotalRows;
    }
    private void populateList(int TotalRows)
    {
        lblTotRec.Text = Convert.ToString(TotalRows);
        int PageCount = Convert.ToInt32(Math.Floor(Convert.ToDouble((TotalRows / Pagesize))) + 1); ;
        for (int i = 1; i <= PageCount; i++)
        {
            ddlJumpToPage.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
        CountingShow();
    }
    public void CountingShow()
    {
        if (ddlJumpToPage.SelectedItem.Text == "1")
        {
            PageNo = 1;
            //Pagesize
        }
        else
        {
            PageNo = 1 + int.Parse(ddlJumpToPage.SelectedItem.Text);
            Pagesize = (Pagesize * int.Parse(ddlJumpToPage.SelectedItem.Text));
        }
    }


    protected void chkMemID_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            CheckBox chkSelect = (CheckBox)sender;
            GridViewRow gv = (GridViewRow)chkSelect.NamingContainer;
            Label lblEMAIL = (Label)gv.FindControl("lblEMAIL");
            txtEmail.Text += lblEMAIL.Text + ",";
        }
        catch (Exception ex)
        {
            objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
        }
    }
    protected void PageChanged(object sender, EventArgs e)
    {
        int Page = Convert.ToInt32(ddlJumpToPage.SelectedItem.Value);
        this.BindResult(Page);
        CountingShow();
    }

    protected void lnkVerify_Click(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkDelete = (LinkButton)sender;
            GridViewRow GVR = (GridViewRow)lnkDelete.NamingContainer;
            Label lblMemId = (Label)GVR.FindControl("lblMemId");
            Label lblMNAME = (Label)GVR.FindControl("lblMNAME");
            Label lblEMAIL = (Label)GVR.FindControl("lblEMAIL");
            Label lblRegnCNFCode = (Label)GVR.FindControl("lblRegnCNFCode");

            Label lblTxnPwd = (Label)GVR.FindControl("lblTxnPwd");
            Label lblLogPwd = (Label)GVR.FindControl("lblLogPwd");
            Label lblSponserID = (Label)GVR.FindControl("lblSponserID");
            //SendResetCnfirmCodeEmail(lblMemId.Text, lblEMAIL.Text, lblMNAME.Text, lblRegnCNFCode.Text);

            try
            {
                string Message123 =
                @"<table width='100%' border='0' cellspacing='0' cellpadding='0' bgcolor='#f5f5f5' style='max-width:896px; margin: 0 auto;'> <tbody> <tr> <td align='center' width='100%'> <table width='100%' border='0' cellspacing='0' cellpadding='0' style='font-family: Roboto, Lato,Helvetica,sans; color: #354147;'> <tbody> <tr> <td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td><td style='min-width:350px'> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td width='100%' align='center'> <table border='0' cellspacing='0' cellpadding='0' width='100%' style='background-color: #009688;'> <tbody> <tr> <td align='center' style='padding-bottom:11px'> <a href='' style='display:inline-block' target='_blank'><img src='http://" + DynamicDtls.WebSite2 + "/Website-Logo/MailLogo.svg' alt='logo' style='padding: 15px 0 0;' border='0'></a> </td></tr></tbody> </table> </td></tr></tbody> </table><table border='0' cellspacing='0' cellpadding='0' width='100%' bgcolor='#fff'> <tbody> <tr> <td height='50'></td> </tr> <tr> <td> <table border='0' cellspacing='0' cellpadding='0' width='100%'> <tbody> <tr> <td> <h3 style=' font-size:29px;margin: 0; text-align: center; '> <span style='color: #009688; font-weight: bolder'> Welcome,</span> " + lblMNAME.Text + "</h3> <br><p style=' text-align: center; font-size: 17px;margin: 5px;font-family: sans-serif;'>now get started just one more step</p> <p style=' text-align: center;font-size: 17px;margin: 5px;font-family: sans-serif;'>Click the big button below to activate your account</p> <div style='padding: 20px 0 20px; text-align: center;'><a href='http://" + DynamicDtls.WebSite2 + "/Verification.html?acc=" + lblRegnCNFCode.Text + "' style='text-align: center; font-weight: 700; color: white; background-color: #FF5722; padding: 13px 17px; text-decoration: none; border: 1px solid #FF5722;'> Activate Account</a> </div><br> </td> </tr> </tbody> </table> </td>  </tr> <tr> </tbody> </table><table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr bgcolor='#009688'> <td> <table width='100%' border='0' cellspacing='0' cellpadding='0'> <tbody> <tr> <td valign='top' align='center' width='100%' height='100%'> <div style='display: inline-block;'><table border='0' cellspacing='0' cellpadding='0' style='width: 100%; float: right;'> <tbody> <tr> <td height='40px'><table style='margin:0 auto;border-collapse:collapse!important;border-spacing:0!important;table-layout:fixed!important;word-break:break-word!important;word-wrap:break-word!important' border='0' cellspacing='0' cellpadding='0' align='center'><tbody> <tr style='text-align:center'> <td style='border-collapse:collapse' colspan='4' height='20' width='100%'> <font style='font-size: 13px;color: white;text-align: center'>Copyright &copy; 2024.&nbsp;All Rights Reserved. </font> </td></tr></tbody> </table> </td></tr></tbody> </table> </div></td></tr></tbody> </table> </td></tr></tbody> </table> </td><td valign='bottom' width='12%'> <table bgcolor='#f5f5f5' width='100%' style='width:100%'> <tbody> <tr> <td width='100%' height='550'></td></tr></tbody> </table> </td></tr></tbody> </table> </td></tr></tbody> </table>";

                this.SendEmailToUser(lblEMAIL.Text, "Your account details !", Message123);
            }
            catch { }


            lblMsg.Text = objgdb.UpdateMessage("Verification Link Has Been Sent sucessfully.");
            ddlJumpToPage.Items.Clear();
            int TotalRows = this.BindResult(1);
            this.populateList(TotalRows);
        }
        catch (Exception ex)
        {
            objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
        }

    }
    protected void SendResetCnfirmCodeEmail(string UserId, string EmailId, string Name, string ConfirmCode)
    {
        try
        {
            //objSentMail.MailFormat("RegnCNFLink", UserId, EmailId, Name, objgdb.base64Encode(ConfirmCode), "");
        }
        catch (Exception ex)
        {
            objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
        }

    }
    protected void lnkDelete_Deleting(object sender, EventArgs e)
    {
        try
        {
            LinkButton lnkDelete = (LinkButton)sender;
            GridViewRow GVR = (GridViewRow)lnkDelete.NamingContainer;
            Label lblMemId = (Label)GVR.FindControl("lblMemId");

            cn = new SqlConnection(new DB().getconnection());
            cmd = new SqlCommand("procUnvarifyUsers", cn);
            cmd.Parameters.Add("@FormDate", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@ToDate", SqlDbType.VarChar).Value = "";
            cmd.Parameters.Add("@MemId", SqlDbType.VarChar).Value = lblMemId.Text;
            cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = "1";
            cmd.Parameters.Add("@intTotalRecords", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.AddWithValue("@intPageSize", Pagesize);
            cmd.Parameters.AddWithValue("@intCurrentPage", "1");
            cmd.Parameters.Add("@Column", DDLDownPos.SelectedItem.Text);
            cmd.Parameters.Add("@SearchTxt", "All");

            cmd.CommandType = CommandType.StoredProcedure;
            cn.Open();
            cmd.ExecuteNonQuery();
            cn.Close();
            cn.Dispose();
            cmd.Dispose();
            lblMsg.Text = objgdb.UpdateMessage("Record Deleted Successfully.");
            ddlJumpToPage.Items.Clear();
            int TotalRows = this.BindResult(1);
            this.populateList(TotalRows);
        }
        catch (Exception ex)
        {
            objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
        }

    }
    protected void DDLDownPos_SelectedIndexChanged(object sender, EventArgs e)
    {
        detsdv.Visible = false;
        txtSearch.Text = "";
        txtEmail.Text = "";
        if (DDLDownPos.SelectedIndex == 0)
        {
            txtSearch.Visible = false;
            DDLFillItems.Visible = false;
        }
        else if (DDLDownPos.SelectedIndex == 1 || DDLDownPos.SelectedIndex == 2 || DDLDownPos.SelectedIndex == 3 || DDLDownPos.SelectedIndex == 4)
        {
            txtSearch.Visible = true;
            DDLFillItems.Visible = false;
            detsdv.Visible = true;

        }

    }
    protected void btnSendEmail_Click(object sender, EventArgs e)
    {
        //try
        //{
        //    objSendEmail.SendMailMessage("support@icapexplus.com", txtSubject.Text, txtEmailMsg.Text, txtEmail.Text);
        //    lblMsg.Text = objgdb.UpdateMessage("Email Sent Sucessfully to the selected EMAIL IDs !!");
        //    txtEmail.Text = "";
        //}
        //catch { }
        try
        {
            string fromEmail = "";
            fromEmail = ConfigurationManager.AppSettings["Email"].ToString();
            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox chkMemID = (CheckBox)row.FindControl("chkMemID");
                if (chkMemID.Checked)
                {
                    Label lblEMAIL = (Label)row.FindControl("lblEMAIL");
                    try
                    {
                        objSendEmail.SendMailMessage(fromEmail, txtSubject.Text, txtEmailMsg.Text, lblEMAIL.Text);
                    }
                    catch
                    {
                    }
                }

            }
            lblMsg.Text = objgdb.UpdateMessage("Email Sent Sucessfully to the selected EMAIL IDs !!");

        }
        catch (Exception ex)
        {
            objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
        }
    }

    protected void SendEmailToUser(string EmailId, string Subjects, string Message)
    {
        objgdb.FillWebSiteEmailCompany();
        MailSenderByEmail mailsend = new MailSenderByEmail();

        try
        {
            mailsend.SendMailMessage(DynamicDtls.Email, Subjects, Message, EmailId);
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
    }
}

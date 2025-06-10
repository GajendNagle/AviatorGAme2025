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

public partial class Adm962xts21qtj_Admin_Deposit_Address : System.Web.UI.Page
{
    public int Pagesize = Convert.ToInt16(ConfigurationManager.AppSettings["gridPageSize"]);
    SqlConnection cn;
    public int PageNo;
    DataSet ds, DS;
    public string Mem_email = "", MName = "", UserID = "";
    DB objdb = new DB();
    DataTable dt; SqlDataAdapter sda; SqlCommand cmd;
    MailSenderByEmail objSentMail = new MailSenderByEmail();
    DynamicDtls objgdb = new DynamicDtls();
    ArrayList id = new ArrayList();
    SendEmail objSendEmail = new SendEmail();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Khbfy897ft36Gv"] != null)
            {
                UserID = DB.base64Decod(Session["Khbfy897ft36Gv"].ToString()).ToString();
                if (!IsPostBack)
                {

                    if (Request.QueryString["MemId"] != null && Request.QueryString["MemId"] != string.Empty)
                    {
                        DDLDownPos.SelectedValue = "Screen";
                    }
                    ddlJumpToPage.Items.Clear();
                    int TotalRows = this.BindResult(1, "0");
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
        int TotalRows = this.BindResult(1, "1");
        this.populateList(TotalRows);
    }
    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        //GridView1.PageIndex = e.NewPageIndex;
        //BindResult();
    }
    private int BindResult(int currentPage, string type)
    {
        int TotalRows = 0;
        try
        {
            cn = new SqlConnection(new DB().getconnection());
            dt = new DataTable();
            ds = new DataSet();
            sda = new SqlDataAdapter();
            cmd = new SqlCommand("Admin_DepositAddress");
            cmd.Parameters.AddWithValue("@MemId", UserID);
            cmd.Parameters.AddWithValue("@AccountNo", txtwltaddress.Text);
            cmd.Parameters.AddWithValue("@AccType", DDLDownPos.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@Date", txtFromDate.Text);
            cmd.Parameters.AddWithValue("@AdminPwd", txtpassword.Text);
            cmd.Parameters.Add("@Type", SqlDbType.VarChar).Value = type;
            cmd.Parameters.AddWithValue("@intPageSize", Pagesize);
            cmd.Parameters.AddWithValue("@intCurrentPage", currentPage);
            cmd.Parameters.Add("@intTotalRecords", SqlDbType.Int).Direction = ParameterDirection.Output;

            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = cn;
            sda.SelectCommand = cmd;
            sda.Fill(ds);

            TotalRows = (int)cmd.Parameters["@intTotalRecords"].Value;

            if (TotalRows == 0)
            {
                lblMsg.Text = new DB().EmptyMessage("Sorry ... No Records found !!");
            }

            if (ds.Tables[1].Rows[0]["Rslt"].ToString() == "ISOk")
            {
                lblMsg.Text = ds.Tables[1].Rows[0]["Msg"].ToString();
            }
            else if (ds.Tables[1].Rows[0]["Rslt"].ToString() == "Ok")
            {
                txtwltaddress.Text = "";
                txtpassword.Text = "";
                txtFromDate.Text = "";
                lblMsg.Text = objdb.UpdateMessage(ds.Tables[1].Rows[0]["Msg"].ToString());
            }
            else
            {
                lblMsg.Text = objdb.ErrorMessage(ds.Tables[1].Rows[0]["Msg"].ToString());
            }
            GridView1.DataSource = ds;
            GridView1.DataBind();
            sda.Dispose();
            cmd.Dispose();
            ds.Dispose();
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

    protected void PageChanged(object sender, EventArgs e)
    {
        int Page = Convert.ToInt32(ddlJumpToPage.SelectedItem.Value);
        this.BindResult(Page, "2");
        CountingShow();
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
            CheckBox chkbox = (CheckBox)GVR.FindControl("chkMemID");

            if (chkbox.Checked == true)
            {
                cn = new SqlConnection(new DB().getconnection());
                cmd = new SqlCommand("Admin_DepositAddress", cn);
                cmd.Parameters.AddWithValue("@MemId", lblMemId.Text);
                cmd.Parameters.AddWithValue("@AccountNo", txtwltaddress.Text);
                cmd.Parameters.AddWithValue("@AccType", DDLDownPos.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@Date", txtFromDate.Text);
                cmd.Parameters.AddWithValue("@AdminPwd", txtpassword.Text);
                cmd.Parameters.Add("@Type", SqlDbType.VarChar).Value = "2";
                cmd.Parameters.AddWithValue("@intPageSize", Pagesize);
                cmd.Parameters.AddWithValue("@intCurrentPage", "1");
                cmd.Parameters.Add("@intTotalRecords", SqlDbType.Int).Direction = ParameterDirection.Output;

                cmd.CommandType = CommandType.StoredProcedure;
                cn.Open();
                cmd.ExecuteNonQuery();
                cn.Close();
                cn.Dispose();
                cmd.Dispose();

                ddlJumpToPage.Items.Clear();
                int TotalRows = this.BindResult(1, "0");
                this.populateList(TotalRows);
                lblMsg.Text = objgdb.UpdateMessage("Record Deleted Successfully.");
            }
            else
            {
                lblMsg.Text = objgdb.ErrorMsg("please select checkbox");
            }
        }
        catch (Exception ex)
        {
            objgdb.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = objgdb.ErrorMsg("Your request could not be completed.");
        }

    }
    //protected void DDLDownPos_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    txtSearch.Text = "";
    //    //txtEmail.Text = "";
    //    if (DDLDownPos.SelectedIndex == 0)
    //    {
    //        txtSearch.Visible = false;
    //        DDLFillItems.Visible = false;
    //    }
    //    else if (DDLDownPos.SelectedIndex == 1 || DDLDownPos.SelectedIndex == 2 || DDLDownPos.SelectedIndex == 3 || DDLDownPos.SelectedIndex == 4)
    //    {
    //        txtSearch.Visible = true;
    //        DDLFillItems.Visible = false;
    //    }

    //}
    protected void btnSendEmail_Click(object sender, EventArgs e)
    {
        //try
        //{
        //    objSendEmail.SendMailMessage("support@skymeta.world", txtSubject.Text, txtEmailMsg.Text, txtEmail.Text);
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
                        // objSendEmail.SendMailMessage(fromEmail, txtSubject.Text, txtEmailMsg.Text, lblEMAIL.Text);
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
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
public partial class Admin_BlockUnblockSetting : System.Web.UI.Page
{
    SqlConnection cn = new SqlConnection(new DB().getconnection());
    DataTable dt; SqlDataAdapter sda; SqlCommand cmd;
    DB objdb = new DB();
    MailSenderByEmail objSendMail = new MailSenderByEmail();
    public int PageNo = 0, Pagesize = Convert.ToInt16(ConfigurationManager.AppSettings["gridPageSize"]);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Khbfy897ft36Gv"] != null)
        {
            if (!IsPostBack)
            {
                ddlJumpToPage.Items.Clear();
                if (string.IsNullOrWhiteSpace(Request.QueryString["MemId"]))
                {
                    txtMemId.Text = "";  
                }
                else
                {
                    txtMemId.Text = Request.QueryString["MemId"].ToString();
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ddlJumpToPage.Items.Clear();
        int TotalRows = this.BindResult(1);
        this.populateList(TotalRows);
    }

    private int BindResult(int currentPage)
    {

        string type = "";

        if (txtMemId.Text == "")
        {
            type = "0";
        }
        else
        {
            type = "1";
        }
        int TotalRows = 0;
        dt = new DataTable();
        sda = new SqlDataAdapter();
        cmd = new SqlCommand("dbo.Hlp_ProcBlockUnBlockStt");
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@intTotalRecords", SqlDbType.Int).Direction = ParameterDirection.Output;
        cmd.Parameters.AddWithValue("@intPageSize", Pagesize);
        cmd.Parameters.AddWithValue("@intCurrentPage", currentPage);
        cmd.Parameters.AddWithValue("@MemId", txtMemId.Text);
        cmd.Parameters.Add("@ColumnName", SqlDbType.VarChar).Value = "";
        cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = type;
        cmd.Connection = cn;
        sda.SelectCommand = cmd;
        sda.Fill(dt);
        TotalRows = (int)cmd.Parameters["@intTotalRecords"].Value;
        if (TotalRows == 0)
        {
            btnUpdate.Visible = false;
            grdGiveHelpDtl.Visible = false;
            lblMsg.Text = objdb.EmptyMessage("Sorry ... No Records found !!");
        }
        else
        {
            btnUpdate.Visible = true;
            lblMsg.Text = "";
            grdGiveHelpDtl.Visible = true;
            grdGiveHelpDtl.PageIndex = currentPage - 1;
            grdGiveHelpDtl.DataSource = dt;
            grdGiveHelpDtl.DataBind();
        }
        return TotalRows;
        sda.Dispose();
        cmd.Dispose();
        dt.Dispose();

    }
    protected void chkSelect_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            CheckBox chktest = (CheckBox)sender;
            GridViewRow gv = (GridViewRow)chktest.NamingContainer;
            Label lblStatus = (Label)gv.FindControl("lblStatus");
            DropDownList ddlStatus = (DropDownList)gv.FindControl("ddlStatus");

            if (chktest.Checked == true)
            {
                lblStatus.Visible = false;
                ddlStatus.Visible = true;
            }
            else
            {
                lblStatus.Visible = true;
                ddlStatus.Visible = false;
            }
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed."; ;}

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
        this.BindResult(Page);
        CountingShow();
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            for (int i = 0; i < grdGiveHelpDtl.Rows.Count; i++)
            {
                CheckBox chkSelect = (CheckBox)grdGiveHelpDtl.Rows[i].FindControl("chkSelect");


                if (chkSelect.Checked == true)
                {
                    Label lblMemId = (Label)grdGiveHelpDtl.Rows[i].FindControl("lblMemId");
                    DropDownList ddlStatus = (DropDownList)grdGiveHelpDtl.Rows[i].FindControl("ddlStatus");

                    dt = new DataTable();
                    sda = new SqlDataAdapter();
                    cmd = new SqlCommand("dbo.Hlp_ProcBlockUnBlockStt");
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@intTotalRecords", SqlDbType.Int).Direction = ParameterDirection.Output;
                    cmd.Parameters.AddWithValue("@intPageSize", Convert.ToInt16(ConfigurationManager.AppSettings["gridPageSize"]));
                    cmd.Parameters.AddWithValue("@intCurrentPage", 0);
                    cmd.Parameters.AddWithValue("@MemId", lblMemId.Text.ToString());
                    cmd.Parameters.Add("@ColumnName", SqlDbType.VarChar).Value = ddlStatus.Text;
                    cmd.Parameters.Add("@type", SqlDbType.VarChar).Value = "2";
                    cmd.Connection = cn;
                    cn.Open();
                    cmd.ExecuteNonQuery();
                    cn.Close();
                    if (ddlStatus.Text.ToUpper() == "BLOCK")
                    {
                        try
                        {
                            string Message = "";
                            // Message = "Your Id [ " + lblMemId.Text.ToString() + " ] has been blocked. Contact your coordinator.";
                            //new SendSms().SendSMSToUserIDMob(Message, lblMemId.Text.ToString());
                        }
                        catch { }
                        try
                        {
                            //   objSendMail.MailFormat("LoginBlock", lblMemId.Text.ToString(), "", "", "");
                        }
                        catch { }

                    }

                }

            }
            ddlJumpToPage.Items.Clear();
            int TotalRows = this.BindResult(1);
            this.populateList(TotalRows);
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed."; ;}
    }
}

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

public partial class ControlSection_ViewQueries : System.Web.UI.Page
{
    SqlConnection cn = new SqlConnection(new DB().getconnection());
    DB objdb = new DB();
    DynamicDtls objgdb = new DynamicDtls();
    SqlCommand cmd;
    SqlDataAdapter da;
    DataSet ds;
    public int Rtrn = 0, Page = 0, result=0, Pagesize = 100, TotalRows = 0;
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
                    int TotalRows = this.fillgrid(1);
                    this.populateList(TotalRows);
                }
            }
            else
            {
                Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
            }
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); 
            lblMsg.Text = "Oops, Somthing is wrong, Please try later !"; ;}

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        if (ddlHelpTopic.Visible == true)
        {
            txtSearch.Text = ddlHelpTopic.SelectedItem.Text;
        }
        ddlJumpToPage.Items.Clear();
        int TotalRows = this.fillgrid(1);
        this.populateList(TotalRows);
    }

    private int fillgrid(int currentPage)
    {
        try
        {
            //       SqlHelp sqla = new SqlHelp();
            //string strfaca = "select * from Rex_Test";
            //DataSet ds = sqla.GetDataSet(strfaca);
            ds = objgdb.ByProcedure("dbo.GetSupportMessages", new string[] { 
            "intPageSize", "intCurrentPage", "FromDt","Todt","Searchtype","SearchValue" },
                new string[] { Pagesize.ToString(), currentPage.ToString(), txtFromDate.Text.Trim(), txtToDate.Text.Trim(), DDLSelect.SelectedValue.ToString(), txtSearch.Text }, "intTotalRecords", out TotalRows, "ByDataset");
            if (TotalRows > 0)
            {
                GridView2.DataSource = ds.Tables[0];
                GridView2.DataBind();
            }
            else
            {
                GridView2.DataSource = null;
                GridView2.DataBind();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
            lblMsg.Text = "Oops, Somthing is wrong, Please try later !"; ;
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }

        return TotalRows;
    }
    private void populateList(int TotalRows)
    {
        lblTotRec.Text = "Total:" + Convert.ToString(TotalRows);
        int PageCount = Convert.ToInt32(Math.Floor(Convert.ToDouble((TotalRows / Pagesize))) + 1); ;
        for (int i = 1; i <= PageCount; i++)
        {
            ddlJumpToPage.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
    }

    protected void PageChanged(object sender, EventArgs e)
    {
        Page = Convert.ToInt32(ddlJumpToPage.SelectedItem.Value);
        this.fillgrid(Page);
    }
    protected void DDLSelect_SelectedIndexChanged(object sender, EventArgs e)
    {
        detsdv.Visible = false;
        txtSearch.Text = "";
        if (DDLSelect.SelectedItem.Text == "All")
        {
            txtSearch.Visible = false;
            ddlHelpTopic.Visible = false;
        }
        else if (DDLSelect.SelectedItem.Text == "Help Topic")
        {
            ddlHelpTopic.Visible = true;
            txtSearch.Visible = false;
            detsdv.Visible = true;
        }
        else
        {
            txtSearch.Visible = true;
            ddlHelpTopic.Visible = false;
            detsdv.Visible = true;

        }
    }
    protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            if (cn.State == ConnectionState.Closed)
            {
                cn.Open();
            }
            
            Label LblId = (Label)GridView2.Rows[e.RowIndex].Cells[2].FindControl("LblId");

            cmd = new SqlCommand("ProcFeedbackUser", cn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@ID", LblId.Text.Trim());
            cmd.Parameters.AddWithValue("@MemId", "");
            cmd.Parameters.AddWithValue("@Subject", "");
            cmd.Parameters.AddWithValue("@Message", "");
            cmd.Parameters.AddWithValue("@AdminReply", "");
            cmd.Parameters.AddWithValue("@Type", "Delete");
            cmd.ExecuteNonQuery();
            da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);


            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                Rtrn = Convert.ToInt32(ds.Tables[0].Rows[0][0].ToString());
            }

            if (ds.Tables[0].Rows[0][0].ToString() == "1")
            {

                lblMsg.Visible = true;
                lblMsg.Text = objdb.AdminUpdateMessage("Record Deleted Successfully !!");

                ddlJumpToPage.Items.Clear();
                int TotalRows = this.fillgrid(Page);
                this.populateList(TotalRows);

            }
            else
            {
                lblMsg.Text = objdb.AdminErrorMessage(ds.Tables[0].Rows[0][1].ToString());
            }
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Oops, Somthing is wrong, Please try later !"; ;}

    }

    protected void GridView2_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView2.EditIndex = -1;
        ddlJumpToPage.Items.Clear();
        int TotalRows = this.fillgrid(Page);
        this.populateList(TotalRows);
    }
    protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            if (cn.State == ConnectionState.Closed)
            {
                cn.Open();
            }
            
            Label LblId = (Label)GridView2.Rows[e.RowIndex].Cells[2].FindControl("LblId");
            TextBox txtbxAdminReply = (TextBox)GridView2.Rows[e.RowIndex].Cells[2].FindControl("txtbxAdminReply");

            cmd = new SqlCommand("ProcFeedbackUser", cn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@ID", LblId.Text.Trim());
            cmd.Parameters.AddWithValue("@MemId", "");
            cmd.Parameters.AddWithValue("@Subject", "");
            cmd.Parameters.AddWithValue("@Message", "");
            cmd.Parameters.AddWithValue("@AdminReply", txtbxAdminReply.Text.Trim());
            cmd.Parameters.AddWithValue("@Type", "FromAdmin");
            cmd.ExecuteNonQuery();
            da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);


            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                Rtrn = Convert.ToInt32(ds.Tables[0].Rows[0][0].ToString());
            }

            if (ds.Tables[0].Rows[0][0].ToString() == "1")
            {

                lblMsg.Visible = true;
                lblMsg.Text = objdb.AdminUpdateMessage("Reply Has been sent Successfully !!");
                GridView2.EditIndex = -1;
                ddlJumpToPage.Items.Clear();
                int TotalRows = this.fillgrid(Page);
                this.populateList(TotalRows);
               

            }
            else
            {
                lblMsg.Text = objdb.AdminErrorMessage(ds.Tables[0].Rows[0][1].ToString());
            }
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Oops, Somthing is wrong, Please try later !"; ;}
    }
    protected void GridView2_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView2.EditIndex = e.NewEditIndex;
        ddlJumpToPage.Items.Clear();
        int TotalRows = this.fillgrid(Page);
        this.populateList(TotalRows);
    }
    protected void logOut_Click(object sender, EventArgs e)
    {
        Response.Cookies["Get563lnr43lbt"].Expires = DateTime.Now.AddDays(-1);
        Session["AID"] = null;
        Response.Redirect("../UsrDashBoard0699/amp.html");
    }
}

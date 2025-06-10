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
using System.IO;

public partial class Adm962xts21qtj_Member_BTC_Address_Report : System.Web.UI.Page
{
    DataSet ds; string searchText;
    public int PageNo;
    public int Pagesize = Convert.ToInt16(ConfigurationManager.AppSettings["gridPageSize"]);
    DynamicDtls objgdb = new DynamicDtls();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Khbfy897ft36Gv"] != null)
        {
            if (!Page.IsPostBack)
            {
                detsdv.Visible = false;
                fill_ColumnFilter();
                ddl_IncType.ClearSelection();
                if (Request.QueryString["Flag"] != null)
                {
                    try
                    {
                        ddl_IncType.Items.FindByText(Request.QueryString["Flag"].ToString()).Selected = true;
                    }
                    catch { }
                }
                if (Request.QueryString["UserId"] != null)
                {
                    ddl_IncType.SelectedValue = "memid";
                    //DDLDownPos_SelectedIndexChanged(sender, e);
                    txtSearch.Text = Request.QueryString["UserId"].ToString();

                    txtSearch.Visible = true;
                }
                ddlJumpToPage.Items.Clear();
                int TotalRows = this.BindResult(1);
                this.populateList(TotalRows);
                lblmymsg.Text = "";
            }
        }
        else
        {
            Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
        }
    }
    public DataSet METHOD(string COLUMN, string VALUE, string FLAG, string PG_SIZE, string CURRENT_PG)
    {
        try
        {
            int TotalRecords = 0;
            ds = new DataSet();
            ds = objgdb.ByProcedure("Member_BTC_Address_Report", new string[] { "COLUMN", "VALUE", "FLAG", "PG_SIZE", "CURRENT_PG" }, new string[] { COLUMN, VALUE, FLAG, PG_SIZE, CURRENT_PG }, "ByDataset");
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = new DB().EmptyMessage("Sorry, Something is wrong please try later !"); }
        finally
        {
            ds.Dispose();
        }
        return ds;
    }

    public DataSet DELETEMETHOD(string UserID)
    {
        try
        {
            int TotalRecords = 0;
            ds = new DataSet();
            ds = objgdb.ByProcedure("Delete_Member_BTC_Address_Report", new string[] { "UserID" }, new string[] { UserID }, "ByDataset");
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = new DB().EmptyMessage("Sorry, Something is wrong please try later !"); }
        finally
        {
            ds.Dispose();
        }
        return ds;
    }

    public void fill_ColumnFilter()
    {
        try
        {
            ddl_IncType.DataSource = METHOD("", "", "SELECT_ONE", "", "");
            ddl_IncType.DataTextField = "SELECT_ONE_TXT";
            ddl_IncType.DataValueField = "SELECT_ONE_VALUE";
            ddl_IncType.DataBind();
        }
        catch
        { }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            lblmymsg.Text = "";
            ddlJumpToPage.Items.Clear();
            int TotalRows = this.BindResult(1);
            this.populateList(TotalRows);
        }
        catch (Exception ex)
        {
        }
        finally
        {
        }
    }
    protected void ColumnFilterChanged(object sender, EventArgs e)
    {
        detsdv.Visible = false;
        DDLDownPos.Items.Clear();
        txtSearch.Text = "";
        if (ddl_IncType.SelectedValue == "ALL")
        {            
            DDLDownPos.Visible = false;
            txtSearch.Visible = false;
            lblmymsg.Text = "";
        }
        else if (ddl_IncType.SelectedValue == "BankName" || ddl_IncType.SelectedValue == "AccountType" || ddl_IncType.SelectedValue == "TransferCode" || ddl_IncType.SelectedValue == "TransactionCurrency")
        {

            DDLDownPos.DataSource = METHOD("", "", ddl_IncType.SelectedValue.ToString().ToUpper(), "", "");
            DDLDownPos.DataTextField = "TYP";
            DDLDownPos.DataValueField = "TYP";
            DDLDownPos.DataBind();
            DDLDownPos.Visible = true;
            txtSearch.Visible = false;
            detsdv.Visible = true;


        }
        else
        {
            txtSearch.Visible = true;
            DDLDownPos.Visible = false;
            detsdv.Visible = true;

        }
        //else if (ddl_IncType.SelectedValue == ""  
    }

    private void populateList(int TotalRows)
    {
        lblTotRec.Text = Convert.ToString(TotalRows);
        PageNo = Convert.ToInt32(Math.Floor(Convert.ToDouble((TotalRows / Pagesize))) + 1);
        for (int i = 1; i <= PageNo; i++)
        {
            ddlJumpToPage.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
        CountingShow();
    }
    private int BindResult(int currentPage)
    {
        int TotalRows = 0;
        try
        {
            if (DDLDownPos.Visible == false && txtSearch.Visible == false)
            {
                searchText = "";
            }
            else if (DDLDownPos.Visible == false)
            {
                searchText = txtSearch.Text;
            }
            else if (txtSearch.Visible == false)
            {
                searchText = DDLDownPos.SelectedValue;
            }

            ds = new DataSet();
            ds = METHOD(ddl_IncType.SelectedValue, searchText.ToString(), "ReportData", (ConfigurationManager.AppSettings["gridPageSize"]).ToString(), currentPage.ToString());
            TotalRows = Convert.ToInt32(ds.Tables[1].Rows[0]["TOTALRECORD"]);
            if (TotalRows == 0)
            {
                lblMsg.Visible = true;
                gvinvoiceno.Visible = false;
                lblMsg.Text = new DB().EmptyMessage(ds.Tables[0].Rows[0]["MSG"].ToString());
            }
            else
            {
                lblMsg.Visible = false;
                lblMsg.Text = "";
                gvinvoiceno.Visible = true;
                gvinvoiceno.DataSource = ds.Tables[0];
                gvinvoiceno.DataBind();
            }
            return TotalRows;
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Sorry, Something is wrong please try later !"; }
        finally { ds.Dispose(); }
        return TotalRows;
    }
    public void CountingShow()
    {
        if (ddlJumpToPage.SelectedItem.Text == "1")
        {
            PageNo = 1;
            lblRecordNo.Text = PageNo.ToString() + " - " + Pagesize.ToString() + " of "; ;
        }
        else
        {
            PageNo = int.Parse(ddlJumpToPage.SelectedItem.Text);
            lblRecordNo.Text = ((Pagesize * (PageNo - 1)) + 1) + " - " + (Pagesize * PageNo) + " of ";
        }
        if (Convert.ToInt32(lblTotRec.Text.ToString().Trim()) == 0)
        {
            lblRecordNo.Text = "";
        }
        if (Convert.ToInt32(lblTotRec.Text.ToString().Trim()) > 0)
        {
            if (Convert.ToInt32(lblTotRec.Text.ToString().Trim()) < (Pagesize * PageNo))
            {
                lblRecordNo.Text = ((Pagesize * (PageNo - 1)) + 1) + " - " + Convert.ToInt32(lblTotRec.Text.ToString().Trim()) + " of ";
            }
        }
    }
    protected void PageChanged(object sender, EventArgs e)
    {
        int Page = Convert.ToInt32(ddlJumpToPage.SelectedItem.Value);
        this.BindResult(Page);
        CountingShow();
    }
    protected void gvinvoiceno_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }
    protected void btnexporttoexport_Click(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "Member-Account-Address.xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        gvinvoiceno.AllowPaging = false;

        ddlJumpToPage.Items.Clear();
        int TotalRows = this.BindResult(1);
        this.populateList(TotalRows);

        if (gvinvoiceno.Rows.Count > 0)
        {
            //Change the Header Row back to white color
            gvinvoiceno.HeaderRow.Style.Add("background-color", "#FFFFFF");
            //Applying stlye to gridview header cells
            for (int i = 0; i < gvinvoiceno.HeaderRow.Cells.Count; i++)
            {
                gvinvoiceno.HeaderRow.Cells[i].Style.Add("background-color", "#df5015");
            }
        }

        gvinvoiceno.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    protected void BtnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            CheckBox chk;
            string strID = string.Empty;
            string st = string.Empty;
            foreach (GridViewRow rw in gvinvoiceno.Rows)
            {
                chk = rw.FindControl("CBDelete") as CheckBox;
                if (chk.Checked == true)
                {
                    Label lb = rw.FindControl("lb") as Label;
                    strID += lb.Text.ToString().TrimEnd() + ",";
                }
            }
            if (strID != "" && strID != string.Empty)
            {
                int strlen = strID.Length;
                st = strID.Substring(0, strlen - 1);
                ds = new DataSet();
                ds = DELETEMETHOD(st);
                this.BindResult(1);
                lblmymsg.Text = "Record Deleted successfully.";
            }
            else
            {
                lblmymsg.Text = "Please select record for delete.";
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Sorry, Something is wrong please try later !";
        }
        finally
        {
            ds.Dispose();
        }

    }


    protected void gvinvoiceno_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvinvoiceno.EditIndex = -1;
        this.BindResult(1);


    }
    protected void gvinvoiceno_RowEditing(object sender, GridViewEditEventArgs e)
    {
        gvinvoiceno.EditIndex = e.NewEditIndex;
        this.BindResult(1);

        // DropDownList ddlStatus = gvinvoiceno.Columns[8].Name;
        DropDownList ddlStatus = (DropDownList)gvinvoiceno.Rows[gvinvoiceno.EditIndex].Cells[8].FindControl("ddlStatus");
        // Label lblACCOUNTTYPE = (DropDownList)gvinvoiceno.Rows[gvinvoiceno.EditIndex].Cells[0].FindControl("ddlStatus");     
        //Label lblACCOUNTTYPE = (Label)gvinvoiceno.EditIndex].Cells[0].FindControl("lblACCOUNTTYPE");

        //if (lblACCOUNTTYPE.Text != "e-Currency")
        //{
        //    ddlStatus.Visible = true;
        //    lblACCOUNTTYPE.Visible = false;
        //}

    }
    protected void gvinvoiceno_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {

            Label Bankid = (Label)gvinvoiceno.Rows[e.RowIndex].Cells[0].FindControl("lb");

            TextBox txtPAYEENAME = (TextBox)gvinvoiceno.Rows[e.RowIndex].Cells[0].FindControl("txtPAYEENAME");
            TextBox txtBANKNAME = (TextBox)gvinvoiceno.Rows[e.RowIndex].Cells[0].FindControl("txtBANKNAME");
            Label lblACCOUNTTYPE = (Label)gvinvoiceno.Rows[e.RowIndex].Cells[0].FindControl("lblACCOUNTTYPE");
            TextBox txtACCOUNTNO = (TextBox)gvinvoiceno.Rows[e.RowIndex].Cells[0].FindControl("txtACCOUNTNO");
            TextBox txtTRANSFERCODE = (TextBox)gvinvoiceno.Rows[e.RowIndex].Cells[0].FindControl("txtTRANSFERCODE");
            TextBox txtPAN = (TextBox)gvinvoiceno.Rows[e.RowIndex].Cells[0].FindControl("txtPAN");


            ds = objgdb.ByProcedure("Member_BTC_Address_UPDATE", new string[] { "Payeename", "BankName", "AccNo", "IFSC", "PAN", "bankID" },
                new string[] { txtPAYEENAME.Text.Trim(), txtBANKNAME.Text.Trim(), txtACCOUNTNO.Text.Trim(), txtTRANSFERCODE.Text.Trim(), txtPAN.Text.Trim(), Bankid.Text.Trim() }, "GET");
            gvinvoiceno.EditIndex = -1;
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
            this.BindResult(1);
        }
    }

    protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList chlist = (DropDownList)e.Row.FindControl("ddlStatus");
            Label lblACCOUNTTYPE = (Label)e.Row.FindControl("lblACCOUNTTYPE");
            if (lblACCOUNTTYPE.Text != "e-Currency")
            {
                //chlist.Visible = true;
            }

        }
    }
}

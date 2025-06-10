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

public partial class Adm962xts21qtj_Win_Wallet_Txn_History : System.Web.UI.Page
{
    DynamicDtls objDynamicDtls = new DynamicDtls();
    public decimal TotCr, TotDr = 0;
    DataSet ds; string searchText; public int Pagesize = Convert.ToInt32(ConfigurationManager.AppSettings["gridPageSize"]);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Khbfy897ft36Gv"] != null)
        {
            if (!Page.IsPostBack)
            {
                detsdv.Visible = false;
                fill_IncType();
                fill_SelectOne();

                if (Request.QueryString["MemId"] != null)
                {
                    DDLSrchByDjGt.SelectedValue = "memid";
                    DDLSrchByDjGt_SelectedIndexChanged(sender, e);
                    txtSearch.Text = Request.QueryString["MemId"].ToString();
                }

                if (Request.QueryString["IncType"] != null)
                {
                    ddl_IncType.SelectedValue = Request.QueryString["IncType"].ToString();
                }

                ddlJumpToPage.Items.Clear();
                int TotalRows = this.BindResult(1);
                this.populateList(TotalRows);
            }
        }
        else
        {
            Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
        }
    }
    public DataSet METHOD(string FRM_DT, string TO_DT, string INCTYPE, string COLUMN, string VALUE, string FLAG, string PG_SIZE, string CURRENT_PG)
    {
        try
        {
            int TotalRecords = 0;
            ds = new DataSet();
            ds = objDynamicDtls.ByProcedure("Admin_WinWlt_History", new string[] { "FRM_DT", "TO_DT", "INCTYPE", "COLUMN", "VALUE", "FLAG", "PG_SIZE", "CURRENT_PG" }, new string[] { FRM_DT, TO_DT, INCTYPE, COLUMN, VALUE, FLAG, PG_SIZE, CURRENT_PG }, "ByDataset");
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = new DB().EmptyMessage("Your request could not be completed."); }
        finally
        {
            ds.Dispose();
        }
        return ds;
    }
    public void fill_IncType()
    {
        try
        {
            ddl_IncType.DataSource = METHOD("", "", "", "", "", "INCTYPE", "", "");
            ddl_IncType.DataTextField = "IncomeType";
            ddl_IncType.DataValueField = "IncomeType";
            ddl_IncType.DataBind();
        }
        catch
        { }
    }
    public void fill_SelectOne()
    {
        try
        {
            DDLSrchByDjGt.DataSource = METHOD("", "", "", "", "", "SELECT_ONE", "", "");
            DDLSrchByDjGt.DataTextField = "SELECT_ONE_TXT";
            DDLSrchByDjGt.DataValueField = "SELECT_ONE_VALUE";
            DDLSrchByDjGt.DataBind();
        }
        catch
        { }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
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
    protected void DDLSrchByDjGt_SelectedIndexChanged(object sender, EventArgs e)
    {
        detsdv.Visible = false;
        if (DDLSrchByDjGt.SelectedValue == "ALL")
        {
            DDLDownPos.Visible = false;
            txtSearch.Visible = false;

        }
        else if (DDLSrchByDjGt.SelectedValue == "mname")
        {

            DDLDownPos.Visible = false;
            txtSearch.Visible = true;
            detsdv.Visible = true;

        }
        else if (DDLSrchByDjGt.SelectedValue == "memid")
        {
            DDLDownPos.Visible = false;
            txtSearch.Visible = true;
            detsdv.Visible = true;

        }
        else if (DDLSrchByDjGt.SelectedValue != "memid" && DDLSrchByDjGt.SelectedValue != "mname" && DDLSrchByDjGt.SelectedValue != "ALL")
        {
            DDLDownPos.Visible = false;
            txtSearch.Visible = true;
            detsdv.Visible = true;

        }
    }
    private void populateList(int TotalRows)
    {
        lblTotRec.Text = "Total Records Found :" + Convert.ToString(TotalRows);
        int PageCount = Convert.ToInt32(Math.Floor(Convert.ToDouble((TotalRows / Pagesize))) + 1); ;
        for (int i = 1; i <= PageCount; i++)
        {
            ddlJumpToPage.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
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
            ds = METHOD(txtFromDate.Text, txtToDate.Text, ddl_IncType.SelectedValue, DDLSrchByDjGt.SelectedValue, searchText.ToString(), "GETTOTAL", "", "");
            lblTotalSum.Text = "TOTAL CREDIT : " + ds.Tables[0].Rows[0]["TOTCREDIT"].ToString() + " ,           TOTAL DEBIT : " + ds.Tables[0].Rows[0]["TOTDEBIT"].ToString() + "   ,     BALANCE :" + ds.Tables[0].Rows[0]["BALANCE"].ToString();
            ds.Dispose();
            ds = new DataSet();
            ds = METHOD(txtFromDate.Text, txtToDate.Text, ddl_IncType.SelectedValue, DDLSrchByDjGt.SelectedValue, searchText.ToString(), "ReportData", (ConfigurationManager.AppSettings["gridPageSize"]).ToString(), currentPage.ToString());
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
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed."; }
        return TotalRows;
    }
    protected void PageChanged(object sender, EventArgs e)
    {
        int Page = Convert.ToInt32(ddlJumpToPage.SelectedItem.Value);
        this.BindResult(Page);
    }
    protected void gvinvoiceno_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

    }
    protected void btnexporttoexport_Click(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "From-V-Up-Bonus.xls"));
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
    protected void LinkButton3_Click(object sender, EventArgs e)
    {
        try
        {
            ds = new DataSet();
            ds = objDynamicDtls.ByProcedure("abc_ProcCalInvestGwth", new string[] { }, new string[] { }, "ByDataset");
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = new DB().EmptyMessage("Your request could not be completed."); }
        finally
        {
            ds.Dispose();
        }

        try
        {
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
    protected void gvinvoiceno_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            TotCr += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "CREDIT"));
            TotDr += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "DEBIT"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[3].Text = "Total";
            e.Row.Cells[3].Font.Bold = true;
            e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Right;
            e.Row.Cells[4].Text = TotCr.ToString();
            e.Row.Cells[4].Font.Bold = true;
            e.Row.Cells[5].Text = TotDr.ToString();
            e.Row.Cells[5].Font.Bold = true;
        }
    }
}
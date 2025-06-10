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

public partial class Adm962xts21qtj_C_Wallet_Fund_Request : System.Web.UI.Page
{
    
    DataSet ds; string searchText;
    public int PageNo;
    public int Pagesize = Convert.ToInt16(ConfigurationManager.AppSettings["gridPageSize"]);
    DynamicDtls objgdb = new DynamicDtls();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Khbfy897ft36Gv"] != null)
        {
            //UserID = DB.base64Decod(Request.Cookies["Get563lnr43lbt"].Value);
            if (!IsPostBack)
            {
                detsdv.Visible = false;
                //ddlJumpToPage.Items.Clear();
                //int TotalRows = this.BindResult(1);
                //this.populateList(TotalRows);
                if (Request.QueryString["UserId"] != null)
                {
                    ddl_IncType.SelectedValue = "memid";
                    //DDLDownPos_SelectedIndexChanged(sender, e);
                    txtSearch.Text = Request.QueryString["UserId"].ToString();
                    txtSearch.Visible = true;
                }
                fill_DateType();
                //DDLDtType.ClearSelection();  
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
                //fill_SelectOne();
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
    public void fill_ColumnFilter()
    {
        try
        {
            //ddl_IncType.DataSource = METHOD("", "", "", "", "", "REQTYPE", "", "");
            //ddl_IncType.DataTextField = "ReqType";
            //ddl_IncType.DataValueField = "ReqType";
            //ddl_IncType.DataBind();
            //ddl_IncType.Items.Insert(0, "ALL");
            ddl_IncType.DataSource = METHOD("", "", "", "", "", "", "SELECT_ONE", "", "");
            ddl_IncType.DataTextField = "SELECT_ONE_TXT";
            ddl_IncType.DataValueField = "SELECT_ONE_VALUE";
            ddl_IncType.DataBind();
        }
        catch
        { }
    }
    public void fill_DateType()
    {
        try
        {
            ddldttTyp.DataSource = METHOD("", "", "", "", "", "", "DTTYPE", "", "");
            ddldttTyp.DataTextField = "DateType";
            ddldttTyp.DataValueField = "DateType";
            ddldttTyp.DataBind();
            ddldttTyp.Items.Insert(0, "ALL");
            //DDLDtType.DataSource = METHOD("","", "", "", "", "", "DTTYPE", "", "");
            ////DDLDtType.DataTextField = "DateType";
            ////DDLDtType.DataValueField = "DateType";
            //DDLDtType.DataBind();
            //DDLDtType.Items.Insert(0, "ALL");
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
    protected void ColumnFilterChanged(object sender, EventArgs e)
    {
        DDLDownPos.Items.Clear();
        txtSearch.Text = "";
        if (ddl_IncType.SelectedValue == "ALL")
        {
            DDLDownPos.Visible = false;
            txtSearch.Visible = false;
            detsdv.Visible = false;
        }
        else if (ddl_IncType.SelectedValue == "Status" || ddl_IncType.SelectedValue == "ReqType")
        {

            DDLDownPos.DataSource = METHOD("", "", "", "", "", "", ddl_IncType.SelectedValue.ToString().ToUpper(), "", "");
            DDLDownPos.DataTextField = "TYP";
            DDLDownPos.DataValueField = "TYP";
            DDLDownPos.DataBind();
            DDLDownPos.Visible = true;
            txtSearch.Visible = false;
        }
        else
        {
            txtSearch.Visible = true;
            DDLDownPos.Visible = false;
            detsdv.Visible = true;
        }
        //else if (ddl_IncType.SelectedValue == ""  
    }
    public DataSet METHOD(string DTTYPE, string FRM_DT, string TO_DT, string INCTYPE, string COLUMN, string VALUE, string FLAG, string PG_SIZE, string CURRENT_PG)
    {
        try
        {
            int TotalRecords = 0;
            ds = new DataSet();
            ds = objgdb.ByProcedure("DEPOSIT_REQUEST_REPORT", new string[] { "DTTYPE", "FRM_DT", "TO_DT", "INCTYPE", "COLUMN", "VALUE", "FLAG", "PG_SIZE", "CURRENT_PG" }, new string[] { DTTYPE, FRM_DT, TO_DT, INCTYPE, COLUMN, VALUE, FLAG, PG_SIZE, CURRENT_PG }, "ByDataset");
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = new DB().EmptyMessage("Sorry, Something is wrong please try later !"); }
        finally
        {
            ds.Dispose();
        }
        return ds;
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
            //ds = new DataSet();
            //ds = METHOD("", "", "", "", "", "GETTOTAL", "", "");
            //lblTotalSum.Text = "TOTAL CREDIT : " + ds.Tables[0].Rows[0]["TOTCREDIT"].ToString() + " ,           TOTAL DEBIT : " + ds.Tables[0].Rows[0]["TOTDEBIT"].ToString() + "   ,     BALANCE :" + ds.Tables[0].Rows[0]["BALANCE"].ToString();
            //ds.Dispose();
            ds = new DataSet();
            ds = METHOD(ddldttTyp.SelectedValue, txtFromDate.Text, txtToDate.Text, "ALL", ddl_IncType.SelectedValue, searchText.ToString(), "ReportData", (ConfigurationManager.AppSettings["gridPageSize"]).ToString(), currentPage.ToString());
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
        return TotalRows;
    }
    public void CountingShow()
    {
        if (ddlJumpToPage.SelectedItem.Text == "1")
        {
            PageNo = 1;
            //Pagesize
            lblRecordNo.Text = PageNo.ToString() + " - " + Pagesize.ToString() + " of "; ;
        }
        else
        {
            //PageNo = 1 + int.Parse(ddlJumpToPage.SelectedItem.Text);
            PageNo = int.Parse(ddlJumpToPage.SelectedItem.Text);
            //Pagesize = (Pagesize * int.Parse(ddlJumpToPage.SelectedItem.Text)); @PG_SIZE*(@CURRENT_PG-1)
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
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "F-Wallet-Fund-Request.xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        gvinvoiceno.AllowPaging = false;

        ddlJumpToPage.Items.Clear();
        int TotalRows = this.BindResult(1);
        this.populateList(TotalRows);

        if (gvinvoiceno.Rows.Count>0)
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






    //private int BindResult(int currentPage)
    //{
    //    int TotalRows = 0;
    //    try
    //    {
    //        if (txtSearch.Text == "")
    //        {

    //            if (DDLFillItems.Items.Count != 0)
    //            {
    //                SearchText = DDLFillItems.SelectedItem.Text;
    //            }
    //            else
    //            {
    //                SearchText = "";
    //            }
    //        }
    //        else
    //        {
    //            SearchText = txtSearch.Text.Trim();
    //        }



    //        FrmDt = txtFromDate.Text.Trim();
    //        ToDt = txtToDate.Text.Trim();
    //        strSearchText = SearchText.Replace("PENDING", "PDG");
    //        strPagesize = Pagesize.ToString();
    //        currentPage = currentPage;
    //        ColumnName = DDLDownPos.SelectedItem.Value;

    //        cn = new SqlConnection(new DB().getconnection());
    //        dt = new DataTable();
    //        sda = new SqlDataAdapter();
    //        cmd = new SqlCommand("dbo.Pro_StockiestRequestDetails");
    //        cmd.CommandType = CommandType.StoredProcedure;
    //        cmd.Parameters.Add("@intTotalRecords", SqlDbType.Int).Direction = ParameterDirection.Output;
    //        cmd.Parameters.AddWithValue("@strSearchText", SearchText);
    //        cmd.Parameters.AddWithValue("@intPageSize", Pagesize);
    //        cmd.Parameters.AddWithValue("@intCurrentPage", currentPage);
    //        cmd.Parameters.AddWithValue("@SrchByDjGt", "All");
    //        cmd.Parameters.AddWithValue("@FrmDt", txtFromDate.Text.Trim());
    //        cmd.Parameters.AddWithValue("@ToDt", txtToDate.Text.Trim());
    //        cmd.Parameters.Add("@ColumnName", SqlDbType.VarChar).Value = DDLDownPos.SelectedItem.Value;
    //        cmd.Parameters.AddWithValue("@status", "");
    //        cmd.Parameters.AddWithValue("@MemId", "");
    //        cmd.Parameters.AddWithValue("@id", "0");
    //        cmd.Parameters.AddWithValue("@Amt", "");

    //        cmd.Connection = cn;
    //        sda.SelectCommand = cmd;
    //        sda.Fill(dt);

    //        TotalRows = (int)cmd.Parameters["@intTotalRecords"].Value;
    //        if (TotalRows != 0)
    //        {
    //            grdUserDtl.Visible = true;
    //            lblgvrecord.Visible = false;
    //            grdUserDtl.PageIndex = currentPage - 1;

    //            grdUserDtl.DataSource = dt;
    //            grdUserDtl.DataBind();
    //            lblgvrecord.Text = "";
    //            idChangeSts.Visible = true;
    //        }
    //        else
    //        {

    //            lblgvrecord.Visible = true;
    //            lblgvrecord.Text = new DB().EmptyMessage(dt.Rows[0]["MSG"].ToString());
    //            grdUserDtl.Visible = false;
    //            idChangeSts.Visible = false;
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed.";
    //    }
    //    finally
    //    {
    //        sda.Dispose();
    //        cmd.Dispose();
    //        dt.Dispose();
    //        cn.Close();
    //        cn.Dispose();
    //    }
    //    return TotalRows;
    //}
    //protected void chkHeader_CheckedChanged(object sender, EventArgs e)
    //{
    //    CheckBox chkbox = (CheckBox)grdUserDtl.HeaderRow.FindControl("chkHeader");

    //    foreach (GridViewRow dr in grdUserDtl.Rows)
    //    {
    //        CheckBox chkselect = (CheckBox)dr.FindControl("chkSelect");
    //        if (chkbox.Checked == true)
    //        {
    //            chkselect.Checked = true;
    //        }
    //        else
    //        {
    //            chkselect.Checked = false;

    //        }
    //    }
    //}
    //private void populateList(int TotalRows)
    //{
    //    lblTotRec.Text = Convert.ToString(TotalRows);
    //    PageNo = Convert.ToInt32(Math.Floor(Convert.ToDouble((TotalRows / Pagesize))) + 1); ;
    //    for (int i = 1; i <= PageNo; i++)
    //    {
    //        ddlJumpToPage.Items.Add(new ListItem(i.ToString(), i.ToString()));
    //    }
    //    CountingShow();
    //}
    //public void CountingShow()
    //{
    //    if (ddlJumpToPage.SelectedItem.Text == "1")
    //    {
    //        PageNo = 1;
    //        //Pagesize
    //    }
    //    else
    //    {
    //        PageNo = 1 + int.Parse(ddlJumpToPage.SelectedItem.Text);
    //        Pagesize = (Pagesize * int.Parse(ddlJumpToPage.SelectedItem.Text));
    //    }
    //}
    //protected void btnSearch_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        ddlJumpToPage.Items.Clear();
    //        int TotalRows = this.BindResult(1);
    //        this.populateList(TotalRows);
    //    }
    //    catch (Exception ex)
    //    {
    //        DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed.";
    //    }
    //}
    //protected void PageChanged(object sender, EventArgs e)
    //{
    //    int Page = Convert.ToInt32(ddlJumpToPage.SelectedItem.Value);
    //    this.BindResult(PageNo);
    //    CountingShow();
    //}
    //protected void DDLDownPos_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    txtSearch.Text = "";
    //    if (DDLDownPos.SelectedValue == "pai.Status")
    //    {
    //        DDLFillItems.Items.Clear();
    //        DDLFillItems.Items.Insert(0, "PENDING");
    //        DDLFillItems.Items.Insert(1, "COMPLETED");
    //        DDLFillItems.Items.Insert(2, "REJECTED");
    //        DDLFillItems.Visible = true;
    //        txtSearch.Visible = false;
    //    }
    //    else if (DDLDownPos.SelectedValue == "pai.IssueMode")
    //    {
    //        DDLFillItems.Items.Clear();
    //        DDLFillItems.Items.Insert(0, "By Perfect Money");
    //        DDLFillItems.Items.Insert(1, "Bank Wire");
    //        DDLFillItems.Visible = true;
    //        txtSearch.Visible = false;
    //    }
    //    else if (DDLDownPos.SelectedValue == "pai.AccNo")
    //    {
    //        DDLFillItems.Items.Clear();
    //        DDLFillItems.Items.Insert(0, "NEFT");
    //        DDLFillItems.Items.Insert(1, "RTGS");
    //        DDLFillItems.Items.Insert(2, "IMPS");
    //        DDLFillItems.Items.Insert(3, "CHEQUE");
    //        DDLFillItems.Items.Insert(4, "CASH");
    //        DDLFillItems.Visible = true;
    //        txtSearch.Visible = false;
    //    }
    //    else
    //    {
    //        txtSearch.TextMode = TextBoxMode.SingleLine;
    //        DDLFillItems.Visible = false;
    //        txtSearch.Visible = true;
    //    }
    //}
    //protected void grdUserDtl_RowDataBound(object sender, GridViewRowEventArgs e)
    //{
    //    try
    //    {
    //        if (e.Row.RowType == DataControlRowType.DataRow)
    //        {
    //            Label lblAmt = (Label)e.Row.FindControl("lblAmt");
    //            try
    //            {
    //                TotalAmt = TotalAmt + float.Parse(lblAmt.Text);
    //            }
    //            catch (Exception ex)
    //            {
    //                DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed.";
    //            }
    //        }

    //        if (e.Row.Cells.Count > 2)
    //        {
    //            //e.Row.Cells[2].Visible = false;
    //            //e.Row.Cells[6].Visible = false;
    //        }


    //        if (e.Row.RowType == DataControlRowType.Footer)
    //        {
    //            Label lblTotalAmt = (Label)e.Row.FindControl("lblTotAmt");
    //            lblTotalAmt.Text = TotalAmt.ToString();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed.";
    //    }
    //}


    //public override void VerifyRenderingInServerForm(Control control)
    //{
    //    /* Verifies that the control is rendered */
    //}
    //protected void btnchangestatus_Click(object sender, EventArgs e)
    //{

    //    foreach (GridViewRow dr in grdUserDtl.Rows)
    //    {
    //        CheckBox chek = (CheckBox)dr.FindControl("chkselect");
    //        Label lblmemberID = (Label)dr.FindControl("lblmemberID");
    //        Label lblID = (Label)dr.FindControl("lblID");
    //        Label lblAmt = (Label)dr.FindControl("lblAmt");

    //        if (chek.Checked == true)
    //        {

    //            try
    //            {
    //                cn = new SqlConnection(new DB().getconnection());
    //                dt = new DataTable();
    //                sda = new SqlDataAdapter();
    //                cmd = new SqlCommand("dbo.Pro_StockiestRequestDetails");
    //                cmd.CommandType = CommandType.StoredProcedure;
    //                cmd.Parameters.Add("@intTotalRecords", SqlDbType.Int).Direction = ParameterDirection.Output;
    //                cmd.Parameters.AddWithValue("@strSearchText", "");
    //                cmd.Parameters.AddWithValue("@intPageSize", "");
    //                cmd.Parameters.AddWithValue("@intCurrentPage", "");
    //                cmd.Parameters.AddWithValue("@SrchByDjGt", "All");
    //                cmd.Parameters.AddWithValue("@FrmDt", "");
    //                cmd.Parameters.AddWithValue("@ToDt", "");
    //                cmd.Parameters.Add("@ColumnName", SqlDbType.VarChar).Value = "";
    //                cmd.Parameters.AddWithValue("@status", ddlchangeStatus.SelectedValue);
    //                cmd.Parameters.AddWithValue("@MemId", lblmemberID.Text.Trim());
    //                cmd.Parameters.AddWithValue("@id", lblID.Text.Trim());
    //                cmd.Parameters.AddWithValue("@Amt", lblAmt.Text.Trim());
    //                cmd.Connection = cn;
    //                sda.SelectCommand = cmd;
    //                ds = new DataSet();
    //                sda.Fill(ds);
    //                if (ds.Tables[0].Rows.Count > 0)
    //                {
    //                    ddlJumpToPage.Items.Clear();
    //                    int TotalRows = this.BindResult(1);
    //                    this.populateList(TotalRows);

    //                }
    //            }
    //            catch (Exception ex)
    //            {
    //                DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed.";
    //            }
    //            finally
    //            {
    //                sda.Dispose();
    //                cmd.Dispose();
    //                dt.Dispose();
    //                cn.Close();
    //                cn.Dispose();
    //            }
    //        }

    //    }



    //}

    //protected void DDLFillItems_SelectedIndexChanged1(object sender, EventArgs e)
    //{

    //    //DDLFillItems.Items.Clear();
    //    if (DDLFillItems.SelectedItem.Text == "PENDING")
    //    {
    //        ddlchangeStatus.Visible = true;
    //        btnchangestatus.Visible = true;

    //    }
    //    else if (DDLFillItems.SelectedItem.Text == "COMPLETED")
    //    {
    //        ddlchangeStatus.Visible = false;
    //        btnchangestatus.Visible = false;
    //    }

    //    else if (DDLFillItems.SelectedItem.Text == "REJECTED")
    //    {
    //        ddlchangeStatus.Visible = false;
    //        btnchangestatus.Visible = false;
    //    }
    //}
}

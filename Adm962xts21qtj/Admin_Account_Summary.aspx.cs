using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
public partial class Adm962xts21qtj_Admin_Account_Summary : System.Web.UI.Page
{
    DataSet ds; string searchText = "";
    public int Pagesize;
    public int PageNo;
    public decimal totPrfsI, totLvlIn, totBrdInc, totRylty, totTltInc, totRollp, totDepcrt, totDepamt, totWithd, totRegis, totFwall, totDifference, totreferal, totBusiness, totbooster;
    DynamicDtls objgdb = new DynamicDtls();
    protected void Page_Load(object sender, EventArgs e)
    {
        Pagesize = Convert.ToInt32(ddlGrpageSz.SelectedValue.Trim());
        if (Session["Khbfy897ft36Gv"] != null)
        {
            //UserID = DB.base64Decod(Request.Cookies["s7dxrpta6o"].Value);

            if (!IsPostBack)
            {
                if (Request.QueryString["MemId"] != null)
                {

                    DropDownList1.SelectedItem.Value = "MemID";
                    DropDownList1_SelectedIndexChanged(sender, e);
                    txtSearch.Text = Request.QueryString["MemId"].ToString();
                }
                ddlJumpToPage.Items.Clear();
                int TotalRows = this.BindResult(1);
                this.populateList(TotalRows);
            }
        }
        else
        {
            Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx");
        }
    }
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        btnSearch_Click(sender, e);
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
    public DataSet METHOD(string DTTYPE, string FRM_DT, string TO_DT, string INCTYPE, string COLUMN, string VALUE, string FLAG, string PG_SIZE, string CURRENT_PG)
    {
        try
        {
            int TotalRecords = 0;
            ds = new DataSet();
            ds = objgdb.ByProcedure("pro_Accountsummary_new", new string[] { "DTTYPE", "FRM_DT", "TO_DT", "INCTYPE", "COLUMN", "VALUE", "FLAG", "PG_SIZE", "CURRENT_PG" }, new string[] { DTTYPE, FRM_DT, TO_DT, INCTYPE, COLUMN, VALUE, FLAG, PG_SIZE, CURRENT_PG }, "ByDataset");
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
        string value = "";
        lblTotRec.Text = Convert.ToString(TotalRows);
        PageNo = Convert.ToInt32(Math.Floor(Convert.ToDouble((TotalRows / Pagesize))));
        for (int i = 1; i <= PageNo; i++)
        {
            value = "1";
            ddlJumpToPage.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
        if (value == "")
        {
            ddlJumpToPage.Items.Insert(0, "1");
        }

        CountingShow();
    }
    private int BindResult(int currentPage)
    {
        int TotalRows = 0;
        try
        {
            string filterType = DropDownList1.SelectedValue;
            string fromDate = txtFromDate.Text;
            string toDate = txtToDate.Text;
            string memberId = txtSearch.Text;
            string column = "All";
            string value = "";

            switch (filterType)
            {
                case "TxnDate":
                    column = "TxnDate";
                    value = "";
                    break;
                case "MemID":
                    column = "MemID";
                    value = memberId;
                    break;
                case "ALLMemID":
                    column = "ALLMemID";
                    value = "ALLMemID";
                    break;
            }

            ds = METHOD("", fromDate, toDate, "ALL", column, value, "ReportData", Pagesize.ToString(), currentPage.ToString());
            TotalRows = Convert.ToInt32(ds.Tables[1].Rows[0]["TOTALRECORD"]);

            if (TotalRows == 0)
            {
                lblMsg.Visible = true;
                gvinvoiceno.Visible = false;
                lblMsg.Text = "No records found.";
            }
            else
            {
                lblMsg.Visible = false;
                gvinvoiceno.Visible = true;
                gvinvoiceno.DataSource = ds.Tables[0];
                gvinvoiceno.DataBind();
                ddlJumpToPage.Items.Clear();
                this.populateList(TotalRows);
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
    protected void PageChangedPz(object sender, EventArgs e)
    {
        Pagesize = Convert.ToInt32(ddlGrpageSz.SelectedValue.Trim());
        this.BindResult(1);
        CountingShow();
    }
    protected void btnexporttoexport_Click(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "Account-Summary.xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        gvinvoiceno.AllowPaging = false;

        ddlJumpToPage.Items.Clear();
        int TotalRows = this.BindResult(1);
        this.populateList(TotalRows);

        //Change the Header Row back to white color
        gvinvoiceno.HeaderRow.Style.Add("background-color", "#FFFFFF");
        //Applying stlye to gridview header cells
        for (int i = 0; i < gvinvoiceno.HeaderRow.Cells.Count; i++)
        {
            gvinvoiceno.HeaderRow.Cells[i].Style.Add("background-color", "#df5015");
        }
        gvinvoiceno.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
}
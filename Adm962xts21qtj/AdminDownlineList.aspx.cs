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


public partial class Admin_AdminDownlineList : System.Web.UI.Page
{
    DataTable dt;
    SqlDataAdapter sda;
    SqlCommand cmd;
    DataSet ds; DB objdb = new DB();
    SqlConnection cn = new SqlConnection(new DB().getconnection());
    float TotalAmt, TotalStkAmt, TotWidAmt, TotTmBuss, TotStkWid, TotStkInc, TotStkBal = 0;
    static string DLMemID1, DecodeUID, SqlFillStatus;
    public static string DLMemID;
    //public int Pagesize = Convert.ToInt16(ConfigurationManager.AppSettings["gridPageSize"]);
    public int Pagesize;
    public int PageNo;
    DynamicDtls objgdb = new DynamicDtls();
    protected void Page_Load(object sender, EventArgs e)
    {
        Pagesize = Convert.ToInt32(ddlGrpageSz.SelectedValue.Trim());
        if (Session["Khbfy897ft36Gv"] != null)
        {
            if (!IsPostBack)
            {
                DLMemID = txtSearch.Text;
                if (txtSearch.Text == "" && Request.QueryString["MemID"] == null)
                {

                    cmd = new SqlCommand("select top 1 memid from memdetail with (nolock)order by acmemid", cn);
                    cn.Open();
                    string strsearch = (string)cmd.ExecuteScalar();
                    cn.Close();

                    DLMemID = txtSearch.Text = strsearch;
                    Session["UserID"] = strsearch;
                    lblDirect.Text = "<a class=Uparmenu href='AdminCurrentLevelStatus.aspx?UserID=" + strsearch + "'>  <img align=absmiddle src=../UserPanel_Images/Update_Status_Icon.png>&nbsp;Direct User List</a>";
                    ddlJumpToPage.Items.Clear();
                    int TotalRows = this.BindResult(1);
                    this.populateList(TotalRows);
                }
                else
                {
                    DLMemID = txtSearch.Text = Request.QueryString["MemID"].ToString();
                    Session["UserID"] = Request.QueryString["MemID"].ToString();
                    lblDirect.Text = "<a class=Uparmenu href='AdminCurrentLevelStatus.aspx?UserID=" + txtSearch.Text + "'>  <img align=absmiddle src=../UserPanel_Images/Update_Status_Icon.png>&nbsp;Direct User List</a>";
                    ddlJumpToPage.Items.Clear();
                    int TotalRows = this.BindResult(1);
                    this.populateList(TotalRows);
                }

            }
        }
        //}

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
        //Response.Redirect("Downlinelist.aspx?MemID=" + txtSearch.Text.Trim());
    }

    private int BindResult(int currentPage)
    {
        string searchtext = string.Empty;
        //txtSearch.AutoPostBack = true;
        if (txtSearch.Text == "")
        {
            searchtext = objgdb.TopId();
        }
        else
        {
            searchtext = txtSearch.Text;
        }
        int TotalRows = 0;
        DataTable dt = new DataTable();
        SqlDataAdapter sda = new SqlDataAdapter();//dbo.sp_UserDownlineAllSearchList_New
        SqlCommand cmd = new SqlCommand("dbo.UserDownlineAllSearchList_WithStk");
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add("@intTotalRecords", SqlDbType.Int).Direction = ParameterDirection.Output;
        cmd.Parameters.AddWithValue("@strSearchText", searchtext.Trim());
        cmd.Parameters.AddWithValue("@intPageSize", Convert.ToInt32(ddlGrpageSz.SelectedValue.Trim()));
        cmd.Parameters.AddWithValue("@intCurrentPage", currentPage);
        cmd.Parameters.AddWithValue("@SrchByDjGt", DDLSrchByDjGt.SelectedItem.Value);
        cmd.Parameters.AddWithValue("@FrmDt", txtFromDate.Text.Trim());
        cmd.Parameters.AddWithValue("@ToDt", txtToDate.Text.Trim());

        cmd.Parameters.Add("@DownPos", SqlDbType.VarChar).Value = DDLDownPos.SelectedItem.Text;

        cmd.Connection = cn;
        sda.SelectCommand = cmd;
        sda.Fill(dt);
        TotalRows = (int)cmd.Parameters["@intTotalRecords"].Value;
        grdUserDtl.PageIndex = currentPage - 1;
        grdUserDtl.DataSource = dt;
        grdUserDtl.DataBind();
        return TotalRows;
    }
    public void CountingShow()
    {
        try
        {
            //if (ddlJumpToPage.SelectedItem.Text == "1" || ddlJumpToPage.SelectedItem.Text.ToString() == "")
            //{
            //    PageNo = 1;
            //    //Pagesize
            //}
            //else
            //{
            //    PageNo = 1 + int.Parse(ddlJumpToPage.SelectedItem.Text);
            //    Pagesize = (Pagesize * int.Parse(ddlJumpToPage.SelectedItem.Text));
            //}

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
        catch { }
    }
    private void populateList(int TotalRows)
    {
        //string value = "";
        //int PageCount = Convert.ToInt32(Math.Floor(Convert.ToDouble((TotalRows / Pagesize)))); ;
        //for (int i = 1; i <= PageCount; i++)
        //{
        //    value = "1";
        //    ddlJumpToPage.Items.Add(new ListItem(i.ToString(), i.ToString()));
        //}
        //if (value == "")
        //{
        //     ddlJumpToPage.Items.Insert(0, "1");
        //}
        //CountingShow();
        string value = "";
        lblTotRec.Text = Convert.ToString(TotalRows);
        PageNo = Convert.ToInt32(Math.Floor(Convert.ToDouble((TotalRows / Pagesize))) + 1);
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

    protected void PageChanged(object sender, EventArgs e)
    {
        int Page = Convert.ToInt32(ddlJumpToPage.SelectedItem.Value);
        this.BindResult(Page);
        CountingShow();
    }
    protected void DDLSrchByDjGt_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (DDLSrchByDjGt.SelectedItem.Text.Trim() == "Level No" || DDLSrchByDjGt.SelectedItem.Text.Trim() == "Position" || DDLSrchByDjGt.SelectedItem.Text.Trim() == "Package")
        {
            txtSearch.AutoPostBack = false;
            if (DDLSrchByDjGt.SelectedItem.Text.Trim() == "Level No")
            {
                string searchtext = string.Empty;
                //txtSearch.AutoPostBack = true;
                if (txtSearch.Text == "")
                {
                    searchtext = DB.GetTopUserId();
                }
                else
                {
                    searchtext = txtSearch.Text;
                }
                SqlFillStatus = "select distinct LevelNo from downlinedetails with(nolock) where memid='" + searchtext + "' order by LevelNo";
            }
            else if (DDLSrchByDjGt.SelectedItem.Text.Trim() == "Position")
            {
                txtSearch.AutoPostBack = false;
                SqlFillStatus = "select Pos from  positionMaster";
            }

            else
            { }

            ds = new DataSet();
            DDLDownPos.Items.Clear();

            foreach (DataRow dr in new DB().SelectRows(ds, SqlFillStatus).Tables[0].Rows)
            {
                DDLDownPos.Items.Add(dr[0].ToString());

            }
            ListItem l = new ListItem("ALL", "0", true); l.Selected = true;
            DDLDownPos.Items.Add(l);

            ds.Dispose();
        }
        else
        {
            DDLDownPos.Items.Clear();
            ListItem l = new ListItem("ALL", "0", true); l.Selected = true;
            DDLDownPos.Items.Add(l);
        }
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        //if (DDLSrchByDjGt.SelectedItem.Text.Trim() == "Level No")
        //{
        //    SqlFillStatus = "select distinct LevelNo from downlinedetails with(nolock) where memid='" + txtSearch.Text + "'";
        //    ds = new DataSet();
        //    DDLDownPos.Items.Clear();

        //    foreach (DataRow dr in new DB().SelectRows(ds, SqlFillStatus).Tables[0].Rows)
        //    {
        //        DDLDownPos.Items.Add(dr[0].ToString());

        //    }
        //    ListItem l = new ListItem("ALL", "0", true); l.Selected = true;
        //    DDLDownPos.Items.Add(l);

        //    ds.Dispose();
        //}
    }
    protected void btnexporttoexport_Click(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "My-DownlineReport.xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        grdUserDtl.AllowPaging = false;

        ddlJumpToPage.Items.Clear();
        int TotalRows = this.BindResult(1);
        this.populateList(TotalRows);

        //Change the Header Row back to white color
        grdUserDtl.HeaderRow.Style.Add("background-color", "#FFFFFF");
        //Applying stlye to gridview header cells
        for (int i = 0; i < grdUserDtl.HeaderRow.Cells.Count; i++)
        {
            grdUserDtl.HeaderRow.Cells[i].Style.Add("background-color", "#df5015");
        }
        grdUserDtl.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }

    protected void grdUserDtl_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblAmt = (Label)e.Row.FindControl("lblAmt");
                Label lblStkAmt = (Label)e.Row.FindControl("lblStkAmt");
                Label lblWidAmt = (Label)e.Row.FindControl("lblWidAmt");
                Label lblTmBuss = (Label)e.Row.FindControl("lblTmBuss");
                Label lblStkWid = (Label)e.Row.FindControl("lblStkWid");
                Label lblStkInc = (Label)e.Row.FindControl("lblStkInc");
                Label lblStkBal = (Label)e.Row.FindControl("lblStkBal");

                try
                {
                    TotalAmt = TotalAmt + float.Parse(lblAmt.Text);
                    TotalStkAmt = TotalStkAmt + float.Parse(lblStkAmt.Text);
                    TotWidAmt = TotWidAmt + float.Parse(lblWidAmt.Text);
                    TotTmBuss = TotTmBuss + float.Parse(lblTmBuss.Text);
                    TotStkWid = TotStkWid + float.Parse(lblStkWid.Text);
                    TotStkInc = TotStkInc + float.Parse(lblStkInc.Text);
                    TotStkBal = TotStkBal + float.Parse(lblStkBal.Text);
                }
                catch (Exception ex)
                {
                    DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
                    lblMsg.Text = "Your request could not be completed.";
                }
            }

            if (e.Row.Cells.Count > 2)
            {
                //e.Row.Cells[2].Visible = false;
                // e.Row.Cells[6].Visible = false;
            }


            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label lblTotalAmt = (Label)e.Row.FindControl("lblTotAmt");
                Label lblTotalStkAmt = (Label)e.Row.FindControl("lblStkTotAmt");
                Label lblTotalWid = (Label)e.Row.FindControl("lblTotWid");
                Label lblTotTmBuss = (Label)e.Row.FindControl("lblTotTmBuss");
                Label lblStkTotWid = (Label)e.Row.FindControl("lblStkTotWid");
                Label lblStkTotInc = (Label)e.Row.FindControl("lblStkTotInc");
                Label lblStkTotBal = (Label)e.Row.FindControl("lblStkTotBal");

                lblTotalAmt.Text = TotalAmt.ToString();
                lblTotalStkAmt.Text = TotalStkAmt.ToString();
                lblTotalWid.Text = TotWidAmt.ToString();
                lblTotTmBuss.Text = TotTmBuss.ToString();
                lblStkTotWid.Text = TotStkWid.ToString();
                lblStkTotInc.Text = TotStkInc.ToString();
                lblStkTotBal.Text = TotStkBal.ToString();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed.";
        }
    }
}


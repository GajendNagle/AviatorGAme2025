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
using System.Drawing;
using System.IO;
public partial class ControlSection_AdminCurrentLevelStatus : System.Web.UI.Page
{
    DynamicDtls objDynamicDtls = new DynamicDtls();
    DataSet ds;
    string UserID;
    public int PageNo;
    public int Pagesize = Convert.ToInt16(ConfigurationManager.AppSettings["gridPageSize"]);
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Khbfy897ft36Gv"] != null)
        {
            if (!IsPostBack)
            {
                try
                {
                    if (Request.QueryString["UserID"] != null)
                    {
                        // UserID = 
                        txtSearch.Text = Request.QueryString["UserID"].ToString();
                        ddlJumpToPage.Items.Clear();
                        int TotalRows = this.BindResult(1);
                        this.populateList(TotalRows);

                    }
                    else
                    {
                        ddlJumpToPage.Items.Clear();
                        int TotalRows = this.BindResult(1);
                        this.populateList(TotalRows);
                        txtSearch.Text = UserID;
                    }
                }
                catch (Exception ex)
                {
                    DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = new DB().ErrorMessage("Your request could not be completed.");
                }
            }
        }
        else
        {
            Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
        }
    }

    private int BindResult(int currentPage)
    {
        int TotalRows = 0;

        ds = objDynamicDtls.ByProcedure("DIRECT_USERLIST_PROC", new string[] { "FRM_DT", "TO_DT", "COLUMN", "VALUE", "PG", "CURRENT_PG" }, new string[] { txtFromDate.Text.Trim(), txtToDate.Text.Trim(), DDLDownPos.SelectedItem.Value, txtSearch.Text.Trim(), Pagesize.ToString(), currentPage.ToString(), }, "BYDATASET");
        if (ds.Tables[0].Rows.Count > 0)
        {
            gv1.Visible = true;
            lblMsg.Visible = false;
            gv1.DataSource = ds.Tables[0];
            gv1.DataBind();

            TotalRows = Convert.ToUInt16(ds.Tables[1].Rows[0][0].ToString());
        }
        else
        {
            lblMsg.Visible = true;
            gv1.Visible = false;
            lblMsg.Text = new DB().EmptyMessage("Oops..No Record Found..!");
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

    protected void PageChanged(object sender, EventArgs e)
    {
        int Page = Convert.ToInt32(ddlJumpToPage.SelectedItem.Value);
        this.BindResult(Page);
        CountingShow();
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
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = new DB().ErrorMessage("Your request could not be completed.");
        }
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
    protected void btnexporttoexport_Click(object sender, EventArgs e)
    {
        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "User-Directs.xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        gv1.AllowPaging = false;

        ddlJumpToPage.Items.Clear();
        int TotalRows = this.BindResult(1);
        this.populateList(TotalRows);

        if (gv1.Rows.Count > 0)
        {
            //Change the Header Row back to white color
            gv1.HeaderRow.Style.Add("background-color", "#FFFFFF");
            //Applying stlye to gridview header cells
            for (int i = 0; i < gv1.HeaderRow.Cells.Count; i++)
            {
                gv1.HeaderRow.Cells[i].Style.Add("background-color", "#df5015");
            }
        }

        gv1.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }

    protected void DDLDownPos_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtSearch.Text = "";
        if (DDLDownPos.SelectedItem.Text == "SPONSERID")
        {
            DDLFillItems.Visible = false;
            txtSearch.Visible = true;
        }
        else
        {
            txtSearch.TextMode = TextBoxMode.SingleLine;
            DDLFillItems.Visible = false;
            txtSearch.Visible = true;
        }
    }
}






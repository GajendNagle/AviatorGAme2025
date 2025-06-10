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
using System.IO;

public partial class Admin_ViewContactEnquiry : System.Web.UI.Page
{
    DB objdb = new DB();
    DynamicDtls objDynamicDtls = new DynamicDtls();
    DataSet ds;
    public int Pagesize = Convert.ToInt16(ConfigurationManager.AppSettings["gridPageSize"]);
    public int PageNo;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            try
            {
                ddlJumpToPage.Items.Clear();
                int TotalRows = this.BindResult(1);
                this.populateList(TotalRows);
            }
            catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg1.Text = "Your request could not be completed."; }

        }
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
        PageNo = Convert.ToInt32(ddlJumpToPage.SelectedItem.Value);
        this.BindResult(PageNo);
        CountingShow();
    }

    private int BindResult(int currentPage)
    {
        int TotalRows = 0;
        ds=objDynamicDtls.ByProcedure("ProcViewEnquiryDetails", new string[] { "intPageSize", "intCurrentPage", "FrmDt", "ToDt" }, new string[] { Pagesize.ToString(), currentPage.ToString(), FromDate.Text, ToDate.Text }, "intTotalRecords", out TotalRows, "byd");


        if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0][0].ToString() != "Sorry, No record found..!!")
        {
            lblMsg1.Text = "";
            GridView2.Visible = true;
            GridView2.PageIndex = currentPage - 1;
            GridView2.DataSource = ds;
            GridView2.DataBind();
        }
        else
        {
            lblMsg1.Text = new DB().EmptyMessage(ds.Tables[0].Rows[0]["MSG"].ToString());
            GridView2.Visible = false;
        }
        return TotalRows;

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ddlJumpToPage.Items.Clear();
        int TotalRows = this.BindResult(1);
        this.populateList(TotalRows);
    }
    protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
      
    }
    protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int EnqNO = Convert.ToInt32(GridView2.DataKeys[e.RowIndex].Value);
            objdb.ByText("Delete EnquiryDetails where id='" + EnqNO + "'");
            lblMsg1.Text = objdb.AdminErrorMessage("!!  Record Deleted !!"); 
            lblMsg1.ForeColor = System.Drawing.Color.Green;
            ddlJumpToPage.Items.Clear();
            int TotalRows = this.BindResult(1);
            this.populateList(TotalRows);
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg1.Text = "Your request could not be completed.";
        }
    }
    protected void imgbtnView_Click(object sender, EventArgs e)
    {
        ddlJumpToPage.Items.Clear();
        int TotalRows = this.BindResult(1);
        this.populateList(TotalRows);
    }

    protected void btnexporttoexport_Click(object sender, EventArgs e)
    {
        //Response.ClearContent();
        //Response.Buffer = true;
        //Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "Report.xls"));
        //Response.ContentType = "application/ms-excel";
        //StringWriter sw = new StringWriter();
        //HtmlTextWriter htw = new HtmlTextWriter(sw);
        //GridView2.AllowPaging = false;

        //ddlJumpToPage.Items.Clear();
        //int TotalRows = this.BindResult(1);
        //this.populateList(TotalRows);

        //GridView2.RenderControl(htw);
        //Response.Write(sw.ToString());
        //Response.End();

        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "Enquiry-Reports.xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        GridView2.AllowPaging = false;

        //ddlJumpToPage.Items.Clear();
        int TotalRows = this.BindResult(Convert.ToInt32(ddlJumpToPage.SelectedItem.Value));
        this.populateList(TotalRows);

        if (GridView2.Rows.Count > 0)
        {
            //Change the Header Row back to white color
            GridView2.HeaderRow.Style.Add("background-color", "#FFFFFF");
            //Applying stlye to gridview header cells
            for (int i = 0; i < GridView2.HeaderRow.Cells.Count; i++)
            {
                GridView2.HeaderRow.Cells[i].Style.Add("background-color", "#df5015");
            }
        }

        GridView2.RenderControl(htw);
        Response.Write(sw.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.Cells.Count > 2)
        {
            e.Row.Cells[2].Visible = false;
        } 
    }
}

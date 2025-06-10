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

public partial class Adm962xts21qtj_ViewOTPList : System.Web.UI.Page
{
    DynamicDtls objgdb = new DynamicDtls(); DataSet ds; DataTable dt;
    public bool sc; public string msg, dtl, strJson, UserID, Role, Filter, SearchText, Psize = "20";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Khbfy897ft36Gv"] != null)
            {
                if (!IsPostBack)
                {
                    
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
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Oops, Somthing is wrong, Please try later !"; ;}

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        ddlJumpToPage.Items.Clear();
        int TotalRows = this.BindResult(1);
        this.populateList(TotalRows);
    }
    private int BindResult(int currentPage)
    {
        
        int TotalRows = 0;
        try
        {
            ds = objgdb.ByProcedure("dbo.getOtpList", new string[] { "intPageSize", "intCurrentPage", "VALUE", "FRM_DT", "ACTUAL_TODT", "COLUMN" },
                new string[] { ConfigurationManager.AppSettings["gridPageSize"], currentPage.ToString(), txtSearch.Text.Trim(), txtFromDate.Text.Trim(), txtToDate.Text.Trim(), DDLDownPos.SelectedValue }, "intTotalRecords", out TotalRows, "ByDataset");

            //TotalRows = Convert.ToInt32(ds.Tables[0].Rows.Count.ToString());
            if (TotalRows > 0)
            {
                dt = ds.Tables[0];
                int count = TotalRows;
                grdUserDtl.PageIndex = currentPage - 1;
                grdUserDtl.DataSource = dt;
                grdUserDtl.DataBind();
                detsdv.Visible = true;

            }
            else
            {
                grdUserDtl.DataSource = null;
                grdUserDtl.DataBind();                

            }
        }
        catch (Exception ex)
        {
            grdUserDtl.DataSource = null;
            grdUserDtl.DataBind();
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace);
        }
        finally
        {
            if (ds != null) { ds.Dispose(); }
        }
        return TotalRows;
    }

    private void populateList(int TotalRows)
    {
        lblTotRec.Text = "Total Records Found :" + Convert.ToString(TotalRows);
        int PageCount = Convert.ToInt32(Math.Floor(Convert.ToDouble((TotalRows / Convert.ToInt32(ConfigurationManager.AppSettings["gridPageSize"])))) + 1); ;
        for (int i = 1; i <= PageCount; i++)
        {
            ddlJumpToPage.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }
    }

    protected void PageChanged(object sender, EventArgs e)
    {
        int Page = Convert.ToInt32(ddlJumpToPage.SelectedItem.Value);
        this.BindResult(Page);
    }

}

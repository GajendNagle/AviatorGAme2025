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

public partial class Adm962xts21qtj_Admin_Login_History : System.Web.UI.Page
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
                Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx");
            }
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Oops, Somthing is wrong, Please try later !"; ; }

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
            ds = objgdb.ByProcedure("dbo.getAdminLoginHistoryReport", new string[] { "intPageSize", "intCurrentPage", "VALUE", "FRM_DT", "ACTUAL_TODT", "COLUMN" },
                new string[] { ConfigurationManager.AppSettings["gridPageSize"], currentPage.ToString(), txtSearch.Text.Trim(), txtFromDate.Text.Trim(), txtToDate.Text.Trim(), DDLDownPos.SelectedValue }, "intTotalRecords", out TotalRows, "ByDataset");

            if (TotalRows > 0)
            {
                dt = ds.Tables[0];
                int count = TotalRows;
                grdUserDtl.PageIndex = currentPage - 1;
                grdUserDtl.DataSource = dt;
                grdUserDtl.DataBind();
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
        lblTotRec.Text = "Total Records Found : " + Convert.ToString(TotalRows);
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
    protected void BtnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            CheckBox chk;
            string strID = string.Empty;
            string st = string.Empty;
            int totalRows = grdUserDtl.Rows.Count;
            int selectedRows = 0;
            foreach (GridViewRow rw in grdUserDtl.Rows)
            {
                chk = rw.FindControl("CBDelete") as CheckBox;
                if (chk.Checked == true)
                {
                    Label lb = rw.FindControl("lb") as Label;
                    strID += lb.Text.ToString().TrimEnd() + ",";
                    selectedRows++;
                }
            }
            if (strID != "" && strID != string.Empty)
            {
                int strlen = strID.Length;
                st = strID.Substring(0, strlen - 1);
                ds = new DataSet();
                ds = DELETEMETHOD(st);
                if (selectedRows == totalRows && totalRows > 0)
                {
                    Session.Abandon();
                    Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx");
                }
                else
                {
                    this.BindResult(1);
                    lblMsg.Text = "Record Deleted successfully.";
                }
            }
            else
            {
                lblMsg.Text = "Please select record for delete.";
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

    public DataSet DELETEMETHOD(string UserID)
    {
        try
        {
            int TotalRecords = 0;
            ds = new DataSet();
            ds = objgdb.ByProcedure("Delete_AdminLoginHistory", new string[] { "ID" }, new string[] { UserID }, "ByDataset");
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = new DB().EmptyMessage("Sorry, Something is wrong please try later !"); }
        finally
        {
            ds.Dispose();
        }
        return ds;
    }

}
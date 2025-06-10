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

public partial class Admin_Appsetting : System.Web.UI.Page
{
    DataSet ds;
    DynamicDtls objgdb = new DynamicDtls();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Khbfy897ft36Gv"] != null)
            {
                if (!IsPostBack)
                {
                    feelgrid();
                }
            }
            else
            {
                Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
            }

        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed."; ;}
    }
    public void feelgrid()
    {
        try
        {
            ds = objgdb.ByProcedure("ProcInvsAppSetting", new string[] { "id", "Code", "Value", "Remark", "Status", "type" },
                new string[] { "0", "", "", "", "", "0" }, "Bydateset");
            GridView2.DataSource = ds.Tables[0];
            GridView2.DataBind();
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed."; ;}
    }

    protected void GridView2_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView2.EditIndex = -1;
        feelgrid();
    }
    protected void GridView2_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView2.EditIndex = e.NewEditIndex;
        feelgrid();

    }
    protected void GridView2_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            int id = Convert.ToInt32(GridView2.DataKeys[e.RowIndex].Value);
           
            TextBox txtRemarks = (TextBox)GridView2.Rows[e.RowIndex].Cells[2].FindControl("txtRemark");
            TextBox txtValue = (TextBox)GridView2.Rows[e.RowIndex].Cells[3].FindControl("txtValue");
            DropDownList ddlStatus = (DropDownList)GridView2.Rows[e.RowIndex].Cells[4].FindControl("ddlStatus");
          

            ds = objgdb.ByProcedure("ProcInvsAppSetting", new string[] { "id", "Code", "Value", "Remark", "Status", "type" },
                 new string[] { id.ToString(), "", txtValue.Text, txtRemarks.Text, ddlStatus.SelectedItem.Text, "1" }, "Bydateset");
            lblMsg.Text = ds.Tables[0].Rows[0][0].ToString();
            GridView2.EditIndex = -1;
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed."; ;}
        feelgrid();
       
    }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
           
            if ((e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                Label lblStatus = (Label)e.Row.FindControl("lblStatus");
                DropDownList ddlStatus = (DropDownList)e.Row.FindControl("ddlStatus");
                ddlStatus.ClearSelection();
                ddlStatus.Items.FindByText(lblStatus.Text).Selected = true;

            }
        }
    }
}

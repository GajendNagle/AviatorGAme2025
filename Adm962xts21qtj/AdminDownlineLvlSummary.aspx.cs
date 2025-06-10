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

public partial class Admin_DownlineLvlSummary : System.Web.UI.Page
{
    SqlConnection cn = new SqlConnection(new DB().getconnection());
    SqlCommand cmd; string UserID, TotalRecords; SqlDataAdapter da; DataSet ds;
    float TotalU, TotalPV;
    DynamicDtls objgdb = new DynamicDtls();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Khbfy897ft36Gv"] != null)
        {
            if (Request.QueryString["UserID"] != null)
            {
                UserID = Request.QueryString["UserID"].ToString();
                this.GetDirectMemberFill();
            }
            else
            {
                UserID = objgdb.TopId();
                this.GetDirectMemberFill();
            }
        }
        else
        {
            Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
        }
    }
    private void GetDirectMemberFill()
    {
        try
        {
            cmd = new SqlCommand("Proc_GetLvlSummary", cn);
            cmd.Parameters.AddWithValue("@MemID", UserID);
            cmd.CommandType = CommandType.StoredProcedure;
            da = new SqlDataAdapter(cmd);
            ds = new DataSet();
            da.Fill(ds);

            TotalRecords = ds.Tables[0].Rows[0]["TotalRows"].ToString();
            if (TotalRecords == "0")
            {
                GridView1.Visible = false;
                lblMsg.Text = new DB().EmptyMessage(ds.Tables[1].Rows[0]["MSG"].ToString());
            }
            else
            {
                GridView1.Visible = true;
                GridView1.DataSource = ds.Tables[1];
                GridView1.DataBind();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed."; 
        }
        finally
        {
            cmd.Dispose();
            ds.Dispose();
        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            TotalU += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalUser"));
           // TotalPV += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "PV"));
        }
        else if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[2].Text = "TOTAL";
            e.Row.Cells[3].Text = Convert.ToString(TotalU);
            //e.Row.Cells[4].Text = Convert.ToString(TotalPV);
        }
    }
}

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


public partial class Adm962xts21qtj_AdminViewBankCardDetails : System.Web.UI.Page
{
    SqlConnection cn; float TotalAmt = 0;
    DataSet ds; SqlDataAdapter sda; SqlCommand cmd;
    string strSearchText;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Khbfy897ft36Gv"] != null)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["FrmDt"] != null && Request.QueryString["ToDt"] != null &&
                    Request.QueryString["strSearchText"] != null && Request.QueryString["Pagesize"] != null &&
                    Request.QueryString["currentPage"] != null && Request.QueryString["ColumnName"] != null)
                {
                    this.BindResult();

                }
            }
        }
        else
        {
            Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
        }
    }

    protected void btnexporttoexport_Click(object sender, ImageClickEventArgs e)
    {

        Response.ClearContent();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", string.Format("attachment; filename={0}", "ViewBankCardDetails.xls"));
        Response.ContentType = "application/ms-excel";
        StringWriter sw = new StringWriter();
        HtmlTextWriter htw = new HtmlTextWriter(sw);
        grdUserDtl.AllowPaging = false;

        this.BindResult();
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
    private void BindResult()
    {
        int TotalRows = 0;
        try
        {
            if (Request.QueryString["strSearchText"].ToString().Trim() == "PDG")
            {
                strSearchText = "PENDING";
                //strSearchText = Request.QueryString["strSearchText"].ToString().Trim();
            }
            else
            {
                strSearchText = Request.QueryString["strSearchText"].ToString().Trim();
            }
            cn = new SqlConnection(new DB().getconnection());
            ds = new DataSet();
            sda = new SqlDataAdapter();
            cmd = new SqlCommand("dbo.Pro_AdminBankPayoutDetails");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@intTotalRecords", SqlDbType.Int).Direction = ParameterDirection.Output;
            cmd.Parameters.AddWithValue("@strSearchText", strSearchText);
            cmd.Parameters.AddWithValue("@intPageSize", Request.QueryString["Pagesize"].ToString().Trim());
            cmd.Parameters.AddWithValue("@intCurrentPage", Request.QueryString["currentPage"].ToString().Trim());
            cmd.Parameters.AddWithValue("@SrchByDjGt", Request.QueryString["WthType"].ToString().Trim());
            cmd.Parameters.AddWithValue("@FrmDt", Request.QueryString["FrmDt"].ToString().Trim());
            cmd.Parameters.AddWithValue("@ToDt", Request.QueryString["ToDt"].ToString().Trim());
            cmd.Parameters.Add("@ColumnName", SqlDbType.VarChar).Value = Request.QueryString["ColumnName"].ToString().Trim();
            cmd.Parameters.AddWithValue("@status", "");
            cmd.Parameters.AddWithValue("@MemId", txtLeaderID.Text.Trim());
            cmd.Parameters.AddWithValue("@id", "0");

            cmd.Connection = cn;
            sda.SelectCommand = cmd;
            sda.Fill(ds);
            TotalRows = (int)cmd.Parameters["@intTotalRecords"].Value;
            if (TotalRows != 0)
            {
                grdUserDtl.Visible = true;

                grdUserDtl.DataSource = ds;
                grdUserDtl.DataBind();

            }
            else
            {
                lblMsg.Text = new DB().EmptyMessage(ds.Tables[0].Rows[0]["MSG"].ToString());
                grdUserDtl.Visible = false;
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed.";
        }
        finally
        {
            if (cn != null && cn.State == ConnectionState.Open)
            {
                cn.Close();
                cn.Dispose();
            }
            if (ds != null) { ds.Dispose(); }
            if (sda != null) { sda.Dispose(); }
            if (cmd != null) { cmd.Dispose(); }
        }
    }
    protected void grdUserDtl_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblAmt = (Label)e.Row.FindControl("lblAmt");
                try
                {
                    TotalAmt = TotalAmt + float.Parse(lblAmt.Text);
                }
                catch (Exception ex)
                {
                    DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed.";
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
                lblTotalAmt.Text = TotalAmt.ToString();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = "Your request could not be completed.";
        }
    }
    protected void btnFind_Click(object sender, EventArgs e)
    {
        this.BindResult();
    }
}

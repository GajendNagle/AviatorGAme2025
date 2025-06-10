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

public partial class Adm962xts21qtj_Account_Setting_User : System.Web.UI.Page
{
    SqlConnection cn = new SqlConnection(new DB().getconnection());
    SqlCommand cmd;
    SqlDataReader dr;

    SqlDataAdapter da;
    DataSet ds;
    DynamicDtls objDBConnectHP = new DynamicDtls();
    public int PageNo;
    public int Pagesize = Convert.ToInt16(ConfigurationManager.AppSettings["gridPageSize"]);
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (Session["Khbfy897ft36Gv"] != null)
            {
                if (!IsPostBack)
                {

                    ddlJumpToPage.Items.Clear();
                    int TotalRows = this.feelgridAll(1);
                    this.populateList(TotalRows);
                }
                cbProfile.Attributes.Add("onclick", "CheckOnlyOneP(event);");
                cbLogin.Attributes.Add("onclick", "CheckOnlyOneL(event);");
                cbRegister.Attributes.Add("onclick", "CheckOnlyOneR(event);");
                cbTopUp.Attributes.Add("onclick", "CheckOnlyOneT(event);");
                cbWithDrawal.Attributes.Add("onclick", "CheckOnlyOneW(event);");
                cblvlbonus.Attributes.Add("onclick", "CheckOnlyOnelvlbns(event);");
                chkstkdiviwid.Attributes.Add("onclick", "CheckOnlyOneStkDiviWid(event);");
            }
            else
            {
                Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
            }

        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg1.Text = "Sorry, Something is wrong please try later !";
        }
    }
    private void clears()
    {

    }
    protected void PageChanged(object sender, EventArgs e)
    {
        int Page = Convert.ToInt32(ddlJumpToPage.SelectedItem.Value);
        feelgridAll(Page);
        //this.BindResult(Page);
        CountingShow();

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
    protected void GetMemIDDetail(object sender, EventArgs e)
    {
        ddlJumpToPage.Items.Clear();
        int TotalRows = this.feelgrid(1, TxtMemID.Text.TrimEnd());
        this.populateList(TotalRows);

    }
    protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //e.Row.ToolTip = (e.Row.DataItem as DataRowView)["Description"].ToString();
            Label lbllog = (Label)e.Row.FindControl("lblomsg");
            Label lblpro = (Label)e.Row.FindControl("lbprmsg");
            Label lblreg = (Label)e.Row.FindControl("lbremsg");
            Label lbltop = (Label)e.Row.FindControl("lbtomsg");
            Label lblwit = (Label)e.Row.FindControl("lbwimsg");
            Label lbllvbns = (Label)e.Row.FindControl("lblvlbnsmsg");
            Label lblstkwithmsg = (Label)e.Row.FindControl("lblstkwithmsg");

            if (lbllog.Text.ToString().Length > 50)
            {
                lbllog.Text = lbllog.Text.ToString().Substring(0, 50);
            }
            if (lblpro.Text.ToString().Length > 50)
            {
                lblpro.Text = lblpro.Text.ToString().Substring(0, 50);
            }
            if (lblreg.Text.ToString().Length > 50)
            {
                lblreg.Text = lblreg.Text.ToString().Substring(0, 50);
            }
            if (lbltop.Text.ToString().Length > 50)
            {
                lbltop.Text = lbltop.Text.ToString().Substring(0, 50);
            }
            if (lblwit.Text.ToString().Length > 50)
            {
                lblwit.Text = lblwit.Text.ToString().Substring(0, 50);
            }
            if (lbllvbns.Text.ToString().Length > 50)
            {
                lbllvbns.Text = lbllvbns.Text.ToString().Substring(0, 50);
            }
            if (lblstkwithmsg.Text.ToString().Length > 50)
            {
                lblstkwithmsg.Text = lblstkwithmsg.Text.ToString().Substring(0, 50);
            }


        }
    }
    public int feelgridAll(int currentPage)
    {
        int TotalRows = 0;
        try
        {

            ds = objDBConnectHP.ByProcedure("UpdateAcc_Seeting_User", new string[] { "ID", "MemID", "Login", "Profile", "Registration", "TopUp", "Withdrawal", "LvlBonus","StkDiviWid", "Message_Login", "Message_Profile", "Message_Register", "Message_TopUp", "Message_Withdrawal", "Message_LvlBonus","Message_StkDiviWid", "Type", "intPageSize", "intCurrentPage" },
new string[] { "", "", "", "", "", "", "", "", "", "", "", "", "", "","","", "ALL", (ConfigurationManager.AppSettings["gridPageSize"]).ToString(), currentPage.ToString() }, "intTotalRecords", out TotalRows, "ByDataset");

            if (TotalRows > 0)
            {


                GridView2.Visible = true;
                GridView2.DataSource = ds.Tables[0];
                GridView2.DataBind();

            }
            else
            {

                GridView2.Visible = false;
            }
            return TotalRows;
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg1.Text = "Sorry, Something is wrong please try later !";
        }
        finally
        {
            ds.Dispose();
        }
        return TotalRows;
    }
    public int feelgrid(int currentPage, string MeID)
    {
        int TotalRows = 0;
        try
        {

            ds = objDBConnectHP.ByProcedure("UpdateAcc_Seeting_User", new string[] { "ID", "MemID", "Login", "Profile", "Registration", "TopUp", "Withdrawal", "LvlBonus","StkDiviWid", "Message_Login", "Message_Profile", "Message_Register", "Message_TopUp", "Message_Withdrawal", "Message_LvlBonus", "Message_StkDiviWid", "Type", "intPageSize", "intCurrentPage" },
new string[] { "", MeID.ToString(), "", "", "", "", "", "", "", "", "", "", "", "","","", "Show", (ConfigurationManager.AppSettings["gridPageSize"]).ToString(), currentPage.ToString() }, "intTotalRecords", out TotalRows, "ByDataset");


            if (ds.Tables[0].Rows.Count > 0)
            {
                //lblEmptyMsg.Visible = false;
                //lblEmptyMsg.Text = "";
                cbWithDrawal.Visible = true;
                cbProfile.Visible = true;
                cbTopUp.Visible = true;
                cbRegister.Visible = true;
                cbLogin.Visible = true;
                cblvlbonus.Visible = true;
                chkstkdiviwid.Visible = true;
                TxtMsgLog.Text = "";
                TxtMsgProf.Text = "";
                TxtMsgReg.Text = "";
                TxtMsgTopup.Text = "";
                TxtMsgWithdra.Text = "";
                TxtMsglvlbonus.Text = "";
                TxtMsgLog.Visible = true;
                TxtMsgProf.Visible = true;
                TxtMsgReg.Visible = true;
                TxtMsgTopup.Visible = true;
                TxtMsgWithdra.Visible = true;
                TxtMsglvlbonus.Visible = true;
                Txtmsgstkdiviwid.Visible = true;
                hdnID.Value = "";
                btnsave.Visible = true;
                GridView2.Visible = true;
                lbpro.Visible = true;
                lbregis.Visible = true;
                lbtopup.Visible = true;
                lbwithdr.Visible = true;
                lblogin.Visible = true;
                lblevlCommBonus.Visible = true;
                lblstkdiviwid.Visible = true;
                //lblMesg.Visible = true;
                GridView2.DataSource = ds.Tables[1];
                GridView2.DataBind();
                cbProfile.SelectedValue = ds.Tables[0].Rows[0]["Profile"].ToString();
                cbLogin.SelectedValue = ds.Tables[0].Rows[0]["Login"].ToString();
                cbRegister.SelectedValue = ds.Tables[0].Rows[0]["Registration"].ToString();
                cbTopUp.SelectedValue = ds.Tables[0].Rows[0]["TopUp"].ToString();
                cbWithDrawal.SelectedValue = ds.Tables[0].Rows[0]["Withdrawal"].ToString();
                cblvlbonus.SelectedValue = ds.Tables[0].Rows[0]["LvlBonus"].ToString();
                chkstkdiviwid.SelectedValue = ds.Tables[0].Rows[0]["StkDiviWid"].ToString();
                TxtMsgLog.Text = ds.Tables[0].Rows[0]["Mesag_Login"].ToString().TrimEnd();
                TxtMsgProf.Text = ds.Tables[0].Rows[0]["Mesag_Profile"].ToString().TrimEnd();
                TxtMsgReg.Text = ds.Tables[0].Rows[0]["Mesag_Register"].ToString().TrimEnd();
                TxtMsgTopup.Text = ds.Tables[0].Rows[0]["Mesag_TopUp"].ToString().TrimEnd();
                TxtMsgWithdra.Text = ds.Tables[0].Rows[0]["Mesag_WithDrawal"].ToString().TrimEnd();
                TxtMsglvlbonus.Text = ds.Tables[0].Rows[0]["Mesag_LvlBonus"].ToString().TrimEnd();
                Txtmsgstkdiviwid.Text = ds.Tables[0].Rows[0]["Msg_StkdiviWith"].ToString().TrimEnd();
                hdnID.Value = ds.Tables[0].Rows[0]["ID"].ToString();
                lblMsg1.Text = "";
            }
            else
            {
                //lblEmptyMsg.Visible = true;
                //lblEmptyMsg.Text = objDBConnectHP.EmptyMessage(ds.Tables[1].Rows[0]["MSG"].ToString());
                GridView2.Visible = false;
            }
            return TotalRows;
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg1.Text = "Sorry, Something is wrong please try later !";
        }
        finally
        {
            ds.Dispose();
        }
        return TotalRows;
    }
    protected void OnSelectedIndexChanged(object sender, EventArgs e)
    {
        GridViewRow row = GridView2.SelectedRow;
        TxtMemID.Text = (row.FindControl("lnkbtn") as LinkButton).Text;
        int Page = Convert.ToInt32(ddlJumpToPage.SelectedItem.Value);
        this.feelgrid(Page, TxtMemID.Text.TrimEnd());

    }

    //protected void OnPageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    GridView2.PageIndex = e.NewPageIndex;
    //    feelgridAll();       

    //}
    protected void SaveDetail(object sender, EventArgs e)
    {
        try
        {
            string mem = TxtMemID.Text.TrimEnd();
            int TotalRows = 0;
            int Page = Convert.ToInt32(ddlJumpToPage.SelectedItem.Value);
            //ds = objDBConnectHP.ByProcedure("UpdateAcc_Seeting_User", new string[] { "ID", "MemID", "Login", "Profile", "Registration", "TopUp", "Withdrawal", "Message_Login", "Message_Profile", "Message_Register", "Message_TopUp", "Message_Withdrawal", "Type" },
            //new string[] { hdnID.Value, TxtMemID.Text.TrimEnd(), cbLogin.SelectedValue, cbProfile.SelectedValue, cbRegister.SelectedValue, cbTopUp.SelectedValue, cbWithDrawal.SelectedValue, TxtMsgLog.Text.TrimEnd(),TxtMsgProf.Text.TrimEnd (),TxtMsgReg.Text.TrimEnd(),TxtMsgTopup.Text.TrimEnd (),TxtMsgWithdra.Text.TrimEnd (), "Update" }, "GET");

            ds = objDBConnectHP.ByProcedure("UpdateAcc_Seeting_User", new string[] { "ID", "MemID", "Login", "Profile", "Registration", "TopUp", "Withdrawal", "LvlBonus", "StkDiviWid", "Message_Login", "Message_Profile", "Message_Register", "Message_TopUp", "Message_Withdrawal", "Message_LvlBonus", "Message_StkDiviWid", "Type", "intPageSize", "intCurrentPage" },
            new string[] { hdnID.Value, TxtMemID.Text.TrimEnd(), cbLogin.SelectedValue, cbProfile.SelectedValue, cbRegister.SelectedValue, cbTopUp.SelectedValue, cbWithDrawal.SelectedValue, cblvlbonus.SelectedValue, chkstkdiviwid.SelectedValue, TxtMsgLog.Text.TrimEnd(), TxtMsgProf.Text.TrimEnd(), TxtMsgReg.Text.TrimEnd(), TxtMsgTopup.Text.TrimEnd(), TxtMsgWithdra.Text.TrimEnd(), TxtMsglvlbonus.Text.TrimEnd(),Txtmsgstkdiviwid.Text, "Update", (ConfigurationManager.AppSettings["gridPageSize"]).ToString(), Page.ToString() }, "intTotalRecords", out TotalRows, "ByDataset");


            if (ds.Tables[0].Rows.Count > 0)
            {
                lblMsg1.Text = ds.Tables[0].Rows[0]["Msg"].ToString();
                TxtMemID.Text = "";
                cbWithDrawal.Visible = false;
                cbProfile.Visible = false;
                cbTopUp.Visible = false;
                cbRegister.Visible = false;
                cbLogin.Visible = false;
                cblvlbonus.Visible = false;
                chkstkdiviwid.Visible = false;
                TxtMsgLog.Text = "";
                TxtMsgProf.Text = "";
                TxtMsgReg.Text = "";
                TxtMsgTopup.Text = "";
                TxtMsgWithdra.Text = "";
                TxtMsglvlbonus.Text = "";
                Txtmsgstkdiviwid.Text = "";
                TxtMsgLog.Visible = false;
                TxtMsgProf.Visible = false;
                TxtMsgReg.Visible = false;
                TxtMsgTopup.Visible = false;
                TxtMsgWithdra.Visible = false;
                TxtMsglvlbonus.Visible = false;
                Txtmsgstkdiviwid.Visible = false;
                hdnID.Value = "";
                btnsave.Visible = false;
                GridView2.Visible = false;
                lbpro.Visible = false;
                lbregis.Visible = false;
                lbtopup.Visible = false;
                lbwithdr.Visible = false;
                lblogin.Visible = false;
                lblevlCommBonus.Visible = false;
                //lblMesg.Visible = false;
            }
            feelgridAll(Page);
            if (GridView2.SelectedIndex != -1)
            {
                GridView2.SelectedIndex = -1;
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg1.Text = "Sorry, Something is wrong please try later !";
        }


    }

}

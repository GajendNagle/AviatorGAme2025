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

public partial class Adm962xts21qtj_AdminHome : System.Web.UI.Page
{
    DataSet ds;
    DynamicDtls objgdb = new DynamicDtls();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Khbfy897ft36Gv"] != null)
        {
            if (IsPostBack != true)
            {
                objgdb.FillWebSiteEmailCompany();
            }
        }
        else
        {
            Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
        }

    }
    protected void txtSearchMember_TextChanged(object sender, EventArgs e)
    {
        try
        {
            ds = new DataSet();
            ds = objgdb.ByProcedure("GetFullName", new string[] { "MemId" }, new string[] { txtSearchMember.Text.Trim() }, "das");
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblfrmUser.Text = "";
                lblfrmUser.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
            }
            else
            {
                txtSearchMember.Text = "";
                lblfrmUser.Text = "Mem-ID Does Not Exist.";
            }
        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = objgdb.ErrorMsg("Sorry, Something is wrong please try later !"); }
        finally
        {
            if (ds != null) { ds.Dispose(); };
        }
    }
    protected void btnSearchMember_Click(object sender, EventArgs e)
    {
        try
        {
            if (txtSearchMember.Text.Trim() != "" && lblfrmUser.Text != "Mem-ID Does Not Exist.")
            {
                if (ddlSearchPage.SelectedItem.Value == "Edit User Profile")
                {
                    Response.Redirect("AdminEditProfile.aspx?mid=My Account&sid=Edit Profile&MemId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "Block And UnBlock User")
                {
                    Response.Redirect("BlockUnblockSetting.aspx?mid=User Section&sid=Block / Unblock User&MemId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "Unverified Users")
                {
                    Response.Redirect("UnverifyUsersReport.aspx?mid=User Section&sid=Unverified Users&MemId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "Payment Request Status")
                {
                    Response.Redirect("c-Wallet-Fund-Request.aspx?mid=Deposit Area&sid=Payment Request Status&UserId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "Deposit Address")
                {
                    Response.Redirect("Admin-Deposit-Address.aspx?mid=Deposit Address&sid=Deposit Address&MemID=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "Fx-Wallet Fund Request")
                {
                    Response.Redirect("c-Wallet-Fund-Request.aspx?mid=Deposit Area&sid=f-Wallet Fund Request&UserId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "Member Account Address")
                {
                    Response.Redirect("Member-BTC-Address-Report.aspx?mid=Deposit Area&sid=Member Account Address&UserId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "From V-Down Bonus")
                {
                    Response.Redirect("AdminGrowthReport.aspx?mid=User Account&sid=From V-down Bonus&MemId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "Lebel Bonus")
                {
                    Response.Redirect("PayoutEwalletReport.aspx?mid=User Account&sid=Level Bonus&MemId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "Level Trade Bonus")
                {
                    Response.Redirect("Admin_Fromup_History.aspx?mid=User Account&sid=Level Trade Bonus&IncType=Level Trade Bonus&MemId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "Invitation Bonus")
                {
                    Response.Redirect("Admin_Fromup_History.aspx?mid=User Account&sid=Invitation Bonus&IncType=Invitation Bonus&MemId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "Trade Bonus")
                {
                    Response.Redirect("Admin_Fromup_History.aspx?mid=User Account&sid=Trade Bonus&IncType=Trade Bonus&MemId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "Promotion Bonus")
                {
                    Response.Redirect("Admin_Fromup_History.aspx?mid=User Account&sid=Promotion Bonus&IncType=Promotion Bonus&MemId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "Deposit Bonus")
                {
                    Response.Redirect("Admin_Fromup_History.aspx?mid=User Account&sid=Deposit Bonus&IncType=Deposit Bonus&MemId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "Recycle History")
                {
                    Response.Redirect("AdminRecycle_History.aspx?mid=User Account&sid=Recycle History&MemId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "Referral And Earn Income")
                {
                    Response.Redirect("Admin_ReferNEarn.aspx?mid=User Account&sid=Referral and Earn Income&MemId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "F-Wallet History")
                {
                    Response.Redirect("AdminCCTransactionReport.aspx?mid=User Account&sid=f-Wallet History&MemId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "Withdrawal Request")
                {
                    Response.Redirect("AdminViewFundRequest.aspx?mid=User Account&sid=Withdrawal Request&MemId=" + txtSearchMember.Text);
                }
                else if (ddlSearchPage.SelectedItem.Value == "Account Summary")
                {
                    Response.Redirect("Admin_Account_Summary.aspx?mid=User Account&sid=Account Summary&MemId=" + txtSearchMember.Text);
                }

            }
            else
            {
                lblfrmUser.Text = "";
                txtSearchMember.Text = "";
            }

        }
        catch (Exception ex) { DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg.Text = objgdb.ErrorMsg("Sorry, Something is wrong please try later !"); }
        finally
        {
            if (ds != null) { ds.Dispose(); };
        }
    }
}

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

public partial class AdminMaster : System.Web.UI.MasterPage
{
    DataSet ds;
    DynamicDtls objgdb = new DynamicDtls();
    public string Mem_Name, UserID, SubMenu1, MainMenu;
    RoleAuthenticationCS objRole = new RoleAuthenticationCS();
    protected void Page_Load(object sender, EventArgs e)
    {
        objgdb.FillWebSiteEmailCompany();
        if (Session["Khbfy897ft36Gv"] != null)
        {
            UserID = DB.base64Decod(Session["Khbfy897ft36Gv"].ToString());
            Mem_Name = "Admin Panel";
            if (Request.QueryString["mid"] != null && Request.QueryString["sid"] != null)
            {
                MainMenu = Request.QueryString["mid"].ToString();
                SubMenu1 = Request.QueryString["sid"].ToString();
                if (SubMenu1 == "E-Mail")
                {
                    SubMenu1 = "Send " + SubMenu1;
                }
                Page.Title = Request.QueryString["sid"].ToString();
            }
            if (!IsPostBack)
            {
                ds = objRole.CheckRole(UserID);
                if (ds.Tables[0].Rows[0]["RoleAlert"].ToString() == "Admin Access")
                {
                    ApplicationSettings.Visible = true; EditUserProfile.Visible = true;
                    BlockUnblockUser.Visible = true;
                    UnverifiedUsers.Visible = true;
                    stkHistory.Visible = true;
                    SAccountsumry.Visible = true;
                    SAmemaccsummry.Visible = true;
                    //StkRewardStatus.Visible = true;
                    stakeNow.Visible = true;
                    //stkebyWallet.Visible = true;
                    StakeDivi.Visible = true;
                    LevelDivi.Visible = true;
                    RankDivi.Visible = true;
                    CreateRole.Visible = true;
                    CreateUsers.Visible = true;
                    //WalletHistory.Visible = true; 
                    //AdBonus.Visible = true;
                    DepositNow.Visible = true;
                    RewardStatus.Visible = true;
                    DepositHistory.Visible = true;
                    WalletAmtReqeust.Visible = true;
                    CreditDebitAmount.Visible = true;
                    BinaryBonus.Visible = true;
                    LvlTradeBns.Visible = true;
                    PromsBonus.Visible = true;
                    DepostBns.Visible = true;
                    DailySalary.Visible = true;
                    cWalletHistory.Visible = true;
                    //Li1.Visible = true;
                    //SponsorRoyaltyBonus.Visible = true; WithdrawalRequests.Visible = true; UserDirects.Visible = true;
                    MyDownlinelist.Visible = true; DownlineTreeView.Visible = false; BinaryMatchingSummary.Visible = false;
                    UserMessages.Visible = true; EnquiryReport.Visible = true; AddRemoveNews.Visible = true;
                    ChangeAdminPassword.Visible = true; /*PostAdlinks.Visible = true; */
                    UserAccSetting.Visible = true; OtpList.Visible = true;
                    CWalletFundReqeust.Visible = true; 
                    TraceTxnHas.Visible = true;
                    DepositAdd.Visible = true;
                    LgnAdminHistory.Visible = true;
                    // ChkMatch.Visible = true;
                    WithdrawalRequests.Visible = true;
                    FstPrtysumm.Visible = true;
                    Prtysumm.Visible = true;
                    Prtysumm3.Visible = true;
                    Avtsumm.Visible = true;
                    Accsummary.Visible = true;
                    WithWallAdd.Visible = true;
                    FromUpBonus.Visible = true;
                    CPHstry.Visible = true;
                    MemberAccountSummary.Visible = true;
                    UpdateGrowth.Visible = true;
                    //Recyclehis.Visible = true;
                    //PoolincomeNext.Visible = true;
                    ReferNEarn.Visible = true;
                    //RoyaltyStatus.Visible = true;
                    parityrwd.Visible = true; Fstparityrwd.Visible = true; parityGlvlrwd.Visible = true;
                    FstparityGlvlrwd.Visible = true; winwlttxnhsty.Visible = true; WinwltwithdrlReq.Visible = true;
                    Gwlttxnhsty.Visible = true; dlychkin.Visible = true; tskrwd.Visible = true; slfregrwd.Visible = true;refbns.Visible = true;

                }
                else if (ds.Tables[0].Rows[0]["RoleAlert"].ToString() == "Role Exist")
                {
                    for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                    {
                        if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Application Settings") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            ApplicationSettings.Visible = true;
                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Edit User Profile") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            EditUserProfile.Visible = true;
                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Block / Unblock User") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            BlockUnblockUser.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Unverified Users") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            UnverifiedUsers.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Create Role") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            CreateRole.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Create Users") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            CreateUsers.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Wallet History") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            CreateRole.Visible = false;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Wallet History") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            //WalletHistory.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Deposit Now") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            DepositNow.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Deposit History") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            DepositHistory.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Coin Payment History") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            CPHstry.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Aviator Game Summary") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            Avtsumm.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Wallet Amt. Reqeust") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            WalletAmtReqeust.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Credit/Debit Amount") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            CreditDebitAmount.Visible = true;

                        }
                        //else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Ad Bonus") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        //{
                        //    AdBonus.Visible = true;

                        //}
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Ad Bonus") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            ChkMatch.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Recycle") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {

                            //Recyclehis.Visible = true;
                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Recycle") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {

                            ReferNEarn.Visible = true;
                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "From Up Bonus") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            FromUpBonus.Visible = true;

                        }
                        //else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Global Pool Status") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        //{
                        //    PoolincomeNext.Visible = true;

                        //}
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Binary Bonus") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            BinaryBonus.Visible = true;
                            cWalletHistory.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Level Trade Bonus") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            LvlTradeBns.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Promotion Bonus") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            PromsBonus.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Promotion Bonus") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            DepostBns.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Promotion Bonus") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            DailySalary.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Sponsor Royalty Bonus") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            //SponsorRoyaltyBonus.Visible = true;

                        }
                        //else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Zevo Coins History") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        //{
                        //    zevocoinsHstry.Visible = true;

                        //}
                        //Zevo

                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Withdrawal Requests") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            WithdrawalRequests.Visible = true;

                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "User Directs") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            UserDirects.Visible = true;
                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "My Downline list") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            MyDownlinelist.Visible = true;
                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Downline Tree View") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            DownlineTreeView.Visible = false;
                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Account Summary") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            Accsummary.Visible = false;
                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Withdraw Wallet Address") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            WithWallAdd.Visible = false;
                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Binary Matching Summary") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            BinaryMatchingSummary.Visible = false;
                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "User Messages") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            UserMessages.Visible = true;
                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Enquiry Report") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            EnquiryReport.Visible = true;
                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Add/Remove News") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            AddRemoveNews.Visible = true;
                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Change Admin Password") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            ChangeAdminPassword.Visible = true;
                        } else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Admin Login history") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            LgnAdminHistory.Visible = true;
                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "Post Ad links") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            //PostAdlinks.Visible = true;
                            OtpList.Visible = true;
                        }
                        else if ((ds.Tables[1].Rows[i]["FormNameID"].ToString() == "User Account Setting") || (Convert.ToBoolean(ds.Tables[1].Rows[i]["SelectA"].ToString()) == false))
                        {
                            UserAccSetting.Visible = true;
                        }

                    }
                }
                else
                {
                    objRole.PageRedirect();
                }
            }
        }
        else
        {
            Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
        }
    }

}

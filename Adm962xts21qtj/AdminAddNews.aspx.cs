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
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.IO;

public partial class Adm962xts21qtj_AdminAddNews : System.Web.UI.Page
{
    SqlConnection cn = new SqlConnection(new DB().getconnection());
    SqlCommand cmd;
    SqlDataReader dr;

    SqlDataAdapter da;
    DataSet ds;
    DynamicDtls objDynamicDtls = new DynamicDtls();

    public static string fname, chkfileEx, SDbFilePath = "", SDbFilePathand = "", imgpath = "", AcFileName, FileNameDB, FileNameDBad, fnamead, chkfileExad, AcFileNamead, SDbFilePathad = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["Khbfy897ft36Gv"] != null)
            {
                if (!IsPostBack)
                {
                    feelgrid();
                    ddlPosttype_SelectedIndexChanged(sender, e);
                }
            }
            else
            {
                Response.Redirect("../CtrlP2nL_Akdvv3jshLG.aspx", false);
            }

        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg1.Text = "Your request could not be completed.";
        }

    }
    private void clears()
    {
        txtnews.Text = txtenddate.Text = txtfirstdate.Text = txtheading.Text = "";
    }

    protected void btnpass_Click(object sender, EventArgs e)
    {
        //cn.Open();
        try
        {

            string fdate = string.Format("{0:MM/dd/YYYY}", txtfirstdate.Text);
            string edate = string.Format("{0:MM/dd/YYYY}", txtenddate.Text);

            UploadImg();
            if (FileNameDB == null)
            {
                FileNameDB = "";
            }
            UploadAudio();
            if (FileNameDBad == null)
            {
                FileNameDBad = "";
            }

            ds = objDynamicDtls.ByProcedure("PROC_ADMIN_NEWS", new string[] { "id", "txtheading", "txtnews", "fdate", "edate", "typ", "News_Type", "News_For", "Image_Path", "Video_Path", "Audio_Path" },
               new string[] { "", txtheading.Text.Trim().ToUpper(), txtnews.Text.Trim(), fdate, edate, "INSERT", ddlPosttype.SelectedValue, ddlNewsfor.SelectedValue, FileNameDB, txtVideoLink.Text.Trim(), FileNameDBad }, "GET");

            lblMsg1.Text = objDynamicDtls.UpdateMessage(ds.Tables[0].Rows[0]["MSG"].ToString());

            //string str = "insert into News(Heading,News,StartDate,EndDate) values('" + txtheading.Text.Trim().ToUpper() + "','" + txtnews.Text.Trim() + "', convert(datetime,'" + fdate + "',103)  ,convert(datetime,'" + edate + "',103))";
            //cmd = new SqlCommand(str, cn);
            //cmd.ExecuteNonQuery();
            //lblMsg1.Visible = true;
            //lblMsg1.Text = "!! News Add Successfully !!";
            //lblMsg1.ForeColor = System.Drawing.Color.Green;
            FileNameDB = "";
            FileNameDBad = "";
            txtVideoLink.Text = "";
            feelgrid();
            this.clears();
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg1.Text = "Your request could not be completed.";
            lblMsg1.Visible = true;

        }
        //cn.Close();

    }

    public void feelgrid()
    {
        try
        {
            ds = objDynamicDtls.ByProcedure("PROC_ADMIN_NEWS", new string[] { "id", "txtheading", "txtnews", "fdate", "edate", "typ", "News_Type", "News_For", "Image_Path", "Video_Path", "Audio_Path" }, new string[] { "", "", "", "", "", "GET", "", "", "", "", "" }, "GET");


            if (ds.Tables[0].Rows.Count > 0)
            {
                lblEmptyMsg.Visible = false;
                lblEmptyMsg.Text = "";
                GridView2.Visible = true;
                GridView2.DataSource = ds.Tables[0];
                GridView2.DataBind();
            }
            else
            {
                lblEmptyMsg.Visible = true;
                lblEmptyMsg.Text = objDynamicDtls.EmptyMessage(ds.Tables[1].Rows[0]["MSG"].ToString());
                GridView2.Visible = false;
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg1.Text = "Your request could not be completed.";
            GridView2.DataSource = null;
            GridView2.DataBind();
            GridView2.Visible = false;
        }
    }

    protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int id = Convert.ToInt32(GridView2.DataKeys[e.RowIndex].Value);
            //string oldbdelete = "delete from News where id =" + id + "delete from News_Detail where NewsID =" + id + "";
            //SqlDataAdapter adp = new SqlDataAdapter(oldbdelete, cn);
            //DataSet ds = new DataSet();
            //adp.Fill(ds);

            ds = objDynamicDtls.ByProcedure("PROC_ADMIN_NEWS", new string[] { "id", "txtheading", "txtnews", "fdate", "edate", "typ", "News_Type", "News_For", "Image_Path", "Video_Path", "Audio_Path" }, new string[] { id.ToString(), "", "", "", "", "DELETE", "", "", "", "", "" }, "GET");

            feelgrid();
            lblMsg1.Text = "News Removed....";
            lblMsg1.ForeColor = System.Drawing.Color.Green;
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg1.Text = "Your request could not be completed.";
        }
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
            TextBox hd = (TextBox)GridView2.Rows[e.RowIndex].Cells[0].FindControl("txtbxheading");
            TextBox nw = (TextBox)GridView2.Rows[e.RowIndex].Cells[1].FindControl("txtbxnews");
            TextBox st = (TextBox)GridView2.Rows[e.RowIndex].Cells[2].FindControl("txtbxstdate");
            TextBox ed = (TextBox)GridView2.Rows[e.RowIndex].Cells[3].FindControl("txtbxeddate");

            ds = objDynamicDtls.ByProcedure("PROC_ADMIN_NEWS", new string[] { "id", "txtheading", "txtnews", "fdate", "edate", "typ", "News_Type", "News_For", "Image_Path", "Video_Path", "Audio_Path" }, new string[] { id.ToString(), hd.Text.Trim(), nw.Text.Trim(), st.Text.Trim(), ed.Text.Trim(), "UPDATE", "", "", "", "", "" }, "GET");

            lblMsg1.Text = objDynamicDtls.UpdateMessage(ds.Tables[0].Rows[0]["MSG"].ToString());

            GridView2.EditIndex = -1;

        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg1.Text = "Your request could not be completed.";
        }
        feelgrid();
    }
    protected void ddlPosttype_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlPosttype.SelectedItem.Value == "All")
            {
                trImg.Visible = true;
                trvideo.Visible = true;
                trAudio.Visible = true;
                FileUploadImg.Focus();
            }
            else if (ddlPosttype.SelectedItem.Value == "Image")
            {
                trImg.Visible = true;
                trvideo.Visible = false;
                trAudio.Visible = false;
                FileUploadImg.Focus();
            }
            else if (ddlPosttype.SelectedItem.Value == "Video")
            {
                trImg.Visible = false;
                trvideo.Visible = true;
                trAudio.Visible = false;
                txtVideoLink.Focus();
            }
            else if (ddlPosttype.SelectedItem.Value == "Audio")
            {
                trImg.Visible = false;
                trvideo.Visible = false;
                trAudio.Visible = true;
                FileUploadAudio.Focus();
            }
            else
            {
                trImg.Visible = false;
                trvideo.Visible = false;
                trAudio.Visible = false;
                btnpass.Focus();
            }
        }
        catch (Exception ex)
        {
            DB.WriteLog(this.ToString() + " Error Msg :" + ex.Message + "\n" + "Event Info :" + ex.StackTrace); lblMsg1.Text = "Your request could not be completed.";
        }
    }

    public static string GenerateRandom()
    {
        string str = Path.GetRandomFileName(); //This method returns a random file name of 11 characters
        str = str.Replace(".", "");
        return str;
    }

    private void UploadImg()
    {
        SDbFilePathand = "";
        imgpath = "";
        if (FileUploadImg.HasFile == true)
        {
            fname = FileUploadImg.FileName;
            chkfileEx = Path.GetExtension(fname).ToLower();
            if (chkfileEx.ToString().Trim() == ".jpg" || chkfileEx.ToString().Trim() == ".gif" ||
            chkfileEx.ToString().Trim() == ".bmp" || chkfileEx.ToString().Trim() == ".jpeg" ||
            chkfileEx.ToString().Trim() == ".png")
            //|| chkfileEx.ToString().Trim() == ".pdf")
            {
                AcFileName = GenerateRandom();

                SDbFilePath = "uploads/News/" + AcFileName + chkfileEx;
                fname = Path.Combine(Server.MapPath("~/uploads/News/"), AcFileName + chkfileEx);
                FileUploadImg.SaveAs(fname);
                FileNameDB = AcFileName + chkfileEx;
                SDbFilePathand = "uploads/News/" + AcFileName + chkfileEx;


                FileUploadImg.Attributes.Clear();
                FileUploadImg.Dispose();
            }
            else
            {
                lblMsg1.Text = "Only GIF, JPEG, PNG, BMP files are allowed !";

            }

        }
        else
        {
            lblMsg1.Text = "Only GIF, JPEG, PNG, BMP files are allowed !";

        }
    }

    private void UploadAudio()
    {
        if (FileUploadAudio.HasFile == true)
        {
            fnamead = FileUploadAudio.FileName;
            chkfileExad = Path.GetExtension(fnamead).ToLower();
            if (chkfileExad.ToString().Trim() == ".mp3" || chkfileExad.ToString().Trim() == ".ogg" || chkfileExad.ToString().Trim() == ".mpeg")
            //|| chkfileEx.ToString().Trim() == ".pdf")
            {
                AcFileNamead = GenerateRandom();

                SDbFilePathad = "uploads/Audio/" + AcFileName + chkfileEx;
                fnamead = Path.Combine(Server.MapPath("~/uploads/Audio/"), AcFileNamead + chkfileExad);
                FileUploadAudio.SaveAs(fnamead);
                FileNameDBad = AcFileNamead + chkfileExad;

            }
            else
            {
                lblMsg1.Text = "Only mp3,ogg,mpeg,audio files are allowed !";

            }

        }
    }
}


using System.IO;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/// <summary>
/// Summary description for GridViewExportUtil
/// </summary>
public class GridViewExportUtil
{
    public GridViewExportUtil()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public static void Export(string fileName, GridView gv, string No)
    {
        if (No == "1")
        {
            gv.Columns[0].Visible = false;
            gv.Columns[1].Visible = false;
            gv.Columns[2].Visible = false;
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader(
            "content-disposition", string.Format("attachment; filename={0}", fileName));
            HttpContext.Current.Response.ContentType = "application/ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {
                    //  Create a form to contain the grid
                    Table table = new Table();
                    table.Style.Add("border-bottom:solid .8px Black;border-top:solid .8px Black;border-right:solid .8px Black;border-left:solid .8px Black;", "Black");
                    //  add the header row to the table
                    if (gv.HeaderRow != null)
                    {

                        GridViewExportUtil.PrepareControlForExport(gv.HeaderRow);
                        gv.Columns[0].Visible = false;
                        gv.Columns[1].Visible = false;
                        gv.Columns[2].Visible = false;
                        table.Rows.Add(gv.HeaderRow);

                        table.Style.Add("border-bottom:solid .8px Black;border-top:solid .8px Black;border-right:solid .8px Black;border-left:solid .8px Black;", "Black");
                    }

                    //  add each of the data rows to the table
                    foreach (GridViewRow row in gv.Rows)
                    {

                        GridViewExportUtil.PrepareControlForExport(row);
                        gv.Columns[0].Visible = false;
                        gv.Columns[1].Visible = false;
                        gv.Columns[2].Visible = false;
                        table.Rows.Add(row);
                        table.Style.Add("border-bottom:solid .8px Black;border-top:solid .8px Black;border-right:solid .8px Black;border-left:solid .8px Black;", "Black");
                    }

                    //  add the footer row to the table
                    if (gv.FooterRow != null)
                    {
                        GridViewExportUtil.PrepareControlForExport(gv.FooterRow);
                        table.Rows.Add(gv.FooterRow);
                    }

                    //  render the table into the htmlwriter
                    table.RenderControl(htw);

                    //  render the htmlwriter into the response
                    HttpContext.Current.Response.Write(sw.ToString());
                    HttpContext.Current.Response.End();
                }
            }
        }
        else if (No == "2")
        {
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader(
            "content-disposition", string.Format("attachment; filename={0}", fileName));
            HttpContext.Current.Response.ContentType = "application/ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {
                    //  Create a form to contain the grid
                    Table table = new Table();
                    table.Style.Add("border-bottom:solid .8px Black;border-top:solid .8px Black;border-right:solid .8px Black;border-left:solid .8px Black;", "Black");
                    //  add the header row to the table
                    if (gv.HeaderRow != null)
                    {
                        GridViewExportUtil.PrepareControlForExport(gv.HeaderRow);

                        table.Rows.Add(gv.HeaderRow);

                        table.Style.Add("border-bottom:solid .8px Black;border-top:solid .8px Black;border-right:solid .8px Black;border-left:solid .8px Black;", "Black");
                    }

                    //  add each of the data rows to the table
                    foreach (GridViewRow row in gv.Rows)
                    {
                        GridViewExportUtil.PrepareControlForExport(row);
                        table.Rows.Add(row);
                        table.Style.Add("border-bottom:solid .8px Black;border-top:solid .8px Black;border-right:solid .8px Black;border-left:solid .8px Black;", "Black");
                    }

                    //  add the footer row to the table
                    if (gv.FooterRow != null)
                    {
                        GridViewExportUtil.PrepareControlForExport(gv.FooterRow);
                        table.Rows.Add(gv.FooterRow);
                    }

                    //  render the table into the htmlwriter
                    table.RenderControl(htw);

                    //  render the htmlwriter into the response
                    HttpContext.Current.Response.Write(sw.ToString());
                    HttpContext.Current.Response.End();
                }
            }
        }
        else if (No == "3")
        {
            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader(
            "content-disposition", string.Format("attachment; filename={0}", fileName));
            HttpContext.Current.Response.ContentType = "application/ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {
                    //  Create a form to contain the grid
                    Table table = new Table();
                    table.Style.Add("border-bottom:solid .8px Black;border-top:solid .8px Black;border-right:solid .8px Black;border-left:solid .8px Black;", "Black");
                    //  add the header row to the table
                    if (gv.HeaderRow != null)
                    {
                        GridViewExportUtil.PrepareControlForExport(gv.HeaderRow);

                        table.Rows.Add(gv.HeaderRow);

                        table.Style.Add("border-bottom:solid .8px Black;border-top:solid .8px Black;border-right:solid .8px Black;border-left:solid .8px Black;", "Black");
                    }

                    //  add each of the data rows to the table
                    foreach (GridViewRow row in gv.Rows)
                    {
                        GridViewExportUtil.PrepareControlForExport(row);
                        table.Rows.Add(row);
                        table.Style.Add("border-bottom:solid .8px Black;border-top:solid .8px Black;border-right:solid .8px Black;border-left:solid .8px Black;", "Black");
                    }

                    //  add the footer row to the table
                    if (gv.FooterRow != null)
                    {
                        GridViewExportUtil.PrepareControlForExport(gv.FooterRow);
                        table.Rows.Add(gv.FooterRow);
                    }

                    //  render the table into the htmlwriter
                    table.RenderControl(htw);

                    //  render the htmlwriter into the response
                    HttpContext.Current.Response.Write(sw.ToString());
                    HttpContext.Current.Response.End();
                }
            }
        }
        else
        {

            HttpContext.Current.Response.Clear();
            HttpContext.Current.Response.AddHeader(
            "content-disposition", string.Format("attachment; filename={0}", fileName));
            HttpContext.Current.Response.ContentType = "application/ms-excel";

            using (StringWriter sw = new StringWriter())
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {
                    //  Create a form to contain the grid
                    Table table = new Table();
                    table.Style.Add("border-bottom:solid .8px Black;border-top:solid .8px Black;border-right:solid .8px Black;border-left:solid .8px Black;", "Black");
                    //  add the header row to the table
                    if (gv.HeaderRow != null)
                    {
                        GridViewExportUtil.PrepareControlForExport(gv.HeaderRow);

                        table.Rows.Add(gv.HeaderRow);

                        table.Style.Add("border-bottom:solid .8px Black;border-top:solid .8px Black;border-right:solid .8px Black;border-left:solid .8px Black;", "Black");
                    }

                    //  add each of the data rows to the table
                    foreach (GridViewRow row in gv.Rows)
                    {
                        GridViewExportUtil.PrepareControlForExport(row);
                        table.Rows.Add(row);
                        table.Style.Add("border-bottom:solid .8px Black;border-top:solid .8px Black;border-right:solid .8px Black;border-left:solid .8px Black;", "Black");
                    }

                    //  add the footer row to the table
                    if (gv.FooterRow != null)
                    {
                        GridViewExportUtil.PrepareControlForExport(gv.FooterRow);
                        table.Rows.Add(gv.FooterRow);
                    }

                    //  render the table into the htmlwriter
                    table.RenderControl(htw);

                    //  render the htmlwriter into the response
                    HttpContext.Current.Response.Write(sw.ToString());
                    HttpContext.Current.Response.End();
                }
            }
        }
    }

    //Export Gridview Data to Excel File and Save Excel file to Server Folder Rather than
    //allowing user to Open or Save it.
    public static void ExportToFolder(string fileName, GridView gv)
    {

        System.Text.StringBuilder sb = new System.Text.StringBuilder();

        using (StringWriter sw = new StringWriter(sb))
        {
            using (HtmlTextWriter htw = new HtmlTextWriter(sw))
            {
                //  Create a form to contain the grid
                Table table = new Table();
                // table.Rows.Add("Style",)
                //  add the header row to the table
                if (gv.HeaderRow != null)
                {
                    GridViewExportUtil.PrepareControlForExport(gv.HeaderRow);
                    table.Rows.Add(gv.HeaderRow);
                    table.Style.Add("border-bottom:solid .8px Black;border-top:solid .8px Black;border-right:solid .8px Black;border-left:solid .8px Black;", "Black");
                }

                //  add each of the data rows to the table
                foreach (GridViewRow row in gv.Rows)
                {
                    GridViewExportUtil.PrepareControlForExport(row);
                    table.Rows.Add(row);
                    table.Style.Add("border-bottom:solid .8px Black;border-top:solid .8px Black;border-right:solid .8px Black;border-left:solid .8px Black;", "Black");
                }

                //  add the footer row to the table
                if (gv.FooterRow != null)
                {
                    GridViewExportUtil.PrepareControlForExport(gv.FooterRow);
                    table.Rows.Add(gv.FooterRow);
                    table.Style.Add("border-bottom:solid .8px Black;border-top:solid .8px Black;border-right:solid .8px Black;border-left:solid .8px Black;", "Black");
                }

                //  render the table into the htmlwriter
                table.RenderControl(htw);

                //Create file
                System.IO.TextWriter w = new System.IO.StreamWriter(HttpContext.Current.Server.MapPath("~") + "\\" + fileName);
                w.Write(sb.ToString());
                w.Flush();
                w.Close();

            }
        }
    }

    private static void PrepareControlForExport(Control control)
    {
        for (int i = 0; i < control.Controls.Count; i++)
        {

            Control current = control.Controls[i];

            if (current is LinkButton)
            {
                control.Controls.Remove(current);
                // control.Controls.AddAt(i, new LiteralControl((current as LinkButton).Text));
                control.Controls.AddAt(i, new LiteralControl((current as Label).Text));
            }
            else if (current is ImageButton)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as ImageButton).AlternateText));
            }
            else if (current is HyperLink)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as HyperLink).Text));
            }
            else if (current is DropDownList)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as DropDownList).SelectedItem.Text));
            }
            else if (current is CheckBox)
            {
                control.Controls.Remove(current);
                control.Controls.AddAt(i, new LiteralControl((current as CheckBox).Checked ? "True" : "False"));
            }

            if (current.HasControls())
            {
                GridViewExportUtil.PrepareControlForExport(current);
            }
        }
    }
}

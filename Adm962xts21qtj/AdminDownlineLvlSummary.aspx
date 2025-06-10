<%@ Page Language="C#"  AutoEventWireup="true"  StylesheetTheme="MySkin" CodeFile="AdminDownlineLvlSummary.aspx.cs" Inherits="Admin_DownlineLvlSummary"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Admin Downline Level Summary</title>
    <link href="../UserPanel_css/MyRegisCss.css" rel="stylesheet" type="text/css" />
    <link href="../UserPanel_css/GridStyle.css" rel="stylesheet" type="text/css" />
</head>
<body bgcolor="white">
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
            <asp:GridView ID="GridView1" runat="server" Font-Bold="False" Font-Names="Verdana" Font-Size="11px" ShowFooter="True" ToolTip="STATUS" Width="550px" OnRowDataBound="GridView1_RowDataBound">
                <HeaderStyle HorizontalAlign="Center" Height="20px" />
                <Columns>
                    <asp:TemplateField HeaderText="Sr.No">
                        <ItemTemplate>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>-- Sorry, Direct User List Not Found --</EmptyDataTemplate>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
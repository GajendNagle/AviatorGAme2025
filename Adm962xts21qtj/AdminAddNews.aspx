<%@ Page Language="C#" MasterPageFile="~/Adm962xts21qtj/AdminMaster.master" AutoEventWireup="true" StylesheetTheme="mySkin" CodeFile="AdminAddNews.aspx.cs" Inherits="Adm962xts21qtj_AdminAddNews" Title="ADD NEWS" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        .form-horizontal .form-group{
            margin-bottom: 0;
        }
        .gvMain {
            width: 100%;
            max-width: 100%;
            /*margin-bottom: 1rem;*/
            display: block;
            overflow-x: auto;
        }
    </style>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12 col-12">
                <asp:Label ID="lblMsg1" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="13px"></asp:Label>
            </div>
        </div>
        <div class="row">
            <div class="col-md-offset-2 col-md-6 col-12 form-horizontal">
                <div class="form-group">
                    <label class="control-label col-sm-6">Heading:</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtheading" runat="server" Width="100%" CssClass="form-control" AutoComplete="off"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtheading" ErrorMessage="ENTER HEADING" SetFocusOnError="True" Width="1px">*</asp:RequiredFieldValidator><br />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-6">Start Date:</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtfirstdate" runat="server" Width="100%" AutoComplete="off" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtfirstdate" ErrorMessage="ENTER START DATE" SetFocusOnError="True">*</asp:RequiredFieldValidator><br />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-6">End Date:</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtenddate" runat="server" AutoComplete="off" CssClass="form-control" placeholder="DD/MM/YYYY"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtenddate" ErrorMessage="ENTER END DATE" SetFocusOnError="True" Width="1px">*</asp:RequiredFieldValidator><br />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-6">News :</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtnews" runat="server" Height="120px" TextMode="MultiLine" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtnews" ErrorMessage="ENTER NEWS" SetFocusOnError="True">*</asp:RequiredFieldValidator><br />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-6">News For :</label>
                    <div class="col-sm-6">
                        <asp:DropDownList ID="ddlNewsfor" runat="server"  CssClass="form-control">
                            <asp:ListItem Value="Users">For Users</asp:ListItem>
                            <asp:ListItem Value="Visitors">For Visitors</asp:ListItem>
                        </asp:DropDownList><br />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-6">Post Type :</label>
                    <div class="col-sm-6">
                        <asp:DropDownList ID="ddlPosttype" runat="server" CssClass="form-control" AutoPostBack="True" OnSelectedIndexChanged="ddlPosttype_SelectedIndexChanged">
                            <asp:ListItem Value="Text">Only Text</asp:ListItem>
                            <asp:ListItem Value="Image">Only Image</asp:ListItem>
                            <asp:ListItem Value="Video">Only Video</asp:ListItem>
                            <asp:ListItem Value="Audio">Only Audio</asp:ListItem>
                            <asp:ListItem Value="All">All(Image&amp;Video&amp;Audio)</asp:ListItem>
                        </asp:DropDownList><br />
                    </div>
                </div>
                <div class="form-group" id="trImg" runat="server">
                    <label class="control-label col-sm-6">Choose Image :</label>
                    <div class="col-sm-6">
                        <asp:FileUpload ID="FileUploadImg" runat="server" CssClass="form-control" /><br />
                    </div>
                </div>
                <div class="form-group" id="trvideo" runat="server">
                    <label class="control-label col-sm-6">Video link :</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtVideoLink" runat="server" CssClass="form-control"></asp:TextBox><br />
                    </div>
                </div>
                <div class="form-group" id="trAudio" runat="server">
                    <label class="control-label col-sm-6">Choose Audio :</label>
                    <div class="col-sm-6">
                        <asp:FileUpload ID="FileUploadAudio" runat="server" CssClass="form-control" /><br />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-6 col-sm-6">
                        <asp:Button ID="btnpass" runat="server" Font-Bold="False" OnClick="btnpass_Click" Text="Submit" CssClass="OuterBtn form-control" />
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-12">
                <br />
                <div id="divPrint">
                   <asp:Label ID="lblEmptyMsg" runat="server" Text=""></asp:Label>
                    <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" EnableTheming="True" OnRowDeleting="GridView2_RowDeleting" OnRowCancelingEdit="GridView2_RowCancelingEdit" OnRowEditing="GridView2_RowEditing" OnRowUpdating="GridView2_RowUpdating" Width="100%">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="linkbtn" runat="Server" CausesValidation="false" CommandName="delete" Text="Remove"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CausesValidation="false" CommandName="Edit" />
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton ID="lnkbtnUpdate" runat="server" Text="Update" CausesValidation="false" CommandName="Update" />
                                    <asp:LinkButton ID="lnkbtnCancel" runat="server" Text="Cancel" CausesValidation="false" CommandName="Cancel" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Heading" ItemStyle-Width="120px">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtbxheading" runat="server" Width="120px" TextMode="MultiLine" Text='<%#Eval("Heading")%>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%#Eval("Heading") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="News">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtbxnews" runat="server" TextMode="MultiLine" Text='<%#Eval("News")%>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%#Eval("News") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Start Date" ItemStyle-Width="80px">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtbxstdate" runat="server" Text='<%#Eval("StartDate")%>' Width="80px"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%#Eval("StartDate") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="End Date" ItemStyle-Width="80px">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtbxeddate" runat="server" Width="80px" Text='<%#Eval("EndDate")%>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%#Eval("EndDate") %>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="News Type" ItemStyle-Width="80px">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="Editddlnewstyp" runat="server" Width="80px">
                                        <asp:ListItem Text="Only Text" Value="TEXT"></asp:ListItem>
                                        <asp:ListItem Text="Only Image" Value="IMAGE"></asp:ListItem>
                                        <asp:ListItem Text="Only Video" Value="VIDEO"></asp:ListItem>
                                        <asp:ListItem Text="Only Audio" Value="Audio"></asp:ListItem>
                                        <asp:ListItem Text="All(Image&Video&Audio)" Value="BOTH"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%#Eval("News_Type")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="News For" ItemStyle-Width="80px">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="Editddlnewsfor" runat="server" Width="80px">
                                        <asp:ListItem Text="For Users" Value="USER"></asp:ListItem>
                                        <asp:ListItem Text="For Visitors" Value="VISITOR"></asp:ListItem>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%#Eval("News_For")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Image" ItemStyle-Width="80px">
                                <EditItemTemplate>
                                    <asp:FileUpload ID="EditFlUpload" runat="server" Width="80px" />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%#Eval("Image_Path")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="VideoLink" ItemStyle-Width="100px">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtbxvideolink" runat="server" Width="80px" Text='<%#Eval("Video_Path")%>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <iframe width="100px" height="100px" src="<%#Eval("Video_Path")%>" name='preview-frame' frameborder='0'></iframe>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="AudioLink">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtbxaudiolink" runat="server" Width="80px" Text='<%#Eval("Audio_Path")%>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <%#Eval("Audio_Path")%>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" Height="30px" />
                        <EmptyDataTemplate>
                            <span style="font: bold 13px verdana; color: Red;">---Oooops, Record Not Found---</span>
                        </EmptyDataTemplate>
                        <PagerStyle Font-Size="12px" />
                        <HeaderStyle Height="30px" />
                    </asp:GridView>
                </div>
            </div>
            <div>&nbsp;</div>
        </div>
    </div>
    <%--<table style="width: 100%;">
        <tr>
            <td>
                <asp:Label ID="lblMsg1" runat="server" Font-Bold="True" Font-Names="Verdana" Font-Size="11px" ForeColor="Red" Width="280px"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <table border="0" cellpadding="2" cellspacing="2">
                    <tr>
                        <td style="width: 124px">Heading :</td>
                        <td align="left" class="datalevel" colspan="3">
                            <asp:TextBox ID="txtheading" runat="server" Width="317px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtheading" ErrorMessage="ENTER HEADING" SetFocusOnError="True" Width="1px">*</asp:RequiredFieldValidator>
                        </td>
                        <td align="left" class="datalevel" colspan="1"></td>
                        <td align="left" class="datalevel" colspan="1" style="width: 5px; font-family: 'Poppins', sans-serif;" valign="top"></td>
                    </tr>
                    <tr>
                        <td class="col-sm-2 control-label no-padding-right" style="width: 124px">
                            <span style="font-size: 13px">Start Date :</span>
                        </td>
                        <td align="left" class="datalevel" colspan="3">
                            <asp:TextBox ID="txtfirstdate" runat="server" Width="155px" AutoComplete="off"></asp:TextBox>&nbsp;
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtfirstdate" ErrorMessage="ENTER START DATE" SetFocusOnError="True">*</asp:RequiredFieldValidator><span style="font-size: 10px; font-weight: bold; color: red;"></span>
                        </td>
                        <td align="left" class="datalevel" colspan="1" valign="top"></td>
                        <td align="left" class="datalevel" colspan="1" style="font-size: 8pt; width: 5px; color: #808080; font-family: Tahoma;"></td>
                    </tr>
                    <tr>
                        <td style="width: 124px">End Date :</td>
                        <td align="left" colspan="3" valign="top">
                            <asp:TextBox ID="txtenddate" runat="server" Width="155px" AutoComplete="off"></asp:TextBox>&nbsp;
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtenddate" ErrorMessage="ENTER END DATE" SetFocusOnError="True">*</asp:RequiredFieldValidator>
                        </td>
                        <td align="left" class="datalevel" colspan="1" style="font-weight: bold; font-size: 7pt; color: #336600; font-family: 'Poppins', sans-serif;" valign="top"></td>
                        <td align="left" colspan="1" valign="top"></td>
                    </tr>
                    <tr>
                        <td style="width: 124px">News : </td>
                        <td align="left" valign="top">
                            <asp:TextBox ID="txtnews" runat="server" Height="149px" TextMode="MultiLine" Width="317px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtnews" ErrorMessage="ENTER NEWS" SetFocusOnError="True">*</asp:RequiredFieldValidator><br />
                        </td>
                        <td align="left" colspan="1" style="color: #666666; font-family: Tahoma;" valign="top"></td>
                        <td align="left" style="width: 5px;" valign="top"></td>
                    </tr>
                    <tr>
                        <td style="width: 124px">News For :</td>
                        <td align="left" class="datalevel" colspan="3">
                            <asp:DropDownList ID="ddlNewsfor" runat="server" Width="155px" CssClass="ComposeTxtBx">
                                <asp:ListItem Value="User's">For User&#39;s</asp:ListItem>
                                <asp:ListItem Value="Visitor's">For Visitor&#39;s</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td align="left" class="datalevel" colspan="1"></td>
                        <td align="left" class="datalevel" colspan="1" style="width: 5px; font-family: 'Poppins', sans-serif;" valign="top"></td>
                    </tr>
                    <tr>
                        <td style="width: 124px">Post Type :</td>
                        <td align="left" class="datalevel" colspan="3">
                            <asp:DropDownList ID="ddlPosttype" runat="server" Width="155px" CssClass="ComposeTxtBx" AutoPostBack="True" OnSelectedIndexChanged="ddlPosttype_SelectedIndexChanged">
                                <asp:ListItem Value="Text">Only Text</asp:ListItem>
                                <asp:ListItem Value="Image">Only Image</asp:ListItem>
                                <asp:ListItem Value="Video">Only Video</asp:ListItem>
                                <asp:ListItem Value="Audio">Only Audio</asp:ListItem>
                                <asp:ListItem Value="All">All(Image&amp;Video&amp;Audio)</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td align="left" class="datalevel" colspan="1"></td>
                        <td align="left" class="datalevel" colspan="1" style="width: 5px; font-family: 'Poppins', sans-serif;" valign="top"></td>
                    </tr>
                    <tr id="trImg" runat="server">
                        <td style="width: 124px">
                            <span>Choose Image :</span>
                        </td>
                        <td align="left" class="datalevel" colspan="3">
                            <asp:FileUpload ID="FileUploadImg" runat="server" />
                        </td>
                        <td align="left" class="datalevel" colspan="1"></td>
                        <td align="left" class="datalevel" colspan="1" style="width: 5px; font-family: 'Poppins', sans-serif;" valign="top"></td>
                    </tr>
                    <tr id="trvideo" runat="server">
                        <td style="width: 124px">
                            <span>Video Link :</span>
                        </td>
                        <td align="left" class="datalevel" colspan="3">
                            <asp:TextBox ID="txtVideoLink" runat="server" Width="155px" CssClass="ComposeTxtBx"></asp:TextBox>
                        </td>
                        <td align="left" class="datalevel" colspan="1"></td>
                        <td align="left" class="datalevel" colspan="1" style="width: 5px; font-family: 'Poppins', sans-serif;" valign="top"></td>
                    </tr>
                    <tr id="trAudio" runat="server">
                        <td style="width: 124px">
                            <span>Choose Audio :</span>
                        </td>
                        <td align="left" class="datalevel" colspan="3">
                            <asp:FileUpload ID="FileUploadAudio" runat="server" />
                        </td>
                        <td align="left" class="datalevel" colspan="1"></td>
                        <td align="left" class="datalevel" colspan="1" style="width: 5px; font-family: 'Poppins', sans-serif;" valign="top"></td>
                    </tr>
                    <tr>
                        <td align="left" valign="top" style="width: 124px"></td>
                        <td align="left" colspan="3" valign="top">
                            <asp:Button ID="btnpass" runat="server" Font-Bold="False" Font-Names="Verdana" OnClick="btnpass_Click" Text="Submit" Width="78px" CssClass="OuterBtn" />&nbsp;
                        </td>
                        <td align="left" class="datalevel" colspan="1" valign="top"></td>
                        <td align="left" class="datalevel" colspan="1" style="width: 5px;" valign="top"></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblEmptyMsg" runat="server" Text=""></asp:Label>
                <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AutoGenerateColumns="False" DataKeyNames="id" EnableTheming="True" OnRowDeleting="GridView2_RowDeleting" OnRowCancelingEdit="GridView2_RowCancelingEdit" OnRowEditing="GridView2_RowEditing" OnRowUpdating="GridView2_RowUpdating" Width="100%">
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="linkbtn" runat="Server" CausesValidation="false" CommandName="delete" Text="Remove"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkbtnEdit" runat="server" Text="Edit" CausesValidation="false" CommandName="Edit" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="lnkbtnUpdate" runat="server" Text="Update" CausesValidation="false" CommandName="Update" />
                                <asp:LinkButton ID="lnkbtnCancel" runat="server" Text="Cancel" CausesValidation="false" CommandName="Cancel" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Heading" ItemStyle-Width="120px">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtbxheading" runat="server" Width="120px" TextMode="MultiLine" Text='<%#Eval("Heading")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%#Eval("Heading") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="News">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtbxnews" runat="server" TextMode="MultiLine" Text='<%#Eval("News")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%#Eval("News") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Start Date" ItemStyle-Width="80px">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtbxstdate" runat="server" Text='<%#Eval("StartDate")%>' Width="80px"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%#Eval("StartDate") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="End Date" ItemStyle-Width="80px">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtbxeddate" runat="server" Width="80px" Text='<%#Eval("EndDate")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%#Eval("EndDate") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="News Type" ItemStyle-Width="80px">
                            <EditItemTemplate>
                                <asp:DropDownList ID="Editddlnewstyp" runat="server" Width="80px">
                                    <asp:ListItem Text="Only Text" Value="TEXT"></asp:ListItem>
                                    <asp:ListItem Text="Only Image" Value="IMAGE"></asp:ListItem>
                                    <asp:ListItem Text="Only Video" Value="VIDEO"></asp:ListItem>
                                    <asp:ListItem Text="Only Audio" Value="Audio"></asp:ListItem>
                                    <asp:ListItem Text="All(Image&Video&Audio)" Value="BOTH"></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%#Eval("News_Type")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="News For" ItemStyle-Width="80px">
                            <EditItemTemplate>
                                <asp:DropDownList ID="Editddlnewsfor" runat="server" Width="80px">
                                    <asp:ListItem Text="For User's" Value="USER"></asp:ListItem>
                                    <asp:ListItem Text="For Visitor's" Value="VISITOR"></asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%#Eval("News_For")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Image" ItemStyle-Width="80px">
                            <EditItemTemplate>
                                <asp:FileUpload ID="EditFlUpload" runat="server" Width="80px" />
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%#Eval("Image_Path")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="VideoLink" ItemStyle-Width="100px">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtbxvideolink" runat="server" Width="80px" Text='<%#Eval("Video_Path")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <iframe width="100px" height="100px" src="<%#Eval("Video_Path")%>" name='preview-frame' frameborder='0'></iframe>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="AudioLink">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtbxaudiolink" runat="server" Width="80px" Text='<%#Eval("Audio_Path")%>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <%#Eval("Audio_Path")%>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" Height="22px" />
                    <EmptyDataTemplate>
                        <span style="font: bold 13px verdana; color: Red;">---Oooops, Record Not Found---</span>
                    </EmptyDataTemplate>
                    <PagerStyle Font-Size="12px" />
                    <HeaderStyle Height="22px" />
                </asp:GridView>
            </td>
        </tr>
    </table>--%>
    <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="True" ShowSummary="False" />
    <%--<asp:ScriptManager id="ScriptManager1" runat="server"></asp:ScriptManager>--%>
    <%--<ajaxToolkit:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="txtfirstdate" TargetControlID="txtfirstdate"></ajaxToolkit:CalendarExtender>
    <ajaxToolkit:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="txtenddate" TargetControlID="txtenddate"></ajaxToolkit:CalendarExtender>--%>
    <script language="javascript" type="text/javascript">
        $(function () {
            $("#<%=txtfirstdate.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                    //showOn: 'button',
                    //buttonImageOnly: true,
                    //buttonImage: '../UserPanel_Icon/calender.png'
                }
            );
        });
        $(function () {
            $("#<%=txtenddate.ClientID%>").datepicker(
                {
                    dateFormat: 'dd/mm/yy'
                    //showOn: 'button',
                    //buttonImageOnly: true,
                    //buttonImage: '../UserPanel_Icon/calender.png'
                }
            );
        });
    </script>
</asp:Content>
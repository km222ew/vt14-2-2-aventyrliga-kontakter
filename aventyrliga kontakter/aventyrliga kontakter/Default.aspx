<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="aventyrliga_kontakter.Default" ViewStateMode="Disabled" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Äventyrliga kontakter</title>
    <link href="~/Content/Style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <h1>Äventyrliga kontakter</h1>
    <form id="form1" runat="server">
        <div>
            <%-- Validation-summary --%>
            <div>
                <asp:ValidationSummary ID="ValidationSummary2" runat="server" HeaderText="Fel inträffade. Korrigera det som är fel och försök igen." />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" HeaderText="Fel inträffade. Korrigera det som är fel och försök igen." ValidationGroup="Edit" />
            </div>

             <%-- Panel with label for successfull message --%>
            <asp:Panel ID="successPanel" runat="server" CssClass="" Visible="false">

                <asp:Label ID="successLabel" runat="server" Text=""></asp:Label>
                <div id="close">
                    <asp:ImageButton ID="closeMessage" runat="server" ImageUrl="Content/delete.jpg" CausesValidation="False" OnClick="closeMessage_Click" />
                </div>
            </asp:Panel>

            <%-- ListView --%>
            <asp:ListView ID="ListView" runat="server"
                Itemtype="aventyrliga_kontakter.Model.Contact"
                SelectMethod="ListView_GetDataPageWise"
                InsertMethod="ListView_InsertItem"
                UpdateMethod="ListView_UpdateItem"
                DeleteMethod="ListView_DeleteItem"
                DataKeyNames="ContactId"
                InsertItemPosition="FirstItem">
            
                <LayoutTemplate>
                    <table>
                        <tr>
                            <th>Förnamn</th>
                            <th>Efternamn</th>
                            <th>E-post</th>
                            <th></th>
                            <th></th>  
                        </tr>
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server"></asp:PlaceHolder>
                    </table>
                    <asp:DataPager ID="DataPager" runat="server" PagedControlID="ListView" PageSize="20">
                  
                        <Fields>
                            <asp:NextPreviousPagerField 
                                ShowFirstPageButton="True" 
                                ShowNextPageButton="False" />
                            <asp:NumericPagerField />
                            <asp:NextPreviousPagerField 
                                ShowLastPageButton="True" 
                                ShowPreviousPageButton="False" />
                        </Fields>

                    </asp:DataPager>
                </LayoutTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <%#: Item.FirstName %>
                        </td>
                        <td>
                            <%#: Item.LastName %>
                        </td>
                        <td>
                            <%#: Item.EmailAddress %>
                        </td>
                        <td>
                            <asp:LinkButton CommandName="Edit" Text="Redigera" CausesValidation="false" runat="server"></asp:LinkButton>
                            <asp:LinkButton CommandName="Delete" Text="Ta bort" CausesValidation="false" runat="server" 
                             OnClientClick='<%# String.Format("return confirm(\"Vill du verkligen ta bort den här ({0} {1}) kontakten?\")", Item.FirstName, Item.LastName) %>'></asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <%-- Empty --%>
                <EmptyDataTemplate>
                    <table>
                        <tr>
                            <td>
                                Kunduppgifter saknas.
                            </td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                <%-- Update --%>
                <EditItemTemplate>
                    <tr>
                        <td>
                            <asp:TextBox ID="FirstNameTextBoxEdit" MaxLength="50" runat="server" Text='<%#: BindItem.FirstName %>' ValidationGroup="Edit"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFirstNameEdit" runat="server" ErrorMessage="Ett förnamn måste anges." ControlToValidate="FirstNameTextBoxEdit" Display="None" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="LastNameTextBoxEdit" MaxLength="50" runat="server" Text='<%#: BindItem.LastName %>' ValidationGroup="Edit"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredLastNameEdit" runat="server" ErrorMessage="Ett efternamn måste anges." ControlToValidate="LastNameTextBoxEdit" Display="None" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="EmailTextBoxEdit" MaxLength="50" runat="server" Text='<%#: BindItem.EmailAddress %>' ValidationGroup="Edit"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredEmailEdit" runat="server" ErrorMessage="En epost-adress måste anges." ControlToValidate="EmailTextBoxEdit" Display="None" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionEmailEdit" runat="server" ErrorMessage="Du måste ange en giltig epost-adress." ControlToValidate="EmailTextBoxEdit" Display="None" ValidationExpression="[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}" ValidationGroup="Edit"></asp:RegularExpressionValidator>
                        </td>
                        <td>    
                            <asp:LinkButton CommandName="Update" Text="Spara" runat="server"></asp:LinkButton>
                            <asp:LinkButton CommandName="Cancel" Text="Avbryt" CausesValidation="false" runat="server"></asp:LinkButton>
                        </td>
                    </tr>
                </EditItemTemplate>
                <%-- Insert --%>
                <InsertItemTemplate>
                    <tr>
                        <td>
                            <asp:TextBox ID="FirstNameTextBoxInsert" MaxLength="50" runat="server" Text='<%#: BindItem.FirstName %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFirstNameInsert" runat="server" ErrorMessage="Ett förnamn måste anges." ControlToValidate="FirstNameTextBoxInsert" Display="None"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="LastNameTextBoxInsert" MaxLength="50" runat="server" Text='<%#: BindItem.LastName %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredLastNameInsert" runat="server" ErrorMessage="Ett efternamn måste anges." ControlToValidate="LastNameTextBoxInsert" Display="None"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="EmailTextBoxInsert" MaxLength="50" runat="server" Text='<%#: BindItem.EmailAddress %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredEmailInsert" runat="server" ErrorMessage="En epost-adress måste anges." ControlToValidate="EmailTextBoxInsert" Display="None"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionEmailInsert" runat="server" ErrorMessage="Du måste ange en giltig epost-adress." ControlToValidate="EmailTextBoxInsert" Display="None" ValidationExpression="[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}"></asp:RegularExpressionValidator>
                        </td>
                        <td>    
                            <asp:LinkButton CommandName="Insert" Text="Lägg till" runat="server"></asp:LinkButton>
                            <asp:LinkButton CommandName="Cancel" Text="Avbryt" CausesValidation="false" runat="server"></asp:LinkButton>
                        </td>
                    
                    </tr>
                </InsertItemTemplate>
            </asp:ListView>
        </div>
    </form>
</body>
</html>

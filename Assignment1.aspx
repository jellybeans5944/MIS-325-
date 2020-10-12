<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Assignment1.aspx.vb" Inherits="MIS_325_Homework_Assignment1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style30 {
            width: 100%;
        }
        .auto-style31 {
            width: 198px;
        }
        .auto-style32 {
            width: 198px;
            height: 22px;
        }
        .auto-style33 {
            height: 22px;
        }
        .auto-style36 {
            height: 22px;
            width: 137px;
        }
        .auto-style37 {
            width: 137px;
        }
        .auto-style40 {
            width: 198px;
            height: 36px;
        }
        .auto-style42 {
            width: 137px;
            height: 36px;
        }
        .auto-style44 {
            height: 36px;
        }
        .auto-style45 {
            width: 198px;
            height: 66px;
        }
        .auto-style47 {
            width: 137px;
            height: 66px;
        }
        .auto-style49 {
            height: 66px;
        }
        .auto-style50 {
            width: 198px;
            height: 23px;
        }
        .auto-style52 {
            width: 137px;
            height: 23px;
        }
        .auto-style54 {
            height: 23px;
        }
        .auto-style55 {
            height: 22px;
            width: 128px;
        }
        .auto-style56 {
            width: 128px;
            height: 36px;
        }
        .auto-style57 {
            width: 128px;
            height: 66px;
        }
        .auto-style58 {
            width: 128px;
            height: 23px;
        }
        .auto-style59 {
            width: 128px;
        }
        .auto-style60 {
            width: 228px;
            height: 22px;
        }
        .auto-style61 {
            width: 228px;
            height: 36px;
        }
        .auto-style62 {
            width: 228px;
            height: 66px;
        }
        .auto-style63 {
            width: 228px;
            height: 23px;
        }
        .auto-style64 {
            width: 228px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <br />
            <table class="auto-style30">
                <tr>
                    <td class="auto-style32">Product Type </td>
                    <td class="auto-style60">Image</td>
                    <td class="auto-style36">Unit Price </td>
                    <td class="auto-style55">Quantity </td>
                    <td class="auto-style33">Sub Total</td>
                </tr>
                <tr>
                    <td class="auto-style40">Select Product
                        <br />
                    </td>
                    <td class="auto-style61"></td>
                    <td class="auto-style42"></td>
                    <td class="auto-style56"></td>
                    <td class="auto-style44"></td>
                </tr>
                <tr>
                    <td class="auto-style45">
                        <asp:RadioButtonList ID="RadioButtonList2" runat="server" Width="153px" AutoPostBack="True">
                            <asp:ListItem>Magazine(s)</asp:ListItem>
                            <asp:ListItem>Book(s)</asp:ListItem>
                            <asp:ListItem>Toy(s)</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td class="auto-style62">
                        <asp:Image ID="Image1" runat="server" />
                    </td>
                    <td class="auto-style47">
                        <br />
                        <asp:TextBox ID="txtBox1" runat="server"></asp:TextBox>
                        <br />
                        <br />
                    </td>
                    <td class="auto-style57">
                        <br />
                        <asp:TextBox ID="txtBox2" runat="server"></asp:TextBox>
                        <br />
                        <br />
                    </td>
                    <td class="auto-style49">
                        <br />
                        <asp:TextBox ID="txtBox3" runat="server"></asp:TextBox>
                        <br />
                        <br />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style50"></td>
                    <td class="auto-style63"></td>
                    <td class="auto-style52"></td>
                    <td class="auto-style58"></td>
                    <td class="auto-style54"></td>
                </tr>
                <tr>
                    <td class="auto-style31">
                        <asp:Button ID="Button3" runat="server" Text="Calculate" Height="26px" />
                    </td>
                    <td class="auto-style64">
                        <asp:TextBox ID="TxtOutput1" runat="server" Height="122px" TextMode="MultiLine" Width="212px"></asp:TextBox>
                    </td>
                    <td class="auto-style37">&nbsp;</td>
                    <td class="auto-style59">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style31">&nbsp;</td>
                    <td class="auto-style64">&nbsp;</td>
                    <td class="auto-style37">&nbsp;</td>
                    <td class="auto-style59">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style31">
                        <asp:Button ID="Button4" runat="server" Text="Clear " />
                    </td>
                    <td class="auto-style64">
                        <asp:TextBox ID="txtOutput2" runat="server" Height="109px" TextMode="MultiLine" Width="212px"></asp:TextBox>
                    </td>
                    <td class="auto-style37">&nbsp;</td>
                    <td class="auto-style59">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style31">&nbsp;</td>
                    <td class="auto-style64">&nbsp;</td>
                    <td class="auto-style37">&nbsp;</td>
                    <td class="auto-style59">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style31">&nbsp;</td>
                    <td class="auto-style64">&nbsp;</td>
                    <td class="auto-style37">&nbsp;</td>
                    <td class="auto-style59">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style31">&nbsp;</td>
                    <td class="auto-style64">&nbsp;</td>
                    <td class="auto-style37">&nbsp;</td>
                    <td class="auto-style59">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style31">&nbsp;</td>
                    <td class="auto-style64">&nbsp;</td>
                    <td class="auto-style37">&nbsp;</td>
                    <td class="auto-style59">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style31">&nbsp;</td>
                    <td class="auto-style64">&nbsp;</td>
                    <td class="auto-style37">&nbsp;</td>
                    <td class="auto-style59">&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
        </div>
    </form>
</body>
</html>

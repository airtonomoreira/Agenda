<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inserindo dados em um banco de dados Access</title>
    <style type="text/css">
        .style1 {
            font-family: "Trebuchet MS";
        }

        .auto-style1 {
            width: 360px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <script type="text/javascript">
                function toggle(o) {
                    var e = document.getElementById(o);
                    e.style.display = e.style.display == 'block' ? 'none' : 'block';
                }
                onload = function () {
                    var e, i = 0;
                    while (e = document.getElementById(['list1'][i++])) {
                        e.style.display = 'none';
                    }
                }
                function desabilita() {
                    alert('hello');
                }  
            </script>



            <div class="tabledata1">
                <span class="style1">
                    <a href="#" onclick="toggle('list1');"><strong>Novo Registro</strong></a>
                </span>
            </div>
            <div id="list1" style="font-family: Verdana; font-size: 11px; background-color: #cccccc; padding: 10px;">
                <table>
                    <tr>
                        <td>
                            <hr />
                            <table>
                                <tr>
                                    <td>Nome</td>
                                    <td style="margin-left: 40px" class="auto-style1">
                                        <asp:TextBox ID="nome" runat="server" Width="165px"></asp:TextBox>
                                        <asp:Label ID="Label1" runat="server" ForeColor="#CC0000" Text="*" Visible="False"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Endereco</td>
                                    <td class="auto-style1">
                                        <asp:TextBox ID="Endereco" runat="server" Width="165px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>Telefone Residencial</td>
                                    <td class="auto-style1">
                                        <asp:TextBox ID="TelefoneResidencial" runat="server" Width="165px" onKeyUp="mascara(this)" MaxLength="15"></asp:TextBox>
                                        <asp:Label ID="Label2" runat="server" ForeColor="#CC0000" Text="*" Visible="False"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Celular</td>
                                    <td class="auto-style1">
                                        <asp:TextBox ID="Celular" runat="server" Width="165px" onKeyUp="mascara(this)" MaxLength="15"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>Telefone (Outros)</td>
                                    <td class="auto-style1">
                                        <asp:TextBox ID="TelefoneOutros" runat="server" Width="165px" onKeyUp="mascara(this)" MaxLength="15"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>Email Pessoal</td>
                                    <td class="auto-style1">
                                        <asp:TextBox ID="EmailPessoal" runat="server" Width="165px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>Email Coml</td>
                                    <td class="auto-style1">
                                        <asp:TextBox ID="EmailComl" runat="server" Width="165px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>Email (Outros)</td>
                                    <td class="auto-style1">
                                        <asp:TextBox ID="EmailOutros" runat="server" Width="165px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>Nascimento</td>
                                    <td class="auto-style1">
                                        <asp:TextBox ID="Nascimento" runat="server" Width="165px" onKeyUp="mascara_data(this); " onBlur="isDate('Nascimento');" MaxLength="10"></asp:TextBox></td>
                                </tr>
                            </table>
                            <div style="text-align: right">
                                <asp:Literal ID="ID" runat="server" Visible="false"></asp:Literal>
                                <asp:Button ID="BtnSubmit" runat="server" Text="Inserir" OnClick="BtnSubmit_Click" />
                                <asp:Button ID="BtnExcluir" runat="server" Text="Excluir" OnClick="BtnExcluir_Click" Visible="false" />
                            </div>
                            <hr />
                        </td>
                    </tr>
                </table>
            </div>
        </div>

        <div style="font-family: Verdana; font-size: 11px; background-color: #c0c0c0; padding: 10px;">
            Procurar por&nbsp;
            <asp:DropDownList ID="DropDownList1" runat="server">
                <asp:ListItem>Nome</asp:ListItem>
                <asp:ListItem>TelefoneResidencial</asp:ListItem>
                <asp:ListItem>TelefoneOutros</asp:ListItem>
                <asp:ListItem>Celular</asp:ListItem>
                <asp:ListItem>Email</asp:ListItem>
            </asp:DropDownList>
            &nbsp;
            where like
            &nbsp;
            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            &nbsp;&nbsp;
            <asp:Button ID="Button1" runat="server" Text="Filtrar"
               OnClick ="Button1_Click" />
            &nbsp;&nbsp;&nbsp;
            <asp:Button ID="Button2" runat="server" Text="Limpar Filtro"
                OnClick="Button2_Click" />
            <br />

            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                    <asp:BoundField DataField="nome" HeaderText="nome" SortExpression="nome" />
                    <asp:BoundField DataField="Endereco" HeaderText="Endereco" SortExpression="Endereco" />
                    <asp:BoundField DataField="DDDResidencial" HeaderText="DDDResidencial" SortExpression="DDDResidencial" />
                    <asp:BoundField DataField="TelefoneResidencial" HeaderText="TelefoneResidencial" SortExpression="TelefoneResidencial" />
                    <asp:BoundField DataField="DDDCelular" HeaderText="DDDCelular" SortExpression="DDDCelular" />
                    <asp:BoundField DataField="Celular" HeaderText="Celular" SortExpression="Celular" />
                    <asp:BoundField DataField="DDDoutros" HeaderText="DDDoutros" SortExpression="DDDoutros" />
                    <asp:BoundField DataField="TelefoneOutros" HeaderText="TelefoneOutros" SortExpression="TelefoneOutros" />
                    <asp:BoundField DataField="EmailPessoal" HeaderText="EmailPessoal" SortExpression="EmailPessoal" />
                    <asp:BoundField DataField="EmailComl" HeaderText="EmailComl" SortExpression="EmailComl" />
                    <asp:BoundField DataField="EmailOutros" HeaderText="EmailOutros" SortExpression="EmailOutros" />
                    <asp:BoundField DataField="Nascimento" HeaderText="Nascimento" SortExpression="Nascimento" />
                    <asp:CommandField SelectText="Editar/Excluir" ShowSelectButton="True" />
                </Columns>
            </asp:GridView>
            <br />
        </div>
        <div>
        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:masterConnectionString %>" SelectCommand="SELECT * FROM [Pessoas]"></asp:SqlDataSource>
    </form>

</body>
</html>

<script type="text/javascript">
                function toggle(o) {
                    var e = document.getElementById(o);
                    e.style.display = e.style.display == 'block' ? 'none' : 'block';
                }
                onload = function () {
                    var e, i = 0;
                    while (e = document.getElementById(['list1'][i++])) {
                        e.style.display = 'block';
                    }
                }
</script>

<script>
                stop = '';
                function mascara(campo) {
                    campo.value = campo.value.replace(/[^\d]/g, '')
                        .replace(/^(\d\d)(\d)/, '($1) $2')
                        .replace(/(\d{5})(\d)/, '$1-$2');
                    if (campo.value.length > 15) campo.value = stop;
                    else stop = campo.value;
                }
</script>
<script type="text/javascript">
                function mascara_data(campo) {
                    campo.value = campo.value.replace(/[^\d]/g, '')
                        .replace(/(\d{2})(\d)/, '$1/$2')
                        .replace(/(\d{2})(\d)/, '$1/$2')

                }                
</script>

               
</script>
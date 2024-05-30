<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GestionTurno.aspx.cs" Inherits="GestionTurnoCliente.GestionTurno" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Gestión de Turnos</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" class="container">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
        <div class="form-group">
            <label for="txtNombre">Nombre</label>
            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label for="txtApellido">Apellido</label>
            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label for="txtDNI">DNI</label>
            <asp:TextBox ID="txtDNI" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label for="txtTelefono">Teléfono</label>
            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <div class="form-group">
            <label for="txtCorreo">Correo</label>
            <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        <br />
        <asp:Button ID="btnRegistrar" runat="server" Text="Registrar" CssClass="btn btn-primary" OnClick="btnRegistrar_Click" />
        <asp:Button ID="btnEliminarSeleccionados" runat="server" Text="Eliminar Seleccionados" CssClass="btn btn-danger" OnClientClick="return confirm('¿Estás seguro de que deseas eliminar los clientes seleccionados?');" OnClick="btnEliminarSeleccionados_Click" />

        <br />

        <asp:GridView ID="gvClientes" runat="server" AutoGenerateColumns="False" CssClass="table table-striped mt-3" DataKeyNames="ClienteId"
                    OnRowEditing="gvClientes_RowEditing" OnRowCancelingEdit="gvClientes_RowCancelingEdit" OnRowUpdating="gvClientes_RowUpdating"
                    OnRowDeleting="gvClientes_RowDeleting" AutoGenerateEditButton="True">
            <Columns>
                <asp:TemplateField HeaderText="Seleccionar">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkSeleccionar" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="ClienteId" HeaderText="ID" ReadOnly="True" Visible="False" />
                <asp:TemplateField HeaderText="Nombre">
                    <ItemTemplate>
                        <%# Eval("Nombre") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtNombre" runat="server" Text='<%# Bind("Nombre") %>' CssClass="form-control" />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Apellido">
                    <ItemTemplate>
                        <%# Eval("Apellido") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtApellido" runat="server" Text='<%# Bind("Apellido") %>' CssClass="form-control" />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="DNI">
                    <ItemTemplate>
                        <%# Eval("DNI") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtDNI" runat="server" Text='<%# Bind("DNI") %>' CssClass="form-control" />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Teléfono">
                    <ItemTemplate>
                        <%# Eval("Telefono") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtTelefono" runat="server" Text='<%# Bind("Telefono") %>' CssClass="form-control" />
                    </EditItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Correo">
                    <ItemTemplate>
                        <%# Eval("Correo") %>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtCorreo" runat="server" Text='<%# Bind("Correo") %>' CssClass="form-control" />
                    </EditItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>


    </form>
</body>
</html>

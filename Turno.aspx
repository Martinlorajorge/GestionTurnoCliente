<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Turno.aspx.cs" Inherits="GestionTurnoCliente.Turno" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Turnos Reservados</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" class="container">
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
        
        <asp:GridView ID="gvTurnos" runat="server" AutoGenerateColumns="False" CssClass="table table-striped mt-3" DataKeyNames="TurnoId">
            <Columns>
                <asp:BoundField DataField="TurnoId" HeaderText="ID" ReadOnly="True" />
                <asp:BoundField DataField="ClienteId" HeaderText="ID Cliente" ReadOnly="True" />
                <asp:BoundField DataField="NombreCompleto" HeaderText="Cliente" ReadOnly="True" />
                <asp:BoundField DataField="Fecha" HeaderText="Fecha" ReadOnly="True" />
                <asp:BoundField DataField="Hora" HeaderText="Hora" ReadOnly="True" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace GestionTurnoCliente
{
    public partial class GestionTurno : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["cadena"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarClientes();
            }
        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            string nombre = txtNombre.Text;
            string apellido = txtApellido.Text;
            string dni = txtDNI.Text;
            string telefono = txtTelefono.Text;
            string correo = txtCorreo.Text;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("INSERT INTO Clientes (Nombre, Apellido, DNI, Telefono, Correo, IsDeleted) VALUES (@Nombre, @Apellido, @DNI, @Telefono, @Correo, 0)", con))
                {
                    cmd.Parameters.AddWithValue("@Nombre", nombre);
                    cmd.Parameters.AddWithValue("@Apellido", apellido);
                    cmd.Parameters.AddWithValue("@DNI", dni);
                    cmd.Parameters.AddWithValue("@Telefono", telefono);
                    cmd.Parameters.AddWithValue("@Correo", correo);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            LimpiarCampos();
            CargarClientes();
        }

        private void LimpiarCampos()
        {
            txtNombre.Text = "";
            txtApellido.Text = "";
            txtDNI.Text = "";
            txtTelefono.Text = "";
            txtCorreo.Text = "";
        }

        private void CargarClientes()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT ClienteId, Nombre, Apellido, DNI, Telefono, Correo FROM Clientes WHERE IsDeleted = 0", con))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvClientes.DataSource = dt;
                        gvClientes.DataBind();
                    }
                }
            }
        }

        protected void gvClientes_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvClientes.EditIndex = e.NewEditIndex;
            CargarClientes(); // Recargar el GridView con el índice de edición activo
        }

        protected void gvClientes_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvClientes.EditIndex = -1;
            CargarClientes(); // Recargar el GridView después de cancelar la edición
        }

        protected void gvClientes_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int clienteId = Convert.ToInt32(gvClientes.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvClientes.Rows[e.RowIndex];

            string nombre = ((TextBox)row.FindControl("txtNombre")).Text;
            string apellido = ((TextBox)row.FindControl("txtApellido")).Text;
            string dni = ((TextBox)row.FindControl("txtDNI")).Text;
            string telefono = ((TextBox)row.FindControl("txtTelefono")).Text;
            string correo = ((TextBox)row.FindControl("txtCorreo")).Text;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("UPDATE Clientes SET Nombre = @Nombre, Apellido = @Apellido, DNI = @DNI, Telefono = @Telefono, Correo = @Correo WHERE ClienteId = @ClienteId", con))
                {
                    cmd.Parameters.AddWithValue("@Nombre", nombre);
                    cmd.Parameters.AddWithValue("@Apellido", apellido);
                    cmd.Parameters.AddWithValue("@DNI", dni);
                    cmd.Parameters.AddWithValue("@Telefono", telefono);
                    cmd.Parameters.AddWithValue("@Correo", correo);
                    cmd.Parameters.AddWithValue("@ClienteId", clienteId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            gvClientes.EditIndex = -1; // Salir del modo de edición
            CargarClientes(); // Recargar la grilla con los datos actualizados
        }


        protected void gvClientes_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int clienteId = Convert.ToInt32(gvClientes.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("UPDATE Clientes SET IsDeleted = 1 WHERE ClienteId = @ClienteId", con))
                {
                    cmd.Parameters.AddWithValue("@ClienteId", clienteId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            CargarClientes(); // Recargar la grilla con los datos actualizados después de la eliminación
        }

        protected string GetConfirmDeleteScript(string nombre)
        {
            return $"return confirm('¿Estás seguro de que deseas eliminar a {nombre}?');";
        }

        protected void btnEliminarSeleccionados_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvClientes.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {
                    CheckBox chkSeleccionar = (CheckBox)row.FindControl("chkSeleccionar");
                    if (chkSeleccionar.Checked)
                    {
                        int clienteId = Convert.ToInt32(gvClientes.DataKeys[row.RowIndex].Value);

                        using (SqlConnection con = new SqlConnection(connectionString))
                        {
                            using (SqlCommand cmd = new SqlCommand("UPDATE Clientes SET IsDeleted = 1 WHERE ClienteId = @ClienteId", con))
                            {
                                cmd.Parameters.AddWithValue("@ClienteId", clienteId);

                                con.Open();
                                cmd.ExecuteNonQuery();
                                con.Close();
                            }
                        }
                    }
                }
            }

            CargarClientes(); // Recargar la grilla con los datos actualizados después de la eliminación
        }

    }
}

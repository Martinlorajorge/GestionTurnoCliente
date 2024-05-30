using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace GestionTurnoCliente
{
    public partial class Turno : System.Web.UI.Page
    {
        private string connectionString = ConfigurationManager.ConnectionStrings["cadena"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarTurnos();
            }
        }

        private void CargarTurnos()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT T.TurnoId, T.ClienteId, CONCAT(C.Nombre, ' ', C.Apellido) AS NombreCompleto, T.Fecha, T.Hora FROM Turnos T INNER JOIN Clientes C ON T.ClienteId = C.ClienteId", con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    gvTurnos.DataSource = reader;
                    gvTurnos.DataBind();
                    con.Close();
                }
            }
        }
    }
}

using System.Data;
using Microsoft.AspNetCore.Mvc;
using MySqlConnector;

namespace MiWebServiceMysql.Controllers
{
    [ApiController]
    [Route("api/[controller]")] // <--- Esto define que la URL base es /api/menu
    public class MenuController : ControllerBase
    {
        [HttpGet] // <--- Déjalo solo como [HttpGet] sin parámetros
        public async Task<IActionResult> GetMenu([FromServices] MySqlConnection connection,
            [FromQuery] int? tipo = 0,
            [FromQuery] string? usuario = "",
            [FromQuery] string? rol = "")
        {
            await connection.OpenAsync();
            using var command = new MySqlCommand("pa_menu", connection);

            // Indicamos que se trata de un procedimiento almacenado
            command.CommandType = CommandType.StoredProcedure;

            // Agregamos los parámetros requeridos por el SP
            command.Parameters.AddWithValue("p_tipo", tipo.HasValue ? tipo.Value : DBNull.Value);
            command.Parameters.AddWithValue("p_usuario", string.IsNullOrEmpty(usuario) ? DBNull.Value : usuario);
            command.Parameters.AddWithValue("p_rol", string.IsNullOrEmpty(rol) ? DBNull.Value : rol);

            using var reader = await command.ExecuteReaderAsync();

            var lista = new List<object>();
            while (await reader.ReadAsync())
            {
                lista.Add(new { Id = reader["id"], Nombre = reader["descripcion"], padre = reader["padre"], url = reader["url"] });
            }

            return Ok(lista);
        }
    }
}
using Microsoft.AspNetCore.Mvc;
using MoviesApi.Core.Domain.Dtos;
using MoviesApi.Core.Domain.Entity;
using MoviesApi.Core.Domain.Exceptions;
using MoviesApi.Core.Domain.Ports;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace MoviesApi.Adapters.Driving.Controllers
{
    [Route("[controller]")]
    [ApiController]
    [Produces("application/json")]
    public class MovieController(IMovieService service) : ControllerBase
    {

        [HttpGet]
        public IActionResult Get()
        {
            return Ok(service.GetAllMovies());
        }


        [HttpGet("{id}")]
        public IActionResult Get(int id)
        {
            try
            {
                return Ok(service.GetMovieById(id));
            }
            catch (MovieNotFound)
            { 
                return NotFound();
            }
        }

        /// <summary>
        /// Adiciona um filme ao banco de dados
        /// </summary>
        /// <param name="movie">Objeto com os campos necessários para criação de um filme</param>
        /// <returns>IActionResult</returns>
        /// <response code="200">Caso inserção seja feita com sucesso</response>
        /// <response code="400">Caso inserção seja feita com sucesso</response>
        [HttpPost]
        [ProducesResponseType(StatusCodes.Status201Created, Type=typeof(Movie))]
        
        public IActionResult Post([FromBody] CreateMovieDto movie)
        {
            return Created(nameof(Get),service.CreateMovie(movie));
        }

        [HttpPatch("{id}")]
        public IActionResult Put(int id, [FromBody] UpdateMovieDto movie)
        {
            try
            {
                if (movie.IsAllNull()) return BadRequest(
                    "Nothing to update.");
                service.UpdateMovie(id, movie);
                return NoContent();
            }
            catch (MovieNotFound)
            {
                return NotFound();
            }
        }


        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            try
            {
                service.DeleteMovie(id);
                return NoContent();
            }
            catch (MovieNotFound)
            {
                return NotFound();
            }
        }
    }
}

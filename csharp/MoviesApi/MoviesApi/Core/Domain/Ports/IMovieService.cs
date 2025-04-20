using MoviesApi.Core.Domain.Dtos;
using MoviesApi.Core.Domain.Entity;

namespace MoviesApi.Core.Domain.Ports;

public interface IMovieService
{
    public Movie CreateMovie(CreateMovieDto movie);
    public IEnumerable<Movie> GetAllMovies();
    public Movie GetMovieById(int id);
    public void UpdateMovie(int id, UpdateMovieDto movie);
    public void DeleteMovie(int id);
}

using MoviesApi.Core.Domain.Dtos;
using MoviesApi.Core.Domain.Entity;
using MoviesApi.Core.Domain.Exceptions;
using MoviesApi.Core.Domain.Ports;

namespace MoviesApi.Core.Application;

public class MovieService(IStorageService storageService) : IMovieService 
{


    public Movie CreateMovie(CreateMovieDto movie)
    {
        var saveMovie = new Movie(
            movie.Duration,
            movie.Title,
            movie.Genre, 
            0);
        return storageService.Save(saveMovie);
    }

    public void DeleteMovie(int id)
    {
        if (storageService.GetById(id) == null)
        {
            throw new MovieNotFound();
        }

        storageService.Delete(id);
    }

    public IEnumerable<Movie> GetAllMovies()
    {
       return storageService.GetAll();
    }

    public Movie GetMovieById(int id)
    {
        if (storageService.GetById(id) == null)
        {
            throw new MovieNotFound();
        }

        return storageService.GetById(id)!;
        
    }

    public void UpdateMovie(int id, UpdateMovieDto movie)
    {
        if (storageService.GetById(id) == null)
        {
            throw new MovieNotFound();
        }

        storageService.Update(id, movie);
    }


}

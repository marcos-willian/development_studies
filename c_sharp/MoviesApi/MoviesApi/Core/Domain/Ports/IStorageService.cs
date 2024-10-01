using MoviesApi.Core.Domain.Dtos;
using MoviesApi.Core.Domain.Entity;

namespace MoviesApi.Core.Domain.Ports
{
    public interface IStorageService
    {
        void Delete(int id);
        IEnumerable<Movie> GetAll();
        Movie? GetById(int id);
        Movie Save(Movie movie);
        void Update( int movieIdToUpdate, UpdateMovieDto data);
    }
}

using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.EntityFrameworkCore;
using MoviesApi.Core.Domain.Dtos;
using MoviesApi.Core.Domain.Entity;
using MoviesApi.Core.Domain.Exceptions;
using MoviesApi.Core.Domain.Ports;

namespace MoviesApi.Adapters.Driven
{
    public class ContextStorage : DbContext, IStorageService
    {

        public ContextStorage(DbContextOptions<ContextStorage> opts)
        : base(opts)
        {

        }

        public DbSet<Movie> Movies { get; set; }

        public void Delete(int id)
        {
            var movie = Movies.Find(id);
            if (movie == null) throw new MovieNotFound();

            Movies.Remove(movie!);
            SaveChanges();
        }

        public IEnumerable<Movie> GetAll()
        {
            return Movies;
        }

        public Movie? GetById(int id)
        {
           return Movies.Find(id);

        }

        public Movie Save(Movie movie)
        {
            var movieCreated = Movies.Add(movie);
            SaveChanges();
            return movieCreated.Entity;
            
        }

        public void Update(int movieIdToUpdate, UpdateMovieDto data)
        {
            var movie = Movies.Find(movieIdToUpdate);
            if (movie == null) throw new MovieNotFound();

            movie!.Update(
                duration: data.Duration,
                title: data.Title,
                genre: data.Genre);
            Update(movie);
            SaveChanges();
        }
    }
}

using System.ComponentModel.DataAnnotations;

namespace MoviesApi.Core.Domain.Entity;

public class Movie(int duration, string title, string genre, int id)
{
    [Range(70, 600, ErrorMessage = "The movie duration must be beetwen 70 and 600 minutes.")]
    [Required]
    public int Duration { get; private set; } = duration;
    [Required]
    public string Title { get; private set; } = title;
    [Required]
    [MaxLength(50, ErrorMessage ="The movie genre must be smaller tha 50 characters")]
    public string Genre { get; private set; } = genre;
    [Key]
    [Required]
    public int Id { get; init; } = id;


    public void Update(
        int? duration, 
        string? title, 
        string? genre)
    {
        Duration = duration ?? Duration;
        Title = title ?? Title;
        Genre = genre ?? Genre;
    }
}

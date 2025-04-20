using System.ComponentModel.DataAnnotations;

namespace MoviesApi.Core.Domain.Dtos;

public class UpdateMovieDto
{
    [Range(70, 600, ErrorMessage = "The movie duration must be beetwen 70 and 600 minutes.")]
    public int? Duration { get; set; }
    public string? Title { get; set; }
    [StringLength(50, ErrorMessage = "The movie genre must be smaller tha 50 characters")]
    public string? Genre { get; set; }

    public bool IsAllNull()
    {
        return (Duration == null) && (Title == null) && (Genre == null);
    }
}

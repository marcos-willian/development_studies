using System.ComponentModel.DataAnnotations;

namespace MoviesApi.Core.Domain.Dtos;

public class CreateMovieDto
{
    [Range(70, 600, ErrorMessage = "The movie duration must be beetwen 70 and 600 minutes.")]
    [Required]
    public required int Duration { get; set; }
    [Required]
    public required string Title { get; set; }
    [Required]
    [StringLength(50, ErrorMessage = "The movie genre must be smaller tha 50 characters")]
    public required string Genre { get; set; } 

}

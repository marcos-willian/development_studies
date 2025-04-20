using ScreenSound.Models;

namespace ScreenSound.Services.API;

internal interface IMusicsApi
{
    Task<List<Music>> GetMusics();
}

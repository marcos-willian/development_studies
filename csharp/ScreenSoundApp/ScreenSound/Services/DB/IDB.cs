
using ScreenSound.Models;

namespace ScreenSound.Services.DB;

internal interface IDB
{
    public void SaveMusic(Music music);

    public void DeleteMusic(Music name);

    public IEnumerable<Music> GetAllMusic();

    public Dictionary<string, IEnumerable<int>> GetBandsNotes();

    /// <summary>
    /// Update Band info
    /// </summary>
    /// <param name="name">Band name</param>
    /// <param name="note">Note for the band</param>
    public void GiveBandNote(string name, int note);
}



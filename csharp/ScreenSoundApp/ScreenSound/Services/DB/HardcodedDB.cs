

using ScreenSound.Models;
using System.Text.Json;

namespace ScreenSound.Services.DB;

class HardcodedDB : IDB
{
    public HardcodedDB()
    {
        try
        {
            string fileContent = File.ReadAllText("notes");
            cacheNotes = JsonSerializer.Deserialize<Dictionary<string, IEnumerable<int>>>(fileContent)!;
        }
        catch (FileNotFoundException)
        {
            cacheNotes = [];
        }

        try
        {
            string fileContent = File.ReadAllText("musics");
            cacheMusics = JsonSerializer.Deserialize<List<Music>>(fileContent)!;
        }
        catch 
        {
            cacheMusics = [];
        }


    }

    private Dictionary<string, IEnumerable<int>> cacheNotes;
    private readonly List<Music> cacheMusics;

    private void SaveCacheMusics()
    {
        using FileStream file = File.Create("musics");
        file.Write(JsonSerializer.SerializeToUtf8Bytes(cacheMusics));
        file.Close();
    }

    public void DeleteMusic(Music music)
    {
        cacheMusics.RemoveAt(cacheMusics.FindIndex((music) => music.Name.Equals(music.Name)));
        SaveCacheMusics();
    }

    public IEnumerable<Music> GetAllMusic()
    {
        return cacheMusics;
    }
    public void SaveMusic(Music music)
    {
        cacheMusics.Add(music);
        SaveCacheMusics();
    }

    public Dictionary<string, IEnumerable<int>> GetBandsNotes()
    {
        return cacheNotes;
    }

    public void GiveBandNote(string name, int note)
    {
        if(!cacheNotes.ContainsKey(name))
        {
            cacheNotes.Add(name, new List<int>());
        }

        cacheNotes[name] = cacheNotes[name].Append(note);

        using FileStream file = File.Create("notes");
        file.Write(JsonSerializer.SerializeToUtf8Bytes(cacheNotes));
        file.Close();
    }

}

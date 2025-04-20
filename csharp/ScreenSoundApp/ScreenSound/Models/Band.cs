using ScreenSound.models;

namespace ScreenSound.Models;

internal class Band(string name)
{
    private readonly List<Note> _notes = [];
    private readonly List<Music> _musics = [];

    public IEnumerable<Music> Musics => _musics.OrderBy((key) => key.Name);

    public void SetNotes(IEnumerable<int> notes)
    {
        _notes.Clear();
        foreach (int note in notes)
        {
            _notes.Add(new (note));
        }
    }

    public string description = "";

    public void AddMusic(Music music) => _musics.Add(music);

    public string Name => name;
    public double Media
    {
        get
        {
            if(_notes.Count == 0) 
                return 0;
            return _notes.Average(n => n.NoteValue);
        }
    }

    public void GiveNote(int note) => _notes.Add(new Note(note));
    public void GiveNote(Note note) => _notes.Add(note);

    public string ShowMusics()
    {
        string text = "";
        foreach (var music in Musics)
        {
            text += $"-> {music.Name} - {music.Year}\n";
        }
        return text;
    }
}
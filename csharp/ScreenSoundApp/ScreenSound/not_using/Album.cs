//using ScreenSound.Models;

//namespace ScreenSound.not_using;

//internal class Album(string nome)
//{
//    private readonly List<Music> musics = [];

//    public string Name { get; } = nome;
//    public int TotalDuration => musics.Sum(m => m.Duration);

//    public void AddMusic(Music music)
//    {
//        musics.Add(music);
//    }

//    public void ShowAlbumMusics()
//    {
//        Console.WriteLine($"Lista de músicas do álbum {Name}:\n");
//        foreach (var music in musics)
//        {
//            Console.WriteLine($"Música: {music.Name}");
//        }
//        Console.WriteLine($"\nPara ouvir este álbum inteiro você precisa de {TotalDuration}");
//    }
//}
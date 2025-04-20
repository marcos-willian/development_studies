//namespace ScreenSound.not_using;

//internal class Podcast(Person host, string name)


//{

//    private static void Main(string[] args)
//    {
//        Podcast podcast = new Podcast(
//    new Person("Marcos"),
//    "Test"
//    );

//        podcast.AddEpisode(new Episodio("Primeiro episodio", "Esse é o primeiro podcast da serie"));

//        podcast.AddEpisode("Segundo podcast", "Esse podcast é dms");

//        podcast.ShowDetails();
//    }


//    Person Host => host;

//    int TotalEpisodios { get { return _episodes.Count; } }

//    public string Name => name;

//    private List<Episodio> _episodes = new List<Episodio>();

//    public void AddEpisode(Episodio episodio)
//    {
//        _episodes.Add(episodio);
//    }

//    public void AddEpisode(string title, string resumo = "")
//    {
//        _episodes.Add(
//            new Episodio(title, resumo, _episodes.Count)
//        );
//    }



//    public void ShowDetails()
//    {
//        Console.WriteLine($"Podcast {name} -  Apresentado por {host}");
//        Console.WriteLine($"Tem {TotalEpisodios} episódios");
//        Console.WriteLine("Aperte Enter para mostrar informações dos episódios:");
//        ConsoleKeyInfo keyInfo = Console.ReadKey();
//        if (keyInfo.Key != ConsoleKey.Enter) { return; }
//        foreach (var episode in _episodes)
//        {
//            episode.ShowDetails();

//        }
//    }

//}
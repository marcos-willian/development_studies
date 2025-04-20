//using ScreenSound.Models;

//namespace ScreenSound.not_using;

//internal class Episodio(string titulo, string resumo, int ordem = 0)
//{
//    public int Ordem => ordem;
//    public string Resumo => resumo;
//    public int Duracao => musicaList.Sum(m => m.Duration);

//    public string Titulo => titulo;

//    readonly List<Music> musicaList = new List<Music> {
//        new Music(
//            new Band("Blazy"),
//            "Interlude"
//         ){
//            Duration = 300,
//        }
//    };

//    readonly List<Person> convidados = new List<Person>();

//    public void ShowDetails()
//    {
//        Console.WriteLine($"Episódio {titulo} - Duração total: {Duracao} - Ordem {ordem}");
//        Console.WriteLine($"Resumo: {Resumo}");
//        Console.WriteLine($"Convidados: ");
//        foreach (Person person in convidados)
//        {
//            Console.WriteLine($"\t{person}");
//        }

//    }

//    public void AdicionarConvidados(Person convidado)
//    {
//        convidados.Add(convidado);
//    }
//}


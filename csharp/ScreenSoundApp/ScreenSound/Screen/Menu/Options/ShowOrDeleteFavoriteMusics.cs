using ScreenSound.models;
using ScreenSound.Models;
using ScreenSound.Services.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ScreenSound.Screen.Menu.Options;

internal class ShowOrDeleteFavoriteMusics(MusicDao dao) : MenuOption
{

    public override string Action => "mostrar músicas favoritas ou remover de favoritos";

    public override Task Execute()
    {
        IEnumerable<Music> musics = dao.GetFavorites();
        Console.Clear();

        ShowTitle("Musicas favoritas");

        Console.WriteLine("1 - Retirar uma musica dos favoritos ou aperte enter para continuar");

        foreach (var music in musics)
        {
            Console.WriteLine($"-> {music.Name} - {music.Year}. Band: {music.BandName}");
        }


        string? result = Console.ReadLine();

        if (result != "1")
        {
            return Task.CompletedTask;
        }

        string selectedMusic = ShowSearchField(
            title: "Retirar uma musica dos favoritos",
            description: "Digite o nome da musica que deseja remover dos favoritos: (Aperte enter para escolher a primeira opção)",
            bands: dao.GetFavorites().Select((music) => music.Name)
      ) ;
        if (selectedMusic != "")
        {
            dao.RemoveFromFavorites(selectedMusic);
            Console.WriteLine($"\nA musica {selectedMusic} foi removida com sucesso");
        }
        else
        {
            Console.WriteLine($"\nA banda {selectedMusic} não foi encontrada!");
        }
        WaitForKey();
        return Task.CompletedTask;
    }
}

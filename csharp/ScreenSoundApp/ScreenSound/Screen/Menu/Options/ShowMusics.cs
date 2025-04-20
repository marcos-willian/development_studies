using ScreenSound.models;
using ScreenSound.Models;
using ScreenSound.Services.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ScreenSound.Screen.Menu.Options;

internal class ShowMusics(MusicDao dao) : MenuOption
{
    public override string Action => "mostrar todas as musicas";

    public override Task Execute()
    {
        Console.Clear();

        ShowTitle("Musicas disponíveis");

        IEnumerable<Music> musics = dao.AllMusics();

        foreach (Music music in musics)
        {
            Console.WriteLine($"-> {music.Name} - {music.Year}");
        }

        Console.WriteLine("1 - Filtrar por gênero ou aperte enter para continuar");
        string? result = Console.ReadLine();

        if (result != "1")
        {
            return Task.CompletedTask;
        }

        Console.WriteLine($"Selecione um gênero");

        string genre = ShowSearchField(
            title: "Filtrar por gênero.",
            description: "\"Digite o gênero que deseja filtrar: (Aperte enter para escolher a primeira opção)\"",
            dao.GetMusicStyles()
         );

        foreach (Music music in dao.FilterMusicByStyle(genre))
        {
            Console.WriteLine($"-> {music.Name} - {music.Year}");
        }

        WaitForKey();
        return Task.CompletedTask;
    }
}

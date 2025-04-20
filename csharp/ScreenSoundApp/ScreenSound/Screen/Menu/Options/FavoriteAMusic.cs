using ScreenSound.models;
using ScreenSound.Models;
using ScreenSound.Services.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ScreenSound.Screen.Menu.Options;

internal class FavoriteAMusic(MusicDao dao) : MenuOption
{


    public override string Action => "salvar como favorita uma musica";

    public override Task Execute()
    {
        IEnumerable<Music> musics = dao.AllMusics();
        string selectedBand = ShowSearchField(
            title: "Salvar como favorita",
            description: "Digite o nome da musica que deseja salvar como favorita: (Aperte enter para escolher a primeira opção)",
            bands: musics.Select((music) => music.Name)
        );

        dao.FavoriteMusic(selectedBand);

        Console.WriteLine("Música salva com sucesso!!!");
        WaitForKey();

        return Task.CompletedTask;

    }
}

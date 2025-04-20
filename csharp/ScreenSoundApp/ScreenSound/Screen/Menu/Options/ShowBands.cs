using ScreenSound.Models;
using ScreenSound.Services.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ScreenSound.Screen.Menu.Options;

internal class ShowBands(BandDao dao) : MenuOption

{
    private readonly BandDao dao = dao;

    public override string Action => "mostrar todas as bandas";

    public override Task Execute()
    {
        Console.Clear();
        ShowTitle("Exibindo todas as bandas registradas na nossa aplicação");
        IEnumerable<string> bands = dao.GetBandsName();
        foreach (string band in bands)
        {
            Console.WriteLine($"Banda: {band}");
        }
        WaitForKey();
        return Task.CompletedTask;
    }
}

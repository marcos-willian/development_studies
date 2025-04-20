using ScreenSound.models;
using ScreenSound.Models;
using ScreenSound.Services.DAO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ScreenSound.Screen.Menu.Options;

internal class GiveNoteToBand(BandDao dB) : MenuOption
{

    private readonly BandDao _dB = dB;

    public override string Action => "avaliar uma banda";

    public override Task Execute()
    {
        IEnumerable<string> bands = _dB.GetBandsName();
        string selectedBand = ShowSearchField(
            title: "Avaliar banda",
            description: "Digite o nome da banda que deseja avaliar: (Aperte enter para escolher a primeira opção)",
            bands: bands
      );
        if (selectedBand != "")
        {
            Console.Write($"Qual a nota que a banda {selectedBand} merece: ");
            Note nota = new(Console.ReadLine()!);
            _dB.GiveNote(selectedBand,nota);
            Console.WriteLine($"\nA nota {nota} foi registrada com sucesso para a banda {selectedBand}");
        }
        else
        {
            Console.WriteLine($"\nA banda {selectedBand} não foi encontrada!");
        }
        WaitForKey();
        return Task.CompletedTask;
    }
}

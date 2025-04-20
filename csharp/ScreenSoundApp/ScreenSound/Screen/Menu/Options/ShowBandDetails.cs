using ScreenSound.Models;
using ScreenSound.Services.DAO;
using ScreenSound.Services.IA;


namespace ScreenSound.Screen.Menu.Options;

internal class ShowBandDetails(BandDao db) : MenuOption
{

    public override string Action => "exibir os detalhes de uma banda";

    public override async Task Execute()
    {
        IEnumerable<string> bands = db.GetBandsName();

        string selectedBand = ShowSearchField(
            title: "Exibir média da banda",
            description: "Digite o nome da banda que deseja exibir a média: (Aperte enter para escolher a primeira opção)",
            bands: bands
        );
        Band band = db.GetBandByName( selectedBand );
        Console.WriteLine("Carregando . . .");
        var description = await db.BandDescription(band.Name);
        Console.WriteLine(description);
        Console.WriteLine($"\nA média para a banda: {selectedBand} é: {band.Media}\n");
        Console.WriteLine($"Discografia:\n{band.ShowMusics()}");
        WaitForKey();
    }
}

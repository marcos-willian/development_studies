using ScreenSound.Screen;
using ScreenSound.Screen.Menu.Options;
using ScreenSound.Services.API;
using ScreenSound.Services.DAO;
using ScreenSound.Services.DB;
using ScreenSound.Services.IA;


Console.WriteLine("Carregando as informações ...");
IDB dB = new HardcodedDB();
BandDao dao = new(dB, new MusicsApi(), new OpenIAClient() );
MusicDao musicDao = new(dao, dB);
await dao.LoadBandList();

View view = new(options: [
    new GiveNoteToBand(dao),
    new ShowBandDetails(dao),
    new ShowBands(dao),
    new ShowMusics(musicDao),
    new FavoriteAMusic(musicDao),
    new ShowOrDeleteFavoriteMusics(musicDao),
]);

await view.StartAsync();


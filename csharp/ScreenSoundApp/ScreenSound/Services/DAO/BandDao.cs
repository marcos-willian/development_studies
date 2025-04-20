
using ScreenSound.models;
using ScreenSound.Models;
using ScreenSound.Services.API;
using ScreenSound.Services.DB;
using ScreenSound.Services.IA;

namespace ScreenSound.Services.DAO;

internal class BandDao(IDB db, IMusicsApi api, IAClient ia)
{
    private readonly IAClient _ia = ia;
    private readonly IDB _db = db;
    private readonly IMusicsApi _api = api;
    private readonly List<Band> _bandList = [];

    private int IndexByName(string name) => _bandList.FindIndex(
        band => band.Name.Equals(name)
    );

    private void UpdateBandList(object? music, string bandName)
    {
        ArgumentNullException.ThrowIfNull(music);

        bool selector(Band band) => band.Name.Equals(bandName);

        if (_bandList.Exists(selector))
        {
            _bandList[_bandList.FindIndex(selector)].AddMusic((Music)music);
            return;
        }
        var band = new Band(bandName);
        band.AddMusic((Music)music);
        _bandList.Add(band);
    }

    public IEnumerable<Band> BandList => _bandList;

    public async Task LoadBandList()
    {
        Music.NewBand += UpdateBandList;
        await _api.GetMusics();
        Music.NewBand -= UpdateBandList;
        var bandsInMemory = _db.GetBandsNotes();
        foreach (var bandInfo in bandsInMemory)
        {
            _bandList[IndexByName(bandInfo.Key)].SetNotes(bandInfo.Value);
        }
    }

    public IEnumerable<string> GetBandsName()
    {
        return _bandList.Select(band => band.Name).Order();
    }

    public Band GetBandByName(string name)
    {
        return _bandList.First(band => band.Name == name);
    }

    public void GiveNote(string bandName, Note note)
    {
        Band band = GetBandByName(bandName);
        band.GiveNote(note);
        _db.GiveBandNote(bandName, note.NoteValue);
    }

    public async Task<string> BandDescription(string bandName)
    {
        var description = await _ia.MakeRequest($"Uma descrição da banda {bandName}, informal.");
        _bandList[IndexByName(bandName)].description = description;
        return description;
    }
}

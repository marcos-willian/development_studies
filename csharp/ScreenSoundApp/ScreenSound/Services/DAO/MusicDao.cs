
using ScreenSound.Models;
using ScreenSound.Services.DB;

namespace ScreenSound.Services.DAO;


internal class MusicDao(BandDao bandDao, IDB db)
{
    public IEnumerable<Music> AllMusics()
    {
        var musicsByBand = bandDao.BandList.Select(band => band.Musics);
        List<Music> musics = [];
        foreach (var musicList in musicsByBand)
        {
            musics.AddRange(musicList);
        }
        return musics.OrderBy((music) => music.Name);
    }

    public IEnumerable<Music> FilterMusicByStyle(string genre)
    {
        return AllMusics().Where((music) => music.Genres.Contains(genre));
    }

        public IEnumerable<string> GetMusicStyles()
    {
        List<Music> musics = AllMusics().ToList();
        return musics.Select(music => music.Genres)
                     .Aggregate((genreByMusic, genres) => [.. genres, .. genreByMusic])
                     .Distinct();
    }

    public IEnumerable<Music> GetMusicByBand(string bandName)
    {
        return bandDao.GetBandByName(bandName).Musics;
    }

    public void FavoriteMusic(string musicName)
    {
        var music = AllMusics().ToList().Find((music) => music.Name.Equals(musicName)) ?? throw new MusicNotFoundException(musicName);
        db.SaveMusic(music);
    }

    public void FavoriteMusic(Music music)
    {
        db.SaveMusic( music);
    }

    public IEnumerable<Music> GetFavorites()
    {
        return db.GetAllMusic();
    }

    public void RemoveFromFavorites(string musicName)
    {
        var music = AllMusics().ToList().Find((music) => music.Name.Equals(musicName)) ?? throw new MusicNotFoundException(musicName);
        db.DeleteMusic(music);
    }

    public void RemoveFromFavorites(Music music)
    {
        db.DeleteMusic(music);
    }

}


internal class MusicNotFoundException(string musicName) :
    Exception(
        $"Music {musicName} não foi encontrada"
        );
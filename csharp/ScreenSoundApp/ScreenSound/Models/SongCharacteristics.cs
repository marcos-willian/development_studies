using System.ComponentModel;
using System.Diagnostics.Metrics;
using System.Formats.Asn1;
using System.Globalization;
using System.Text.Json;
using System.Text.Json.Serialization;
using System.Text.Json.Serialization.Metadata;

namespace ScreenSound.Models;

internal record class SongCharacteristics(
   double Popularity,
   double Danceability,
   double Energy,
   double Speechiness,
   double Instrumentalness,
   double Acousticness,
   double Liveness,
   double Valence
    );


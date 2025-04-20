using JornadaMilhasV1.Modelos;
using Microsoft.IdentityModel.Tokens;
using Xunit;

namespace JornadaMilhas.Test;

public class OfertaViagemTest
{
    [Theory]
    [InlineData("", null, "2024-01-01", "2024-01-02", 0, false)]
    [InlineData("OrigemTeste", "DestinoTeste", "2024-02-01", "2024-02-05", 100, true)]
    [InlineData(null, "São Paulo", "2024-01-01", "2024-01-02", -1, false)]
    [InlineData("Vitória", "São Paulo", "2024-01-01", "2024-01-01", 0, false)]
    [InlineData("Rio de Janeiro", "São Paulo", "2024-01-01", "2024-01-02", -500, false)]
    public void ShouldShowEhValidoFalseWhenDataIsInvalid(
        string origin,
        string destiny,
        string initialDate,
        string finalDate,
        double price,
        bool isValid
    )
    {
        //Arrange
        var rota = new Rota(origin, destiny);
        var period = new Periodo(DateTime.Parse(initialDate), DateTime.Parse(finalDate));

        //Act
        var offer = new OfertaViagem(rota, period, price);

        //Assert
        Assert.Equal(isValid, offer.EhValido);
    }


    [Theory]
    [InlineData(false, true, 1, OfertaViagem.RouteOrPeriodNullError)]
    [InlineData(true, false, 1, OfertaViagem.RouteOrPeriodNullError)]
    [InlineData(false, false, 0, OfertaViagem.PriceLowerOrEqualZeroError)]
    public void ShouldShowTheRightMessageAccordingToTheValidationError(
        bool isRouteNull,
        bool isPeriodNull,
        double price,
        string message
    )
    {
        //Arrange
        Rota? rota = isRouteNull ? null : new Rota("", "");
        Periodo? period = isPeriodNull ? null : new Periodo(
            DateTime.Parse("2024-02-01"), 
            DateTime.Parse("2024-02-05")
        );

        //Act
#pragma warning disable CS8604 // Possible null reference argument.
        var offer = new OfertaViagem(rota, period, price);
#pragma warning restore CS8604 // Possible null reference argument.

        //Assert
        Assert.Contains(message, offer.Erros.Select((err) => err.Mensagem));
    }


}
using DevOps.Api.Services;
namespace DevOps.Api.Tests;

public class CalculadoraServiceTests
{
    [Fact]
    public void Somar_DeveRetornarSomaDosDoisNumeros()
    {
        // Arrange
        var calculadora = new CalculadoraService();

        // Act
        int resultado = calculadora.Somar(10, 5);

        // Assert
        Assert.Equal(15, resultado);
    }

    [Fact]
    public void Somar_ComNumeroNegativo_DeveRetornarResultadoCorreto()
    {
        // Arrange
        var calculadora = new CalculadoraService();

        // Act
        int resultado = calculadora.Somar(-10, 5);

        // Assert
        Assert.Equal(-5, resultado);
    }
}

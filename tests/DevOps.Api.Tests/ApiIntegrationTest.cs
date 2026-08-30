using System.Net;
using Microsoft.AspNetCore.Mvc.Testing;

namespace DevOps.Api.Tests;

public class ApiIntegrationTests :
    IClassFixture<WebApplicationFactory<Program>>
{
    private readonly HttpClient _client;

    public ApiIntegrationTests(WebApplicationFactory<Program> factory)
    {
        _client = factory.CreateClient();
    }

    [Fact]
    public async Task Somar_DeveRetornarResultadoCorreto()
    {
        // Act
        var resposta = await _client.GetAsync(
            "/api/calculadora/somar?primeiroNumero=10&segundoNumero=5");

        var conteudo = await resposta.Content.ReadAsStringAsync();

        // Assert
        Assert.Equal(HttpStatusCode.OK, resposta.StatusCode);
        Assert.Contains("\"resultado\":15", conteudo);
    }

    [Fact]
    public async Task Health_DeveRetornarSucesso()
    {
        // Act
        var resposta = await _client.GetAsync("/health");

        // Assert
        Assert.Equal(HttpStatusCode.OK, resposta.StatusCode);
    }
}

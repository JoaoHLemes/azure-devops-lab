using DevOps.Api.Services;
using Microsoft.AspNetCore.Mvc;

namespace DevOps.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class CalculadoraController : ControllerBase
{
    private readonly CalculadoraService _calculadoraService;

    public CalculadoraController(CalculadoraService calculadoraService)
    {
        _calculadoraService = calculadoraService;
    }

    [HttpGet("somar")]
    public IActionResult Somar(
        [FromQuery] int primeiroNumero,
        [FromQuery] int segundoNumero)
    {
        int resultado = _calculadoraService.Somar(
            primeiroNumero,
            segundoNumero
        );

        return Ok(new
        {
            primeiroNumero,
            segundoNumero,
            resultado
        });
    }
}

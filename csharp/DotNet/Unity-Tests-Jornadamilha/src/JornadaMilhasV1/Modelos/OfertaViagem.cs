﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using JornadaMilhasV1.Validador;

namespace JornadaMilhasV1.Modelos;

public class OfertaViagem: Valida
{
    public int Id { get; set; }
    public Rota Rota { get; set; } 
    public Periodo Periodo { get; set; }
    public double Preco { get; set; }

    public const string RouteOrPeriodNullError = "A oferta de viagem não possui rota ou período válidos.";
    public const string PriceLowerOrEqualZeroError = "O preço da oferta de viagem deve ser maior que zero.";


    public OfertaViagem(Rota rota, Periodo periodo, double preco)
    {
        Rota = rota;
        Periodo = periodo;
        Preco = preco;
        Validar();
    }

    public override string ToString()
    {
        return $"Origem: {Rota.Origem}, Destino: {Rota.Destino}, Data de Ida: {Periodo.DataInicial.ToShortDateString()}, Data de Volta: {Periodo.DataFinal.ToShortDateString()}, Preço: {Preco:C}";
    }

    protected override void Validar()
    {
        if (Rota == null || Periodo == null)
        {
            Erros.RegistrarErro(RouteOrPeriodNullError);
        }
        else if (!Periodo.EhValido)
        {
            Erros.RegistrarErro(Periodo.Erros.Sumario);
        } 
        else if (Preco <= 0)
        {
            Erros.RegistrarErro(PriceLowerOrEqualZeroError);
        }
    }
}

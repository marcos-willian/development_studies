using ItemService.Data;
using ItemService.Dtos;
using ItemService.Models;
using Microsoft.Extensions.Configuration;
using RabbitMQ.Client;
using RabbitMQ.Client.Events;
using System.Runtime.ConstrainedExecution;
using System.Text;
using System.Text.Json;

namespace ItemService.Consumer;

public class RestauranteConsumer : BackgroundService
{
    private readonly IItemRepository _itemRepository;
    private readonly IModel _channel;
    private readonly string _exchangeName;

    public RestauranteConsumer(
        IServiceScopeFactory scopeFactory,
        IConfiguration configuration)
    {
        _itemRepository = scopeFactory.CreateScope().ServiceProvider.GetRequiredService<IItemRepository>();
        var _connection = new ConnectionFactory()
        {
            HostName = configuration.GetValue<string>("Rabbit:Host"),
            Port = configuration.GetValue<int>("Rabbit:Port"),
        }.CreateConnection();

        _channel = _connection.CreateModel();
        _exchangeName = "ItemService";


        _channel.ExchangeDeclare(exchange: _exchangeName, type: "fanout");
    }

    protected override Task ExecuteAsync(CancellationToken stoppingToken)
    {
        _channel.QueueDeclare("Restaurantes", false, false, false, arguments: null);
        _channel.QueueBind("Restaurantes", _exchangeName, "");

        var consumer = new EventingBasicConsumer(_channel);

        consumer.Received += Consumer_Received;

        _channel.BasicConsume(
            queue: "Restaurantes",
            autoAck: false,
            consumer: consumer);

        return Task.CompletedTask;
    }

    private void Consumer_Received(object? sender, BasicDeliverEventArgs e)
    {
        string json = Encoding.UTF8.GetString(e.Body.ToArray());
        var restaurante = JsonSerializer.Deserialize<RestauranteReadDto>(json)!;

        if (!_itemRepository.ExisteRestauranteExterno(restaurante.Id))
        {
            _itemRepository.CreateRestaurante(
                new Restaurante()
                {
                    IdExterno = restaurante.Id,
                    Nome = restaurante.Nome,
                }
            );
            _itemRepository.SaveChanges();

        }


    }

}

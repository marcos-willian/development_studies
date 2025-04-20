using RabbitMQ.Client;
using RestauranteService.Dtos;
using Services;
using System.Text;
using System.Text.Json;
using System.Threading.Channels;

namespace RestauranteService.Services;

public class ItemServiceClient : IItemServiceClient
{
    private readonly IModel _channel;
    private readonly string _exchangeName;

    public ItemServiceClient(
        IConfiguration _configuration
    )
    {
        var _connection = new ConnectionFactory(){
            HostName = _configuration.GetValue<string>("Rabbit:Host"),
            Port = _configuration.GetValue<int>("Rabbit:Port"),
        }.CreateConnection();

        _channel = _connection.CreateModel();
        _exchangeName =  "ItemService";


        _channel.ExchangeDeclare(exchange: _exchangeName, type: "fanout");

    }

    public void EnviaRestauranteParaItemService(RestauranteReadDto restauranteReadDto)
    {
        var json = JsonSerializer.Serialize(restauranteReadDto);
        var bytes = Encoding.UTF8.GetBytes(json);

        _channel.BasicPublish(_exchangeName, "", null, bytes);
    }
}

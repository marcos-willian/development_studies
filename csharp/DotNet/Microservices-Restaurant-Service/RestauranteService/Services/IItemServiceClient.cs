using RestauranteService.Dtos;

namespace Services;

public interface IItemServiceClient
{
    void EnviaRestauranteParaItemService(RestauranteReadDto restauranteReadDto);
}



using ScreenSound.Screen.Menu;

namespace ScreenSound.Screen;

internal class View(List<MenuOption> options)
{
    private readonly List<MenuOption> _options = options;


    private static void ShowLogo()
    {
        {
            Console.WriteLine(@"

░██████╗░█████╗░██████╗░███████╗███████╗███╗░░██╗  ░██████╗░█████╗░██╗░░░██╗███╗░░██╗██████╗░
██╔════╝██╔══██╗██╔══██╗██╔════╝██╔════╝████╗░██║  ██╔════╝██╔══██╗██║░░░██║████╗░██║██╔══██╗
╚█████╗░██║░░╚═╝██████╔╝█████╗░░█████╗░░██╔██╗██║  ╚█████╗░██║░░██║██║░░░██║██╔██╗██║██║░░██║
░╚═══██╗██║░░██╗██╔══██╗██╔══╝░░██╔══╝░░██║╚████║  ░╚═══██╗██║░░██║██║░░░██║██║╚████║██║░░██║
██████╔╝╚█████╔╝██║░░██║███████╗███████╗██║░╚███║  ██████╔╝╚█████╔╝╚██████╔╝██║░╚███║██████╔╝
╚═════╝░░╚════╝░╚═╝░░╚═╝╚══════╝╚══════╝╚═╝░░╚══╝  ╚═════╝░░╚════╝░░╚═════╝░╚═╝░░╚══╝╚═════╝░
");
            Console.WriteLine("Boas vindas ao Screen Sound 2.0!");
        }
    }

    private async Task<bool> TakeOptionAsync()
    {
        Console.Clear();
        ShowLogo();
        foreach (MenuOption option in _options)
        {
            Console.WriteLine($"Digite {_options.IndexOf(option)} para {option.Action}");
        }
        Console.WriteLine("Digite -1 para sair");

        Console.Write("\nDigite a sua opção: ");
        string value = Console.ReadLine()!;
        try
        {
            int optionNumber = int.Parse(value);
            if (optionNumber == -1) return false;

            MenuOption? menuOption = _options.ElementAtOrDefault(optionNumber);

            if (menuOption is null)
            {
                Console.WriteLine("Opção inválida");
            }
            else
            {
                await menuOption.Execute();
            }
        }
        catch (Exception)
        {
            Console.WriteLine("Opção inválida");
            Console.ReadLine();

        }

        return true;
    }

    public async Task StartAsync()
    {
        while (await TakeOptionAsync()) { }
        Console.WriteLine("Tchau tchau :)");
    }
}

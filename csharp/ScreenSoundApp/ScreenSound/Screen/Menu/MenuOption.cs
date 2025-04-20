using ScreenSound.extensions;
using ScreenSound.Models;

namespace ScreenSound.Screen.Menu;

internal abstract class MenuOption
{
    public abstract string Action { get; }
    public abstract Task Execute();

    protected static void ShowTitle(string title)
    {
        int quantidadeDeLetras = title.Length;
        string asteriscos = string.Empty.PadLeft(quantidadeDeLetras, '*');
        Console.WriteLine(asteriscos);
        Console.WriteLine(title);
        Console.WriteLine(asteriscos + "\n");
    }

    protected static void WaitForKey()
    {
        Console.WriteLine("\nDigite uma tecla para voltar ao menu principal");
        Console.ReadKey();
        Console.Clear();
    }

    protected static string ShowSearchField(
        string title, 
        string description,
        IEnumerable<string> bands
        )
    {
        (int, int) cursorPosition;

        void printHeader(string bandSearch)
        {
            Console.Clear();
            ShowTitle(title);
            Console.WriteLine(description);
            Console.Write(bandSearch);
            cursorPosition = Console.GetCursorPosition();
            Console.WriteLine();

        }


        string selectedBand = bands.First();
        string searchBandBuffer = "";
        printHeader("");
        foreach (string band in bands)
        {
            Console.WriteLine(band);
        }
        Console.SetCursorPosition(cursorPosition.Item1, cursorPosition.Item2);
        ConsoleKeyInfo key = Console.ReadKey();
        while (key.Key != ConsoleKey.Enter)
        {
            if (key.Key == ConsoleKey.Backspace)
            {
                searchBandBuffer = searchBandBuffer.Backspace();
            }
            else
            {
                searchBandBuffer += key.KeyChar;
            }
            var filteredBands = bands.ToList().FindAll(
                bool (string banda) =>
                {
                    return banda.Contains(searchBandBuffer, StringComparison.CurrentCultureIgnoreCase);
                }
            );
            printHeader(searchBandBuffer);
            selectedBand = filteredBands.FirstOrDefault() ?? "";
            filteredBands.ForEach(Console.WriteLine);
            Console.SetCursorPosition(cursorPosition.Item1, cursorPosition.Item2);
            key = Console.ReadKey();
        }

        Console.Clear();
        ShowTitle(title);
        return selectedBand;
    }
}

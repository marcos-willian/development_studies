

namespace ScreenSound.extensions;

internal static class StringExtension
{
    public static string Backspace(this string text)
    {
        if (text.Length <= 1)
        {
            return "";
        }

        return text.Substring(0, text.Length - 2);
    }
}

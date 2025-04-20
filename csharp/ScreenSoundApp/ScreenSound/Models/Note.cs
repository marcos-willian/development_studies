
namespace ScreenSound.models
{
    internal class Note
    {
        public int NoteValue { get; }

        public Note(int note)
        {
            if(note > 10)
            {
                note = 10;
                Console.WriteLine("Nota maior que 10, a nota máxima será aplicada (10)");
            }else if (note < 0)
            {
                note = 0;
                Console.WriteLine("Nota menor que 0, a nota mínima será aplicada (0)");
            }

            NoteValue = note;
        }

        public Note(string note) : this(int.Parse(note)) { }

        public override string ToString()
        {
            return NoteValue.ToString();

        }
    }
}

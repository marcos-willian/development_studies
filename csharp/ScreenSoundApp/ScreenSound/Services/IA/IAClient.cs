using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ScreenSound.Services.IA
{
    internal interface IAClient
    {
        Task<string> MakeRequest(string quest);
    }
}

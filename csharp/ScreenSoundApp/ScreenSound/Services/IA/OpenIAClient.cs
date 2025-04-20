
using OpenAI;
using OpenAI.Assistants;
using OpenAI.Chat;
using OpenAI.Models;
using OpenAI.Threads;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Message = OpenAI.Chat.Message;

namespace ScreenSound.Services.IA
{
    internal class OpenIAClient : IAClient
    {
        private readonly OpenAIClient _api = new OpenAIClient("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");

        ~OpenIAClient()
        {
            _api.Dispose();
        }

        public async Task<string> MakeRequest(string quest)
        {
            var messages = new List<Message>
            {
                new(Role.User, quest),
            };
            var chatRequest = new ChatRequest(messages, Model.GPT3_5_Turbo);
            var response = await _api.ChatEndpoint.GetCompletionAsync(chatRequest);
            var choice = response.FirstChoice;
            return choice.Message;
        }

    }
}


using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;

namespace Playground
{
    public static class CurlConverter
    {
        private static StringBuilder StringBuilder;

        public static async Task<string> CopyAsCurlBash(this HttpResponseMessage req)
        {
            StringBuilder = new StringBuilder();
            StringBuilder.AppendLine($"curl '{req.RequestMessage.RequestUri}'\\");
            // append headers
            foreach (var header in req.RequestMessage.Headers)
            {
                StringBuilder.AppendLine($"-H '{header.Key}:{header.Value.First()}'\\");
            }

            // append body
            string body = await req.RequestMessage.Content.ReadAsStringAsync();
            StringBuilder.AppendLine($"-H 'Content-Type: {req.RequestMessage.Content.Headers.ContentType.MediaType}'");

            StringBuilder.AppendLine($"--data '{body}'");

            // set method
            StringBuilder.AppendLine($"-X {req.RequestMessage.Method.Method}");

            StringBuilder.AppendLine("--compressed");
            return StringBuilder.ToString();
        }
    }
}    

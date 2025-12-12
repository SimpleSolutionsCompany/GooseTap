using System.Security.Cryptography;
using System.Text;
using System.Web;
using Org.BouncyCastle.Crypto.Parameters;
using Org.BouncyCastle.Crypto.Signers;
using SSC.GooseTap.Business.DTOs;

namespace SSC.GooseTap.Infrastructure.Services
{
    public class TelegramAuthService 
    {
        private readonly string _botToken;
        private readonly long? _botId;
        private const string WebAppDataConstant = "WebAppData";


        private const string ProductionPublicKey = "e7bf03a2fa4602af4580703d88dda5bb59f32ed8b02a56c187fe7d34caed242d";
        private const string TestPublicKey = "40055058a4ee38156a06562e52eece92a771bcd8346a8c4615cb7376eddf72ec";

        public TelegramAuthService(string botToken, long? botId = null, bool useTestEnvironment = false)
        {
            if (string.IsNullOrWhiteSpace(botToken))
                throw new ArgumentException("Bot token cannot be null or empty", nameof(botToken));

            _botToken = botToken;
            _botId = botId ?? ExtractBotIdFromToken(botToken);


            PublicKey = useTestEnvironment ? TestPublicKey : ProductionPublicKey;
        }

        public string PublicKey { get; set; }

        public bool Validate(string initData, int maxAgeSeconds = 86400)
        {
            if (string.IsNullOrWhiteSpace(initData))
            {

                return false;
            }

            try
            {


                var parsedData = ParseInitData(initData);


                bool hasSignature = parsedData.ContainsKey("signature");
                bool hasHash = parsedData.ContainsKey("hash");




                if (parsedData.ContainsKey("auth_date"))
                {
                    if (long.TryParse(parsedData["auth_date"], out long authDate))
                    {
                        long currentTimestamp = DateTimeOffset.UtcNow.ToUnixTimeSeconds();
                        long age = currentTimestamp - authDate;


                        if (age > maxAgeSeconds)
                        {

                            return false;
                        }
                    }
                }


                if (hasSignature)
                {
                    return ValidateWithEd25519(parsedData);
                }
                else if (hasHash)
                {
                    return ValidateWithHmac(parsedData);
                }
                else
                {

                    return false;
                }
            }
            catch (Exception ex)
            {

                return false;
            }
        }


        private bool ValidateWithEd25519(Dictionary<string, string> parsedData)
        {
            try
            {
                string signatureBase64 = parsedData["signature"];



                string base64 = signatureBase64.Replace('-', '+').Replace('_', '/');
                switch (base64.Length % 4)
                {
                    case 2: base64 += "=="; break;
                    case 3: base64 += "="; break;
                }

                byte[] signature = Convert.FromBase64String(base64);



                var dataCheckString = CreateEd25519DataCheckString(parsedData);


                byte[] message = Encoding.UTF8.GetBytes(dataCheckString);
                byte[] publicKeyBytes = HexToBytes(PublicKey);




                var publicKey = new Ed25519PublicKeyParameters(publicKeyBytes, 0);
                var verifier = new Ed25519Signer();
                verifier.Init(false, publicKey);
                verifier.BlockUpdate(message, 0, message.Length);
                bool isValid = verifier.VerifySignature(signature);



                return isValid;
            }
            catch (Exception ex)
            {

                return false;
            }
        }


        private bool ValidateWithHmac(Dictionary<string, string> parsedData)
        {
            string receivedHash = parsedData["hash"];
            Console.WriteLine($"Received hash: {receivedHash}");

            var dataCheckString = CreateHmacDataCheckString(parsedData);
            Console.WriteLine("Data-check-string for HMAC:");
            Console.WriteLine(dataCheckString);
            Console.WriteLine();

            byte[] secretKey = ComputeHmacSha256(Encoding.UTF8.GetBytes(WebAppDataConstant), Encoding.UTF8.GetBytes(_botToken));
            byte[] calculatedHash = ComputeHmacSha256(Encoding.UTF8.GetBytes(dataCheckString), secretKey);
            string calculatedHashHex = BitConverter.ToString(calculatedHash).Replace("-", "").ToLower();

            Console.WriteLine($"Calculated hash: {calculatedHashHex}");
            Console.WriteLine($"Received hash:   {receivedHash.ToLower()}");

            bool isValid = calculatedHashHex == receivedHash.ToLower();
            Console.WriteLine($"HMAC Validation result: {isValid}");
            Console.WriteLine("=================================");

            return isValid;
        }


        private string CreateEd25519DataCheckString(Dictionary<string, string> data)
        {
            var header = $"{_botId}:{WebAppDataConstant}";

            var sortedFields = data
                .Where(kvp => kvp.Key != "hash" && kvp.Key != "signature")
                .OrderBy(kvp => kvp.Key)
                .Select(kvp => $"{kvp.Key}={kvp.Value}");

            return header + "\n" + string.Join("\n", sortedFields);
        }


        private string CreateHmacDataCheckString(Dictionary<string, string> data)
        {
            var filteredData = data
                .Where(kvp => kvp.Key != "hash" && kvp.Key != "signature")
                .OrderBy(kvp => kvp.Key)
                .Select(kvp => $"{kvp.Key}={kvp.Value}");

            return string.Join("\n", filteredData);
        }

        private Dictionary<string, string> ParseInitData(string initData)
        {
            var result = new Dictionary<string, string>();
            var pairs = initData.Split('&');

            foreach (var pair in pairs)
            {
                var keyValue = pair.Split(new[] { '=' }, 2);
                if (keyValue.Length == 2)
                {
                    string key = keyValue[0];
                    string value = keyValue[1];
                    result[key] = HttpUtility.UrlDecode(value);
                }
            }

            return result;
        }

        private byte[] ComputeHmacSha256(byte[] data, byte[] key)
        {
            using (var hmac = new HMACSHA256(key))
            {
                return hmac.ComputeHash(data);
            }
        }

        private long ExtractBotIdFromToken(string botToken)
        {
            var parts = botToken.Split(':');
            if (parts.Length > 0 && long.TryParse(parts[0], out long botId))
            {
                return botId;
            }
            throw new ArgumentException("Invalid bot token format");
        }

        private byte[] HexToBytes(string hex)
        {
            int length = hex.Length;
            byte[] bytes = new byte[length / 2];
            for (int i = 0; i < length; i += 2)
            {
                bytes[i / 2] = Convert.ToByte(hex.Substring(i, 2), 16);
            }
            return bytes;
        }

        public TelegramUserData GetUser(string initData)
        {
            if (string.IsNullOrWhiteSpace(initData))
                return null;

            try
            {
                var parsedData = ParseInitData(initData);

                if (!parsedData.ContainsKey("user"))
                    return null;

                string userJson = parsedData["user"];
                return System.Text.Json.JsonSerializer.Deserialize<TelegramUserData>(userJson);
            }
            catch
            {
                return null;
            }
        }
    }
}

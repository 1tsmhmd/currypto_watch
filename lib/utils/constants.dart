import 'package:dotenv/dotenv.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:televerse/televerse.dart';

//! < ------------- .env ------------- />
var dotEnv = DotEnv(includePlatformEnvironment: true)..load();
String apiKey = dotEnv['API_KEY'] ?? '';
String telegramBotToken = dotEnv['TELEGRAM_BOT_TOKEN'] ?? '';
String telegramChannelUsername = dotEnv['TELEGRAM_CHANNEL_USERNAME'] ?? '';

//! < ------------- Bot ------------- />
Bot bot = Bot(telegramBotToken);

//! < ------------- APIs ------------- />
class ApiEndpoints {
  static const String baseUrl = "https://currency.babakcode.com";
  static const String currencyEndpoint = "$baseUrl/api/v2/currency/all/";
  static const String cryptoEndpoint = "$baseUrl/api/v2/crypto/all/";
  static const String fiatCurrency = "IRT";
}

//! < ------------- Channel ------------- />
final String channelUsername = telegramChannelUsername;
final String channelLink =
    "https://t.me/${telegramChannelUsername.replaceFirst("@", '')}";

//! < ------------- Messages ------------- />
class BotMessages {
  static const String welcomeMessage = "🌟 به ربات رمز ارز خوش آمدید! 🚀";
  static const String dataFetchError = "❌ خطا در دریافت داده‌های ارز";
  static const List<String> currencySymbol = [
    "USD",
    "EUR",
    "GBP",
    "AED",
    "CAD",
    "CNY",
    "KWD",
    "TRY"
  ];
  static const List<String> cryptoSymbol = [
    "BTC",
    "TRX",
    "XAUT",
    "ETH",
    "BNB",
    "ADA",
    "NOT",
    "TON",
    "USDT",
  ];

  static String captionMessage() {
    final currentTime = DateTime.now();
    final formattedTime =
        "${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}"
            .toPersianDigit();
    final persianDate = currentTime.toPersianDate();

    return '⌚ **آخرین بروزرسانی: ساعت** [$formattedTime]($channelLink)\n'
        '📅 **تاریخ امروز:** [$persianDate]($channelLink)\n\n\n'
        'ربات هر ۳۰ دقیقه با اطلاعات جدید به‌روز میشه! 🚀\n'
        'با زدن دکمه های زیر، میتونید به آخرین قیمت‌ها دسترسی پیدا کنید! \n\n'
        '⚡$channelUsername';
  }
}

class ButtonLabels {
  static const String crypto = '₿ نرخ کریپتو';
  static const String currency = "✪ نرخ ارز";
}

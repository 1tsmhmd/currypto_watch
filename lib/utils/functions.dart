import 'dart:async';
import 'dart:io';
import 'package:currypto_watch/modles/crypto_models.dart';
import 'package:currypto_watch/modles/currency_model.dart';
import 'package:currypto_watch/services/dio_service.dart';
import 'package:currypto_watch/utils/constants.dart';
import 'package:currypto_watch/utils/keyboards.dart';
import 'package:televerse/televerse.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

//! < ------------- Fetch Currency Data ------------- />
/// This function fetches fiat currency data from the API and returns it in a formatted string.
/// [hasLink]: If `true`, a link to the Telegram channel will be added to the text.
Future<String> fetchCurrencyData({bool hasLink = true}) async {
  // Fetch currency data from the API
  final res = await DioService().getMethod(
      "${ApiEndpoints.currencyEndpoint}${ApiEndpoints.fiatCurrency}");
  // Return an error if the data is not a list.
  if (res.data is! List) return BotMessages.dataFetchError;

  List<CurrencyModel> currencyData = [];
  res.data.forEach(
    (value) {
      currencyData.add(
        CurrencyModel.fromJson(value), // Convert JSON data to the CurrencyModel
      );
    },
  );

  // Filter currencies based on predefined symbols
  var filteredCurrency = currencyData.where(
    (value) => BotMessages.currencySymbol.contains(value.currency),
  );

  // Convert filtered data into a formatted string
  return filteredCurrency.map(
    (value) {
      String formattedPrice = "${value.price}"
          .seRagham()
          .toPersianDigit(); // Format price in Persian digits
      return hasLink == true
          ? "🔹 ${value.fa}: [$formattedPrice]($channelLink) ت" // With link
          : "🔹 ${value.fa}: $formattedPrice ت"; // Without link
    },
  ).join("\n"); // Join the list into a string with newline separators
}

//! < ------------- Fetch Crypto Data ------------- />
/// This function fetches cryptocurrency data from the API and returns it in a formatted string.
/// [hasLink]: If `true`, a link to the Telegram channel will be added to the text.
Future<String> fetchCryptoData({bool hasLink = true}) async {
  // Fetch cryptocurrency data from the API
  final res = await DioService()
      .getMethod("${ApiEndpoints.cryptoEndpoint}${ApiEndpoints.fiatCurrency}");
  // Return an error if the data is not a list.
  if (res.data is! List) return BotMessages.dataFetchError;

  List<CryptoModel> cryptoData = [];
  res.data.forEach(
    (value) {
      cryptoData.add(
        CryptoModel.fromJson(value), // Convert JSON data to the CryptoModel
      );
    },
  );

  // Filter cryptocurrencies based on predefined symbols
  var filteredCurrency = cryptoData.where(
    (value) => BotMessages.cryptoSymbol.contains(
      value.symbol,
    ),
  );

  // Convert filtered data into a formatted string
  return filteredCurrency.map((value) {
    String formattedPrice = "${value.price}"
        .seRagham()
        .toPersianDigit(); // Format price in Persian digits
    return hasLink == true
        ? "🔺 ${value.fa}: [$formattedPrice]($channelLink) ت" // With link
        : "🔺 ${value.fa}: $formattedPrice ت"; // Without link
  }).join("\n"); // Join the list into a string with newline separators
}

//! < ------------- Send Currency & Crypto Message To Channel ------------- />
/// This function automatically sends messages containing fiat and cryptocurrency data
/// to the Telegram channel at specified intervals.
void scheduleAutoSend() async {
  void sendMsgToChannel({required int interval}) {
    Future<void> fetchAndSend() async {
      // Fetch currency and cryptocurrency data and combine them into a single message
      String currencyMessage = await fetchCurrencyData();
      String cryptoMessage = await fetchCryptoData();

      String fullMessage = "$currencyMessage\n\n"
          "$cryptoMessage\n\n"
          "${BotMessages.captionMessage()}"; // Add a caption to the message

      // Send the message to the Telegram channel
      try {
        await bot.api.sendMessage(
          ChannelID(channelUsername),
          fullMessage,
          parseMode: ParseMode.markdown,
          replyMarkup: Keyboards.buildChannelKeybaord,
        );
      } catch (e) {
        if (e is TelegramException && e.code == 403) {
          print("Error: bot is not an admin of the channel.");
          exit(0);
        }
      }
    }

    // Calculate the time remaining until the next interval
    DateTime now = DateTime.now();
    int secondsUntilNextInterval =
        (interval - (now.minute % interval)) * 60 - now.second;

    // Initial send and set up a timer for periodic sending
    Future.delayed(Duration(seconds: secondsUntilNextInterval), () {
      fetchAndSend();
      Timer.periodic(Duration(minutes: interval), (timer) {
        fetchAndSend();
      });
    });
  }

  // Start sending messages with a 30-minute interval
  sendMsgToChannel(interval: 30);
}

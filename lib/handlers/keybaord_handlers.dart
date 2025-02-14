import 'package:currypto_watch/utils/constants.dart';
import 'package:currypto_watch/utils/functions.dart';
import 'package:televerse/televerse.dart';

/// This function sets up callback query handlers for the Telegram bot.
/// It handles user interactions with inline buttons.
Future<void> callbackDataHandlers() async {
  // Handle the callback query for the 'currency' button
  bot.callbackQuery(
    // The callback data associated with the 'currency' button
    ButtonLabels.currency,
    (ctx) async {
      // Fetch currency data without including a link
      String currencyText = await fetchCurrencyData(hasLink: false);

      // Respond to the callback query with the fetched currency data
      await ctx.answerCallbackQuery(
        text: currencyText, // The text to display in the alert
        showAlert: true, // Show the result as an alert
        cacheTime: 3, // Cache the result for 2 seconds
      );
    },
  );

  // Handle the callback query for the 'crypto' button
  bot.callbackQuery(
    // The callback data associated with the 'crypto' button
    ButtonLabels.crypto,
    (ctx) async {
      // Fetch cryptocurrency data without including a link
      String cryptoText = await fetchCryptoData(hasLink: false);

      // Respond to the callback query with the fetched cryptocurrency data
      await ctx.answerCallbackQuery(
        text: cryptoText, // The text to display in the alert
        showAlert: true, // Show the result as an alert
        cacheTime: 3, // Cache the result for 3 seconds
      );
    },
  );
}

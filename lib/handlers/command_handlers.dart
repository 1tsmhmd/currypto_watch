import 'dart:async';
import 'package:currypto_watch/utils/constants.dart';
import 'package:televerse/televerse.dart';

/// This function sets up command handlers for the Telegram bot.
void commandsHandlers() {
  // Register the 'start' command and associate it with the `startHandler` function
  bot.command('start', startHandler);
}

/// This function handles the 'start' command sent by the user.
/// It sends a welcome message to the user.
FutureOr<void> startHandler(Context ctx) async {
  // Reply to the user with the welcome message defined in `Messages.welcomeMessage`
  await ctx.reply(BotMessages.welcomeMessage);
}

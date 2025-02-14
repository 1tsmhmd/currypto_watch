import 'package:currypto_watch/handlers/command_handlers.dart';
import 'package:currypto_watch/handlers/keybaord_handlers.dart';
import 'package:currypto_watch/utils/constants.dart';
import 'package:currypto_watch/services/auto_send_service.dart';

/// The main entry point of the application.
/// This function initializes the bot and sets up all necessary handlers.
void main() async {
  // Set up command handlers (e.g.: for the 'start' command)
  commandsHandlers();

  // Schedule automatic sending of messages (e.g., currency and crypto updates)
  scheduleAutoSend();

  // Set up callback query handlers (e.g., for handling inline button interactions)
  callbackDataHandlers();

  // Start the bot and begin listening for updates
  await bot.start();
}

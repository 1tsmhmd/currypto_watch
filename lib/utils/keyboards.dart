import 'package:currypto_watch/utils/constants.dart';
import 'package:televerse/televerse.dart';

class Keyboards {
  static final buildChannelKeybaord = InlineKeyboard()
      .add(ButtonLabels.crypto, ButtonLabels.crypto)
      .add(ButtonLabels.currency, ButtonLabels.currency);
}

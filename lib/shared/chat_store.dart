import 'package:flutter/foundation.dart';

// ─── Message Model ───────────────────────────────────────────────────────────

enum ChatSender { creator, brand }

class ChatMessage {
  ChatMessage({
    required this.text,
    required this.sender,
    required this.timestamp,
  });

  final String text;
  final ChatSender sender;
  final DateTime timestamp;
}

// ─── Shared Singleton Store ───────────────────────────────────────────────────
// Both DealChatScreen (creator) and BrandDealChatScreen (brand) listen to
// the same ValueNotifier so messages appear on both sides instantly.

class ChatStore {
  ChatStore._();
  static final ChatStore instance = ChatStore._();

  // Seed with the existing "hardcoded" conversation so no blank state on launch
  final ValueNotifier<List<ChatMessage>> messages =
      ValueNotifier<List<ChatMessage>>([
    ChatMessage(
      text:
          'Hey! We love your content style. Would you be interested in a collab for our new skincare line?',
      sender: ChatSender.brand,
      timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 30)),
    ),
    ChatMessage(
      text:
          'Hey! Thanks so much — I\'d definitely be open to hearing more. What kind of deliverables are you thinking?',
      sender: ChatSender.creator,
      timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 15)),
    ),
    ChatMessage(
      text:
          'We\'re looking at 2 Instagram reels + 3 stories. Budget is flexible — we were thinking ₹35,000 for the package.',
      sender: ChatSender.brand,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    ),
  ]);

  void send(String text, ChatSender sender) {
    final updated = List<ChatMessage>.from(messages.value)
      ..add(ChatMessage(
        text: text,
        sender: sender,
        timestamp: DateTime.now(),
      ));
    messages.value = updated;
  }
}

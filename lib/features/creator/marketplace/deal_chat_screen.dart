import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/mock_data.dart';
import 'package:aura_influencer_portfolio/shared/chat_store.dart';

class DealChatScreen extends StatefulWidget {
  const DealChatScreen({super.key});

  @override
  State<DealChatScreen> createState() => _DealChatScreenState();
}

class _DealChatScreenState extends State<DealChatScreen> {
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scroll = ScrollController();

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    HapticFeedback.lightImpact();
    ChatStore.instance.send(text, ChatSender.creator);
    _ctrl.clear();
    // Scroll to bottom after state rebuild
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const _ChatHeader(),
            const _OfferSummary(),
            Expanded(
              child: ValueListenableBuilder<List<ChatMessage>>(
                valueListenable: ChatStore.instance.messages,
                builder: (_, messages, __) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (_scroll.hasClients) {
                      _scroll.animateTo(
                        _scroll.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                      );
                    }
                  });
                  return ListView.builder(
                    controller: _scroll,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    itemCount: messages.length,
                    itemBuilder: (_, int i) {
                      final msg = messages[i];
                      final isCreator = msg.sender == ChatSender.creator;
                      return isCreator
                          ? _UserBubble(text: msg.text, time: msg.timestamp)
                          : _BrandBubble(text: msg.text, time: msg.timestamp);
                    },
                  );
                },
              ),
            ),
            _Composer(controller: _ctrl, onSend: _send),
          ],
        ),
      ),
    );
  }
}

// ── Header ──────────────────────────────────────────────────────────────────

class _ChatHeader extends StatelessWidget {
  const _ChatHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 8),
      decoration: BoxDecoration(
        color: AuraColors.midnight.withOpacity(0.8),
        border: Border(
          bottom: BorderSide(color: AuraColors.textPrimary.withOpacity(0.05)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back_ios, color: AuraColors.sage),
          ),
          Column(
            children: <Widget>[
              Text(
                MockDealChat.brandName,
                style: const TextStyle(
                  fontSize: 11,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                MockDealChat.status,
                style: TextStyle(
                  fontSize: 9,
                  letterSpacing: 2,
                  color: AuraColors.textPrimary.withOpacity(0.7),
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline, color: AuraColors.sage),
          ),
        ],
      ),
    );
  }
}

// ── Offer Summary Banner ─────────────────────────────────────────────────────

class _OfferSummary extends StatelessWidget {
  const _OfferSummary();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AuraColors.obsidian.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AuraColors.textPrimary.withOpacity(0.08)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AuraColors.sage.withOpacity(0.1),
                  ),
                  child: Icon(Icons.handshake_outlined,
                      size: 20, color: AuraColors.sage.withOpacity(0.6)),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Current Offer',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 2,
                        color: AuraColors.sage.withOpacity(0.6),
                      ),
                    ),
                    const Text(
                      MockDealChat.offerTitle,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Text(
                  MockDealChat.offerAmount,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                Text(
                  MockDealChat.offerType,
                  style: const TextStyle(
                      fontSize: 9, letterSpacing: 1.5, color: AuraColors.sage),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Bubbles ───────────────────────────────────────────────────────────────────

String _fmt(DateTime t) {
  final h = t.hour.toString().padLeft(2, '0');
  final m = t.minute.toString().padLeft(2, '0');
  return '$h:$m';
}

class _BrandBubble extends StatelessWidget {
  const _BrandBubble({required this.text, required this.time});
  final String text;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
          decoration: BoxDecoration(
            color: AuraColors.obsidian,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(18),
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text, style: const TextStyle(fontSize: 13, height: 1.4)),
              const SizedBox(height: 4),
              Text(
                _fmt(time),
                style: TextStyle(
                  fontSize: 9,
                  color: AuraColors.textPrimary.withOpacity(0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserBubble extends StatelessWidget {
  const _UserBubble({required this.text, required this.time});
  final String text;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
          decoration: BoxDecoration(
            color: AuraColors.sage.withOpacity(0.15),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(4),
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
            border: Border.all(color: AuraColors.sage.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(text, style: const TextStyle(fontSize: 13, height: 1.4)),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _fmt(time),
                    style: TextStyle(
                      fontSize: 9,
                      color: AuraColors.textPrimary.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.done_all,
                      size: 11, color: AuraColors.sage.withOpacity(0.5)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Composer ─────────────────────────────────────────────────────────────────

class _Composer extends StatelessWidget {
  const _Composer({required this.controller, required this.onSend});
  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
      decoration: BoxDecoration(
        color: AuraColors.midnight.withOpacity(0.95),
        border: Border(
          top: BorderSide(color: AuraColors.textPrimary.withOpacity(0.05)),
        ),
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 4),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AuraColors.obsidian,
                borderRadius: BorderRadius.circular(24),
                border:
                    Border.all(color: AuraColors.textPrimary.withOpacity(0.08)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 13, color: AuraColors.textPrimary),
                maxLines: 4,
                minLines: 1,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => onSend(),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Message...',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: AuraColors.textPrimary.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: onSend,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AuraColors.sage,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.send_rounded,
                  size: 18, color: AuraColors.midnight),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

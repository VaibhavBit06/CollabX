import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/chat_store.dart';

class BrandDealChatScreen extends StatefulWidget {
  const BrandDealChatScreen({
    super.key,
    this.creatorName = 'Sohail',
    this.creatorHandle = '@sohail.creates',
    this.campaignTitle = 'Summer Skincare Launch',
    this.dealAmount = '₹35,000',
  });

  final String creatorName;
  final String creatorHandle;
  final String campaignTitle;
  final String dealAmount;

  @override
  State<BrandDealChatScreen> createState() => _BrandDealChatScreenState();
}

class _BrandDealChatScreenState extends State<BrandDealChatScreen> {
  final TextEditingController _ctrl = TextEditingController();
  final ScrollController _scroll = ScrollController();

  void _send() {
    final text = _ctrl.text.trim();
    if (text.isEmpty) return;
    HapticFeedback.lightImpact();
    ChatStore.instance.send(text, ChatSender.brand);
    _ctrl.clear();
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
            _Header(
              creatorName: widget.creatorName,
              creatorHandle: widget.creatorHandle,
              onBack: () => Navigator.of(context).maybePop(),
            ),
            _DealBanner(
              campaignTitle: widget.campaignTitle,
              dealAmount: widget.dealAmount,
            ),
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
                      // From brand's perspective: brand is "us" (right), creator is "them" (left)
                      final isBrand = msg.sender == ChatSender.brand;
                      return isBrand
                          ? _BrandOwnBubble(text: msg.text, time: msg.timestamp)
                          : _CreatorBubble(
                              text: msg.text,
                              time: msg.timestamp,
                              name: widget.creatorName,
                            );
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

// ── Header ───────────────────────────────────────────────────────────────────

class _Header extends StatelessWidget {
  const _Header({
    required this.creatorName,
    required this.creatorHandle,
    required this.onBack,
  });

  final String creatorName;
  final String creatorHandle;
  final VoidCallback onBack;

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
        children: <Widget>[
          IconButton(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back_ios_new,
                color: AuraColors.sage, size: 18),
          ),
          // Avatar circle
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AuraColors.sage.withOpacity(0.15),
              border: Border.all(color: AuraColors.sage.withOpacity(0.3)),
            ),
            child: Center(
              child: Text(
                creatorName[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AuraColors.sage,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  creatorName,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  creatorHandle,
                  style: TextStyle(
                    fontSize: 10,
                    color: AuraColors.textPrimary.withOpacity(0.45),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: AuraColors.sage),
          ),
        ],
      ),
    );
  }
}

// ── Deal Banner ───────────────────────────────────────────────────────────────

class _DealBanner extends StatelessWidget {
  const _DealBanner({
    required this.campaignTitle,
    required this.dealAmount,
  });

  final String campaignTitle;
  final String dealAmount;

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
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AuraColors.sage.withOpacity(0.1),
                  ),
                  child: Icon(Icons.campaign_outlined,
                      size: 18, color: AuraColors.sage.withOpacity(0.6)),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Active Deal',
                      style: TextStyle(
                        fontSize: 9,
                        letterSpacing: 2,
                        color: AuraColors.sage.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      campaignTitle,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              dealAmount,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
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

// Brand's own messages — right side
class _BrandOwnBubble extends StatelessWidget {
  const _BrandOwnBubble({required this.text, required this.time});
  final String text;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1A3A4A),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(4),
              bottomLeft: Radius.circular(18),
              bottomRight: Radius.circular(18),
            ),
            border: Border.all(color: const Color(0xFF7EB5D6).withOpacity(0.2)),
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
                      size: 11,
                      color: const Color(0xFF7EB5D6).withOpacity(0.6)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Creator's messages — left side
class _CreatorBubble extends StatelessWidget {
  const _CreatorBubble(
      {required this.text, required this.time, required this.name});
  final String text;
  final DateTime time;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
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
              decoration: const BoxDecoration(
                color: Color(0xFF7EB5D6),
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

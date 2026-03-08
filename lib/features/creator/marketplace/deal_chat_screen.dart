import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/theme/aura_theme.dart';
import 'package:aura_influencer_portfolio/shared/utils/mock_data.dart';

class DealChatScreen extends StatefulWidget {
  const DealChatScreen({super.key});

  @override
  State<DealChatScreen> createState() => _DealChatScreenState();
}

class _DealChatScreenState extends State<DealChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
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
            const Expanded(child: _Messages()),
            _Composer(controller: _messageController),
          ],
        ),
      ),
    );
  }
}

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
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2),
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
                    color: AuraColors.textPrimary.withOpacity(0.1),
                  ),
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
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const <Widget>[
                Text(
                  MockDealChat.offerAmount,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  MockDealChat.offerType,
                  style: TextStyle(
                    fontSize: 9,
                    letterSpacing: 1.5,
                    color: AuraColors.sage,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Messages extends StatelessWidget {
  const _Messages();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
      children: const <Widget>[
        _Timestamp(MockDealChat.timestamp),
        _BrandBubble(
          text: MockDealChat.msg1,
        ),
        _UserBubble(
          text: MockDealChat.msg2,
        ),
        _BrandBubble(
          text: MockDealChat.msg3,
        ),
      ],
    );
  }
}

class _Timestamp extends StatelessWidget {
  const _Timestamp(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 9,
            letterSpacing: 3,
            color: AuraColors.textPrimary.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}

class _BrandBubble extends StatelessWidget {
  const _BrandBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AuraColors.obsidian,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}

class _UserBubble extends StatelessWidget {
  const _UserBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AuraColors.sage.withOpacity(0.15),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AuraColors.sage.withOpacity(0.2),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({required this.controller});

  final TextEditingController controller;

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
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Attachment coming soon')),
              );
            },
            icon: const Icon(Icons.add_circle_outline, color: AuraColors.sage),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AuraColors.obsidian,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AuraColors.textPrimary.withOpacity(0.08)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 13, color: AuraColors.textPrimary),
                maxLines: 1,
                textInputAction: TextInputAction.send,
                onSubmitted: (String value) {
                  if (value.trim().isNotEmpty) {
                    controller.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Message sent!')),
                    );
                  }
                },
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
          IconButton(
            onPressed: () {
              final String text = controller.text.trim();
              if (text.isNotEmpty) {
                controller.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Message sent!')),
                );
              }
            },
            icon: const Icon(Icons.send, color: AuraColors.sage),
          ),
        ],
      ),
    );
  }
}

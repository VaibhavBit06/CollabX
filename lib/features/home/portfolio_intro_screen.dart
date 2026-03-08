import 'package:flutter/material.dart';

import 'package:aura_influencer_portfolio/routing/app_router.dart';
import 'package:aura_influencer_portfolio/theme/aura_theme.dart';

class PortfolioIntroScreen extends StatelessWidget {
  const PortfolioIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuraColors.midnight,
      body: Stack(
        children: <Widget>[
          const _HeroImageBackground(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const _TopBar(),
                const Spacer(),
              const _IntroCard(),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const _GlowOverlays(),
        ],
      ),
    );
  }
}

class _HeroImageBackground extends StatelessWidget {
  const _HeroImageBackground();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: FractionallySizedBox(
        heightFactor: 0.6,
        widthFactor: 1.0,
        child: ShaderMask(
          shaderCallback: (Rect rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.white,
                Colors.white,
                Colors.transparent,
              ],
              stops: <double>[0.0, 0.8, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                image: NetworkImage(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDp8z8PKW7ApSNLvZeTb1X4iVpFwkSPrtRJqihZN2xLq_dE6th_oqBBuUcenI52CIbOtwi95OOWi_FJuOMCq4dfwK_AQOqhVUnpk_up4J_duJYSWY6_FH_GPuUGKnfRfsEY1WaLE3suCRoprI98NLilRxsrrwsALqbLulBL8-YhtfWOydVeT59dnE19JHyOrGuYBIPNNz3tGmGJHdq2vf7nDPiL6LFYpxSm4HNe--GQL4GgULu0ejtI99lB5H8NZMUMPsT5fZAyOg',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'Portfolio',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 4,
              fontWeight: FontWeight.w500,
              color: AuraColors.sage.withOpacity(0.8),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                width: 16,
                height: 1,
                color: AuraColors.textPrimary,
              ),
              const SizedBox(width: 4),
              Container(
                width: 8,
                height: 1,
                color: AuraColors.textPrimary.withOpacity(0.2),
              ),
              const SizedBox(width: 4),
              Container(
                width: 8,
                height: 1,
                color: AuraColors.textPrimary.withOpacity(0.2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(15, 15, 18, 0.82),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: AuraColors.textPrimary.withOpacity(0.08),
          ),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              blurRadius: 40,
              offset: Offset(0, 24),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Your Career,\nManaged by You.',
              style: TextStyle(
                fontSize: 32,
                height: 1.1,
                fontWeight: FontWeight.w200,
                color: AuraColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Direct brand access and creative control. Experience the new standard for elite creators.',
              style: TextStyle(
                color: Color(0xB39DB4A0),
                fontSize: 14,
                height: 1.5,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: <Widget>[
                Container(
                  height: 4,
                  width: 32,
                  decoration: BoxDecoration(
                    color: AuraColors.sage,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const SizedBox(width: 6),
                _smallBar(),
                const SizedBox(width: 6),
                _smallBar(),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 64,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ).copyWith(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      return const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color(0xFFF3F4F6),
                          Color(0xFF9CA3AF),
                          Color(0xFFD1D5DB),
                        ],
                      ).colors.first;
                    },
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.authWelcome);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'CONTINUE',
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                        color: AuraColors.midnight,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: AuraColors.midnight,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallBar() {
    return Container(
      height: 4,
      width: 4,
      decoration: BoxDecoration(
        color: AuraColors.textPrimary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

class _GlowOverlays extends StatelessWidget {
  const _GlowOverlays();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: -120,
            left: -120,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                color: AuraColors.textPrimary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            right: -120,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                color: AuraColors.textPrimary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

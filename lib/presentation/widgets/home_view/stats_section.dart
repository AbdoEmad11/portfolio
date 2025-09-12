import 'package:flutter/material.dart';
import '../../../core/utils/extensions.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = const [
      _StatItem(label: 'Years Experience', value: 3),
      _StatItem(label: 'Projects', value: 24),
      _StatItem(label: 'Happy Clients', value: 12),
      _StatItem(label: 'Certificates', value: 6),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: context.isDesktop ? 48 : 32,
        horizontal: context.responsiveValue(
          mobile: 16,
          tablet: 24,
          desktop: 32,
        ),
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: context.responsiveValue(
              mobile: 1200,
              tablet: 1400,
              desktop: 1600,
              largeDesktop: 1800,
            ),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 24,
            runSpacing: 24,
            children: items
                .map((e) => _AnimatedStatCard(
                      label: e.label,
                      value: e.value,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _AnimatedStatCard extends StatelessWidget {
  final String label;
  final int value;

  const _AnimatedStatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: context.isDesktop ? 260 : 160,
      padding: EdgeInsets.symmetric(
        vertical: context.isDesktop ? 24 : 16,
        horizontal: context.isDesktop ? 24 : 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            scheme.surface.withOpacity(0.6),
            scheme.surface.withOpacity(0.3),
          ],
        ),
        border: Border.all(color: scheme.primary.withOpacity(0.15)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            context.isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOut,
            tween: Tween(begin: 0, end: value.toDouble()),
            builder: (context, val, _) {
              return Text(
                val.toInt().toString(),
                style: context.textTheme.headlineMedium?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w800,
                ),
              );
            },
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem {
  final String label;
  final int value;
  const _StatItem({required this.label, required this.value});
}



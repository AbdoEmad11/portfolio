import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/utils/extensions.dart';

class TechMarquee extends StatefulWidget {
  const TechMarquee({super.key});

  @override
  State<TechMarquee> createState() => _TechMarqueeState();
}

class _TechMarqueeState extends State<TechMarquee> {
  late final ScrollController _controller;
  Timer? _timer;

  final List<String> techs = const [
    'Flutter', 'Dart', 'Bloc', 'GoRouter', 'Firebase', 'REST', 'CI/CD', 'GitHub Actions',
  ];

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (_) {
      if (!mounted) return;
      if (_controller.hasClients) {
        final max = _controller.position.maxScrollExtent;
        final next = _controller.offset + 1;
        _controller.jumpTo(next >= max ? 0 : next);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.only(
        top: context.isDesktop ? 24 : 16,
        bottom: context.isDesktop ? 24 : 16,
      ),
      child: SizedBox(
        height: 48,
        child: ListView.separated(
          controller: _controller,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: techs.length * 4,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            final label = techs[index % techs.length];
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: scheme.surface.withOpacity(0.5),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: scheme.primary.withOpacity(0.15)),
              ),
              child: Text(
                label,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



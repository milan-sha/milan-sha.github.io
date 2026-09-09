import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class PortraitPlate extends StatefulWidget {
  const PortraitPlate({
    super.key,
    required this.asset,
    this.caption,
    this.aspectRatio = 4 / 5,
    this.scan = true,
  });

  final String asset;
  final String? caption;
  final double aspectRatio;
  final bool scan;

  @override
  State<PortraitPlate> createState() => _PortraitPlateState();
}

class _PortraitPlateState extends State<PortraitPlate>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scan;
  bool _hover = false;

  @override
  void initState() {
    super.initState();
    _scan = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    );
    if (widget.scan) {
      _scan.repeat();
    }
  }

  @override
  void dispose() {
    _scan.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduce = MediaQuery.disableAnimationsOf(context);
    if (reduce && _scan.isAnimating) {
      _scan.stop();
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AspectRatio(
        aspectRatio: widget.aspectRatio,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: 12,
              top: 12,
              right: -10,
              bottom: -10,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 280),
                color: AppColors.laterite.withValues(
                  alpha: _hover ? 0.42 : 0.22,
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: AppColors.graphite,
                  border: Border.fromBorderSide(
                    BorderSide(color: AppColors.line),
                  ),
                ),
                child: ClipRect(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 420),
                        curve: Curves.easeOutCubic,
                        foregroundDecoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.night.withValues(
                                alpha: _hover ? 0.08 : 0.28,
                              ),
                            ],
                          ),
                        ),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.matrix(
                            _hover || reduce ? _identity : _lateriteGrade,
                          ),
                          child: Image.asset(
                            widget.asset,
                            fit: BoxFit.cover,
                            alignment: const Alignment(0.05, -0.28),
                            filterQuality: FilterQuality.high,
                            errorBuilder: (context, error, stack) {
                              return ColoredBox(
                                color: AppColors.plate,
                                child: Center(
                                  child: Text(
                                    'MS',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(color: AppColors.laterite),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      if (widget.scan && !reduce)
                        AnimatedBuilder(
                          animation: _scan,
                          builder: (context, _) {
                            return CustomPaint(
                              painter: _ScanPainter(t: _scan.value),
                            );
                          },
                        ),
                      CustomPaint(painter: _BracketPainter()),
                    ],
                  ),
                ),
              ),
            ),
            if (widget.caption != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: IgnorePointer(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    color: AppColors.night.withValues(alpha: 0.72),
                    child: Text(
                      widget.caption!,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.ember,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PortraitMark extends StatelessWidget {
  const PortraitMark({super.key, required this.asset, this.size = 40});

  final String asset;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: AppColors.laterite)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: ColorFiltered(
            colorFilter: const ColorFilter.matrix(_lateriteGrade),
            child: Image.asset(
              asset,
              fit: BoxFit.cover,
              alignment: const Alignment(0.1, -0.45),
              filterQuality: FilterQuality.high,
              errorBuilder: (context, error, stack) {
                return const ColoredBox(color: AppColors.plate);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _ScanPainter extends CustomPainter {
  _ScanPainter({required this.t});

  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final y = size.height * (0.08 + (t * 0.84));
    final trail = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.laterite.withValues(alpha: 0),
          AppColors.laterite.withValues(alpha: 0.18),
        ],
      ).createShader(Rect.fromLTWH(0, y - 28, size.width, 28));
    canvas.drawRect(Rect.fromLTWH(0, y - 28, size.width, 28), trail);
    canvas.drawLine(
      Offset(0, y),
      Offset(size.width, y),
      Paint()
        ..color = AppColors.laterite.withValues(alpha: 0.7)
        ..strokeWidth = 1.2,
    );
  }

  @override
  bool shouldRepaint(covariant _ScanPainter oldDelegate) => oldDelegate.t != t;
}

class _BracketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.laterite
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;
    const arm = 18.0;
    const inset = 8.0;

    void corner(Offset origin, double dx, double dy) {
      canvas.drawLine(origin, origin + Offset(dx * arm, 0), paint);
      canvas.drawLine(origin, origin + Offset(0, dy * arm), paint);
    }

    corner(const Offset(inset, inset), 1, 1);
    corner(Offset(size.width - inset, inset), -1, 1);
    corner(Offset(inset, size.height - inset), 1, -1);
    corner(Offset(size.width - inset, size.height - inset), -1, -1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

const _identity = <double>[
  1, 0, 0, 0, 0,
  0, 1, 0, 0, 0,
  0, 0, 1, 0, 0,
  0, 0, 0, 1, 0,
];

const _lateriteGrade = <double>[
  0.85, 0.08, 0.04, 0, 8,
  0.06, 0.72, 0.06, 0, 4,
  0.04, 0.06, 0.58, 0, 0,
  0, 0, 0, 1, 0,
];

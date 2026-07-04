import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class TerminalWindow extends StatelessWidget {
  final Widget child;
  final String title;

  const TerminalWindow({
    super.key,
    required this.child,
    this.title = 'bash',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.surfaceLight, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(
                bottom: BorderSide(color: AppColors.surfaceLight, width: 2),
              ),
            ),
            child: Row(
              children: [
                _buildDot(Colors.redAccent),
                const SizedBox(width: 8),
                _buildDot(Colors.yellowAccent),
                const SizedBox(width: 8),
                _buildDot(Colors.greenAccent),
                Expanded(
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontFamily: 'monospace',
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 48), // Balance for centering
              ],
            ),
          ),
          // Content
          child,
        ],
      ),
    );
  }

  Widget _buildDot(Color color) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

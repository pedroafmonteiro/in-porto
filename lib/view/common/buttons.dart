import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.icon,
    this.disabled = false,
  });

  final VoidCallback onPressed;
  final String text;
  final IconData icon;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : () => onPressed(),
      child: ClipRSuperellipse(
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 32.0,
          ),
          color: disabled
              ? Theme.of(context).colorScheme.onSurface.withAlpha(128)
              : Theme.of(context).colorScheme.onSurface,
          child: Row(
            children: [
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.surface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Icon(
                icon,
                color: Theme.of(context).colorScheme.surface,
                size: 24.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class RouteBadge extends StatelessWidget {
  const RouteBadge({
    super.key,
    required this.number,
    required this.color,
    required this.textColor,
  });

  final String? number;
  final String? color;
  final String? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 1,
          horizontal: 6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Color(
            int.parse(
              '0xff${color?.replaceFirst('#', '') ?? 'ffffff'}',
            ),
          ),
        ),
        child: Text(
          number ?? 'Line',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Color(
              int.parse(
                '0xff${textColor?.replaceFirst('#', '') ?? '000000'}',
              ),
            ),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

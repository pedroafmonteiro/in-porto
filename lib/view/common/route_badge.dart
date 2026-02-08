import 'package:flutter/material.dart';

class RouteBadge extends StatelessWidget {
  const RouteBadge({
    super.key,
    required this.number,
    required this.color,
    required this.textColor,
    this.large = false,
  });

  final String? number;
  final String? color;
  final String? textColor;
  final bool large;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: large ? 40 : 32,
      height: large ? 24 : 20,
      alignment: Alignment.center,
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
        style: large
            ? Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Color(
                  int.parse(
                    '0xff${textColor?.replaceFirst('#', '') ?? '000000'}',
                  ),
                ),
                fontWeight: FontWeight.bold,
              )
            : Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Color(
                  int.parse(
                    '0xff${textColor?.replaceFirst('#', '') ?? '000000'}',
                  ),
                ),
                fontWeight: FontWeight.bold,
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

typedef ActionCenterBuilder =
    Widget Function(
      BuildContext context, {
      required VoidCallback onOpen,
      VoidCallback? onClose,
      required ValueChanged<Widget> onSelected,
    });

class ActionCenterOverride {
  final ActionCenterBuilder closedBuilder;
  final WidgetBuilder initialOpenBuilder;
  final Object key;

  const ActionCenterOverride({
    required this.closedBuilder,
    required this.initialOpenBuilder,
    required this.key,
  });
}

class ActionCenter extends StatefulWidget {
  final ActionCenterOverride overrideContent;
  final VoidCallback? onCloseOverride;

  const ActionCenter({
    super.key,
    required this.overrideContent,
    this.onCloseOverride,
  });

  @override
  State<ActionCenter> createState() => _ActionCenterState();
}

class _ActionCenterState extends State<ActionCenter> {
  late Widget _selectedView;
  Object? _activeKey;

  void _updateActiveOverride() {
    final current = widget.overrideContent;
    if (_activeKey != current.key) {
      _activeKey = current.key;
      _selectedView = current.initialOpenBuilder(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    _updateActiveOverride();

    return Container(
      margin: const EdgeInsets.all(32.0),
      child: OpenContainer(
        tappable: false,
        transitionType: ContainerTransitionType.fade,
        transitionDuration: const Duration(milliseconds: 500),
        closedElevation: 5,
        openElevation: 0,
        closedShape: RoundedSuperellipseBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        closedColor: Theme.of(context).colorScheme.surface,
        openColor: Theme.of(context).colorScheme.surface,
        closedBuilder: (context, action) => AnimatedSize(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubicEmphasized,
          alignment: Alignment.center,
          child: ClipRSuperellipse(
            key: ValueKey(widget.overrideContent.key),
            borderRadius: BorderRadius.circular(24.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              color: Theme.of(context).colorScheme.surface,
              child: widget.overrideContent.closedBuilder(
                context,
                onOpen: action,
                onClose: widget.onCloseOverride,
                onSelected: (w) => setState(() => _selectedView = w),
              ),
            ),
          ),
        ),
        openBuilder: (context, action) => _selectedView,
      ),
    );
  }
}

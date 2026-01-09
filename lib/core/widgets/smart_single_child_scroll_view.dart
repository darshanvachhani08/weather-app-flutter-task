import '../core.dart';

/// SmartSingleChildScrollView - Enhanced SingleChildScrollView with built-in refresh and keyboard dismiss
class SmartSingleChildScrollView extends StatelessWidget {
  final Widget child;
  final ScrollController? controller;
  final Axis? scrollDirection;
  final ScrollPhysics? physics;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final bool? primary;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final String? restorationId;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final Future<void> Function()? onRefresh;
  final bool safeArea;

  const SmartSingleChildScrollView({
    super.key,
    required this.child,
    this.controller,
    this.scrollDirection,
    this.physics,
    this.reverse = false,
    this.padding,
    this.primary,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.onRefresh,
    this.safeArea = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget view = SingleChildScrollView(
      controller: controller,
      scrollDirection: scrollDirection ?? Axis.vertical,
      physics: physics,
      reverse: reverse,
      padding: padding,
      primary: primary,
      dragStartBehavior: dragStartBehavior,
      clipBehavior: clipBehavior,
      restorationId: restorationId,
      keyboardDismissBehavior: keyboardDismissBehavior,
      child: child,
    );

    // Auto-dismiss keyboard on tap
    view = GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: _getRefreshIndicatorView(view: view),
    );

    if (safeArea) {
      view = SafeArea(child: view);
    }

    return view;
  }

  Widget _getRefreshIndicatorView({required Widget view}) {
    if (onRefresh != null) {
      return RefreshIndicator.adaptive(triggerMode: RefreshIndicatorTriggerMode.anywhere, onRefresh: onRefresh!, child: view);
    }
    return view;
  }
}

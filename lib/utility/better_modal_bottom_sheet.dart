import 'package:flutter/material.dart';

const Duration _kBottomSheetDuration = const Duration(milliseconds: 200);

Future<T> showBetterModalBottomSheet<T>({
  @required BuildContext context,
  @required WidgetBuilder builder,
  bool dismissOnTap: true,
  bool resizeToAvoidBottomPadding: true,
}) {
  assert(context != null);
  assert(builder != null);
  return Navigator.push(
      context,
      new _ModalBottomSheetRoute<T>(
        builder: builder,
        theme: Theme.of(context, shadowThemeOnly: true),
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        resizeToAvoidBottomPadding: resizeToAvoidBottomPadding,
        dismissOnTap: dismissOnTap,
      ));
}

class _ModalBottomSheetRoute<T> extends PopupRoute<T> {
  _ModalBottomSheetRoute({
    this.builder,
    this.theme,
    this.barrierLabel,
    RouteSettings settings,
    this.resizeToAvoidBottomPadding,
    this.dismissOnTap,
  }) : super(settings: settings);

  final WidgetBuilder builder;
  final ThemeData theme;
  final bool resizeToAvoidBottomPadding;
  final bool dismissOnTap;

  @override
  Duration get transitionDuration => _kBottomSheetDuration;

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController = BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    // By definition, the bottom sheet is aligned to the bottom of the page
    // and isn't exposed to the top padding of the MediaQuery.
    Widget bottomSheet = new MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: new _ModalBottomSheet<T>(route: this),
    );
    if (theme != null) bottomSheet = new Theme(data: theme, child: bottomSheet);
    return bottomSheet;
  }
}

class _ModalBottomSheet<T> extends StatefulWidget {
  const _ModalBottomSheet({Key key, this.route}) : super(key: key);

  final _ModalBottomSheetRoute<T> route;

  @override
  _ModalBottomSheetState<T> createState() => new _ModalBottomSheetState<T>();
}

class _ModalBottomSheetState<T> extends State<_ModalBottomSheet<T>> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onTap: widget.route.dismissOnTap ? () => Navigator.pop(context) : null,
        child: new AnimatedBuilder(
            animation: widget.route.animation,
            builder: (BuildContext context, Widget child) {
              double bottomInset = widget.route.resizeToAvoidBottomPadding ? MediaQuery.of(context).viewInsets.bottom : 0.0;
              return new ClipRect(
                  child: new CustomSingleChildLayout(
                      delegate: new _ModalBottomSheetLayout(widget.route.animation.value, bottomInset),
                      child: new BottomSheet(animationController: widget.route._animationController, onClosing: () => Navigator.pop(context), builder: widget.route.builder)));
            }));
  }
}

class _ModalBottomSheetLayout extends SingleChildLayoutDelegate {
  _ModalBottomSheetLayout(this.progress, this.bottomInset);

  final double progress;
  final double bottomInset;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return new BoxConstraints(minWidth: constraints.maxWidth, maxWidth: constraints.maxWidth, minHeight: 0.0, maxHeight: constraints.maxHeight * 9.0 / 16.0);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return new Offset(0.0, size.height - bottomInset - childSize.height * progress);
  }

  @override
  bool shouldRelayout(_ModalBottomSheetLayout oldDelegate) {
    return progress != oldDelegate.progress || bottomInset != oldDelegate.bottomInset;
  }
}

import 'package:flutter/widgets.dart';
import 'package:widgets_visibility_provider/src/widgets_visibility_provider.dart';
import 'package:widgets_visibility_provider/widgets_visibility_provider.dart';

class VisibleNotifierWidget extends StatelessWidget {
  final Widget child;
  final dynamic data;
  final bool Function(
    ScrollNotification previousNotification,
    PositionData previousPositionData,
    ScrollNotification currentNotification,
    PositionData currentPositionData,
  ) condition;
  final void Function(
    BuildContext context,
    ScrollNotification notification,
    PositionData positionData,
  ) listener;
  final Widget Function(
    BuildContext context,
    ScrollNotification notification,
    PositionData positionData,
  ) builder;

  const VisibleNotifierWidget({
    Key key,
    this.data,
    this.child,
    this.condition,
    this.listener,
    this.builder,
  })  : assert(!(child != null && builder != null)),
        assert(!(listener != null && builder != null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    UniqueKey uniqueKey = UniqueKey();

    if (builder != null)
      return WidgetsVisibilityBuilder(
        condition:
            (WidgetsVisibilityEvent previous, WidgetsVisibilityEvent current) =>
                _condition(previous, current, uniqueKey),
        builder: (BuildContext context, WidgetsVisibilityEvent event) {
          var e = (event as WidgetsVisibilityFullEvent);
          var notification = e.notification;
          var positionData = _getPositionData(e, uniqueKey);

          var child = builder(
            context,
            notification,
            positionData,
          );
          return SenderWidget(
            key: uniqueKey,
            data: data,
            child: child,
          );
        },
      );

    var senderWidget = SenderWidget(
      key: uniqueKey,
      child: child,
      data: data,
    );

    if (listener != null)
      return WidgetsVisibilityListener(
        condition:
            (WidgetsVisibilityEvent previous, WidgetsVisibilityEvent current) =>
                _condition(previous, current, uniqueKey),
        listener: (BuildContext context, WidgetsVisibilityEvent event) {
          var e = (event as WidgetsVisibilityFullEvent);
          var notification = e.notification;
          PositionData positionData = _getPositionData(e, uniqueKey);

          return listener(
            context,
            notification,
            positionData,
          );
        },
        child: senderWidget,
      );

    return senderWidget;
  }

  PositionData _getPositionData(
      WidgetsVisibilityFullEvent e, UniqueKey uniqueKey) {
    try {
      return e.positionDataMap.entries
          .firstWhere((mapEntry) => mapEntry.key == uniqueKey)
          ?.value;
    } catch (_) {}

    return null;
  }

  _condition(WidgetsVisibilityEvent previous, WidgetsVisibilityEvent current,
      Key uniqueKey) {
    var p = (previous as WidgetsVisibilityFullEvent);
    var c = (current as WidgetsVisibilityFullEvent);

    var previousPositionData = p.positionDataMap[uniqueKey];
    var currentPositionData = c.positionDataMap[uniqueKey];

    var previousNotification = p.notification;
    var currentNotification = c.notification;

    return condition?.call(previousNotification, previousPositionData,
            currentNotification, currentPositionData) ??
        _defaultCondition(previousNotification, previousPositionData,
            currentNotification, currentPositionData);
  }

  _defaultCondition(
    ScrollNotification previousNotification,
    PositionData previousPositionData,
    ScrollNotification currentNotification,
    PositionData currentPositionData,
  ) {
    if (previousPositionData != currentPositionData) return true;

    if (previousPositionData != null && currentPositionData != null)
      return previousNotification != currentNotification;

    return false;
  }
}

class SenderWidget extends ProxyWidget {
  const SenderWidget({
    @required Key key,
    @required Widget child,
    this.data,
  })  : assert(key != null),
        assert(child != null),
        super(key: key, child: child);

  final dynamic data;

  @override
  Element createElement() => SenderElement(this);
}

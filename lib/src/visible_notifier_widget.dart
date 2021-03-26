import 'package:flutter/widgets.dart';
import 'package:widgets_visibility_provider/src/widgets_visibility_provider.dart';
import 'package:widgets_visibility_provider/widgets_visibility_provider.dart';

class VisibleNotifierWidget extends StatelessWidget {
  final Widget? child;
  final dynamic data;
  final bool Function(
    ScrollNotification? previousNotification,
    PositionData? previousPositionData,
    ScrollNotification? currentNotification,
    PositionData? currentPositionData,
  )? condition;
  final void Function(
    BuildContext context,
    ScrollNotification? notification,
    PositionData? positionData,
  )? listener;
  final Widget Function(
    BuildContext context,
    ScrollNotification? notification,
    PositionData? positionData,
  )? builder;

  const VisibleNotifierWidget({
    Key? key,
    this.data,
    this.child,
    this.condition,
    this.listener,
    this.builder,
  })  : assert(!(child != null && builder != null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var uniqueKey = UniqueKey();

    if (builder != null) {
      return WidgetsVisibilityConsumer(
        listenWhen:
            (WidgetsVisibilityEvent previous, WidgetsVisibilityEvent current) =>
                _condition(previous, current, uniqueKey),
        buildWhen:
            (WidgetsVisibilityEvent previous, WidgetsVisibilityEvent current) =>
                _condition(previous, current, uniqueKey),
        builder: (context, event) => _builder(event, uniqueKey, context),
        listener: (BuildContext context, WidgetsVisibilityEvent event) =>
            _listener(event, uniqueKey, context),
      );
    }

    var senderWidget = SenderWidget(
      key: uniqueKey,
      data: data,
      child: child!,
    );

    if (listener != null) {
      return WidgetsVisibilityListener(
        listenWhen:
            (WidgetsVisibilityEvent previous, WidgetsVisibilityEvent current) =>
                _condition(previous, current, uniqueKey),
        listener: (BuildContext context, WidgetsVisibilityEvent event) =>
            _listener(event, uniqueKey, context),
        child: senderWidget,
      );
    }

    return senderWidget;
  }

  void _listener(
      WidgetsVisibilityEvent event, UniqueKey uniqueKey, BuildContext context) {
    var e = (event as WidgetsVisibilityFullEvent);
    var notification = e.notification;
    var positionData = _getPositionData(e, uniqueKey);

    return listener?.call(
      context,
      notification,
      positionData,
    );
  }

  SenderWidget _builder(
      WidgetsVisibilityEvent event, UniqueKey uniqueKey, BuildContext context) {
    var e = (event as WidgetsVisibilityFullEvent);
    var notification = e.notification;
    var positionData = _getPositionData(e, uniqueKey);

    assert(builder != null);
    var child = builder!(
      context,
      notification,
      positionData,
    );
    return SenderWidget(
      key: uniqueKey,
      data: data,
      child: child,
    );
  }

  PositionData? _getPositionData(
      WidgetsVisibilityFullEvent e, UniqueKey uniqueKey) {
    try {
      return e.positionDataMap.entries
          .firstWhere((mapEntry) => mapEntry.key == uniqueKey)
          .value;
    } catch (_) {}

    return null;
  }

  bool _condition(WidgetsVisibilityEvent previous,
      WidgetsVisibilityEvent current, Key uniqueKey) {
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

  bool _defaultCondition(
    ScrollNotification? previousNotification,
    PositionData? previousPositionData,
    ScrollNotification? currentNotification,
    PositionData? currentPositionData,
  ) {
    if (previousPositionData != currentPositionData) return true;

    if (previousPositionData != null && currentPositionData != null) {
      return previousNotification != currentNotification;
    }

    return false;
  }
}

class SenderWidget extends ProxyWidget {
  const SenderWidget({
    required Key key,
    required Widget child,
    this.data,
  }) : super(key: key, child: child);

  final dynamic data;

  @override
  Element createElement() => SenderElement(this);
}

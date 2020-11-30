import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_visibility_provider/widgets_visibility_provider.dart';

class WidgetsVisibilityListener extends StatelessWidget {
  final Widget child;
  final BlocWidgetListener<WidgetsVisibilityEvent> listener;
  final BlocListenerCondition<WidgetsVisibilityEvent> listenWhen;

  const WidgetsVisibilityListener({
    Key key,
    this.child,
    this.listener,
    this.listenWhen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocListener<WidgetsVisibilityProviderBloc, WidgetsVisibilityEvent>(
        listener: listener,
        listenWhen: listenWhen,
        child: child,
      );
}

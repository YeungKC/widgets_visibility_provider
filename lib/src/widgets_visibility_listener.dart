import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_visibility_provider/widgets_visibility_provider.dart';

class WidgetsVisibilityListener extends StatelessWidget {
  final Widget child;
  final void Function(BuildContext context, WidgetsVisibilityEvent event)
      listener;
  final bool Function(
          WidgetsVisibilityEvent previous, WidgetsVisibilityEvent current)
      condition;

  const WidgetsVisibilityListener({
    Key key,
    this.child,
    this.listener,
    this.condition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocListener<WidgetsVisibilityProviderBloc, WidgetsVisibilityEvent>(
        listener: listener,
        listenWhen: condition,
        child: child,
      );
}

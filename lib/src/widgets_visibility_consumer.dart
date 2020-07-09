import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_visibility_provider/widgets_visibility_provider.dart';

class WidgetsVisibilityConsumer extends StatelessWidget {
  final bool Function(
          WidgetsVisibilityEvent previous, WidgetsVisibilityEvent current)
      buildWhen;
  final Widget Function(BuildContext context, WidgetsVisibilityEvent event)
      builder;
  final void Function(BuildContext context, WidgetsVisibilityEvent event)
      listener;
  final bool Function(
          WidgetsVisibilityEvent previous, WidgetsVisibilityEvent current)
      listenWhen;

  const WidgetsVisibilityConsumer({
    Key key,
    this.buildWhen,
    this.builder,
    this.listenWhen,
    this.listener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<WidgetsVisibilityProviderBloc, WidgetsVisibilityEvent>(
        builder: builder,
        buildWhen: buildWhen,
        listenWhen: listenWhen,
        listener: listener,
      );
}

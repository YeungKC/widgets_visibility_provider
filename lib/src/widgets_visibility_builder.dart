import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_visibility_provider/widgets_visibility_provider.dart';

class WidgetsVisibilityBuilder extends StatelessWidget {
  final bool Function(
          WidgetsVisibilityEvent previous, WidgetsVisibilityEvent current)
      condition;
  final Widget Function(BuildContext context, WidgetsVisibilityEvent event)
      builder;

  const WidgetsVisibilityBuilder({Key key, this.condition, this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WidgetsVisibilityProviderBloc, WidgetsVisibilityEvent>(
        builder: builder,
        buildWhen: condition,
      );
}

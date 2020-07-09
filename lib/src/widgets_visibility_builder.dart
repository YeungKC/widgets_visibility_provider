import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_visibility_provider/widgets_visibility_provider.dart';

class WidgetsVisibilityBuilder extends StatelessWidget {
  final bool Function(
          WidgetsVisibilityEvent previous, WidgetsVisibilityEvent current)
      buildWhen;
  final Widget Function(BuildContext context, WidgetsVisibilityEvent event)
      builder;

  const WidgetsVisibilityBuilder({Key key, this.buildWhen, this.builder})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WidgetsVisibilityProviderBloc, WidgetsVisibilityEvent>(
        builder: builder,
        buildWhen: buildWhen,
      );
}

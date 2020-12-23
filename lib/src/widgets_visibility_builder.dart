import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_visibility_provider/widgets_visibility_provider.dart';

class WidgetsVisibilityBuilder extends StatelessWidget {
  final BlocBuilderCondition<WidgetsVisibilityEvent>? buildWhen;
  final BlocWidgetBuilder<WidgetsVisibilityEvent> builder;

  const WidgetsVisibilityBuilder({
    Key? key,
    this.buildWhen,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<WidgetsVisibilityProviderBloc, WidgetsVisibilityEvent>(
        builder: builder,
        buildWhen: buildWhen,
      );
}

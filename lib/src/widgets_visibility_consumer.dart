import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets_visibility_provider/widgets_visibility_provider.dart';

class WidgetsVisibilityConsumer extends StatelessWidget {
  final BlocBuilderCondition<WidgetsVisibilityEvent>? buildWhen;
  final BlocWidgetBuilder<WidgetsVisibilityEvent> builder;
  final BlocWidgetListener<WidgetsVisibilityEvent> listener;
  final BlocListenerCondition<WidgetsVisibilityEvent>? listenWhen;

  const WidgetsVisibilityConsumer({
    Key? key,
    this.buildWhen,
    required this.builder,
    this.listenWhen,
    required this.listener,
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

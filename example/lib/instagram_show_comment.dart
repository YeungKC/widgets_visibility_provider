import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:widgets_visibility_provider/widgets_visibility_provider.dart';

class ShowCommentBloc extends Bloc<int, Set<int>> {
  ShowCommentBloc() : super({});

  @override
  Stream<Transition<int, Set<int>>> transformEvents(
          Stream<int> events, transitionFn) =>
      super.transformEvents(
        events
            .distinct()
            .debounce((event) => TimerStream(event, Duration(seconds: 3))),
        transitionFn,
      );

  @override
  Stream<Set<int>> mapEventToState(int event) async* {
    // 为了改变 hashCode
    // for change hashCode
    yield (state..add(event)).toSet();
  }
}

class InstagramShowComment extends StatelessWidget {
  const InstagramShowComment({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Instagram Show Comment'),
      ),
      body: Stack(
        children: [
          BlocProvider<ShowCommentBloc>(
            create: (ctx) => ShowCommentBloc(),
            child: WidgetsVisibilityProvider(
              condition: (PositionData positionData) {
                if (positionData == null) return false;
                var center = positionData.viewportSize / 2;
                return center > positionData.startPosition &&
                    center < positionData.endPosition;
              },
              child: BlocBuilder<ShowCommentBloc, Set<int>>(
                builder: (context, set) => WidgetsVisibilityListener(
                  listener: (context, event) {
                    if (event.positionDataList.isNotEmpty)
                      BlocProvider.of<ShowCommentBloc>(context)
                          .add(event.positionDataList.first.data);
                  },
                  child: ListView.builder(
                    itemBuilder: (context, index) => VisibleNotifierWidget(
                      data: index,
                      child: InsItem(
                        index: index,
                        showComment: set.contains(index),
                      ),
                    ),
                    itemCount: 64,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 1,
              width: double.infinity,
              color: Color(0xff000000),
            ),
          ),
        ],
      ),
    );
  }
}

class InsItem extends StatelessWidget {
  const InsItem({
    Key key,
    this.index,
    this.showComment,
  }) : super(key: key);

  final int index;
  final bool showComment;

  static List<Color> colors = [
    Colors.red[300],
    Colors.green[300],
    Colors.yellow[300]
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          color: colors[index % 3],
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: showComment ? Text('show comment') : Text('$index'),
          ),
        ),
      ],
    );
  }
}

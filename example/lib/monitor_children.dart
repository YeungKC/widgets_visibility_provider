import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:widgets_visibility_provider/widgets_visibility_provider.dart';

class MonitorChildren extends StatelessWidget {
  const MonitorChildren({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Monitor Children'),
      ),
      body: WidgetsVisibilityProvider(
        // range condition default or return null condition is:
        // 范围判断默认或者返回 null 情况下执行的是：
        // positionData.endPosition >= 0 && positionData.startPosition <= positionData.viewportSize
        condition: (PositionData positionData) => null,
        child: Column(
          children: [
//              WidgetVisibilityListener(
//                listener: (context, event) {
//                  print('[WidgetVisibilityListener] event: $event');
//                },
//                condition: (previous, current) => true,
//                child: someWidget,
//              ),
            WidgetsVisibilityBuilder(
                // if you don't need startPosition end endPosition change, you can use it
                // 如果你不需要 startPosition 和 endPosition 变化，你可以增加此条件减少 build 次数
//                   condition: (previous, current) => !listEquals(
//                       previous.positionDataList.map((e) => e.data).toList(),
//                       current.positionDataList.map((e) => e.data).toList()),
                builder: (context, event) => Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Text(
                              '[notification] pixels: ${event.notification?.metrics?.pixels}, minScrollExtent: ${event.notification?.metrics?.minScrollExtent}, maxScrollExtent: ${event.notification?.metrics?.maxScrollExtent}, viewportDimension: ${event.notification?.metrics?.viewportDimension}'),
                          Wrap(
                            children: [
                              Text('display: '),
                              ...event.positionDataList.map(
                                (e) => Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: Text('${e.data}'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => VisibleNotifierWidget(
                  // data type is dynamic, you can set everything
                  // data 的类型是 dynamic, 你可以设置任何数据
                  data: index,
                  // positionData and notification is nullable
                  // positionData 和 notification 有可能为空
                  builder: (context, notification, positionData) => Container(
                    height: 128,
                    color: index.isEven
                        ? const Color(0xff000000).withOpacity(0.3)
                        : const Color(0xff000000).withOpacity(0.1),
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: Text(
                          '$index, start: ${positionData?.startPosition}, end: ${positionData?.endPosition}'),
                    ),
                  ),
//                    listener: (context, notification, positionData) {
//                      print(
//                          '[listener] notification: $notification, positionData: $positionData');
//                    },
                  // builder or child
//                    child: someWidget,
                ),
                itemCount: 64,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

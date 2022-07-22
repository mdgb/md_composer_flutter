import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

class JsonDynamicWidget extends StatefulWidget {
  final Map<String, dynamic>? jsonData;
  final JsonWidgetRegistry? registry;

  const JsonDynamicWidget({this.jsonData, this.registry, Key? key})
      : super(key: key);

  @override
  State<JsonDynamicWidget> createState() => _JsonDynamicWidgetState();
}

class _JsonDynamicWidgetState extends State<JsonDynamicWidget> {
  late JsonWidgetData? _data;

  final widgetJsonData = {
    "type": "center",
    "child": {
      "type": "column",
      "children": [
        {
          "type": "text",
          "args": {
            "text":
                "This is a very important message generated from Json Widget data!"
          }
        },
        {
          "type": "text",
          "args": {
            "text": "This is a very important message on row 2!",
          }
        },
      ]
    }
  };

  @override
  void initState() {
    super.initState();

    _data = JsonWidgetData.fromDynamic(widgetJsonData);
  }

  @override
  Widget build(BuildContext context) {
    var widget = JsonWidgetData.fromDynamic(
      widgetJsonData,
    );
    if (widget != null) {
      return widget.build(context: context);
    } else {
      return Center(child: Text('No data found'));
    }
  }
}

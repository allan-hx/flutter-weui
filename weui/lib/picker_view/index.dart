import 'package:flutter/material.dart';
import '../theme.dart';

class  WePickerView extends StatefulWidget {
  final int itemCount;
  final double itemHeight;
  final List<List<WePickerItem>> children;

  WePickerView({
    itemCount = 5,
    this.itemHeight = 35,
    @required this.children
  }) : assert(itemCount % 2 == 1), this.itemCount = itemCount;

  @override
  WePickerViewState createState() => WePickerViewState();
}

class WePickerViewState extends State<WePickerView> {
  final Map<int, double> tops = {};
  double boxHeight;
  double borderTop;
  double _startY;
  double _endY = 0;

  @override
  initState() {
    super.initState();
    final int placeholderNumber = ((widget.itemCount - 1) / 2).toInt();
    // 计算线框top值
    borderTop = placeholderNumber * widget.itemHeight;
    boxHeight = widget.itemHeight * widget.itemCount;
  }

  onVerticalDragDown(DragDownDetails _) {
    _startY = _.globalPosition.dy;
  }

  onVerticalDragUpdate(DragUpdateDetails _, int index) {
    this.setState(() {
      tops[index] = _endY + (_.globalPosition.dy - _startY);
    });
  }

  onVerticalDragEnd(int index) {
    _endY = tops[index];
  }

  DecoratedBox _renderMaskDecoratedBox(Alignment begin, Alignment end) {
    return DecoratedBox(
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            begin: begin,
            end: end,
            colors: [Color.fromRGBO(255, 255, 255, 0.2), Color.fromRGBO(255, 255, 255, 1)]
          )
        )
      );
  }

  List<Widget> renderItem () {
    final List<Widget> columns = [];

    for (int i = 0; i < widget.children.length; i++) {
      final column = widget.children[i];
      columns.add(
        Expanded(
          flex: 1,
          child: GestureDetector(
            onVerticalDragDown: onVerticalDragDown,
            onVerticalDragUpdate: (_) {
              onVerticalDragUpdate(_, i);
            },
            onVerticalDragEnd: (_) {
              onVerticalDragEnd(i);
            },
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Stack(
                overflow: Overflow.clip,
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Transform.translate(
                      offset: Offset(0, tops[i] == null ? 0 : tops[i]),
                      child: Column(
                        children: column.map((item) {
                          return SizedBox(
                            height: widget.itemHeight,
                            child: DefaultTextStyle(
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(item.label)
                              )
                            )
                          );
                        }).toList()
                      )
                    )
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: borderTop + widget.itemHeight,
                    child: _renderMaskDecoratedBox(Alignment.bottomCenter, Alignment.topCenter)
                  ),
                  Positioned(
                    top: borderTop + widget.itemHeight,
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: _renderMaskDecoratedBox(Alignment.topCenter, Alignment.bottomCenter)
                  )
                ]
              )
            )
          )
        )
      );
    }

    return columns;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: boxHeight,
      child: Stack(
        children: [
          Row(
            children: renderItem()
          ),
          Positioned(
            top: borderTop,
            left: 0,
            right: 0,
            child: Divider(height: 1, color: defaultBorderColor)
          ),
          Positioned(
            top: borderTop + widget.itemHeight,
            left: 0,
            right: 0,
            child: Divider(height: 1, color: defaultBorderColor)
          )
        ]
      )
    );
  }
}

class WePickerItem {
  final String label;
  final String value;

  WePickerItem({
    @required this.label,
    @required this.value
  });
}

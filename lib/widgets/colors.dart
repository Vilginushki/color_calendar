import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker(
      {Key? key,
      required this.pickerColor,
      required this.onColorChanged,
      required this.onEditChanged,
      required this.texts})
      : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
  final List<Color> pickerColor;
  final ValueChanged<Color> onColorChanged;
  final ValueChanged<int> onEditChanged;
  final List<String> texts;
}

class _ColorPickerState extends State<ColorPicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
      GestureDetector(
        onTap: () {
          widget.onEditChanged(0);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  titlePadding: const EdgeInsets.all(0),
                  contentPadding: const EdgeInsets.all(0),
                  content: SingleChildScrollView(
                    child: MaterialPicker(
                      onColorChanged: widget.onColorChanged,
                      pickerColor: widget.pickerColor[0],
                      enableLabel: true,
                      portraitOnly: true,
                    ),
                  ),
                );
                Navigator.of(context).pop();
              });
          },
        child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.all(4),
            child: ColoredBox(
              color: widget.pickerColor[0],
            ),
          ),
          Text(widget.texts[0]),
        ],
      ),
    ),
    GestureDetector(
      onTap: () {
        widget.onEditChanged(1);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(0),
                contentPadding: const EdgeInsets.all(0),
                content: SingleChildScrollView(
                  child: MaterialPicker(
                    onColorChanged: widget.onColorChanged,
                    pickerColor: widget.pickerColor[1],
                    enableLabel: true,
                    portraitOnly: true,
                  ),
                ),
              );
            });
      },
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.all(4),
            child: ColoredBox(
              color: widget.pickerColor[1],
            ),
          ),
          Text(widget.texts[1]),
        ],
      ),
    ),
    GestureDetector(
      onTap: () {
        widget.onEditChanged(2);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(0),
                contentPadding: const EdgeInsets.all(0),
                content: SingleChildScrollView(
                  child: MaterialPicker(
                    onColorChanged: widget.onColorChanged,
                    pickerColor: widget.pickerColor[2],
                    enableLabel: true,
                    portraitOnly: true,
                  ),
                ),
              );
            });
      },
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.all(4),
            child: ColoredBox(
              color: widget.pickerColor[2],
            ),
          ),
          Text(widget.texts[2]),
        ],
      ),
    ),
    GestureDetector(
      onTap: () {
        widget.onEditChanged(3);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(0),
                contentPadding: const EdgeInsets.all(0),
                content: SingleChildScrollView(
                  child: MaterialPicker(
                    onColorChanged: widget.onColorChanged,
                    pickerColor: widget.pickerColor[3],
                    enableLabel: true,
                    portraitOnly: true,
                  ),
                ),
              );
            });
      },
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.all(4),
            child: ColoredBox(
              color: widget.pickerColor[3],
            ),
          ),
          Text(widget.texts[3]),
        ],
      ),
    ),
    GestureDetector(
      onTap: () {
        widget.onEditChanged(4);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(0),
                contentPadding: const EdgeInsets.all(0),
                content: SingleChildScrollView(
                  child: MaterialPicker(
                    onColorChanged: widget.onColorChanged,
                    pickerColor: widget.pickerColor[4],
                    enableLabel: true,
                    portraitOnly: true,
                  ),
                ),
              );
            });
      },
      child: Row(
        children: [
          Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.all(4),
            child: ColoredBox(
              color: widget.pickerColor[4],
            ),
          ),
          Text(widget.texts[4]),
        ],
      ),
    ),
      ],
    );
  }
}

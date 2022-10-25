import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Selector extends StatefulWidget {
  const Selector({Key? key, required this.colors, required this.texts})
      : super(key: key);

  @override
  State<Selector> createState() => _SelectorState();

  final List<Color> colors;
  final List<String> texts;
}

class _SelectorState extends State<Selector> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 320,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      print("X");
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          margin: EdgeInsets.only(right: 10),
                          child: ColoredBox(
                            color: widget.colors[index],
                          ),
                        ),
                        Text(widget.texts[index])
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Selector extends StatefulWidget {
  const Selector({Key? key, required this.colors, required this.texts, required this.day, required this.moods})
      : super(key: key);

  @override
  State<Selector> createState() => _SelectorState();



  final List<Color> colors;
  final List<String> texts;
  final DateTime day;
  final Map<DateTime, Mood> moods;
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
                      print(widget.texts[index]);
                      if(widget.moods.containsKey(widget.day)){
                        widget.moods.update(widget.day, (value) => Mood.values[index]);
                      }
                      else{
                        widget.moods.putIfAbsent(widget.day, () => Mood.values[index]);
                      }
                      print(widget.moods);
                      Navigator.of(context).pop();

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


enum Mood {v_good, good, funny, bad, tragedy}
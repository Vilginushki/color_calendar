import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Selector extends StatefulWidget {
  const Selector(
      {Key? key,
      required this.colors,
      required this.texts,
      required this.day,
      required this.moods})
      : super(key: key);

  @override
  State<Selector> createState() => _SelectorState();

  final List<Color> colors;
  final List<String> texts;
  final DateTime day;
  final Map<DateTime, int> moods;
}

class _SelectorState extends State<Selector> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
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
                    onTap: () async {
                      if (widget.moods.containsKey(widget.day)) {
                        widget.moods
                            .update(widget.day, (value) => index);
                      } else {
                        widget.moods
                            .putIfAbsent(widget.day, () => index);
                      }
                      //DEBUG ONLY
                      // print(widget.moods);
                      if(FirebaseAuth.instance.currentUser != null){
                        FirebaseFirestore db  = FirebaseFirestore.instance;
                        Map<String, int> temp = {};

                        widget.moods.forEach((k,v)=> temp.putIfAbsent(Timestamp.fromDate(k).millisecondsSinceEpoch.toString(), () => v));
                        db.collection("days").doc(FirebaseAuth.instance.currentUser?.uid.toString()).set({
                          "map":temp
                        });

                      }
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.only(right: 10),
                          child: ColoredBox(
                            color: widget.colors[index],
                          ),
                        ),
                        Text(widget.texts[index])
                      ],
                    ),
                  ),
                  const SizedBox(
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

// enum Mood { v_good, good, funny, bad, tragedy }
class Save{
  final Map<int, int>? mood;

  Save({
    this.mood
});

  factory Save.fromFirestore(DocumentSnapshot<Map<String,dynamic>> snapshot, SnapshotOptions? options){
    final data = snapshot.data();
    return Save(
      mood:
        data?["map"] is Iterable ? Map.from(data?["map"]) :null,
    );
  }

  Map<String, dynamic> toFirestore(){
    return{
      if(mood!=null) "map":mood,
    };
  }

}
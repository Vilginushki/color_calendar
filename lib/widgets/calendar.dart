import 'package:color_calendar/widgets/selector.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key, required this.pickerColor, required this.texts, required this.moods})
      : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
  final List<Color> pickerColor;
  final List<String> texts;
  final Map<DateTime, Mood> moods;
}

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TableCalendar(
          calendarBuilders:
              CalendarBuilders(defaultBuilder: (context, day, selectedDay) {
            if (((day.day < DateTime.now().day) && (day.month<=DateTime.now().month)|| day.month<DateTime.now().month)) {
              if(widget.moods.containsKey(day)){
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: (){

                              },
                              child: AlertDialog(
                                titlePadding: const EdgeInsets.all(0),
                                contentPadding: const EdgeInsets.all(0),
                                content: SingleChildScrollView(
                                    child: Selector(
                                        day:day,
                                        moods: widget.moods,
                                        colors: widget.pickerColor,
                                        texts: widget.texts)),
                              ),
                            );
                          }).then((_) =>setState((){}));
                    },
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: ColoredBox(
                        color: widget.pickerColor[widget.moods.entries.firstWhere((entry) => entry.key==day).value.index],
                      ),
                    ),
                  ),
                );
              }else{
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              titlePadding: const EdgeInsets.all(0),
                              contentPadding: const EdgeInsets.all(0),
                              content: SingleChildScrollView(
                                  child: Selector(
                                      day:day,
                                      moods: widget.moods,
                                      colors: widget.pickerColor,
                                      texts: widget.texts)),
                            );
                          }).then((_) =>setState((){}));
                    },
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: ColoredBox(
                        color: Colors.white
                      ),
                    ),
                  ),
                );
              }

            }
          }),
          headerStyle: const HeaderStyle(formatButtonVisible: false),
          startingDayOfWeek: StartingDayOfWeek.monday,
          calendarFormat: CalendarFormat.month,
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2010, 10, 10),
          lastDay: DateTime.utc(2030, 10, 10)),
    );
  }
}

import 'package:academ_gora_release/common/times_controller.dart';
import 'package:academ_gora_release/model/instructor.dart';
import 'package:academ_gora_release/model/workout.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';


import '../../../../main.dart';

class InstructorDataWidget extends StatefulWidget {
  final Instructor instructor;
  final DateTime selectedDate;

  const InstructorDataWidget(
    this.instructor, {
    Key? key,
    required this.selectedDate,
  }) : super(key: key);

  @override
  _InstructorDataWidgetState createState() => _InstructorDataWidgetState();
}

class _InstructorDataWidgetState extends State<InstructorDataWidget> {
  bool isExpanded = false;
  final ExpandableController _expandableController = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return _instructorWidget();
  }

  Widget _instructorWidget() {
    return ExpandablePanel(
      header: _header(),
      expanded: _body(),
      controller: _expandableController,
      collapsed: Container(),
    );
  }

  Widget _header() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(bottom: 6),
      height: 40,
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 8, right: 8),
            child: Text(
              widget.instructor.name ?? "Имя Фамилия",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: Text(
              widget.instructor.phone ?? '',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      width: screenWidth * 0.9,
      decoration: const BoxDecoration(color: Colors.white70),
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: buildWorkoutTable(),
      ),
    );
  }

  Widget buildWorkoutTable() {
    final filteredDayWorkOut=_sortWorkoutsBySelectedDate(widget.instructor.workouts!);
    return filteredDayWorkOut.isNotEmpty? Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10, right: 10),
      child: Table(
        border: TableBorder.all(color: Colors.black, width: 2),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(3),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: List.generate(
          filteredDayWorkOut.length,
          (index) => _tableRow(
            filteredDayWorkOut[index],
          ),
        ),
      ),
    ): Container(
      height: 30,
    );
  }


  TableRow _tableRow(Workout workout,
      {Color color = Colors.transparent, double leftPadding = 0}) {
    return TableRow(
      children: <Widget>[
        _textInTable(
          "${workout.from}",
        ),
        _textInTable(
          "${workout.peopleCount} человека",
        ),
        _textInTable(
          workout.workoutDuration == 1
              ? "${workout.workoutDuration} час"
              : "${workout.workoutDuration} часа",
        ),
        _textInTable(
          "${workout.userPhoneNumber}",
        ),
      ],
    );
  }

  Widget _textInTable(String text) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 1, top: 5, bottom: 5),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
      ),
    );
  }
  List<Workout> _sortWorkoutsBySelectedDate(List<Workout> list) {
    List<Workout> sortedWorkouts = [];
    if (list.isNotEmpty) {
      for (var workout in list) {
        String workoutDateString = workout.date!;
        String now = DateFormat('ddMMyyyy').format(widget.selectedDate);
        if (now == workoutDateString) sortedWorkouts.add(workout);
      }
    }
    return _sortWorkoutsByTime(sortedWorkouts);
  }

  List<Workout> _sortWorkoutsByTime(List<Workout> list) {
    TimesController timesController = TimesController();
    if (list.isNotEmpty) {
      list.sort((first, second) {
        return timesController.times[first.from] -
            timesController.times[second.from];
      });
    }
    return list;
  }



}

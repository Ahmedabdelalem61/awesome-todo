import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/pages/task%20cubit/task_cubit.dart';
import 'package:todo/pages/task%20cubit/task_states.dart';


class CalendarPage extends StatefulWidget {
  CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Text(
          'Calendar',
          style: GoogleFonts.lato(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<TaskCubit, TaskStates>(
        listener: (context, state) {
          if(state is LoadingAllTasksFromDatabase){
            TaskCubit.get(context).getTasksForPickedDay();
          }
        },
        builder: (context, state) {
          var taskCubit = TaskCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  getDatePicker(taskCubit),
                  const Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat.yMEd().format(taskCubit.selectedDate).split(',')[0],
                      ),
                      Text(
                        DateFormat.yMEd().format(taskCubit.selectedDate).split(',')[1],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        taskCubit.getTask(context, taskCubit.pickedTasks[index]),
                    itemCount: taskCubit.pickedTasks.length,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  getDatePicker(TaskCubit taskCubit) {
    return DatePicker(
      DateTime.now(),
      initialSelectedDate: taskCubit.selectedDate,
      selectionColor: Colors.green,
      selectedTextColor: Colors.white,
      dayTextStyle: GoogleFonts.lato(
        textStyle: const TextStyle(fontSize: 10),
      ),
      dateTextStyle: GoogleFonts.lato(
        textStyle: const TextStyle(fontSize: 15),
      ),
      monthTextStyle: GoogleFonts.lato(
        textStyle: const TextStyle(fontSize: 10),
      ),
      onDateChange: (date) {
          taskCubit.selectedDate = date;
          taskCubit.getTasksForPickedDay();
      },
    );
  }
}

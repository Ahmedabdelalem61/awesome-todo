import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/task.dart';
import 'package:todo/pages/common/common_component.dart';
import 'package:todo/pages/resource%20manager/router.dart';
import 'package:todo/pages/task%20cubit/task_states.dart';

import '../task cubit/task_cubit.dart';

class AddTaskPage extends StatelessWidget {
  

  /*
  [
                MyInputField(
                    textEditingController: _titleController,
                    title: 'Title',
                    hint: 'Enter title name'),
                MyInputField(
                  title: 'Date',
                  hint: DateFormat.yMEd().format(_taskCubit.date),
                  widget: _getIconButton(context, _taskCubit)
                ),
                MyInputField(
                  title: 'Start Time',
                  hint: _taskCubit.startTime,
                  widget: _getTimePicker(true, context, _taskCubit)
                ),
                MyInputField(
                  title: 'End Time',
                  hint: _taskCubit.endTime,
                  widget: _getTimePicker(false, context, _taskCubit)
                ),
                MyInputField(
                  title: 'Reminder',
                  hint: _taskCubit.repeatingType,
                  widget: _getDrodDownMenue(_taskCubit)
                ),
              ]
  */

  final TextEditingController _titleController = TextEditingController();

  AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var _taskCubit = TaskCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            title: Text(
              'Add task',
              style: GoogleFonts.lato(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyInputField(
                    textEditingController: _titleController,
                    title: 'Title',
                    hint: 'Enter title name'),
                    MyInputField(
                  title: 'Date',
                  hint: DateFormat.yMEd().format(_taskCubit.date),
                  widget: _taskCubit.getIconButton(context)
                ),
                MyInputField(
                  title: 'Start Time',
                  hint: _taskCubit.startTime,
                  widget: _taskCubit.getTimePicker(true, context)
                ),
                MyInputField(
                  title: 'End Time',
                  hint: _taskCubit.endTime,
                  widget: _taskCubit.getTimePicker(false, context)
                ),
                MyInputField(
                  title: 'Reminder',
                  hint: _taskCubit.repeatingType,
                  widget: _taskCubit.getDrodDownMenue()
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          bottomSheet: Container(
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            child: CustomMaterailButton(
              borderRadious: 15,
              callback: () {
                //todo add to datebase after validation
                if (_titleController.text.isNotEmpty &&
                    _taskCubit.date != null &&
                    _taskCubit.startTime.isNotEmpty &&
                    _taskCubit.endTime.isNotEmpty) {
                  Navigator.pushNamed(context, Routes.viewBoard);
                  TaskCubit.get(context).addTaskToDatabase(Task(
                      title: _titleController.text,
                      date: _taskCubit.date.toString(),
                      start: _taskCubit.startTime,
                      end: _taskCubit.endTime,
                      reminder: _taskCubit.actualNeededTimeForRepeating,
                      favourite: 0,
                      completed: 0,
                      id: 0));
                } else {
                  //todo validate
                }
              },
              buttonColor: Colors.green,
              width: double.infinity,
              child: const Text(
                'Create task',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
    );
  }
  }



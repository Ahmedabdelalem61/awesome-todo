import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/pages/task%20cubit/task_states.dart';
import 'package:todo/services/local_database.dart';

import '../../models/task.dart';

class TaskCubit extends Cubit<TaskStates> {
  TaskCubit() : super(TaskInitialState());

  static TaskCubit get(context) => BlocProvider.of<TaskCubit>(context);

  List<Task> tasks = [];
  List<Task> todo = [];
  List<Task> completed = [];
  List<Task> favourite = [];

  String repeatingType = '1 day before';
  String startTime = '9:00 AM';
  String endTime = '11:00 AM';
  DateTime date = DateTime.now();
  int actualNeededTimeForRepeating =
      60 * 60 * 12; //time needed for alarm by seconds
      DateTime selectedDate = DateTime.now();
  List<Task> pickedTasks = [];

  getTasksFromDateBase() async {
    tasks = [];
    todo = [];
    completed = [];
    favourite = [];
    
    List<Map<String, dynamic>>? table = await LocalDatabase.getData();
    tasks.addAll(table!.map((taskMap) => Task.fromJson(taskMap)).toList());
    completed.addAll(tasks.where((task) => task.completed == 1));
    favourite.addAll(tasks.where((task) => task.favourite == 1));
    todo.addAll(tasks.where((task) => task.completed == 0));
    emit(LoadingAllTasksFromDatabase());
    for(Task task in tasks){
      print('${task.title} ${task.completed} ${task.favourite} ${task.date} ' );
    }
  }

   getTasksForPickedDay() {
    pickedTasks =[];
    pickedTasks.addAll(tasks.where((task) => task.date!.split(' ')[0]==selectedDate.toString().split(' ')[0]).toList());
    emit(PickedDayTasksState());
  }

  addTaskToDatabase(Task task) async {
    await LocalDatabase.insertRaw(task);
    emit(NewTaskAddedState());
    await getTasksFromDateBase();
  }

  updateTask(Task task,Map<String,dynamic> updatedValue) async {
    await LocalDatabase.update(task,updatedValue);
    await getTasksFromDateBase();
    emit(ExistingTaskUpdatedState());
  }

  removeTask(Task task) async {
    await LocalDatabase.delete(task);
    await getTasksFromDateBase();
    emit(RemoveTaskState());
  }

  showTimePicer(
    BuildContext context, {
    bool? start,
  }) async {
    TimeOfDay? timeOfDay = await showTimePicker(
        context: context, initialTime: TimeOfDay(hour: 9, minute: 0));
    String formatted = await timeOfDay!.format(context);

    if (start == true) {
      startTime = formatted.toString();
    } else if (start == false) {
      endTime = formatted.toString();
    }
    emit(SelectingTimeState());
  }

  getIconButton(BuildContext context) => IconButton(
        color: Colors.grey[500],
        onPressed: () async {
          DateTime? _pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2018),
              lastDate: DateTime(2025));
          if (_pickedDate != null) {
            date = _pickedDate;
          }
          emit(SelectingDateState());
        },
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
      );

  getTimePicker(bool start, BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.access_alarm),
      onPressed: () {
        showTimePicer(context, start: start);
      },
    );
  }

  final dynamic _dropDownMenueItems = const [
    DropdownMenuItem(
      value: RepeatingType.day,
      child: Text('day before'),
    ),
    DropdownMenuItem(
      value: RepeatingType.hour,
      child: Text('hour before'),
    ),
    DropdownMenuItem(
      value: RepeatingType.thirtyMin,
      child: Text('30 min before'),
    ),
    DropdownMenuItem(
      value: RepeatingType.tenMin,
      child: Text('10 min before'),
    ),
  ];

  DropdownButton getDrodDownMenue() {
    return DropdownButton(
        elevation: 0,
        underline: Container(height: 0),
        items: _dropDownMenueItems,
        onChanged: (item) {
          /////////////
          switch (item) {
            case RepeatingType.day:
              repeatingType = '1 day';
              actualNeededTimeForRepeating = 60 * 60 * 12;
              break;
            case RepeatingType.hour:
              repeatingType = 'hour';
              actualNeededTimeForRepeating = 60 * 60;
              break;
            case RepeatingType.thirtyMin:
              repeatingType = '30 min';
              actualNeededTimeForRepeating = 60 * 30;
              break;
            case RepeatingType.tenMin:
              repeatingType = '10 min';
              actualNeededTimeForRepeating = 10 * 60;
              break;
          }
          emit(RepeatingTimeState());
        });
  }

  getTask(BuildContext context, Task task) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          getcheckBox(task),
          const SizedBox(
            width: 25,
          ),
          Text(task.title!),
          Spacer(),
          getPopUpMenuButton(task),
        ],
      ),
    );
  }

  getcheckBox(Task task) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.greenAccent;
      }
      //color that fill the box
      return Colors.white;
    }

    return Checkbox(
        overlayColor: MaterialStateProperty.resolveWith(getColor),
        side: const BorderSide(
          style: BorderStyle.solid,
          color: Colors.green,
        ),
        checkColor: Colors.green,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: task.completed == 1 ? true : false,
        onChanged: (bool? value) {
          if (value == true) {
            updateTask(task,{'completed':1});
          }
          if (value == false) {
            updateTask(task,{'completed':0});
          }
          emit(ExistingTaskUpdatedState());
        });
  }

  getPopUpMenuButton(Task task) {
    return PopupMenuButton(
        onSelected: (value) {
          if (value == TaskType.addToFavourites) {
            updateTask(task,{'favourite':1});
          } else if (value == TaskType.remove) {
            removeTask(task);
          }
          emit(ExistingTaskUpdatedState());
        },
        itemBuilder: (context) => [
              const PopupMenuItem(
                value: TaskType.addToFavourites,
                child: Text('add to favourite'),
              ),
              const PopupMenuItem(
                value: TaskType.remove,
                child: Text('remove'),
              ),
            ]);
  }
}

enum TaskType { remove, addToFavourites }

enum RepeatingType { day, hour, thirtyMin, tenMin }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/pages/add%20task/add_task.dart';
import 'package:todo/pages/board/board_view.dart';
import 'package:todo/pages/calendar/calendar_page.dart';

import '../task cubit/task_cubit.dart';

class Routes {
  static const String viewBoard = '/';
  static const String calendar = 'calendar';
  static const String addTask = 'addTask';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    final TaskCubit taskCubit = TaskCubit();
    switch (settings.name) {
      case Routes.viewBoard:
        return MaterialPageRoute(
            builder: (context) => BlocProvider<TaskCubit>.value(
                value: taskCubit..getTasksFromDateBase(),
                child: const BoardView()));
      case Routes.addTask:
        return MaterialPageRoute(
            builder: (context) =>
                BlocProvider.value(value: taskCubit, child: AddTaskPage()));
      case Routes.calendar:
        return MaterialPageRoute(
            builder: (context) => 
             BlocProvider.value(
                value: taskCubit..getTasksFromDateBase()..getTasksForPickedDay(), child:  CalendarPage()));
    }
    return MaterialPageRoute(
        builder: (context) => const Scaffold(
              body: Center(
                child: Text('wrong path'),
              ),
            ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/pages/common/common_component.dart';
import 'package:todo/pages/resource%20manager/router.dart';
import 'package:todo/pages/task%20cubit/task_states.dart';

import '../task cubit/task_cubit.dart';

class BoardView extends StatelessWidget {
  const BoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: BlocConsumer<TaskCubit, TaskStates>(
          listener: (context, state) {
          if (state is NewTaskAddedState) {
            TaskCubit.get(context).getTasksFromDateBase();
          }
        }, builder: (context, state) {
          var _taskCubit = TaskCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              title: Text(
                'Board',
                style: GoogleFonts.lato(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                ),
              ),
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.calendar);
                  },
                  icon: const Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                ),
              ],
              bottom: TabBar(
                automaticIndicatorColorAdjustment: true,
                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                //padding: EdgeInsets.symmetric(horizontal: 7),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Colors.grey,
                tabs: [
                  Text(
                    'All',
                    style: Theme.of(context).tabBarTheme.labelStyle,
                  ),
                  Text(
                    'completed',
                    style: Theme.of(context).tabBarTheme.labelStyle,
                  ),
                  Text(
                    'todo',
                    style: Theme.of(context).tabBarTheme.labelStyle,
                  ),
                  Text(
                    'favourite',
                    style: Theme.of(context).tabBarTheme.labelStyle,
                  ),
                ],
              ),
            ),
            body: TabBarView(
              physics: const BouncingScrollPhysics(),
              children: [
                ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => _taskCubit.getTask(context, _taskCubit.tasks[index]),
                    itemCount: _taskCubit.tasks.length),
                ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => _taskCubit.getTask(context, _taskCubit.completed[index]),
                    itemCount: _taskCubit.completed.length),
                ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => _taskCubit.getTask(context, _taskCubit.todo[index]),
                    itemCount: _taskCubit.todo.length),
                ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => _taskCubit.getTask(context, _taskCubit.tasks[index]),
                    itemCount: _taskCubit.favourite.length),
              ],
            ),
            bottomSheet: Container(
              padding: EdgeInsets.all(15),
              color: Colors.white,
              child: CustomMaterailButton(
                borderRadious: 15,
                callback: () {
                  Navigator.pushNamed(context, Routes.addTask);
                },
                buttonColor: Colors.green,
                width: double.infinity,
                child: const Text(
                  'add Task',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        }));
  }
}

import 'package:flutter/material.dart';
import 'package:todo/pages/common/theme_manager.dart';
import 'package:todo/pages/resource%20manager/router.dart';
import 'package:todo/services/local_database.dart';
import 'package:todo/services/notification_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDatabase.initDataBase();
  await NotificationHelper().initializeNotification();
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.viewBoard,
    );
  }
}


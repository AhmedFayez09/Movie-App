import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qeema_task/app.dart';
import 'package:qeema_task/src/core/config/routes/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

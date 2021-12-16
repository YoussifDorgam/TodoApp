import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todoap/blocObservar/blocObservar.dart';
import 'package:todoap/layout/material_Home.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

   return MaterialApp(
     debugShowCheckedModeBanner: false,
     home:HomeLayout() ,
    );
  }
}
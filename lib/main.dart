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
     theme: ThemeData(
       primarySwatch: Colors.deepOrange,
       scaffoldBackgroundColor: Colors.white,
     ),
     debugShowCheckedModeBanner: false,
     home:HomeLayout() ,
    );
  }
}
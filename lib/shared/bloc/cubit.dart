import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoap/models/arshevd_Screen/arshevd_screen.dart';
import 'package:todoap/models/done_Screen/done_screen.dart';
import 'package:todoap/models/tasks_Screen/tasks.dart';
import 'package:todoap/shared/bloc/status.dart';
import 'package:todoap/shared/combonants/constance.dart';

class bloc extends Cubit<appstatus> {
  bloc() : super(appinitialsyatus());

  static bloc get(context) => BlocProvider.of(context);
  late int currentIndex = 0;
  late Database database;

  List<Map> newtasks = [];
  List<Map> donetasks = [];
  List<Map> archivetasks = [];

  List<Widget> models = [
    Tasks(),
    done(),
    Archived(),
  ];

  void navchange(int index) {
    currentIndex = index;
    emit(appchange_navbarstatus());
  }

//عمل كرييت لملف ال sqflite وعمل  creat لل Table
  void CreatDatabase() {
    openDatabase(
      'dataAAb.db',
      version: 1,
      onCreate: (database, version) async {
        print('database created');
        await database
            .execute(
                'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT , data TEXT , time TEXT ,status TEXT )')
            .then((value) {
          print('Table created');
        }).catchError((error) {
          print('Table is error ${error.toString()}');
        });
      },
      onOpen: (database) {
        getdatafromdatabase(database);
        print('Opened database');
      },
    ).then((value) {
      database = value;
      emit(Appcreatdatabasestate());
    });
  }

//حفظ المعلومات داخل الداتا بيز
  Future inserToDatabase({
    required String title,
    required String data,
    required String time,
  }) async {
    return await database.transaction((txn) async {
      return await txn
          .rawInsert(
              'INSERT INTO tasks(title ,data,time,status) VALUES("$title" ,"$data","$time","new")')
          .then((value) {
        emit(Appinsertdatabasestate());
        print('$value data inserted successful');
        getdatafromdatabase(database);
        emit(Appgetdatabasestate());
      }).catchError((error) {
        print('data inserted error is ${error.toString()}');
      });
    });
  }

  void getdatafromdatabase(database) {
    newtasks = [];
    donetasks = [];
    archivetasks = [];
    database.rawQuery('SELECT * FROM tasks').then((value) {
      emit(Appgetdatabasestate());
      value.forEach((element) {
        if (element['status'] == 'new')
          newtasks.add(element);
        else if (element['status'] == 'done')
          donetasks.add(element);
        else
          archivetasks.add(element);
      });
    });
  }

  IconData iconData = Icons.edit;
  bool openShowMottom = false;

  void showbottomsheeat({
    required IconData icon,
    required bool isShow,
  }) {
    iconData = icon;
    openShowMottom = isShow;
    emit(Appchangiconstate());
  }

  void updatedatabase({
    required String status,
    required int id,
  }) {
    database.rawUpdate('UPDATE tasks SET status = ?  WHERE id = ?',
        ['$status', id]).then((value) {
      getdatafromdatabase(database);
      emit(Appapdetdatabasestate());
    });
  }

  void deletdatabase({
    required int id,
  }) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getdatafromdatabase(database);
      emit(AppDeletdatabasestate());
    });
  }
}

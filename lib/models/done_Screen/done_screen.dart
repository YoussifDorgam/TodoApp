import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoap/shared/bloc/cubit.dart';
import 'package:todoap/shared/bloc/status.dart';
import 'package:todoap/shared/combonants/componants.dart';

class done extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<bloc, appstatus>(
        listener: (context, status) {},
        builder: (context, status) {
          var cubit = bloc.get(context).donetasks;
          return buildTaskItem(cubit: cubit);
        });
  }
}

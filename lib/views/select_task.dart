import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/bloc/tiles_data_bloc.dart';
import 'package:tasks_app/utils/common_widget.dart';
import 'package:tasks_app/views/color_strip_screen.dart';
import 'package:tasks_app/views/tiles_screen.dart';

import '../bloc/color_strip_bloc.dart';
import '../mixins/button_mixin.dart';

class SelectTask extends StatelessWidget with BlackRoundedButtonMixin {
  const SelectTask({super.key});

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        body: Center(
      child: SizedBox(
        height: mediaQuery.height / 1.5,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonWidgets.textWidget("Select task to test"),
              getBlackRoundedButton(
                  text: "Task 1 - Tiles App",
                  borderRadius: 20,
                  width: mediaQuery.width,
                  height: 200,
                  onPressed: () {
                    print("1 pressed");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider<TilesDataBloc>(
                                create: (context) => TilesDataBloc(),
                                child: const TilesScreen())));
                  }),
              getBlackRoundedButton(
                  text: "Task 2 - Color Strip",
                  borderRadius: 20,
                  width: mediaQuery.width,
                  height: 200,
                  onPressed: () {
                    print("2 pressed");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider<ColorStripBloc>(
                                create: (context) => ColorStripBloc(),
                                child: ColorStrip())));
                  })
            ],
          ),
        ),
      ),
    ));
  }
}

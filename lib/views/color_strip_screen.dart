import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/bloc/color_strip_bloc.dart';
import 'package:tasks_app/models/color_categories.dart';
import 'package:tasks_app/views/widgets/color_strip_list.dart';

import '../events/color_strip_event.dart';
import '../states/color_strip_state.dart';
import '../utils/common_widget.dart';

class ColorStrip extends StatefulWidget {
  ColorStrip({super.key});

  @override
  State<ColorStrip> createState() => _ColorStripState();
}

class _ColorStripState extends State<ColorStrip> {

  late ColorStripBloc colorStripBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colorStripBloc = BlocProvider.of<ColorStripBloc>(context);
    colorStripBloc.add(AddData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ColorStripBloc, ColorStripStates>(
            bloc: BlocProvider.of<ColorStripBloc>(context),
            builder: (context, state) {
              if (state is DataLoading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state is DataSuccess) {
                return ColorStripList(
                  colorStripBloc: colorStripBloc,
                );
              } else if (state is DataFailure) {
                return Center(child: CommonWidgets.textWidget("Error : ${state.errorMsg}"));
              } else {
                return Container();
              }
            }));
  }
}

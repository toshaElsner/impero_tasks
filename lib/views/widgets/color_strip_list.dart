import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks_app/bloc/color_strip_bloc.dart';
import 'package:tasks_app/events/color_strip_event.dart';
import 'package:tasks_app/utils/common_widget.dart';

import '../../utils/colors.dart';

class ColorStripList extends StatelessWidget {
  final ColorStripBloc colorStripBloc;

  const ColorStripList({super.key, required this.colorStripBloc});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: ListView.builder(
          itemCount: colorStripBloc.categories.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                /// Left selected color widget
                CommonWidgets.sizedBoxW10,
                VerticalDividerWidget(),
                Container(
                  color: colorStripBloc
                      .categories[index]
                      .colors![
                          colorStripBloc.categories[index].selectedColorIndex!]
                      .keys
                      .first,
                  width: 30,
                  height: 20,
                ),
                VerticalDividerWidget(),
                /// Listing of categories
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [headingRow(index), colorsRow(index)],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget headingRow(index) {
    return Row(
      children: [
        CommonWidgets.textWidget(colorStripBloc.categories[index].catName!,
            fontWeight: FontWeight.bold),
        const Spacer(),
        Container(
          width: 80.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(3.0),
            border: Border.all(
              color: AppColors.blackColor,
              width: 2.0,
            ),
          ),
          child: Center(
            child: colorStripBloc.categories[index].selectedColorIndex! <= 4
                ? CommonWidgets.smallTextWidget(colorStripBloc
                    .categories[index]
                    .colors![
                        colorStripBloc.categories[index].selectedColorIndex!]
                    .values
                    .toString())
                : Container(),
          ),
        )
      ],
    );
  }

  Widget colorsRow(index) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: colorStripBloc.categories[index].colors!.map((e) {
          Color color = e.keys.first;
          int value = e.values.first;
          int i = colorStripBloc.categories[index].colors!.indexOf(e);

          return InkWell(
            onTap: () {
              /// Updates value
              colorStripBloc.add(ChangeData(index, i));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    Container(
                        width: 50,
                        height: 20,
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(3))),
                    CommonWidgets.textWidget(value.toString())
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class VerticalDividerWidget extends StatelessWidget {

  VerticalDividerWidget();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 100, color: AppColors.greyColor);
  }

}

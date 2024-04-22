import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/states/tiles_data_state.dart';

import '../bloc/tiles_data_bloc.dart';
import '../events/tiles_data_event.dart';
import '../models/tiles_category_model.dart';
import '../utils/colors.dart';
import '../utils/common_widget.dart';

class TilesScreen extends StatefulWidget {
  const TilesScreen({super.key});

  @override
  State<TilesScreen> createState() => _TilesScreenState();
}

class _TilesScreenState extends State<TilesScreen>
    with TickerProviderStateMixin {
  late TilesDataBloc tilesDataBloc;
  late TabController tabController;
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  int catId = 59;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tilesDataBloc = BlocProvider.of<TilesDataBloc>(context);
    tilesDataBloc.add(GetCategories(context));
    paginatingSubCategories();
  }

  /// Pagination
  paginatingSubCategories() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        tilesDataBloc.add(GetSubCategories(context, page++, catId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TilesDataBloc, TilesDataStates>(
        bloc: BlocProvider.of<TilesDataBloc>(context),
        builder: (context, state) {
          if (state is TilesDataLoading) {
            return const Scaffold(
                body: Center(child: CupertinoActivityIndicator()));
          } else if (state is TilesDataSuccess) {
            tabController = TabController(
                length: tilesDataBloc.categories!.length, vsync: this);
            return DefaultTabController(
              length: tilesDataBloc.categories!.length,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.blackColor,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back,color: AppColors.whiteColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: const [
                    Icon(Icons.filter_alt_outlined, color: AppColors.whiteColor),
                    CommonWidgets.sizedBoxW10,
                    Icon(Icons.search, color: AppColors.whiteColor)
                  ],
                  bottom: TabBar(
                      isScrollable: true,
                      labelStyle: const TextStyle(color: AppColors.whiteColor),
                      unselectedLabelStyle:
                          const TextStyle(color: AppColors.whiteColor),
                      indicatorColor: AppColors.whiteColor,
                      tabs: tilesDataBloc.categories!
                          .map((e) => Tab(
                                text: e.name,
                              ))
                          .toList()),
                ),

                /// TabBar View
                body: TabBarView(
                    children: tilesDataBloc.categories!
                        .map((e) => buildView(e))
                        .toList()),
              ),
            );
          } else if (state is TilesDataFailure) {
            return Scaffold(
                body: Center(
                    child:
                        CommonWidgets.textWidget(state.errorMsg.toString())));
          } else {
            return Scaffold(
                body: Center(child: CommonWidgets.textWidget("No data")));
          }
        });
  }

  /// View on click of different tabs
  Widget buildView(Category data) {
    List<SubCategories>? subCat;
    if (data.subCategories != null) {
      subCat = page == 1
          ? (data.subCategories ?? [])
          : (tilesDataBloc.subCategories);
    }
    if (subCat == null) {
      return Center(child: CommonWidgets.textWidget("No data"));
    } else {
      if (tilesDataBloc.subCategories.isNotEmpty) {
        print(
            "tilesDataBloc.subCategories = ${tilesDataBloc.subCategories[0].name}");
      }
      if (subCat.isNotEmpty) {
        return ListView.builder(
            controller: _scrollController,
            itemCount: subCat.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonWidgets.textWidget(subCat![index].name!,
                        fontWeight: FontWeight.bold),
                    subCat[index].product!.isNotEmpty
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: subCat[index].product!.map((product) {
                                return SizedBox(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Image.network(product.imageName!,
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.fill),
                                            Positioned(
                                                child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  color: Colors.yellow),
                                              child:
                                                  CommonWidgets.smallTextWidget(
                                                      product.priceCode
                                                          .toString()),
                                            ))
                                          ],
                                        ),
                                        CommonWidgets.smallTextWidget(
                                            product.name!)
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        : Center(child: CommonWidgets.textWidget("No products"))
                  ],
                ),
              );
            });
      } else {
        return Center(child: CommonWidgets.textWidget("No subcategories"));
      }
    }
  }
}

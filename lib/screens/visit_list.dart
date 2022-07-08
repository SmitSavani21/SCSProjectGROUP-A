// ignore_for_file: file_names, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:health_app/models/visit_module.dart';

import 'visit_module.dart';

class VisitListModule extends StatefulWidget {
  const VisitListModule({Key? key, required this.list}) : super(key: key);
  final List<VisitModel> list;
  @override
  _VisitListModuleState createState() => _VisitListModuleState();
}

class _VisitListModuleState extends State<VisitListModule> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return StaggeredGridView.countBuilder(
        mainAxisSpacing: height * 0.02,
        crossAxisSpacing: width * 0.04,
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          return VisitModule(
            model: widget.list[index],
          );
        },
        staggeredTileBuilder: (index) {
          return StaggeredTile.fit(2);
        });
  }
}

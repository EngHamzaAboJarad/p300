import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../global_features/color_manager.dart';

class PrimaryTable extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  const PrimaryTable({
    Key? key,
    required this.columns,
    required this.rows,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.secondaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: DataTable2(
        dataRowHeight: 130.h,
        columnSpacing: 15,
        minWidth: 300,
        columns: columns,
        rows: rows,
      ),
    );
  }
}

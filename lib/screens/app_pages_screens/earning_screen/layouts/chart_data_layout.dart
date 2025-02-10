import 'package:flutter/material.dart';

import '../../../../config.dart';

class ChartDataLayout extends StatelessWidget {
  final CategoryEarnings? data;
final int? index;
  const ChartDataLayout({super.key,this.data, this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          const SizedBox(
              height: 3,
              width: 9
          ).decorated(color:  index == 0
              ? Color(0xFF5465FF)
              : index == 1
              ? Color(0xFF7482FD)
              : index == 2
              ? Color(0xFF949FFC)
              : index == 3
              ? Color(0xFFB5BCFA)
              : Color(0xFFB5BCFA),borderRadius: const BorderRadius.all(Radius.circular(10))),
          const HSpace(Sizes.s7),
          Expanded(child: Text("${data!.categoryName!} (${data!.percentage!}%)",style: appCss.dmDenseRegular12.textColor(appColor(context).appTheme.darkText)))
        ]
    );
  }
}

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:multi_select_flutter/util/horizontal_scrollbar.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../config.dart';

class CategorySelectionLayout extends StatefulWidget {
  const CategorySelectionLayout({super.key});

  @override
  State<CategorySelectionLayout> createState() =>
      _CategorySelectionLayoutState();
}

class _CategorySelectionLayoutState extends State<CategorySelectionLayout> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AddNewServiceProvider>(builder: (context1, value, child) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: Sizes.s20),
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.s15, vertical: Sizes.s10),
        decoration: ShapeDecoration(
            color: appColor(context).appTheme.whiteBg,
            shape: SmoothRectangleBorder(
                borderRadius:
                    SmoothBorderRadius(cornerRadius: 8, cornerSmoothing: 1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(eSvgAssets.categorySmall,
                          colorFilter: ColorFilter.mode(
                              value.categories.isNotEmpty
                                  ? appColor(context).appTheme.darkText
                                  : appColor(context).appTheme.lightText,
                              BlendMode.srcIn))
                      .padding(
                          left: Insets.i5,
                          right: rtl(context) ? Insets.i5 : 0,
                          top: Sizes.s5,
                          vertical: Sizes.s5),
                  const HSpace(Sizes.s12),
                  if (value.categories.isNotEmpty)
                    Expanded(
                      child: Wrap(
                          direction: Axis.horizontal,
                          children: value.categories
                              .asMap()
                              .entries
                              .map((e) => Container(
                                      margin:  EdgeInsets.only(bottom: value.categories.length -1 != e.key? Sizes.s8:0,right: Sizes.s5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: Sizes.s9,
                                          vertical: Sizes.s5),
                                      decoration: ShapeDecoration(
                                          shape: SmoothRectangleBorder(
                                            borderRadius: SmoothBorderRadius(
                                                cornerRadius: 8,
                                                cornerSmoothing: 1),
                                          ),
                                          color: Color.fromRGBO(84, 101, 255, 0.1)),
                                      child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SvgPicture.asset(eSvgAssets.cross,height: 16,colorFilter: ColorFilter.mode(appColor(context).appTheme.primary, BlendMode.srcIn),),
                                        const HSpace(Sizes.s2),
                                        Text(e.value.title!,
                                            style: appCss.dmDenseLight14
                                                .textColor(appColor(context)
                                                    .appTheme
                                                    .primary))
                                      ]))
                                  .inkWell(
                                      onTap: () => value.onChangeCategory(
                                          e.value, e.value.id)))
                              .toList()),
                    ),
                  if (value.categories.isEmpty)
                    Text(language(context, appFonts.categories),
                        style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.lightText))
                ],
              ),
            ),
            SvgPicture.asset(eSvgAssets.dropDown,
                colorFilter: ColorFilter.mode(
                    value.categories.isNotEmpty
                        ? appColor(context).appTheme.darkText
                        : appColor(context).appTheme.lightText,
                    BlendMode.srcIn))
          ],
        ),
      ).inkWell(onTap: () => value.onBottomSheet(context));

    });
  }
}

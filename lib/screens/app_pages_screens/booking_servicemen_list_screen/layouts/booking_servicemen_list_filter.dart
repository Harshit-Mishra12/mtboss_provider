import 'package:flutter/cupertino.dart';
import '../../../../config.dart';

class BookingServicemenListFilter extends StatelessWidget {
  const BookingServicemenListFilter({super.key});

  @override
  Widget build(BuildContext context) {

    return  Consumer<BookingServicemenListProvider>(
        builder: (context1, value, child) {
        return SizedBox(
            height: MediaQuery.of(context).size.height / 1.23,
            child: SingleChildScrollView(
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text(language(context, "${language(context, appFonts.filterBy)} (1)"),
                      style: appCss.dmDenseBold18
                          .textColor(appColor(context).appTheme.darkText)),
                  const Icon(CupertinoIcons.multiply)
                      .inkWell(onTap: () => route.pop(context))
                ]).paddingSymmetric(horizontal: Insets.i20),
                Text(language(context, appFonts.showMemberSince),
                        style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.lightText))
                    .padding(
                        horizontal: Insets.i20,
                        top: Insets.i10,
                        bottom: Insets.i15),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(language(context, appFonts.year),
                      style: appCss.dmDenseMedium14
                          .textColor(appColor(context).appTheme.darkText)),
                  const VSpace(Sizes.s6),
                  DropDownLayout(
                      hintText: appFonts.selectYear,
                      icon: eSvgAssets.calender,
                      val: value.yearValue,
                      isIcon: true,
                      categoryList: appArray.jobExperienceList,
                      onChanged: (val) => value.onTapYear(val))
                ])
                    .paddingAll(AppRadius.r15)
                    .boxShapeExtension(
                        color: appColor(context).appTheme.fieldCardBg)
                    .paddingSymmetric(horizontal: Insets.i20),
                Text(language(context, appFonts.rates),
                        style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.lightText))
                    .padding(
                        horizontal: Insets.i20,
                        top: Insets.i10,
                        bottom: Insets.i15),
                ...appArray.ratingList
                    .asMap()
                    .entries
                    .map((e) => RatingBarLayout(
                        index: e.key,
                        data: e.value,
                        selectedIndex: value.selectedRates.contains(e.key),
                        onTap: () => value.onTapRating(e.key)))
                    ,
                BottomSheetButtonCommon(
                        textOne: appFonts.clearAll,
                        textTwo: appFonts.apply,
                        applyTap: ()=> value.applyTap(context),
                        clearTap: ()=> value.onClearTap(context))
                    .padding(horizontal: Insets.i20,top: Insets.i10)
              ]).paddingSymmetric(vertical: Insets.i20)
            )).bottomSheetExtension(context);
      }
    );
  }
}

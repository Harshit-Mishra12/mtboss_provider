import 'package:flutter/services.dart';

import '../../../../config.dart';
import 'category_selection.dart';

class FormCategoryLayout extends StatelessWidget {
  const FormCategoryLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<AddNewServiceProvider>(context);
    return Column(children: [
      ContainerWithTextLayout(title: language(context, appFonts.categories))
          .paddingOnly(top: Insets.i24, bottom: Insets.i12),
      const CategorySelectionLayout(),
      ContainerWithTextLayout(
              title: language(context, appFonts.applicableCommission))
          .paddingOnly(top: Insets.i24, bottom: Insets.i12),
      Column(children: [
        Container(
            decoration: ShapeDecoration(
                color: appColor(context).appTheme.stroke,
                shape: RoundedRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                        cornerRadius: AppRadius.r8, cornerSmoothing: 0))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    SvgPicture.asset(eSvgAssets.commission,
                        colorFilter: ColorFilter.mode(
                            appColor(context).appTheme.lightText,
                            BlendMode.srcIn)),
                    const HSpace(Sizes.s10),
                    Text("${value.commission}%",
                        style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.lightText))
                  ]),
                  Text(language(context, appFonts.percentage),
                      style: appCss.dmDenseRegular12
                          .textColor(appColor(context).appTheme.lightText))
                ]).paddingAll(Insets.i15)),
        const VSpace(Sizes.s2),
        Text(language(context, appFonts.noteHighest),
            style: appCss.dmDenseMedium12
                .textColor(appColor(context).appTheme.red))
      ]).paddingSymmetric(horizontal: Insets.i20),
      ContainerWithTextLayout(
              title: language(context, appFonts.perServicemanCommission))
          .paddingOnly(top: Insets.i24, bottom: Insets.i12),
      TextFieldCommon(
        keyboardType: TextInputType.number,
        focusNode: value.perServicemanCommissionFocus,
        controller: value.perServicemanCommission,
        hintText: appFonts.perServicemanCommission,
        prefixIcon: eSvgAssets.commission,
      ).paddingSymmetric(horizontal: Insets.i20),
      ContainerWithTextLayout(title: language(context, appFonts.location))
          .paddingOnly(top: Insets.i24, bottom: Insets.i12),
      Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: Sizes.s20),
        padding: const EdgeInsets.symmetric(horizontal: Sizes.s20,vertical: Sizes.s20),
        decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                  cornerRadius: 8,cornerSmoothing: 1
              )
          ),
          color: appColor(context).appTheme.whiteBg,

        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            value.areaData == null?
            Text(language(context, appFonts.location),style:  appCss.dmDenseMedium14
                .textColor(appColor(context).appTheme.lightText)): Expanded(
              child: Text(value.areaData!,style:  appCss.dmDenseMedium14
                  .textColor(appColor(context).appTheme.darkText),),
            ),
            SvgPicture.asset(eSvgAssets.locationOut).inkWell(onTap: ()=> value.getLocation(context))
          ],
        ).marginOnly(bottom: Sizes.s10),
      ),
      ContainerWithTextLayout(title: language(context, appFonts.description))
          .paddingOnly(top: Insets.i24, bottom: Insets.i12),
      CommonDescriptionBox(
          focusNode: value.descriptionFocus, description: value.description),
      ContainerWithTextLayout(
              title: language(context, appFonts.timeForCompletion))
          .paddingOnly(top: Insets.i24, bottom: Insets.i12),
      Row(children: [
        Expanded(
            flex: 2,
            child: TextFieldCommon(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp("[1-9]")),
                ],
                focusNode: value.durationFocus,
                controller: value.duration,
                hintText: appFonts.addServiceTime,
                prefixIcon: eSvgAssets.timer)),
        const HSpace(Sizes.s6),
        Expanded(
            child: DarkDropDownLayout(
                isBig: true,
                val: value.durationValue,
                hintText: appFonts.hour,
                isIcon: false,
                durationList: appArray.durationList,
                onChanged: (val) => value.onChangeDuration(val)))
      ]).paddingSymmetric(horizontal: Insets.i20),
      ContainerWithTextLayout(title: language(context, appFonts.selectOption))
          .paddingOnly(top: Insets.i24, bottom: Insets.i12),
      Column(
              children: appArray.serviceType
                  .asMap()
                  .entries
                  .map((e) => Row(
                        children: [
                          Container(
                              width: Sizes.s20,
                              height: Sizes.s20,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color:  value.serviceOption == e.value['val'] ? appColor(context)
                                      .appTheme
                                      .primary
                                      .withOpacity(0.12):appColor(context).appTheme.stroke),
                                  color: value.serviceOption == e.value['val'] ? appColor(context)
                                      .appTheme
                                      .primary
                                      .withOpacity(0.12):appColor(context).appTheme.whiteBg),
                              child: value.serviceOption == e.value['val'] ?  Icon(Icons.circle,
                                  color: appColor(context).appTheme.primary,
                                  size: Sizes.s10):null),
                          const HSpace(Sizes.s10),
                          Text(language(context, e.value['title']),
                              style: appCss.dmDenseRegular14.textColor(
                                  value.serviceOption == e.value['val'] ?appColor(context).appTheme.darkText:    appColor(context).appTheme.lightText))
                        ],
                      ).marginOnly(
                          bottom: e.key != appArray.serviceType.length - 1
                              ? Sizes.s20
                              : 0).inkWell(onTap: ()=>value.onSelectServiceTypeOption(e.value['val'])))
                  .toList())
          .paddingAll(15)
          .boxShapeExtension(
              color: appColor(context).appTheme.whiteBg, radius: 8)
          .paddingSymmetric(horizontal: Insets.i20),
      ContainerWithTextLayout(
              title: language(context, appFonts.faq),
              title2: appFonts.addFaq,
              onTap: () => value.addFaq(context))
          .paddingOnly(top: Insets.i24, bottom: Insets.i12),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: Sizes.s20),
        padding: const EdgeInsets.all(Sizes.s15),
        decoration: ShapeDecoration(
            color: appColor(context).appTheme.whiteBg,
            shape: SmoothRectangleBorder(
                borderRadius:
                    SmoothBorderRadius(cornerRadius: 8, cornerSmoothing: 1))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (value.faqList.isNotEmpty)
              ...value.faqList.asMap().entries.map((e) => Container(
                    margin: const EdgeInsets.symmetric(vertical: Sizes.s8),
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.s20),
                    decoration: ShapeDecoration(
                        shadows: [
                          BoxShadow(
                              blurRadius: 2,
                              spreadRadius: 2,
                              color: appColor(context)
                                  .appTheme
                                  .darkText
                                  .withOpacity(0.06))
                        ],
                        color: appColor(context).appTheme.fieldCardBg,
                        shape: SmoothRectangleBorder(
                            borderRadius: SmoothBorderRadius(
                                cornerRadius: 8, cornerSmoothing: 1))),
                    child: ExpansionTile(
                        expansionAnimationStyle:
                            AnimationStyle(curve: Curves.fastOutSlowIn),
                        key: Key(value.selected.toString()),
                        initiallyExpanded: e.key == value.selected,
                        onExpansionChanged: (newState) =>
                            value.onExpansionChange(newState, e.key),
                        //atten
                        tilePadding: EdgeInsets.zero,
                        collapsedIconColor: appColor(context).appTheme.darkText,
                        dense: true,
                        iconColor: appColor(context).appTheme.darkText,
                        title: Text("${e.value['question']}",
                            style: appCss.dmDenseMedium14.textColor(
                                appColor(context).appTheme.darkText)),
                        children: <Widget>[
                          Divider(
                            color: appColor(context).appTheme.stroke,
                            height: .5,
                            thickness: 0,
                          ),
                          ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.s5),
                              title: Text("${e.value['answer']}",
                                  style: appCss.dmDenseLight14.textColor(
                                      appColor(context)
                                          .appTheme
                                          .darkText
                                          .withOpacity(.8))))
                        ]),
                  )),
            if (value.faqList.isEmpty)
              Row(
                children: [
                  SvgPicture.asset(eSvgAssets.faq,
                      fit: BoxFit.scaleDown,
                      height: Sizes.s20,
                      colorFilter: ColorFilter.mode(
                          appColor(context).appTheme.lightText,
                          BlendMode.srcIn)),
                  const HSpace(Sizes.s15),
                  Text(language(context, appFonts.addFaq),
                      style: appCss.dmDenseMedium14
                          .textColor(appColor(context).appTheme.lightText)),
                ],
              ).paddingSymmetric(horizontal: Sizes.s5)
          ],
        ),
      ),
      ContainerWithTextLayout(
              title: language(context, appFonts.minRequiredServiceman))
          .paddingOnly(top: Insets.i24, bottom: Insets.i12),
      TextFieldCommon(
              keyboardType: TextInputType.number,
              focusNode: value.minRequiredFocus,
              controller: value.minRequired,
              hintText: appFonts.addNoOfServiceman,
              prefixIcon: eSvgAssets.tagUser)
          .paddingSymmetric(horizontal: Insets.i20)
    ]);
  }
}

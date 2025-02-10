import '../../../config.dart';

class TimeSlotScreen extends StatelessWidget {
  const TimeSlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeSlotProvider>(builder: (context1, value, child) {
      return StatefulWrapper(
        onInit: () => Future.delayed(Durations.short3)
            .then((_) => value.fetchSlotTime(context)),
        child: LoadingComponent(
          child: Scaffold(
              appBar: AppBarCommon(title: appFonts.timeSlots),
              body: SingleChildScrollView(
                  child: Form(
                key: value.formKey,
                child: Column(children: [
                  Stack(children: [
                    const FieldsBackground(),
                    Column(children: [
                      Row(
                              children: appArray.timeSlotStartAtList
                                  .asMap()
                                  .entries
                                  .map((e) => Row(
                                        children: [
                                          Text(language(context, e.value),
                                              style: appCss.dmDenseMedium12
                                                  .textColor(appColor(context)
                                                      .appTheme
                                                      .lightText)),
                                          HSpace(e.key == 0
                                              ? Sizes.s42
                                              : Sizes.s35),
                                        ],
                                      ))
                                  .toList())
                          .paddingSymmetric(horizontal: Insets.i15),
                      const VSpace(Sizes.s15),
                      ...appArray.timeSlotList.asMap().entries.map((e) =>
                          AllTimeSlotLayout(
                              data: e.value,
                              index: e.key,
                              list: appArray.timeSlotList,
                              onTapSecond: e.value.status == "1"
                                  ? () => value.selectTimeBottomSheet(
                                      context, e.value, e.key, "end")
                                  : () {},
                              onTap: e.value.status == "1"
                                  ? () => value.selectTimeBottomSheet(
                                      context, e.value, e.key, "start")
                                  : () {},
                              onToggle: (val) => value.onToggle(e.key, val))),
                      const DividerCommon()
                          .paddingOnly(bottom: Insets.i15, top: Insets.i20),
                      Text(language(context, appFonts.slotNote),
                              style: appCss.dmDenseMedium12.textColor(
                                  appColor(context).appTheme.lightText))
                          .paddingSymmetric(horizontal: Insets.i15),
                      const VSpace(Sizes.s15),
                      ContainerWithTextLayout(
                          title: language(context, appFonts.gapBetween)),
                      const VSpace(Sizes.s8),
                      Row(children: [
                        Expanded(
                            flex: 2,
                            child: TextFieldCommon(
                                keyboardType: TextInputType.number,
                                focusNode: value.hourGapFocus,
                                controller: value.hourGap,
                                validator: (value) =>
                                    validation.dynamicTextValidation(
                                        context, value, "Please Add Gap Time"),
                                hintText: appFonts.addGap,
                                prefixIcon: eSvgAssets.timer)),
                        const HSpace(Sizes.s6),
                        Expanded(
                            flex: 1,
                            child: DarkDropDownLayout(
                                isBig: true,
                                val: value.gapValue,
                                hintText: appFonts.hour,
                                isIcon: false,
                                categoryList: appArray.durationList,
                                onChanged: (val) =>
                                    value.durationUnitSelection(val)))
                      ]).paddingSymmetric(horizontal: Insets.i15)
                    ]).paddingSymmetric(vertical: Insets.i15)
                  ]),
                  ButtonCommon(
                          title: appFonts.updateHours,
                          onTap: () => value.onUpdateHour(context))
                      .paddingOnly(top: Insets.i40, bottom: Insets.i30)
                ]).padding(horizontal: Insets.i20, bottom: Insets.i20),
              ))),
        ),
      );
    });
  }
}

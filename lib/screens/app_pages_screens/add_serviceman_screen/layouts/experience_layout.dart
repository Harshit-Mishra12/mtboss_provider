import '../../../../config.dart';

class ExperienceLayout extends StatelessWidget {
  const ExperienceLayout({super.key});

  @override
  Widget build(BuildContext context) {

    final value = Provider.of<AddServicemenProvider>(context);

    return Column(
      children: [
        ContainerWithTextLayout(title: appFonts.experience)
            .paddingOnly(bottom: Insets.i8, top: Insets.i20),
        Row(children: [
          Expanded(

              child: TextFieldCommon(
                keyboardType: TextInputType.number,
                focusNode: value.experienceFocus,
                  controller: value.experience,
                  hintText: appFonts.experience,
                  prefixIcon: eSvgAssets.timer)
                  .paddingOnly(left: rtl(context) ? 0 : Insets.i20, right: rtl(context) ? Insets.i20 : 0)),
          Expanded(
              child: DarkDropDownLayout(
                  isBig: true,
                  val: value.chosenValue,
                  hintText: appFonts.month,
                  isIcon: false,
                  categoryList: appArray.experienceList,
                  onChanged: (val) => value.onDropDownChange(val))
                  .paddingOnly(right:  rtl(context) ? Insets.i8 : Insets.i20, left: rtl(context) ? Insets.i20 : Insets.i8))
        ])
      ]
    );
  }
}

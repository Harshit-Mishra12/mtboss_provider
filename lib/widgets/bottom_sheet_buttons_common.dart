import '../config.dart';

class BottomSheetButtonCommon extends StatelessWidget {
  final GestureTapCallback? clearTap,applyTap;
  final String? textOne,textTwo;
  const BottomSheetButtonCommon({super.key,this.applyTap,this.clearTap,this.textOne,this.textTwo});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: ButtonCommon(
              title: textOne!,
              onTap: clearTap,
              style: appCss.dmDenseRegular16
                  .textColor(appColor(context).appTheme.primary),
              color: appColor(context).appTheme.trans,
              borderColor: appColor(context).appTheme.primary)),
      const HSpace(Sizes.s15),
      Expanded(child: ButtonCommon(title: textTwo!,onTap: applyTap))
    ]);
  }
}

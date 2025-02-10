import '../../../../config.dart';

class CommissionRowLayout extends StatelessWidget {
  final dynamic data;
  final String? title;
  final TextStyle? style;
  final Color? color;
  final bool? isCommission;
  const CommissionRowLayout({super.key, this.data, this.style, this.color, this.title, this.isCommission = false});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(language(context, title!), style: appCss.dmDenseRegular12
              .textColor(appColor(context).appTheme.darkText)),

          Text("\$$data", style: style ?? appCss.dmDenseMedium14
              .textColor( color ?? appColor(context).appTheme.red))
        ]
    ).paddingOnly(bottom: isCommission == true ? Insets.i22 : Insets.i16);
  }
}

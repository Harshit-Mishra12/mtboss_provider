import '../config.dart';

class DividerCommon extends StatelessWidget {
  const DividerCommon({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
        color: appColor(context).appTheme.stroke, thickness: 1, height: 1);
  }
}

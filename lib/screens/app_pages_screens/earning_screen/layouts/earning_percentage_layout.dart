import '../../../../config.dart';

class EarningPercentageLayout extends StatelessWidget {
  const EarningPercentageLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
          height: Sizes.s92,
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 4,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2),
              itemCount: totalEarningModel!.categoryEarnings!.length,
              itemBuilder: (context, index) => ChartDataLayout(index: index,
                  data: totalEarningModel!.categoryEarnings![index])))
    ])
        .paddingAll(Insets.i20)
        .boxShapeExtension(color: appColor(context).appTheme.whiteBg);
  }
}

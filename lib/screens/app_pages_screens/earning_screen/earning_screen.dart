import 'dart:developer';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../config.dart';

class EarningScreen extends StatelessWidget {
  const EarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /*final List<ChartDataColor> chartData = [
      ChartDataColor('Cleaning', 35, Color(0xFF5465FF)),
      ChartDataColor('Ac repair', 25, Color(0xFF7482FD)),
      ChartDataColor('Painting', 20, Color(0xFF949FFC)),
      ChartDataColor('Carpenter', 18, Color(0xFFB5BCFA)),
      ChartDataColor('Salon', 12, Color(0xFFD5D9F9))
    ];*/
    log("commissionList::  ${commissionList?.total}");
    return Scaffold(
        appBar: AppBarCommon(title: appFonts.earnings),
        body: commissionList == null
            ? const CommonEmpty()
            : SingleChildScrollView(
                child: Column(children: [
                Column(children: [
                  Container(
                      height: Sizes.s63,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(eImageAssets.balanceContainer),
                              fit: BoxFit.fill)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                language(context,
                                    "${language(context, appFonts.totalEarning)} :"),
                                style: appCss.dmDenseMedium12.textColor(
                                    appColor(context).appTheme.whiteBg)),
                            Text(
                                "${getSymbol(context)}${currency(context).currencyVal * commissionList!.total!}",
                                style: appCss.dmDenseBold18.textColor(
                                    appColor(context).appTheme.whiteColor))
                          ]).paddingSymmetric(horizontal: Insets.i20)),
                  const VSpace(Sizes.s30),
                  if (commissionList!.histories!.isNotEmpty)
                    Column(children: [
                      Stack(alignment: Alignment.center, children: [
                        SfCircularChart(series: <CircularSeries>[
                          DoughnutSeries<ChartDataColor, String>(
                              dataSource: appArray.earningChartData,
                              xValueMapper: (ChartDataColor data, _) => data.x,
                              yValueMapper: (ChartDataColor data, _) => data.y,
                              cornerStyle: CornerStyle.bothCurve,
                              pointColorMapper: (ChartDataColor data, _) =>
                                  data.color,
                              explodeAll: true,
                              innerRadius: '85%',
                              explode: true)
                        ]),
                        SizedBox(
                            width: Sizes.s120,
                            child: Text(
                                language(context, appFonts.topCategorys),
                                textAlign: TextAlign.center,
                                style: appCss.dmDenseMedium16.textColor(
                                    appColor(context).appTheme.darkText)))
                      ]),
                      const EarningPercentageLayout()
                    ]).paddingAll(Insets.i15).boxShapeExtension(
                        color: appColor(context).appTheme.fieldCardBg)
                ]).paddingSymmetric(horizontal: Insets.i20),
                const VSpace(Sizes.s25),
                if (commissionList!.histories!.isEmpty) const CommonEmpty(),
                if (commissionList!.histories!.isNotEmpty) const HistoryBody()
              ])));
  }
}

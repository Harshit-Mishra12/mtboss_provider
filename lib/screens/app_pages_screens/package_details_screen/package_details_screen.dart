import 'package:fixit_provider/screens/app_pages_screens/package_details_screen/service_package_shimmer/service_package_shimmer.dart';

import '../../../config.dart';

class PackageDetailsScreen extends StatefulWidget {
  const PackageDetailsScreen({super.key});

  @override
  State<PackageDetailsScreen> createState() => _PackageDetailsScreenState();
}

class _PackageDetailsScreenState extends State<PackageDetailsScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer2<PackageDetailProvider, DeleteDialogProvider>(
        builder: (context1, value, deleteVal, child) {
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          value.onBack(context, false);
          if (didPop) return;
        },
        child: StatefulWrapper(
            onInit: () => Future.delayed(
                const Duration(milliseconds: 50), () => value.onReady(context)),
            child:  value.widget1Opacity == 0.0 ? const ServicePackageShimmer() :
            RefreshIndicator(
              onRefresh: (){
                return value.onRefresh(context);
              },
              child: Scaffold(
                  appBar: ActionAppBar(title: appFonts.packageDetails,onTap: ()=> value.onBack(context, true), actions: [
                    CommonArrow(
                            arrow: eSvgAssets.delete,
                            onTap: () => value.onPackageDelete(context, this))
                        .paddingSymmetric(horizontal: Insets.i20)
                  ]),
                  body: SingleChildScrollView(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              PackageDetailsLayout(data: value.packageModel),
                              const DottedLines()
                                  .paddingSymmetric(vertical: Insets.i15),
                              Text(language(context, appFonts.disclaimer),
                                  style: appCss.dmDenseMedium12.textColor(
                                      appColor(context).appTheme.darkText)),
                              Text(language(context, appFonts.youWillOnlyGet),
                                  style: appCss.dmDenseRegular12
                                      .textColor(appColor(context).appTheme.red)),
                              ButtonCommon(
                                      title: appFonts.editPackage,
                                      onTap: () => route.pushNamed(
                                              context, routeName.appPackage, arg: {
                                            'isEdit': true,
                                            "data": value.packageModel
                                          }))
                                  .paddingOnly(top: Insets.i40, bottom: Insets.i30)
                            ]).paddingSymmetric(horizontal: Insets.i20))),
            )),
      );
    });
  }
}

import 'dart:developer';

import '../../../../config.dart';

class ServiceListBottomLayout extends StatelessWidget {
  final List<CategoryModel>? subCategory;

  const ServiceListBottomLayout({super.key, this.subCategory});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<ServiceListProvider>(context);
    final userApi = Provider.of<UserDataApiProvider>(context);
log("value.serviceList:${value.serviceList.length}");
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (categoryList[value.selectedIndex].hasSubCategories != null &&
              categoryList[value.selectedIndex].hasSubCategories!.isNotEmpty)
            const ServiceListTabBarCommon()
                .width(MediaQuery.of(context).size.width)
                .decorated(
                    border: Border(
                        bottom: BorderSide(
                            color: appColor(context).appTheme.stroke,
                            width: 2.5))),
          if (categoryList[value.selectedIndex].hasSubCategories!.isNotEmpty)
            const VSpace(Sizes.s15),
          if(value.serviceList.isEmpty)
            const CommonEmpty(),
          if(value.serviceList.isNotEmpty)
          ...value.serviceList
              .asMap()
              .entries
              .map((e) => FeaturedServicesLayout(
                    data: e.value,
                    onTap: () => route.pushNamed(
                        context, routeName.serviceDetails,
                        arg: {"detail": e.value.id}),
                    onToggle: (val) => value.updateActiveStatusService(
                        context, e.value.id, val, e.key),
                  ).paddingSymmetric(horizontal: Insets.i20))

        ]);
  }
}

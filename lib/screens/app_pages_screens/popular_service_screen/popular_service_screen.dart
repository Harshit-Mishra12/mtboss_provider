import '../../../config.dart';

class PopularServiceScreen extends StatelessWidget {
  const PopularServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<DashboardProvider>(context, listen: true);
    return Consumer<UserDataApiProvider>(builder: (context1, userApi, child) {
      return Scaffold(
          appBar: AppBarCommon(title: appFonts.popularService),
          body: SingleChildScrollView(
              child: Column(children: [
            SearchTextFieldCommon(
                focusNode: value.searchFocus,
                controller: value.searchCtrl,
                onChanged: (v) {
                  if (v.isEmpty) {
                    userApi.getPopularServiceList();
                  }
                },
                onFieldSubmitted: (v) => userApi.getPopularServiceList(
                      search: v,
                    )).padding(bottom: Insets.i20),
            ...popularServiceList.asMap().entries.map((e) =>
                FeaturedServicesLayout(
                    data: e.value,
                    onToggle: (val) => userApi.updateActiveStatusService(context, e.value.id, val,e.key),
                    onTap: () =>
                        route.pushNamed(context, routeName.serviceDetails,arg: {"detail":e.value.id})))
          ]).paddingSymmetric(horizontal: Insets.i20)));
    });
  }
}




import 'package:fixit_provider/screens/app_pages_screens/custom_job_request/job_request_list/layouts/job_request_list_card.dart';

import '../../../../config.dart';
import '../../../../providers/app_pages_provider/job_request_providers/job_request_list_provider.dart';

class JobRequestList extends StatefulWidget {
  const JobRequestList({super.key});

  @override
  State<JobRequestList> createState() => _JobRequestListState();
}

class _JobRequestListState extends State<JobRequestList>with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobRequestListProvider>(builder: (context1, value, child) {
      return StatefulWrapper(
        onInit: () => Future.delayed(const Duration(milliseconds: 50)).then(
          (_) => value.onInit(context),
        ),
        child: LoadingComponent(
          child: Scaffold(
              appBar: AppBarCommon(title: appFonts.customJobRequest),
              body: RefreshIndicator(
                onRefresh: () async {
                  value.onRefresh(context);
                },
                child: jobRequestList.isNotEmpty
                    ? Stack(
                  alignment: Alignment.bottomCenter,
                      children: [
                        ListView(children: [

                            Column(
                              children: [
                                ...jobRequestList.asMap().entries.map(
                                    (data) =>JobRequestListCard(data: data.value,))
                              ],
                            )
                          ]).paddingSymmetric(horizontal: Insets.i20),
                      //  ButtonCommon(title: appFonts.requestNewJob,margin: 20,onTap: ()=>route.pushNamed(context,routeName.addJobRequestList),).marginOnly(bottom: 20)
                      ],
                    )
                    : EmptyLayout(
                        widget: Image.asset(eImageAssets.noSearch,
                            height: Sizes.s380),
                        title: appFonts.oopsYour,
                        subtitle: appFonts.noDataFound,
                       // isButtonShow: false,
                      ).center(),
              )),
        ),
      );
    });
  }
}

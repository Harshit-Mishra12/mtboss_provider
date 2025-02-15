import 'dart:developer';

import '../../../config.dart';

class IdVerificationScreen extends StatelessWidget {
  const IdVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LanguageProvider,IdVerificationProvider>(builder: (context1, lang,value, child) {
      return LoadingComponent(
        child: Scaffold(
            appBar: AppBarCommon(title: translations!.idVerification),
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  if (providerDocumentList.isNotEmpty)
                    Text(language(context, translations!.submittedDocument),
                        style: appCss.dmDenseMedium14
                            .textColor(appColor(context).appTheme.lightText)),
                  if (providerDocumentList.isNotEmpty) const VSpace(Sizes.s15),
                  ...providerDocumentList
                      .asMap()
                      .entries
                      .map((e) => DocumentLayout(
                            data: e.value,
                            list: appArray.documentsList,
                            index: e.key,
                          )),
                  const VSpace(Sizes.s20),
                  Text(language(context, translations!.pendingDocument),
                      style: appCss.dmDenseMedium14
                          .textColor(appColor(context).appTheme.lightText)),
                  const VSpace(Sizes.s15),
                  ...notUpdateDocumentList.asMap().entries.map((e) =>
                      PendingDocumentLayout(
                          onTap: () => value.onImagePick(context, e.value),
                          data: e.value))
                ]).paddingSymmetric(horizontal: Insets.i20))),
      );
    });
  }
}

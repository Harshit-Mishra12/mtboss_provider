
import '../../../config.dart';

class AddServiceProofScreen extends StatelessWidget {
  const AddServiceProofScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddServiceProofProvider>(builder: (context1, value, child) {
      return StatefulWrapper(
        onInit: () => Future.delayed(
            const Duration(milliseconds: 20), () => value.onReady(context)),
        child: LoadingComponent(
          child: PopScope(
            canPop: true,
            onPopInvoked: (didPop) {
              if(didPop) value.onBack(context, false);
             // value.onBack(context, false);
            },
            child: Scaffold(
                appBar: AppBarCommon(title: appFonts.addServiceProof,onTap: ()=> value.onBack(context, true)),
                body: const AddProofBodyWidget()),
          )
        )
      );
    });
  }
}

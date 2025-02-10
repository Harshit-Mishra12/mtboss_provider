import 'dart:developer';

import '../../config.dart';

class CategoriesListProvider with ChangeNotifier{
  TextEditingController searchCtrl = TextEditingController();

  FocusNode searchFocus = FocusNode();
  bool isGrid = true;
  List<CategoryModel> searchList =[];
  int? selectedIndex;

  CategoryModel? categoryModel;

  //on grid to list
  onGrid(){
    isGrid = !isGrid;
    notifyListeners();
  }


  onReady(context)async{
    showLoading(context);
    notifyListeners();
    dynamic data = ModalRoute.of(context)!.settings.arguments ?? [];
    categoryModel =data;
    hideLoading(context);
    notifyListeners();
  }

  //search category
  searchCategory(context,search)async{

    notifyListeners();
    try {
      String apiUrl = "${api.category}?providerId=${userModel!.id}";
      if(search != null && search != ""){
        apiUrl = "${api.category}?providerId=${userModel!.id}&search=${searchCtrl.text}";
      }else{
        apiUrl = "${api.category}?providerId=${userModel!.id}";
      }

      log("CATEGIRY");
      await apiServices.getApi(apiUrl, []).then((value) {
        searchList= [];
        if (value.isSuccess!) {

          List category =value.data;
          for (var data in category.reversed.toList()) {
            if(!searchList.contains(CategoryModel.fromJson(data))) {
              searchList.add(CategoryModel.fromJson(data));
            }
            notifyListeners();
          }
        }
      });
      log("categoryList :${searchList.length}");
      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
    notifyListeners();
  }

}
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:fixit_provider/screens/auth_screens/current_location_screen/layouts/location_list_tile.dart';
import 'package:fixit_provider/screens/auth_screens/current_location_screen/layouts/network_utilities.dart';

import '../../../../config.dart';

class SearchLocation extends StatefulWidget {
  const SearchLocation({super.key});

  @override
  State<SearchLocation> createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {
  List placePredictions = [];
  FocusNode focusNode = FocusNode();
  TextEditingController search = TextEditingController();
  String apiKey = "AIzaSyB49607c3ybClHZX-UxSIjHcmv0qGrinCk";


  placeAutoComplete(query) async {
    String api = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String request = "$api?input=${search.text}&key=${appSettingModel!.firebase!.googleMapApiKey??api}";


    var res = await http.get(Uri.parse(request));

    var result = res.body.toString();

    if (res.statusCode == 200) {
      setState(() {
        placePredictions = jsonDecode(res.body.toString())['predictions'];
      });
    }else{
      log("EEERE :${res.body}");
    }
    setState(() {});
  }

  findCord(context, placeID) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=$apiKey";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      log("HTTP Error: ${response.statusCode} - ${response.reasonPhrase}");
      return;
    }

    var data = jsonDecode(response.body);
    log("Full API Response: $data");

    if (data['status'] != "OK") {
      log("Google API Error: ${data['error_message'] ?? 'Unknown error'}");
      return;
    }

    var location = data['result']?['geometry']?['location'];
    if (location == null) {
      log("Error: 'geometry' or 'location' missing in API response.");
      return;
    }

    double lat = location['lat'];
    double lng = location['lng'];

    log("Extracted LatLng: ($lat, $lng)");

    Navigator.pop(context, LatLng(lat, lng));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBarCommon(title: language(context, appFonts.location)),
        body:  ListView(
          children: [
            TextFieldCommon(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: appColor(context).appTheme.stroke)
                ),
                focusNode: focusNode,
                onChanged: (v) => placeAutoComplete(v),
                controller: search,
                hintText: language(context, appFonts.searchHere),
                prefixIcon: eSvgAssets.location)
                .paddingSymmetric(horizontal: Insets.i20),
            const VSpace(Sizes.s20),
            Divider(color: appColor(context).appTheme.stroke, height: 0),
            if (placePredictions.isNotEmpty) const VSpace(Sizes.s20),
            ButtonCommon(
                margin: 20,
                onTap: ()=> route.pop(context),
                title: language(context, appFonts.useCurrentLocation),
                icon: SvgPicture.asset(eSvgAssets.zipcode,colorFilter: ColorFilter.mode(appColor(context).appTheme.whiteBg, BlendMode.srcIn),)),
            const VSpace(Sizes.s20),
            Divider(color: appColor(context).appTheme.stroke, height: 0),
            if (placePredictions.isNotEmpty) const VSpace(Sizes.s20),
            ...placePredictions.asMap().entries.map((e) => LocationListTile(
              loc: e.value['description'],
              onTap: () {
                findCord(context,e.value['place_id']);
              },
            )),
          ],
        ));
  }
}

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:test_project/model/newlead.model.dart';
import 'package:test_project/utils/const.dart';

import '../service/services.dart';
import '../utils/extension.dart';

class NewLeadsController extends ChangeNotifier {
  bool _loadMore = true;
  bool _isLoading = false;
  NewLeadModel? _apiModel;
  NewLeadModel? get apiModel => _apiModel;
 

  List<Datum> dataNewLeads = [];
  List<Datum> searchLeads = [];

  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  searchStatus() {
    isSearching = !isSearching;
    notifyListeners();
  }

  // SEARCH THE NEW LEADS
  searchNewLeads(String query) {
    //CLEARING THE LIST ON CALL
    dataNewLeads.clear();
    //ADDING ALL THE API DATA TO THE LIST
    dataNewLeads.addAll(apiModel!.newLeads!.data!.map((e) => e));
    query = searchController.text;

    //FILTERING THE DATA FROM THE LIST OF DATA
    final suggestion = dataNewLeads.where((element) {
      final leadNames = element.leadName!;
      final input = query;
      return leadNames.startsWith(input);
    }).toList();

    //ASSIGNING THE DATA TO THE SEARCH LIST
    searchLeads = suggestion;

    notifyListeners();
  }

  Future fetchNewLeads(
      {bool isInitial = true,
      String? loadMoreUrl,
      bool isReset = false}) async {
 
    if (_loadMore == false) return;
    if (isInitial) isLoading = true;
    NewLeadModel? response = await RemoteServices.newLeads(
        query: loadMoreUrl ?? "?page=pagenumber", loginToken: bearerToken);
    // if (isReset) reset();
    if (isInitial == false) controller.finishLoad(IndicatorResult.success);
    if (isInitial) isLoading = false;
    if (response != null) {
      if (response.newLeads?.nextPageUrl == null) {
        _loadMore = true;
        controller.finishLoad(IndicatorResult.noMore);
      }
      if (!isInitial && response.newLeads?.data != null) {
        //paginate data with existing model.
        apiModel?.newLeads?.data?.addAll(response.newLeads!.data!);
        //change next apge url ffor another iterate.
        apiModel?.newLeads?.nextPageUrl = response.newLeads?.nextPageUrl;
        //removing duplicayte values
        _apiModel?.newLeads?.data?.distinctBy((e) => e.id);
      } else {
        //means first time.
        _apiModel = response;
      }

      notifyListeners();
    } else {}
  }

  EasyRefreshController controller = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  void onLoading() async {
    if (_loadMore == false || _apiModel?.newLeads?.nextPageUrl == null) {
      controller.finishLoad(IndicatorResult.noMore);
    }
    fetchNewLeads(
        isInitial: false, loadMoreUrl: _apiModel?.newLeads?.nextPageUrl);
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

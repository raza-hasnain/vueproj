import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:test_project/utils/const.dart';
import '../utils/extension.dart';
import '../model/get_leads.model.dart';
import '../service/services.dart';
import '../utils/local.storage.dart';

class GetSalesLeadController extends ChangeNotifier {
  bool _loadMore = true;
  bool _isLoading = false;
  ApiModel? _apiModel;
  ApiModel? get apiModel => _apiModel;

  Future fetchMyUsers(
      {bool isInitial = true,
      String? loadMoreUrl,
      bool isReset = false}) async {
   
    if (_loadMore == false) return;
    if (isInitial) isLoading = true;
    ApiModel? response = await RemoteServices.getUsers(
        query: loadMoreUrl ?? "?page=pagenumber", loginToken: bearerToken);
    // if (isReset) reset();
    if (isInitial == false) controller.finishLoad(IndicatorResult.success);
    if (isInitial) isLoading = false;
    if (response != null) {
      if (response.userLeads?.nextPageUrl == null) {
        _loadMore = true;
        controller.finishLoad(IndicatorResult.noMore);
      }
      if (!isInitial && response.userLeads?.data != null) {
        //paginate data with existing model.
        apiModel?.userLeads?.data?.addAll(response.userLeads!.data!);
        //change next apge url ffor another iterate.
        apiModel?.userLeads?.nextPageUrl = response.userLeads?.nextPageUrl;
        //removing duplicayte values
        _apiModel?.userLeads?.data?.distinctBy((e) => e.id);
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
    if (_loadMore == false || _apiModel?.userLeads?.nextPageUrl == null) {
      controller.finishLoad(IndicatorResult.noMore);
    }
    fetchMyUsers(
        isInitial: false, loadMoreUrl: _apiModel?.userLeads?.nextPageUrl);
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

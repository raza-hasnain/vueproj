import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:test_project/utils/const.dart';

import '../model/thirdparty.leads.model.dart';
import '../service/services.dart';
import '../utils/extension.dart';
import '../utils/local.storage.dart';

class ThirdPartyLeadsController extends ChangeNotifier {
  bool _loadMore = true;
  bool _isLoading = false;
  ThirdPartyLeadsModel? _apiModel;
  ThirdPartyLeadsModel? get apiModel => _apiModel;

  

  Future fetchThirdPartyLeads(
      {bool isInitial = true,
      String? loadMoreUrl,
      bool isReset = false}) async {
   
    if (_loadMore == false) return;
    if (isInitial) isLoading = true;
    ThirdPartyLeadsModel? response = await RemoteServices.thirdpartyLeads(
        query: loadMoreUrl ?? "&page=pagenumber", loginToken: bearerToken);
        //query: loadMoreUrl ?? "&page=1", loginToken: loginToken);
    // if (isReset) reset();
    if (isInitial == false) controller.finishLoad(IndicatorResult.success);
    if (isInitial) isLoading = false;
    if (response != null) {
      if (response.thirdpartyLeads?.nextPageUrl == null) {
        _loadMore = true;
        controller.finishLoad(IndicatorResult.noMore);
      }
      if (!isInitial && response.thirdpartyLeads?.data != null) {
        //paginate data with existing model.
        apiModel?.thirdpartyLeads?.data?.addAll(response.thirdpartyLeads!.data!);
        //change next page url for another iterate.
        apiModel?.thirdpartyLeads?.nextPageUrl = response.thirdpartyLeads?.nextPageUrl;
        //removing duplicate values
        _apiModel?.thirdpartyLeads?.data?.distinctBy((e) => e.id);
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
    if (_loadMore == false || _apiModel?.thirdpartyLeads?.nextPageUrl == null) {
      controller.finishLoad(IndicatorResult.noMore);
    }
    fetchThirdPartyLeads(
        isInitial: false, loadMoreUrl: _apiModel?.thirdpartyLeads?.nextPageUrl);
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

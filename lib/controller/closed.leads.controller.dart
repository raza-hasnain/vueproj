import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import '../model/closed.deals.model.dart';
import '../service/services.dart';
import '../utils/extension.dart';
import '../utils/local.storage.dart';

class ClosedDealsController extends ChangeNotifier {
  bool _loadMore = true;
  bool _isLoading = false;
  ClosedDealsModel? _apiModel;
  late String loginToken;
  ClosedDealsModel? get apiModel => _apiModel;
  final LocalStorage _localStorage = LocalStorage();

  Future<String?> getloginToken() async {
    loginToken = (await _localStorage.getLoginToken())!;

    return loginToken;
  }

  Future fetchClosedDeals(
      {bool isInitial = true,
      String? loadMoreUrl,
      bool isReset = false}) async {
    await getloginToken().then((value) {
      loginToken = value!;

      notifyListeners();
    });
    if (_loadMore == false) return;
    if (isInitial) isLoading = true;
    ClosedDealsModel? response = await RemoteServices.closedLeadsFunc(
        query: loadMoreUrl ?? "?page=pagenumber", loginToken: loginToken);
    if (isInitial == false) controller.finishLoad(IndicatorResult.success);
    if (isInitial) isLoading = false;
    if (response != null) {
      if (response.closedLeads?.nextPageUrl == null) {
        _loadMore = true;
        controller.finishLoad(IndicatorResult.noMore);
      }
      if (!isInitial && response.closedLeads?.data != null) {
        apiModel?.closedLeads?.data?.addAll(response.closedLeads!.data!);
        apiModel?.closedLeads?.nextPageUrl = response.closedLeads?.nextPageUrl;
        _apiModel?.closedLeads?.data?.distinctBy((e) => e.lid);
      } else {
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
    if (_loadMore == false || _apiModel?.closedLeads?.nextPageUrl == null) {
      controller.finishLoad(IndicatorResult.noMore);
    }
    fetchClosedDeals(
        isInitial: false, loadMoreUrl: _apiModel?.closedLeads?.nextPageUrl);
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

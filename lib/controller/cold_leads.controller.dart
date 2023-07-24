import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import '../model/cold.leads.model.dart';
import '../service/services.dart';
import '../utils/extension.dart';
import '../utils/local.storage.dart';

class ColdLeadsController extends ChangeNotifier {
  bool _loadMore = true;
  bool _isLoading = false;
  ColdLeadsModel? _apiModel;
  late String loginToken;
  ColdLeadsModel? get apiModel => _apiModel;
  final LocalStorage _localStorage = LocalStorage();

  Future<String?> getloginToken() async {
    loginToken = (await _localStorage.getLoginToken())!;

    return loginToken;
  }

  Future fetchColdLeads(
      {bool isInitial = true,
      String? loadMoreUrl,
      bool isReset = false}) async {
    await getloginToken().then((value) {
      loginToken = value!;

      notifyListeners();
    });
    if (_loadMore == false) return;
    if (isInitial) isLoading = true;
    ColdLeadsModel? response = await RemoteServices.coldLeads(
        query: loadMoreUrl ?? "?page=pagenumber", loginToken: loginToken);
    // if (isReset) reset();
    if (isInitial == false) controller.finishLoad(IndicatorResult.success);
    if (isInitial) isLoading = false;
    if (response != null) {
      if (response.coldLeads?.nextPageUrl == null) {
        _loadMore = true;
        controller.finishLoad(IndicatorResult.noMore);
      }
      if (!isInitial && response.coldLeads?.data != null) {
        //paginate data with existing model.
        apiModel?.coldLeads?.data?.addAll(response.coldLeads!.data!);
        //change next apge url ffor another iterate.
        apiModel?.coldLeads?.nextPageUrl = response.coldLeads?.nextPageUrl;
        //removing duplicayte values
        _apiModel?.coldLeads?.data?.distinctBy((e) => e.id);
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
    if (_loadMore == false || _apiModel?.coldLeads?.nextPageUrl == null) {
      controller.finishLoad(IndicatorResult.noMore);
    }
    fetchColdLeads(
        isInitial: false, loadMoreUrl: _apiModel?.coldLeads?.nextPageUrl);
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:test_project/model/followup.model.dart';

import '../service/services.dart';
import '../utils/extension.dart';
import '../utils/local.storage.dart';

class FolloweUpController extends ChangeNotifier {
  bool _loadMore = true;
  bool _isLoading = false;
  FollowUpModel? _apiModel;
  late String loginToken;
  FollowUpModel? get apiModel => _apiModel;
  final LocalStorage _localStorage = LocalStorage();

  Future<String?> getloginToken() async {
    loginToken = (await _localStorage.getLoginToken())!;

    return loginToken;
  }

  Future fetchFollowUpLeads(
      {bool isInitial = true,
      String? loadMoreUrl,
      bool isReset = false}) async {
    await getloginToken().then((value) {
      loginToken = value!;

      notifyListeners();
    });
    if (_loadMore == false) return;
    if (isInitial) isLoading = true;
    FollowUpModel? response = await RemoteServices.followUpLeads(
        query: loadMoreUrl ?? "?page=pagenumber", loginToken: loginToken);
    // if (isReset) reset();
    if (isInitial == false) controller.finishLoad(IndicatorResult.success);
    if (isInitial) isLoading = false;
    if (response != null) {
      if (response.followUpLeads?.nextPageUrl == null) {
        _loadMore = true;
        controller.finishLoad(IndicatorResult.noMore);
      }
      if (!isInitial && response.followUpLeads?.data != null) {
        //paginate data with existing model.
        apiModel?.followUpLeads?.data?.addAll(response.followUpLeads!.data!);
        //change next apge url ffor another iterate.
        apiModel?.followUpLeads?.nextPageUrl =
            response.followUpLeads?.nextPageUrl;
        //removing duplicayte values
        _apiModel?.followUpLeads?.data?.distinctBy((e) => e.id);
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
    if (_loadMore == false || _apiModel?.followUpLeads?.nextPageUrl == null) {
      controller.finishLoad(IndicatorResult.noMore);
    }
    fetchFollowUpLeads(
        isInitial: false, loadMoreUrl: _apiModel?.followUpLeads?.nextPageUrl);
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

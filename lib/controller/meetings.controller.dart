import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:test_project/model/meetings.model.dart';

import '../service/services.dart';
import '../utils/extension.dart';
import '../utils/local.storage.dart';

class MeetingsController extends ChangeNotifier {
  bool _loadMore = true;
  bool _isLoading = false;
  MeetingModel? _apiModel;
  late String loginToken;
  MeetingModel? get apiModel => _apiModel;
  final LocalStorage _localStorage = LocalStorage();

  Future<String?> getloginToken() async {
    loginToken = (await _localStorage.getLoginToken())!;

    return loginToken;
  }

  Future fetchMeetingsData(
      {bool isInitial = true,
      String? loadMoreUrl,
      bool isReset = false}) async {
    await getloginToken().then((value) {
      loginToken = value!;

      notifyListeners();
    });
    if (_loadMore == false) return;
    if (isInitial) isLoading = true;
    MeetingModel? response = await RemoteServices.meetingData(
        query: loadMoreUrl ?? "?page=pagenumber", loginToken: loginToken);
    // if (isReset) reset();
    if (isInitial == false) controller.finishLoad(IndicatorResult.success);
    if (isInitial) isLoading = false;
    if (response != null) {
      if (response.lead?.nextPageUrl == null) {
        _loadMore = true;
        controller.finishLoad(IndicatorResult.noMore);
      }
      if (!isInitial && response.lead?.data != null) {
        //paginate data with existing model.
        apiModel?.lead?.data?.addAll(response.lead!.data!);
        //change next apge url ffor another iterate.
        apiModel?.lead?.nextPageUrl = response.lead?.nextPageUrl;
        //removing duplicayte values
        _apiModel?.lead?.data?.distinctBy((e) => e.lid);
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
    if (_loadMore == false || _apiModel?.lead?.nextPageUrl == null) {
      controller.finishLoad(IndicatorResult.noMore);
    }
    fetchMeetingsData(
        isInitial: false, loadMoreUrl: _apiModel?.lead?.nextPageUrl);
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

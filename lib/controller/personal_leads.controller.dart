
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:test_project/utils/const.dart';
import '../model/personal.leads.model.dart';
import '../service/services.dart';
import '../utils/extension.dart';

class PersonalLeadsController extends ChangeNotifier {
  bool _loadMore = true;
  bool _isLoading = false;
  PersonalLeadsModel? _apiModel;
  PersonalLeadsModel? get apiModel => _apiModel;

  Future fetchPersonalLeads(
      {bool isInitial = true,
      String? loadMoreUrl,
      bool isReset = false}) async {
    if (_loadMore == false) return;
    if (isInitial) isLoading = true;
    PersonalLeadsModel? response = await RemoteServices.personalLeads(
      query: loadMoreUrl ?? "&page=pagenumber",
      loginToken: bearerToken,
    );

    if (isInitial == false) controller.finishLoad(IndicatorResult.success);
    if (isInitial) isLoading = false;
    if (response != null) {
      if (response.personalLeads?.nextPageUrl == null) {
        _loadMore = true;
        controller.finishLoad(IndicatorResult.noMore);
      }
      if (!isInitial && response.personalLeads?.data != null) {
        //paginate data with existing model.
        apiModel?.personalLeads?.data?.addAll(response.personalLeads!.data!);
        //change next page url for another iterate.
        apiModel?.personalLeads?.nextPageUrl =
            response.personalLeads?.nextPageUrl;
        //removing duplicate values
        _apiModel?.personalLeads?.data?.distinctBy((e) => e.id);
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
    if (_loadMore == false || _apiModel?.personalLeads?.nextPageUrl == null) {
      controller.finishLoad(IndicatorResult.noMore);
    }
    fetchPersonalLeads(
        isInitial: false, loadMoreUrl: _apiModel?.personalLeads?.nextPageUrl);
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}

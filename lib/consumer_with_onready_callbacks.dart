import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_project/custom.func.dart';
import 'package:test_project/lifecyle_base.dart';
import 'package:test_project/utils/global.util.dart';

//ignore: must_be_immutable
class ConsumerWithOnReadyCallBack<T> extends StatelessWidget with LifeCyle {
  final ConsumerBuilderCallBack<T> builder;
  final ConsumerReadyCallBack<T>? onModelReady;

  ConsumerWithOnReadyCallBack(
      {Key? key, required this.builder, this.onModelReady})
      : super(key: key) {
    $configureLifeCycle();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(builder: (context, viewModel, child) {
      return builder(context, viewModel, child);
    });
  }

  @override
  void onInit() {
    if (onModelReady != null) {
      // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //   onModelReady!(
      //       Provider.of<T>(navigatorKey.currentState!.context, listen: false));
      // });
      onModelReady!(
          Provider.of<T>(navigatorKey.currentState!.context, listen: false));
    }
    super.onInit();
  }
}

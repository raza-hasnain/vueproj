import 'package:test_project/custom.func.dart';


class InternalFinalCallBack<T> {
  ValueUpdater<T>? _callBack;

  InternalFinalCallBack({ValueUpdater<T>? callBack}) : _callBack = callBack;
}

mixin LifeCyle {
  final onStart = InternalFinalCallBack<void>();
  final onDelete = InternalFinalCallBack<void>();

  void onInit() {}

  void onReady() {}

  void onClose() {}

  bool isInitialized = false;

  void _onStart() {
    if (isInitialized) return onInit();
    isInitialized = true;
  }

  bool _closed = false;

  void _onDelete() {
    if (_closed) return;
    _closed = true;
    onClose();
  }

  void $configureLifeCycle() {
    _checkIfLifeCycleIsAlreadyConfigured();
    (onStart._callBack = _onStart)();
    (onDelete._callBack = _onDelete)();
  }

  void _checkIfLifeCycleIsAlreadyConfigured() {
    if (isInitialized) {
      throw "You can only configure lifecycle once";
    }
  }
}

abstract class Lifecycle with LifeCyle {
  Lifecycle() {
    $configureLifeCycle();
  }
}

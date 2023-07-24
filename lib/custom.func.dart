
import 'package:flutter/material.dart';

typedef ValueUpdater<T> = T Function();
typedef ConsumerBuilderCallBack<T> = Widget Function(BuildContext, T, Widget?);
typedef ConsumerReadyCallBack<T> = Function(T);
typedef DialogueCloseCallback = Function(dynamic);
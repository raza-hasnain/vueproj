import 'package:get_it/get_it.dart';
import 'package:test_project/src/core/components/app.pop_ups.dart';
import 'package:test_project/src/config/providers/providers.dart';

final injector = GetIt.instance;

Future<void> initializeDependies() async {
  injector.allowReassignment = true;

  //APP PROVIDERS
  injector.registerSingleton<Providers>(Providers());
  injector.registerSingleton<AppPopUps>(AppPopUps());
}

import 'package:get_it/get_it.dart';
import 'package:test_project/providers.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.allowReassignment = true;

  //APP PROVIDERS
  injector.registerSingleton<Providers>(Providers());
}

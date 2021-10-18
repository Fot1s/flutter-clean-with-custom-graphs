// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i3;

import '../../framework/services/injectable_services_module.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final injectableServicesModule = _$InjectableServicesModule();
  gh.lazySingleton<_i3.NavigationService>(
      () => injectableServicesModule.navigationService);
  return get;
}

class _$InjectableServicesModule extends _i4.InjectableServicesModule {
  @override
  _i3.NavigationService get navigationService => _i3.NavigationService();
}

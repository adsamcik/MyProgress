import 'package:MarkMyProgress/data/preference/bloc/PreferenceBlocEvent.dart';
import 'package:MarkMyProgress/data/preference/bloc/PreferenceBlocState.dart';
import 'package:MarkMyProgress/data/preference/database/SettingsStore.dart';
import 'package:MarkMyProgress/data/preference/database/preference.dart';
import 'package:MarkMyProgress/extensions/map_extensions.dart';
import 'package:bloc/bloc.dart';

class PreferenceBloc extends Bloc<PreferenceBlocEvent, PreferenceBlocState> {
  final SettingsStore settingsStore;

  PreferenceBloc(this.settingsStore);

  @override
  PreferenceBlocState get initialState => PreferenceBlocState.notReady();

  @override
  Stream<PreferenceBlocState> mapEventToState(PreferenceBlocEvent event) =>
      event.map(
        load: _mapLoad,
        setPreference: _mapSet,
        updateFilterData: _mapUpdateFilterData,
      );

  Stream<PreferenceBlocState> _mapLoad(LoadPreferences event) async* {
    try {
      var preferences = await settingsStore
          .transactionClosed((settingsStore) => settingsStore.getAll());
      var entries =
          await preferences.map((event) => event.toMapEntry()).toList();
      yield PreferenceBlocState.ready(
          version: 0, preferences: Map<String, dynamic>.fromEntries(entries));
    } on Error catch (_, trace) {
      print(trace);
      yield PreferenceBlocState.notReady();
    }
  }

  Stream<PreferenceBlocState> _mapSet(SetPreference event) async* {
    yield await state.maybeMap(
        ready: (PreferencesReady ready) {
          var preference = Preference(event.key, event.value);
          return settingsStore.upsert(preference).then((dynamic value) {
            ready.preferences[event.key] = event.value;

            return ready.copyWith(version: ready.version + 1);
          });
        },
        orElse: () => state);
  }

  Stream<PreferenceBlocState> _mapUpdateFilterData(
      UpdateFilterData event) async* {
    yield await state.maybeMap(
        ready: (ready) {
          var data = event.data
              .toJson()
              .mapToIterable((key, dynamic value) => Preference(key, value));
          return Future.wait<dynamic>(data.map((e) {
            ready.preferences[e.key] = e.value;
            return settingsStore.upsert(e);
          })).then((value) {
            return ready.copyWith(version: ready.version + 1);
          });
        },
        orElse: () => state);
  }
}

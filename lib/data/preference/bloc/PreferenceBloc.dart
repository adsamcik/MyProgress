import 'package:MarkMyProgress/data/preference/bloc/PreferenceBlocEvent.dart';
import 'package:MarkMyProgress/data/preference/bloc/PreferenceBlocState.dart';
import 'package:MarkMyProgress/data/preference/database/SettingsStore.dart';
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
        set: _mapSet,
      );

  Stream<PreferenceBlocState> _mapLoad(LoadPreferences event) async* {
    try {
      var preferences = await settingsStore
          .transaction((settingsStore) => settingsStore.getAll());
      yield PreferenceBlocState.ready(version: 0, preferences: preferences);
    } on Error catch (_, trace) {
      print(trace);
      yield PreferenceBlocState.notReady();
    }
  }

  Stream<PreferenceBlocState> _mapSet(Set event) async* {
    yield state.maybeMap(
        ready: (PreferencesReady ready) {
          settingsStore.upsert(event.key, event.value);
          ready.preferences[event.key] = event.value;

          return ready.copyWith(version: ready.version + 1);
        },
        orElse: () => state);
  }
}

class SettingsResult {
  final bool filterChanged;
  final bool dataImported;

  SettingsResult(this.filterChanged, this.dataImported);
}

class MutableSettingsResult implements SettingsResult {
  @override
  bool filterChanged;

  @override
  bool dataImported;

  MutableSettingsResult(
      {this.filterChanged = false, this.dataImported = false});
}

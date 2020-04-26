import '../../../abstract/IPersistentBookmark.dart';
import '../abstract/DatabaseCollection.dart';
import '../../../runtime/FilterData.dart';

class DataStore extends DatabaseCollection<IPersistentBookmark> {
  Future<Iterable<IPersistentBookmark>> GetSelected(
      String filter, FilterData filterData) async {
    filter = filter.toLowerCase();
    var strippedFilter = _stripString(filter);
    var result = await GetAll();

    if (filter.isNotEmpty) {
      result = result.where((readable) =>
          _contains(readable.LocalizedTitle, strippedFilter) ||
          _contains(readable.OriginalTitle, strippedFilter));
    }

    if (filterData.reading) {
      result = result.where((readable) =>
          !readable.Abandoned &&
          (readable.Ongoing || readable.progress < readable.MaxProgress));
    }

    if (filterData.abandoned) {
      result = result.where((readable) => !readable.Abandoned);
    }

    if (filterData.ended) {
      result = result.where((readable) => readable.Ongoing);
    }

    if (filterData.finished) {
      result = result.where((readable) =>
          readable.Ongoing || readable.progress < readable.MaxProgress);
    }

    if (filterData.ongoing) {
      result = result.where((readable) => !readable.Ongoing);
    }

    var resultList = result.toList();
    resultList.sort((a, b) => a.Title.compareTo(b.Title));
    return resultList;
  }

  static bool _contains(String title, String filter) {
    if (title == null) return false;

    var strippedTitle = _stripString(title);
    return strippedTitle.contains(filter);
  }

  static String _stripString(String text) {
    return text.replaceAll(RegExp('[\\p{IsPunctuation} ]'), text);
  }
}

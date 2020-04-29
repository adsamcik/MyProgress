import '../../../abstract/IPersistentBookmark.dart';
import '../abstract/DatabaseCollection.dart';
import '../../../runtime/FilterData.dart';
import '../../../extension/UserBookmark.dart';

class DataStore extends DatabaseCollection<IPersistentBookmark> {
  Future<Iterable<IPersistentBookmark>> GetSelected(
      String filter, FilterData filterData) async {
    filter = filter.toLowerCase();
    var strippedFilter = _stripString(filter);
    var result = await GetAll();

    if (filter.isNotEmpty) {
      result = result.where((readable) =>
          _contains(readable.localizedTitle, strippedFilter) ||
          _contains(readable.originalTitle, strippedFilter));
    }

    if (filterData.reading) {
      result = result.where((readable) =>
          !readable.abandoned &&
          (readable.ongoing || readable.progress < readable.maxProgress));
    }

    if (filterData.abandoned) {
      result = result.where((readable) => !readable.abandoned);
    }

    if (filterData.ended) {
      result = result.where((readable) => readable.ongoing);
    }

    if (filterData.finished) {
      result = result.where((readable) =>
          readable.ongoing || readable.progress < readable.maxProgress);
    }

    if (filterData.ongoing) {
      result = result.where((readable) => !readable.ongoing);
    }

    var resultList = result.toList();
    resultList.sort((a, b) => a.title.compareTo(b.title));
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

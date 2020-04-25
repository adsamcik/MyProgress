using System;
using System.Collections.Generic;
using System.Linq;
using LastIRead.Data.Instance;
using LastIRead.windows.main.pages;
using LiteDB;

namespace LastIRead.data.database {
	public class DataStore : DatabaseCollection<IPersistentBookmark> {
		public DataStore(LiteDatabase database) : base(database, database.GetBookmarkCollection()) { }

		public IEnumerable<IUserBookmark> GetSelected(string filter, FilterData filterData) {
			var strippedFilter = StripString(filter);
			var result = Collection.FindAll();

			if (!string.IsNullOrEmpty(filter)) {
				result = result.Where(
					readable => Contains(readable.LocalizedTitle, strippedFilter) ||
					            Contains(readable.OriginalTitle, strippedFilter)
				);
			}

			if (filterData.Hide.HasFlag(Filter.Reading)) {
				result = result.Where(
					readable => !readable.Abandoned && (readable.Ongoing || readable.Progress < readable.MaxProgress)
				);
			}

			if (filterData.Hide.HasFlag(Filter.Abandoned)) {
				result = result.Where(readable => !readable.Abandoned);
			}

			if (filterData.Hide.HasFlag(Filter.Ended)) {
				result = result.Where(readable => readable.Ongoing);
			}

			if (filterData.Hide.HasFlag(Filter.Finished)) {
				result = result.Where(readable => readable.Ongoing || readable.Progress < readable.MaxProgress);
			}

			if (filterData.Hide.HasFlag(Filter.Ongoing)) {
				result = result.Where(readable => !readable.Ongoing);
			}

			return result
			       .Select(x => new WrapperUserBookmark(x))
			       .OrderBy(x => x.Title)
			       .ToArray();
		}

		private static bool Contains(string? title, string filter) {
			if (title == null) return false;

			var strippedTitle = StripString(title);
			return strippedTitle.Contains(filter, StringComparison.InvariantCultureIgnoreCase);
		}

		private static string StripString(string text) {
			var selectedCharacters = text
				.Where(
					character =>
						!char.IsPunctuation(character) &&
						!char.IsWhiteSpace(character) &&
						!char.IsSeparator(character)
				);

			return string.Concat(selectedCharacters);
		}
	}
}
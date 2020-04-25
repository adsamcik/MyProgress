using System.Linq;
using System.Reflection;
using LastIRead.Data.Instance;
using LiteDB;

namespace LastIRead.data.database.conversions {
	/// <summary>
	///     Converts database from readables to bookmarks.
	/// </summary>
	public class ReadableProgressableConversion : IConversion {
		public void Convert(LiteDatabase database) {
			const string bookmarksCollection = "bookmarks";

			var collection = database.GetCollection(bookmarksCollection);
			var castList = collection.FindAll().ToArray();

			foreach (var item in castList) {
				item["_type"] = $"{typeof(GenericBookmark)}, {Assembly.GetExecutingAssembly().GetName().Name}";
			}

			collection.Update(castList);
		}
	}
}
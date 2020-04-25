using LastIRead.data.database;
using LastIRead.data.database.conversions;
using LastIRead.tools;
using LiteDB;

namespace LastIRead {
	public static class AppDatabase {
		private const string BookmarkCollection = "bookmarks";
		private const string PreferenceCollection = "preferences";

		private const string Path = "reading_data.db";

		private static LiteDatabase? _database;
		private static int _getCounter;
		private static readonly object DatabaseLock = new object();

		static AppDatabase() {
			var database = GetDatabase();
			foreach (var conversion in ReflectionTools.GetImplementors<IConversion>()) {
				conversion.Convert(database);
			}

			Dispose();
		}

		public static LiteDatabase GetDatabase() {
			lock (DatabaseLock) {
				_getCounter++;
				return _database ??= new LiteDatabase(Path);
			}
		}

		public static void Dispose() {
			lock (DatabaseLock) {
				if (--_getCounter > 0 || _database == null) {
					return;
				}

				_database.Dispose();
				_database = null;
			}
		}

		/// <summary>
		///     Gets collection for progress items.
		/// </summary>
		/// <param name="database">Lite database instance</param>
		/// <returns>Progress collection</returns>
		public static ILiteCollection<IPersistentBookmark> GetBookmarkCollection(this LiteDatabase database) {
			return database.GetCollection<IPersistentBookmark>(BookmarkCollection);
		}

		public static ILiteCollection<PreferenceValue> GetPreferenceCollection(this LiteDatabase database) {
			return database.GetCollection<PreferenceValue>(PreferenceCollection);
		}
	}
}
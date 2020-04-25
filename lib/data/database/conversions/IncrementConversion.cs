using LiteDB;

namespace LastIRead.data.database.conversions {
	/// <summary>
	///     Converts database from readables to bookmarks.
	/// </summary>
	public class IncrementConversion : IConversion {
		public void Convert(LiteDatabase database) {
			var dataStore = new DataStore(database);

			var collection = dataStore.GetAll();

			foreach (var item in collection) {
				if (item.ProgressIncrement == 0.0) {
					item.ProgressIncrement = 1.0;
				}
			}

			dataStore.Update(collection);
		}
	}
}
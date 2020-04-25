using LiteDB;

namespace LastIRead.data.database {
	public class Preferences {
		public const string PrefListHide = "listHide";

		private readonly ILiteCollection<PreferenceValue> _collection;

		public Preferences(LiteDatabase database) {
			_collection = database.GetPreferenceCollection();
		}

		public void UpdatePreference(string name, object value) {
			var preference = new PreferenceValue {
				Name = name,
				Value = value
			};

			_collection.Upsert(preference);
		}

		public T GetPreference<T>(string name) {
			return _collection.FindById(new BsonValue(name)).GetValue<T>();
		}
	}

	public struct PreferenceValue {
		[BsonId]
		public string Name { get; set; }

		public object Value { get; set; }

		public T GetValue<T>() {
			return (T) Value;
		}
	}
}
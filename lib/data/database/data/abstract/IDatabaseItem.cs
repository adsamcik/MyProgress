using LiteDB;

namespace LastIRead.data.database {
	/// <summary>
	///     Determines object item. This allows generic methods to work with database items.
	/// </summary>
	public interface IDatabaseItem {
		public ObjectId? Id { get; set; }
	}
}
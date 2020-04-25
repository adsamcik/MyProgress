using LiteDB;

namespace LastIRead.data.database.conversions {
	/// <summary>
	///     Interface specifying conversion action. This converts database from older format to newer format.
	/// </summary>
	public interface IConversion {
		/// <summary>
		///     Convert method converting database from old format to new format.
		/// </summary>
		/// <param name="database">Database instance</param>
		public void Convert(LiteDatabase database);
	}
}
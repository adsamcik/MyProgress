	/// <summary>
	///     Generic implementation of database collection providing basic methods to work with collection.
	/// </summary>
	/// <typeparam name="T"></typeparam>
	abstract class DatabaseCollection<T> {
		protected readonly ILiteCollection<T> Collection;
		protected readonly LiteDatabase Database;

		protected DatabaseCollection(LiteDatabase database, ILiteCollection<T> collection) {
			Database = database;
			Collection = collection;
		}

		public async ValueTask DisposeAsync() {
			await Task.Run(Dispose);
		}

		public void Dispose() {
			Database.Dispose();
		}

		/// <summary>
		///     Updates single item.
		/// </summary>
		/// <param name="item">Item.</param>
		public void Update(T item) {
			Collection.Update(item);
		}

		/// <summary>
		///     Updates all items in a collection.
		/// </summary>
		/// <param name="itemEnumerable">Item collection (Enumerable).</param>
		public void Update(IEnumerable<T> itemEnumerable) {
			Collection.Update(itemEnumerable);
		}

		/// <summary>
		///     Inserts single item.
		/// </summary>
		/// <param name="item">Item.</param>
		public void Insert(T item) {
			Collection.Insert(item);
		}

		/// <summary>
		///     Inserts item collection.
		/// </summary>
		/// <param name="itemEnumerable">Item collection (Enumerable).</param>
		public void Insert(IEnumerable<T> itemEnumerable) {
			Collection.Insert(itemEnumerable);
		}

		/// <summary>
		///     Removes single item.
		/// </summary>
		/// <param name="item">Item.</param>
		public void Delete(T item) {
			Collection.Delete(item.Id);
		}

		/// <summary>
		///     Removes all items from a collection.
		/// </summary>
		/// <param name="itemEnumerable">Item collection (Enumerable).</param>
		public void Delete(IEnumerable<T> itemEnumerable) {
			foreach (var item in itemEnumerable) {
				Delete(item);
			}
		}

		/// <summary>
		///     Returns all items in a database.
		/// </summary>
		/// <returns>Item collection (Enumerable).</returns>
		public IEnumerable<T> GetAll() {
			return Collection.FindAll().ToArray();
		}

		/// <summary>
		///     Upserts an item.
		/// </summary>
		/// <param name="item">Item.</param>
		public void Upsert(T item) {
			Collection.Upsert(item);
		}
	}
}

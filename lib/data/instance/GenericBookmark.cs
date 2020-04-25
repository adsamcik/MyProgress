using System;
using System.Collections.Generic;
using CsvHelper.Configuration.Attributes;
using LiteDB;
using Newtonsoft.Json;

namespace LastIRead.Data.Instance {
	/// <summary>
	///     Generic readable implementation for most reading materials.
	/// </summary>
	public class GenericBookmark : BaseBookmark, IWebBookmark {
		public override ObjectId? Id { get; set; }

		public override string? LocalizedTitle { get; set; }

		public override string? OriginalTitle { get; set; }

		public override double MaxProgress { get; set; }

		[Optional]
		public override bool Ongoing { get; set; }

		[Optional]
		public override bool Abandoned { get; set; }

		[Optional]
		[JsonProperty]
		public override IList<IProgress> History { get; protected set; } = new List<IProgress>();

		public override double ProgressIncrement { get; set; } = 1.0;

		public string? WebAddress { get; set; }

		protected override IProgress CreateNewProgress(double progress) {
			return new GenericProgress(DateTime.Today, progress);
		}
	}
}
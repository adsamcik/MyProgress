using System;
using System.Collections.Generic;
using System.Linq;

namespace LastIRead.Data.Instance {
	public class WrapperUserBookmark : IUserBookmark {
		public WrapperUserBookmark(IPersistentBookmark bookmark) {
			Bookmark = bookmark ?? throw new ArgumentNullException(nameof(bookmark));
		}

		public IPersistentBookmark Bookmark { get; }

		public string Title => Bookmark.LocalizedTitle ??
		                       Bookmark.OriginalTitle ??
		                       string.Empty;

		public string FormattedProgress => $"{Progress}/{MaxProgress}";
		public IProgress? LastProgress => History.LastOrDefault();
		public DateTime StartedReading => History.FirstOrDefault()?.Date ?? DateTime.MinValue;
		public DateTime LastProgressDate => LastProgress?.Date ?? DateTime.MinValue;

		public string? LocalizedTitle {
			get => Bookmark.LocalizedTitle;
			set => Bookmark.LocalizedTitle = value;
		}

		public string? OriginalTitle {
			get => Bookmark.OriginalTitle;
			set => Bookmark.OriginalTitle = value;
		}

		public double MaxProgress {
			get => Bookmark.MaxProgress;
			set => Bookmark.MaxProgress = value;
		}

		public bool Ongoing {
			get => Bookmark.Ongoing;
			set => Bookmark.Ongoing = value;
		}

		public bool Abandoned {
			get => Bookmark.Abandoned;
			set => Bookmark.Abandoned = value;
		}

		public IList<IProgress> History => Bookmark.History;

		public double ProgressIncrement {
			get => Bookmark.ProgressIncrement;
			set => Bookmark.ProgressIncrement = value;
		}

		public double Progress {
			get => Bookmark.Progress;
			set => Bookmark.Progress = value;
		}

		public string FormattedIncrement => $"{(ProgressIncrement > 0 ? '+' : '-')} {ProgressIncrement}";

		public void IncrementProgress() {
			Bookmark.IncrementProgress();
		}

		public void LogProgress(double progress) {
			Bookmark.LogProgress(progress);
		}
	}
}
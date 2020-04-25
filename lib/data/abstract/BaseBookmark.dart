import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

	/// <summary>
	///     Base readable implementation providing utility methods for UI.
	/// </summary>
  @JsonSerializable()
class BaseBookmark implements IPersistentBookmark {
		private IProgress? LastProgress => History.LastOrDefault();

		[Ignore]
		[JsonIgnore]
		public abstract ObjectId? Id { get; set; }

		[Optional]
		public abstract string? LocalizedTitle { get; set; }

		[Optional]
		public abstract string? OriginalTitle { get; set; }

		[Optional]
		public abstract double MaxProgress { get; set; }

		[Optional]
		public abstract bool Ongoing { get; set; }

		[Optional]
		public abstract bool Abandoned { get; set; }

		public abstract IList<IProgress> History { get; protected set; }
		public abstract double ProgressIncrement { get; set; }

		[Optional]
		[JsonIgnore]
		[BsonIgnore]
		public virtual double Progress {
			get => LastProgress?.Value ?? 0.0;
			set => LogProgress(value);
		}

		public virtual void IncrementProgress() {
			LogProgress(Progress + ProgressIncrement);
		}

		public virtual void LogProgress(double progress) {
			if (!Ongoing && MaxProgress > 0) {
				progress = Math.Min(MaxProgress, progress);
			}

			if (Ongoing) {
				MaxProgress = Math.Max(progress, MaxProgress);
			}

			var newProgress = CreateNewProgress(progress);
			if (LastProgress?.Date != newProgress.Date) {
				History.Add(newProgress);
			} else {
				History[^1] = newProgress;
			}
		}

		protected abstract IProgress CreateNewProgress(double progress);
	}
}

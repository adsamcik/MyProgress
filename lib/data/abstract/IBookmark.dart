import 'dart:core';
import 'IProgress.dart';

abstract class IBookmark {
		/// <summary>
		///     Title of the reading material
		/// </summary>
		String LocalizedTitle;

		/// <summary>
		///     Title of the reading material in original language.
		/// </summary>
		String OriginalTitle;

		String get Title;

		/// <summary>
		///     Max progress indicates how long the reading material is.
		/// </summary>
		double MaxProgress;

		/// <summary>
		///     Indicates whether the reading material is still being added to.
		///     This allows max progress to expand if actual progress is larger.
		/// </summary>
		bool Ongoing;

		/// <summary>
		///     Is abandoned.
		/// </summary>
		bool Abandoned;

		/// <summary>
		///     Complete progress history of reading.
		/// </summary>
		List<IProgress> get history;

		/// <summary>
		///     Progress increment value.
		/// </summary>
		double ProgressIncrement;

		/// <summary>
		///     Latest progress data.
		/// </summary>
		double progress;

		/// <summary>
		///     Increments progress by 1. If this is first time reading that day
		///     also creates a new record.
		/// </summary>
		void IncrementProgress();

		/// <summary>
		///     Updates reading progress with given progress value.
		/// </summary>
		/// <param name="progress">Progress value</param>
		void LogProgress(double progress);
}

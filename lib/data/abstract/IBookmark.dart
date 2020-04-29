import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

import 'IProgress.dart';

abstract class IBookmark {
		/// <summary>
		///     Title of the reading material
		/// </summary>
		String localizedTitle;

		/// <summary>
		///     Title of the reading material in original language.
		/// </summary>
		String originalTitle;

    /// <summary>
    ///     Default title for reading material. Should not store value by itself.
    /// </summary>
		String get title;

		/// <summary>
		///     Max progress indicates how long the reading material is.
		/// </summary>
		double maxProgress;

		/// <summary>
		///     Indicates whether the reading material is still being added to.
		///     This allows max progress to expand if actual progress is larger.
		/// </summary>
		bool ongoing;

		/// <summary>
		///     Is abandoned.
		/// </summary>
		bool abandoned;

		/// <summary>
		///     Complete progress history of reading.
		/// </summary>
		List<IProgress> get history;

		/// <summary>
		///     Progress increment value.
		/// </summary>
		double progressIncrement;

		/// <summary>
		///     Increments progress by 1. If this is first time reading that day
		///     also creates a new record.
		/// </summary>
		void incrementProgress();

		/// <summary>
		///     Updates reading progress with given progress value.
		/// </summary>
		/// <param name="progress">Progress value</param>
		void logProgress(double progress);
}

extension DurationExtensions on Duration {
  /// Counts number of days in Duration
  /// https://stackoverflow.com/a/248525
  int countDays(DateTime start, int weekDay) {
    var days = inDays;
    var count = (days / 7).floor(); // Number of whole weeks
    var remainder = (days % 7); // Number of remaining days
    var sinceLastDay = start.weekday - weekDay; // Number of days since last [day]
    if (sinceLastDay < 0) sinceLastDay += 7; // Adjust for negative days since last [day]

    // If the days in excess of an even week are greater than or equal to the number days since the last [day], then count this one, too.
    if (remainder >= sinceLastDay) count++;

    return count;
  }
}

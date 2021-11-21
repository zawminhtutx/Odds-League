bool isSameDay({required DateTime dayOne, required DateTime dayTwo}) {
  return dayOne.day == dayTwo.day &&
      dayOne.month == dayTwo.month &&
      dayOne.year == dayTwo.year;
}

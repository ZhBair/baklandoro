import 'dart:core';

String formatDuration(Duration duration) => '$duration'.split('.')[0].padLeft(8, '0');

String formatMillis(int millis) => formatDuration(Duration(milliseconds: millis));

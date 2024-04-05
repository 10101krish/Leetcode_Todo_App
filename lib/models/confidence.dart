import 'package:flutter/material.dart';

enum ConfidenceLevel {
  low,
  medium,
  high,
}

Color confidenceColor(ConfidenceLevel confidenceLevel) {
  if (confidenceLevel == ConfidenceLevel.low) {
    return Colors.redAccent.shade700;
  } else if (confidenceLevel == ConfidenceLevel.medium) {
    return Colors.yellow.shade900;
  } else if (confidenceLevel == ConfidenceLevel.high) {
    return Colors.green.shade900;
  }
  return Colors.black;
}

Map<ConfidenceLevel, int> dueDelay = {
  ConfidenceLevel.high: 21,
  ConfidenceLevel.medium: 14,
  ConfidenceLevel.low: 7,
};

Map<String, ConfidenceLevel> mapConfidence = {
  'low': ConfidenceLevel.low,
  'medium': ConfidenceLevel.medium,
  'high': ConfidenceLevel.high,
};

import 'package:flutter/material.dart';

enum ConfidenceLevel {
  low,
  medium,
  high,
  expierienced,
}

Map<String, ConfidenceLevel> mapConfidence = {
  'low': ConfidenceLevel.low,
  'medium': ConfidenceLevel.medium,
  'high': ConfidenceLevel.high,
  'expierienced': ConfidenceLevel.expierienced,
};

Map<ConfidenceLevel, Color> confidenceColor = {
  ConfidenceLevel.low: Colors.redAccent.shade700,
  ConfidenceLevel.medium: Colors.yellow.shade900,
  ConfidenceLevel.high: Colors.green.shade900,
  ConfidenceLevel.expierienced: Colors.deepPurple.shade800,
};

Map<ConfidenceLevel, int> dueDelay = {
  ConfidenceLevel.high: 21,
  ConfidenceLevel.medium: 14,
  ConfidenceLevel.low: 7,
  ConfidenceLevel.expierienced: 28,
};

Map<ConfidenceLevel, String> confidenceSubstitleText = {
  ConfidenceLevel.low: 'Require a lot of practice',
  ConfidenceLevel.medium: 'May require practice from time to time',
  ConfidenceLevel.high: 'Pratice once a month is enough',
  ConfidenceLevel.expierienced: 'No more practice needed',
};

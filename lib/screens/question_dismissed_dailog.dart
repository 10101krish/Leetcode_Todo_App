import 'package:flutter/material.dart';
import 'package:leetcode_todo_app/models/confidence.dart';
import 'package:leetcode_todo_app/models/question.dart';

class QuestionDismissedDialog extends StatefulWidget {
  const QuestionDismissedDialog({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  State<QuestionDismissedDialog> createState() {
    return _QuestionDismissedDialogState();
  }
}

class _QuestionDismissedDialogState extends State<QuestionDismissedDialog> {
  late ConfidenceLevel _selectedConfidenceLevel;

  @override
  void initState() {
    super.initState();
    _selectedConfidenceLevel = widget.question.confidence;
  }

  Widget formatConfidenceText(ConfidenceLevel confidenceLevel) {
    return Text(
      confidenceLevel.name[0].toUpperCase() + confidenceLevel.name.substring(1),
      style: TextStyle(
        color: confidenceColor[confidenceLevel],
        fontWeight: FontWeight.w500,
        fontSize: 20,
      ),
    );
  }

  Widget confidenceRadioButtons(ConfidenceLevel confidenceLevel) {
    return RadioListTile(
      title: formatConfidenceText(confidenceLevel),
      subtitle: Text(confidenceSubstitleText[confidenceLevel]!),
      value: confidenceLevel,
      groupValue: _selectedConfidenceLevel,
      onChanged: (value) {
        setState(() {
          _selectedConfidenceLevel = value!;
        });
      },
    );
  }

  void submitDialog() {
    Navigator.of(context).pop(_selectedConfidenceLevel);
  }

  void cancelDialog() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Question Response'),
      alignment: Alignment.centerLeft,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Current Question: ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.question.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 17.5,
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            'Question Confidence : ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          for (ConfidenceLevel confidenceLevel in ConfidenceLevel.values)
            confidenceRadioButtons(confidenceLevel),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: cancelDialog,
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: submitDialog,
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

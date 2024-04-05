import 'dart:math';
import 'package:flutter/material.dart';
import 'package:leetcode_todo_app/database/database.dart';
import 'package:leetcode_todo_app/models/confidence.dart';
import 'package:leetcode_todo_app/models/question.dart';
import 'package:leetcode_todo_app/widgets/scrape_data.dart';
import 'package:string_validator/string_validator.dart';
import 'package:uuid/uuid.dart';

class NewQuestionScreen extends StatefulWidget {
  const NewQuestionScreen({super.key});

  @override
  State<NewQuestionScreen> createState() => _NewQuestionScreenState();
}

class _NewQuestionScreenState extends State<NewQuestionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _dataScrapped = false;
  String _enteredURL = '';
  String _enteredQuestionTitle = '';
  String _enteredDescription = '';
  String _enteredDifficulty = '';
  ConfidenceLevel _selectedConfidenceLevel = ConfidenceLevel.low;

  Uuid uuid = const Uuid();

  String questionTitleFilter(String rawQuestionTitle) {
    return rawQuestionTitle.substring(0, rawQuestionTitle.indexOf('-'));
  }

  String questionDescriptionFilter(String rawQuestionDescription) {
    String tempString = rawQuestionDescription
        .substring(0, min(200, rawQuestionDescription.length))
        .trim();
    return '${tempString.substring(0, tempString.lastIndexOf('.')).trim()}.';
  }

  void fetchItem() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      List<String> returnValues = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScrapeDate(link: _enteredURL)),
      );
      setState(() {
        _dataScrapped = true;
        _enteredQuestionTitle = questionTitleFilter(returnValues[0]).trim();
        _enteredDescription = questionDescriptionFilter(returnValues[1]).trim();
        _enteredDifficulty = returnValues[2].trim();
      });
    }
  }

  void resetItem() {
    _formKey.currentState!.reset();
    setState(() {
      _dataScrapped = false;
    });
  }

  void saveItem() async {
    final Question question = Question(
      id: uuid.v4(),
      title: _enteredQuestionTitle,
      description: _enteredDescription,
      difficulty: _enteredDifficulty,
      confidence: _selectedConfidenceLevel,
    );
    addNewQuestion(question: question);
    Navigator.pop(context);
  }

  String formatConfidenceLevelName(String confidenceLevelName) {
    return confidenceLevelName[0].toUpperCase() +
        confidenceLevelName.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    Widget additionalTextFields({
      required String initialvalue,
      required TextInputType textInputType,
      required String fieldTitle,
      required IconData iconData,
      int? maxLines,
    }) {
      return TextFormField(
        initialValue: initialvalue,
        keyboardType: textInputType,
        maxLines: maxLines == null ? maxLines : 1,
        decoration: InputDecoration(
          label: Text(fieldTitle),
          enabled: false,
          icon: Icon(iconData),
        ),
      );
    }

    Widget additionalFormElements() {
      return Column(
        children: [
          additionalTextFields(
            initialvalue: _enteredQuestionTitle,
            textInputType: TextInputType.text,
            fieldTitle: 'Question Title',
            iconData: Icons.title,
          ),
          const SizedBox(height: 10),
          additionalTextFields(
            initialvalue: _enteredDescription,
            textInputType: TextInputType.multiline,
            fieldTitle: 'Question Description',
            iconData: Icons.description,
            maxLines: null,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: additionalTextFields(
                  initialvalue: _enteredDifficulty,
                  textInputType: TextInputType.text,
                  fieldTitle: 'Question Difficulty',
                  iconData: Icons.description,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    label: Text('Confidence Level'),
                    icon: Icon(Icons.bolt),
                  ),
                  value: _selectedConfidenceLevel,
                  items: [
                    for (ConfidenceLevel confidence in ConfidenceLevel.values)
                      DropdownMenuItem(
                        value: confidence,
                        child: Text(
                          formatConfidenceLevelName(confidence.name),
                          style: TextStyle(
                            color: confidenceColor(confidence),
                          ),
                        ),
                      ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedConfidenceLevel = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: resetItem,
                child: const Text('Reset Form'),
              ),
              ElevatedButton(
                onPressed: saveItem,
                child: const Text('Save'),
              ),
            ],
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Question'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    label: Text('Question URL'),
                    icon: Icon(Icons.link),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || !isURL(value)) {
                      return 'Please enter a URL';
                    } else if (!contains(
                        value, 'https://leetcode.com/problems/')) {
                      return 'Please enter a LeetCode Question URL';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    _enteredURL = newValue!;
                  },
                ),
                const SizedBox(height: 10),
                if (_dataScrapped)
                  additionalFormElements()
                else
                  ElevatedButton(
                    onPressed: fetchItem,
                    child: const Text('Fetch Data'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

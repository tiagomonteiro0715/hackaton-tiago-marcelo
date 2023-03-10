import 'package:flutter/material.dart';
import 'package:dart_openai/openai.dart';

void main() => runApp(const MyApp());

/// `MyApp` is a `StatelessWidget` that returns a `MaterialApp` with a `title` and a `home` property
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  /// `build` is a function that returns a widget
  ///
  /// Args:
  ///   context (BuildContext): The current configuration.
  ///
  /// Returns:
  ///   A MaterialApp widget.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: chatGPTAnswer(),
    );
  }
}

/// `chatGPTAnswer` is a `StatefulWidget` that creates a `_chatGPTAnswerState` when it's
/// `createState` method is called
class chatGPTAnswer extends StatefulWidget {
  const chatGPTAnswer({super.key});

  @override
  State<chatGPTAnswer> createState() => _chatGPTAnswerState();
}

class _chatGPTAnswerState extends State<chatGPTAnswer> {

  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }
  /// _generateTextFromChatGPTAPI() is a function that takes in a string and returns a string. It uses the
  /// OpenAI API to generate text based on the input string._
  ///
  /// Returns:
  ///   A string of text.
  Future<String> _generateTextFromChatGPTAPI() async {
    /// It's setting the API key for the OpenAI API.
    OpenAI.apiKey = "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";

    /// It's calling the OpenAI API to generate text based on the input string.
    final completion = await OpenAI.instance.completion.create(
      model: "text-davinci-003",
      prompt: "What is the meaning of life?",
      maxTokens: 5,
    );

    return (completion.choices[0].text);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.displayMedium!,
      textAlign: TextAlign.center,
      child: FutureBuilder<String>(
        future:
            _generateTextFromChatGPTAPI(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          /// It's checking if the snapshot has data. If it does, it's setting the children to a list of widgets.
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[
              /// It's adding padding to the text.
              Padding(
                padding: const EdgeInsets.only(
                    top: 16, bottom: 16, left: 16, right: 16),
                child: Text(
                  'You might have: ${snapshot.data}',
                  textScaleFactor: 0.5,
                ),
              ),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'Awaiting result...',
                  textScaleFactor: 0.5,
                ),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }
}
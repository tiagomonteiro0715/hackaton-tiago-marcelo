import 'package:flutter/material.dart';
import 'package:dart_openai/openai.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: ChatGPTAnswer(),
    );
  }
}

class ChatGPTAnswer extends StatefulWidget {
  const ChatGPTAnswer({Key? key}) : super(key: key);

  @override
  State<ChatGPTAnswer> createState() => _ChatGPTAnswerState();
}

class _ChatGPTAnswerState extends State<ChatGPTAnswer> {
  late TextEditingController _controller;
  String _prompt = '';

  /// `initState()` is a function that is called when the widget is first created.
  ///
  /// `super.initState()` is a function that is called when the widget is first created.
  ///
  /// `_controller` is a variable that is called when the widget is first created.
  ///
  /// `TextEditingController()` is a function that is called when the widget is first created.
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  /// It takes a string as input, and returns a string as output
  ///
  /// Args:
  ///   gptPrompt (String): This is the text that you want to use to generate the response.
  ///
  /// Returns:
  ///   A string of text.

  Future<String> _generateTextFromChatGPTAPI(String gptPrompt) async {
    OpenAI.apiKey = "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";

    final completion = await OpenAI.instance.completion.create(
      model: "text-davinci-003",
      prompt: gptPrompt,
      maxTokens: 50,
    );

    return (completion.choices[0].text);
  }

  /// It takes a string as input, and returns a string as output
  ///
  /// Args:
  ///   context (BuildContext): The context of the widget.
  ///
  /// Returns:
  ///   A string.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Creating the app bar.
      appBar: AppBar(
        title: const Text('Chat with GPT'),
      ),

      body: Column(
        children: [
          /// Creating a text field.
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter your message',
                border: OutlineInputBorder(),
              ),

              /// Setting the value of the text field to the value of the string.
              onSubmitted: (String value) {
                setState(() {
                  _prompt = value;
                });
              },
            ),
          ),

          Expanded(
            child: FutureBuilder<String>(
              future: _generateTextFromChatGPTAPI(_prompt),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                List<Widget> children;

                /// Checking if the snapshot has data. If it does, it will return the data.
                if (snapshot.hasData) {
                  children = <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        '${snapshot.data}',
                        style: const TextStyle(fontSize: 24.0),
                      ),
                    ),
                  ];
                }

                /// If the data is loading, show a progress indicator. If the data is done loading,
                /// show the data. If the data failed to load, show an error message
                ///
                /// Args:
                ///    (snapshot):
                else if (snapshot.hasError) {
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
                }

                /// Showing the text "Type a message to start chatting" if the data is not loading.
                else {
                  children = const <Widget>[
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Type a message to start chatting',
                        style: TextStyle(fontSize: 24.0),
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

            /// Returning the data.
          ),
        ],
      ),
    );
  }
}

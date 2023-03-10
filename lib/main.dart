import 'package:flutter/material.dart';
import 'package:dart_openai/openai.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: chatGPTAnswer(),
    );
  }
}

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

  Future<String> _generateTextFromChatGPTAPI(String APIprompt) async {
    /// It's setting the API key for the OpenAI API.
    OpenAI.apiKey = "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";
    /// It's calling the OpenAI API to generate text based on the input string.
    final completion = await OpenAI.instance.completion.create(
      model: "text-davinci-003",
      prompt: APIprompt,
      maxTokens: 10,
    );
    return (completion.choices[0].text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String userInput;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "DoctorAI",
              textScaleFactor: 2,
            ),
            FutureBuilder<String>(
              future: _generateTextFromChatGPTAPI(
                  userInput), // a previously-obtained Future<String> or null
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16, bottom: 16, left: 16, right: 16),
                      child: Text('Result: ${snapshot.data}'),
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
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
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
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'What are you feeling?',
              ),
              controller: _controller,
              onSubmitted: (String value) async {
                userInput = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
  String _prompt = ' ';

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
    String API_KEY = "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";
    OpenAI.apiKey = API_KEY;

    if (gptPrompt != ' ') {
      final completion = await OpenAI.instance.completion.create(
        model: "text-davinci-003",
        prompt: """

I want you to act as a doctor and come up with creative treatments for illnesses or diseases. 

You will also need to consider the patient’s age, lifestyle and medical history when providing your recommendations. 

Only anwer in bullet points within the categories: conventional medicines, herbal remedies and other natural alternatives. 

Do not surpass 200 tokens

My first suggestion request is “$gptPrompt”.

""",
        maxTokens: 10,
      );
      return (completion.choices[0].text);
    }
    return ("""
    \nMay occasionally produce harmful or biased content due to data and language patterns used to train me
    \nKnowledge of world events and information is limited to data and events up until 2021
    \nFact-checking is recommended, especially for specialized or technical subjects
    \nLimitations should be kept in mind when relying on my services for research or analysis""");
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
      backgroundColor: Color.fromARGB(255, 45, 45, 45),
      appBar: AppBar(
        title: const Text('Chat with GPT'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Creating a text field.
          Text("DoctorAI",
              textScaleFactor: 2, style: TextStyle(color: Colors.white)),
          Expanded(
            child: FutureBuilder<String>(
              future: _generateTextFromChatGPTAPI(_prompt),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                List<Widget> children;

                /// Checking if the snapshot has data. If it does, it will return the data.
                if (snapshot.hasData) {
                  children = <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 1000,
                        height: 350,
                        padding: EdgeInsets.all(
                            14.0), // add some padding to the container
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 111, 111,
                              111), // set the background color to grey
                          borderRadius: BorderRadius.circular(
                              20.0), // set the border radius to 10
                        ),
                        child: Text(
                          '${snapshot.data}',
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
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
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
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
          Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white,
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter your message',
                border: OutlineInputBorder(),
                fillColor: Colors.grey,
              ),

              /// Setting the value of the text field to the value of the string.
              onSubmitted: (String value) {
                setState(() {
                  _prompt = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

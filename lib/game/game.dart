import 'package:flutter/material.dart';

class WordPairGameScreen extends StatefulWidget {
  const WordPairGameScreen({super.key});

  @override
  State<WordPairGameScreen> createState() => _WordPairGameScreenState();
}

class _WordPairGameScreenState extends State<WordPairGameScreen> {
  // List of words (English-Hindi pairs)
  final List<String> englishWords = ['Apple', 'Book', 'Dog', 'Sun', 'Water'];
  final List<String> hindiWords = ['Seb', 'Kitab', 'Kutta', 'Sooraj', 'Paani'];

  // To track selected button colors
  List<Color> buttonColorsEnglish = List.filled(5, Colors.grey);
  List<Color> buttonColorsHindi = List.filled(5, Colors.grey);

  // To track disabled state of buttons
  List<bool> buttonDisabledHindi = List.filled(5, false);

  int? firstSelectedIndex; // Store the first selected button index
  String? firstSelectedWord; // Store the first selected word

  // Function to handle button clicks
  void handleClick(int index, String word, bool isEnglish) {
    setState(() {
      if (firstSelectedIndex == null && isEnglish) {
        // First button clicked (English side)
        firstSelectedIndex = index;
        firstSelectedWord = word;
        buttonColorsEnglish[index] = Colors.green; // Turn first button green
      } else if (firstSelectedIndex != null && !isEnglish) {
        // Second button clicked (Hindi side)
        bool isCorrectPair =
            hindiWords[index] == hindiWords[firstSelectedIndex!];

        if (isCorrectPair) {
          // If correct pair, second button turns green and is disabled
          buttonColorsHindi[index] = Colors.green;
          buttonDisabledHindi[index] = true;
        } else {
          // If incorrect, second button turns red briefly, then reverts to grey
          buttonColorsHindi[index] = Colors.red;
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              buttonColorsHindi[index] = Colors.grey;
            });
          });
        }

        // Reset the first button state regardless of the result
        firstSelectedIndex = null;
        firstSelectedWord = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("English-Hindi Word Pair Game"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(englishWords.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // English Word Button
                  SizedBox(
                    height: h * 0.06,
                    width: w * 0.35,
                    child: ElevatedButton(
                      onPressed: () =>
                          handleClick(index, englishWords[index], true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            buttonColorsEnglish[index], // Button color
                      ),
                      child: Text(englishWords[index]), // English Word
                    ),
                  ),

                  const SizedBox(width: 20), // Space between buttons

                  // Hindi Word Button
                  SizedBox(
                    height: h * 0.06,
                    width: w * 0.35,
                    child: ElevatedButton(
                      onPressed: buttonDisabledHindi[index]
                          ? null
                          : () => handleClick(index, hindiWords[index], false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColorsHindi[index],
                        disabledBackgroundColor: Colors.green, // Button color
                      ),
                      child: Text(hindiWords[index]), // Hindi Word
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

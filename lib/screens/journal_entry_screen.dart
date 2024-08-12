import 'package:flutter/material.dart';
import 'package:clearmind_app/services/database_service.dart';
import 'package:clearmind_app/models/journal_entry.dart';
import 'package:clearmind_app/screens/entry_list_screen.dart';
import 'package:clearmind_app/widgets/mood_selector.dart';

class JournalEntryScreen extends StatefulWidget {
  @override
  _JournalEntryScreenState createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends State<JournalEntryScreen> {
  final TextEditingController _textController = TextEditingController();
  String selectedMood = 'Neutral';
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Journal Entry',
          selectionColor: Color.fromARGB(255, 240, 236, 236),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Background image based on mood
          Positioned.fill(
            child: _getBackgroundImage(selectedMood),
          ),
          // UI components overlaid on the background
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    maxLines: null,
                    style: TextStyle(color: Colors.white), // Text color
                    decoration: InputDecoration(
                      hintText: 'Write your thoughts here...',
                      hintStyle:
                          TextStyle(color: Colors.white70), // Hint text color
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(16.0), // Curved border
                        borderSide:
                            BorderSide(color: Colors.white), // Border color
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(16.0), // Curved border
                        borderSide:
                            BorderSide(color: Colors.white), // Border color
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(16.0), // Curved border
                        borderSide:
                            BorderSide(color: Colors.white), // Border color
                      ),
                      filled: true,
                      fillColor: Colors.black
                          .withOpacity(0.5), // Input field background color
                    ),
                  ),
                ),
                SizedBox(height: 10),
                MoodSelector(
                  onMoodSelected: (mood) {
                    setState(() {
                      selectedMood = mood;
                    });
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black, // Button color
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () async {
                    String content = _textController.text.trim();

                    if (content.isEmpty) {
                      _showSnackBar('Please enter some text before saving.');
                      return;
                    }

                    try {
                      await _databaseService.insertJournalEntry(
                        JournalEntry(
                          content: content,
                          mood: selectedMood,
                          id: null,
                        ),
                      );
                      _textController.clear();
                      setState(() {
                        selectedMood = 'Neutral';
                      });
                      _showSnackBar('Entry saved successfully!');
                    } catch (e) {
                      _showSnackBar('Failed to save entry: $e');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                    child: Text('Save Entry'),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black, // Button color
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EntryListScreen()),
                    );
                  },
                  label: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text('View Entries'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBackgroundImage(String mood) {
    switch (mood) {
      case 'Happy':
        return Image.asset(
          'assets/images/happy_bg.jpg',
          fit: BoxFit.cover,
        );
      case 'Sad':
        return Image.asset(
          'assets/images/sad_bg.jpg',
          fit: BoxFit.cover,
        );
      default:
        return Image.asset(
          'assets/images/neutral_bg.jpg',
          fit: BoxFit.cover,
        );
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

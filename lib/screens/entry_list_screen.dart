import 'package:flutter/material.dart';
import 'package:clearmind_app/services/database_service.dart';
import 'package:clearmind_app/models/journal_entry.dart';

class EntryListScreen extends StatefulWidget {
  @override
  _EntryListScreenState createState() => _EntryListScreenState();
}

class _EntryListScreenState extends State<EntryListScreen> {
  final DatabaseService _databaseService = DatabaseService();
  String _selectedFilter = 'All'; // Default filter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Journal Entries',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.home, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Filter Chips
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Wrap(
              spacing: 8.0,
              children: [
                _buildFilterChip('All', Colors.grey.shade600),
                _buildFilterChip('Happy', Colors.yellow.shade700),
                _buildFilterChip('Sad', Colors.blue.shade700),
                _buildFilterChip('Neutral', Colors.grey.shade500),
              ],
            ),
          ),
          // Entries List
          Expanded(
            child: FutureBuilder<List<JournalEntry>>(
              future: _getFilteredEntries(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                var entries = snapshot.data!;
                return ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (context, index) {
                    final entry = entries[index];
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: _getMoodColor(entry.mood),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Stack(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.all(16.0),
                            title: Text(
                              entry.content,
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0)),
                            ),
                            subtitle: Text(
                              'Mood: ${entry.mood}',
                              style: TextStyle(
                                  color: const Color.fromARGB(179, 85, 85, 85)),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () async {
                                if (entry.id == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Entry ID is null')),
                                  );
                                  return;
                                }
                                try {
                                  await _databaseService
                                      .deleteJournalEntry(entry.id!);
                                  setState(() {}); // Refresh the UI
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Entry deleted')),
                                  );
                                } catch (e) {
                                  // Show error if delete operation fails
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Failed to delete entry: $e')),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade700,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String mood, Color color) {
    return FilterChip(
      label: Text(mood, style: TextStyle(color: Colors.white)),
      selected: _selectedFilter == mood,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? mood : 'All';
        });
      },
      selectedColor: Colors.black,
      backgroundColor: color,
      selectedShadowColor: Colors.transparent,
    );
  }

  Future<List<JournalEntry>> _getFilteredEntries() async {
    List<JournalEntry> entries = await _databaseService.getJournalEntries();
    if (_selectedFilter == 'All') {
      return entries;
    } else {
      return entries.where((entry) => entry.mood == _selectedFilter).toList();
    }
  }

  Color _getMoodColor(String mood) {
    switch (mood) {
      case 'Happy':
        return Colors.yellow.shade100;
      case 'Sad':
        return Colors.blue.shade100;
      default:
        return Colors.grey.shade500;
    }
  }
}

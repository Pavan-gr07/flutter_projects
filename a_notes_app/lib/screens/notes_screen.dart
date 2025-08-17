import 'package:a_notes_app/database/notes_database.dart';
import 'package:a_notes_app/screens/note_dialog.dart';
import 'package:flutter/material.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    final fetchedNotes = await NotesDatabase.instance.getNotes();

    setState(() {
      notes = fetchedNotes;
    });
  }

final List<Color> noteColors = [
  const Color(0xFFFFF3E0),
  const Color(0xFFE1F5FE),
  const Color(0xFFFFE4EC),
  const Color(0xFFF8F9CF),
  const Color(0xFFFFF9AB),
  const Color(0xFFB2F9FC),
  const Color(0xFFFFDF59A),
  const Color(0xFFFFE4B5),
  const Color(0xFFF9F8FB98),
  const Color(0xFFFFFD700),
  const Color(0xFFFAFEEE),
  const Color(0xFFFFFB6C1),
  const Color(0xFFFFFAD2),
  const Color(0xFFD3D3D3),
];

void showNoteDialog({int? id, String? title, String? content, int colorindex = 0}) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return NoteDialog(
          colorindex: colorindex,
          noteColors: noteColors,
          noteId: id,
          title: title,
          content: content,
          onNotSaved: (newTitle, newDescription, newColorIndex, currentDate) async {
            if (id == null) {
              await NotesDatabase.instance.addNote(newTitle, newDescription, currentDate, newColorIndex);
            } else {
              await NotesDatabase.instance.updateNote(newTitle, newDescription, currentDate, newColorIndex, id);
            }
            fetchNotes(); // Refresh notes after add/update
            Navigator.of(dialogContext).pop(); // Close dialog
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        showNoteDialog();
      },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add,color:Colors.amber),
        ),
      body: notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notes_outlined, size: 80, color: Colors.grey[600]),
                  const SizedBox(height: 20),
                  Text(
                    'No Notes Found',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];

                  return Text(note['title']);
                },
              ),
            ),
    );
  }
}

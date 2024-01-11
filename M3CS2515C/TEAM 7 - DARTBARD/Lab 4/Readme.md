
#2310-ICT602

#Lab Work 4 CRUD

1. Group of 4
2. Using VS Code create the information page detail form.
3. Using Firebase as a Database.
4. Speed Code Video + Music + End with Highlight on VSCode final coding pages
5. Create form for User Information.
6. Create form other information (e.g. Product, Transaction, Course or Department)
7. Run on AVD

Group Members

1. MUHAMMAD AIMAN HAZIQ BIN MOHD RAZI (2022879436)
2. NIK AFIQ AKMAL BIN NIK PAR (2022830644)
3. SYED FAISAL BIN SYED AB.RAZAK (2022874134)
4. AHMAD FIKRIE BIN MIRZA (2022873988)


FULL CODE VS:

CREATE

```dart
class AddBookScreen extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();

  void _addBook(BuildContext context) {
    FirebaseFirestore.instance.collection('books').add({
      'title': _titleController.text,
      'author': _authorController.text,
      // Add more fields as needed
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Book Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _addBook(context),
              child: Text('Add Book'),
            ),
          ],
        ),
      ),
    );
  }
}
```

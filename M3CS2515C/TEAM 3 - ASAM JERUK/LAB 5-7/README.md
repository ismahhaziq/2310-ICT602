# Lab Work 5

## CRUD

1. Group of 4
2. Using VS Code create the information page detail form.
3. Using Firebase as a Database.
4. Speed Code Video + Music.
5. Create Page for User Information.
6. Create Page for other information (e.g. Product, Transaction, Course or Department)
7. Run on AVD
8. Github page README.md should highlight on VSCode final coding pages + Speedcode.


### LINK FOR LAB: 

Link Speedcode : https://youtu.be/Z7f-nkdU56E

Link source code: https://github.com/thisisnotmasyi/ICT602-LAB5.git

******************************************************************************************

Update Function

```
 void updateStudent() {
    studentCollection.doc(documentID).update({
      'name': newName,
      'matric': newMatric,
      'faculty': newFaculty,
      'programme': newProgramme,
      'programme code': newProgrammeCode,
      'isDeleted': false,
      'updated_at': FieldValue.serverTimestamp(),
      });
  }
```

Delete Function

```
void deleteStudent() {
    studentCollection.doc(documentID).update({
      'isDeleted': true,
      'deleted_at': FieldValue.serverTimestamp(),
    });
  }
```

Create page for other information

```
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Students Database'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              onChanged: (value) {
                setState(() {
                  documentID = value;
                });
              },
              decoration: InputDecoration(labelText: 'Document ID (Leave empty to generate)'),
              ),
            TextField(
              onChanged: (value) {
                setState(() {
                  newName = value;
                });
              },
              decoration: InputDecoration(labelText: 'New Name'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  newMatric = value;
                });
              },
              decoration: InputDecoration(labelText: 'New Matric'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  newFaculty = value;
                });
              },
              decoration: InputDecoration(labelText: 'New Faculty'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  newProgramme = value;
                });
              },
              decoration: InputDecoration(labelText: 'New Programme'),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  newProgrammeCode = value;
                });
              },
              decoration: InputDecoration(labelText: 'New Programme Code'),
            ),
            ElevatedButton(
              onPressed: () {
                createStudent();
              },
              child: Text('Create'),
            ),
            ElevatedButton(
              onPressed: () {
                updateStudent();
              },
              child: Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                deleteStudent();
              },
              child: Text('Delete'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ViewStudentsScreen()),
                );
              },
              child: Text('View'),
            ),
          ],
        ),
```

Read/View Function

```
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Students'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: studentCollection.where('isDeleted', isEqualTo: false).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final students = snapshot.data!.docs;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                final data = student.data() as Map<String, dynamic>;
                final documentID = student.id;
                final name = data['name'] as String;
                final matric = data['matric'] as String;
                return ListTile(
                  title: Text('Name: $name'),
                  subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Document ID: $documentID'),
                    Text('Matric: $matric'),
                    ]
                  )
                );
              },
```

Create Function

```
title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: register,
              child: const Text('Register'),
            ),
          ],
        ),

```

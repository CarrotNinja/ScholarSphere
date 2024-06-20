import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EcsPage extends StatefulWidget {
  final String userId; // Add userId as a parameter

  EcsPage({Key? key, required this.userId}) : super(key: key);

  @override
  _EcsPageState createState() => _EcsPageState();
}

class _EcsPageState extends State<EcsPage> {
  final List<Map<String, dynamic>> _Items = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    // Call a method to fetch Ecs from Firestore when the page loads
    _fetchEcs();
  }

  void _fetchEcs() {
    _firestore.collection('users').doc(widget.userId).collection('Ecs').get().then((querySnapshot) {
      setState(() {
        _Items.clear(); // Clear existing items
        querySnapshot.docs.forEach((doc) {
          _Items.add({
            'taskId': doc.id,
            'task': doc['task'],
            'completed': doc['completed'],
          });
        });
      });
    }).catchError((error) {
      print("Error fetching Ecs: $error");
      // Handle error gracefully, e.g., show a snackbar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to fetch Ecs')));
    });
  }

  void _addItem(String task) {
    if (task.isNotEmpty) {
      _firestore.collection('users').doc(widget.userId).collection('Ecs').add({
        'task': task,
        'completed': false,
      }).then((value) {
        setState(() {
          _Items.add({
            'taskId': value.id,
            'task': task,
            'completed': false,
          });
        });
      }).catchError((error) => print("Failed to add Ec: $error"));
    }
  }

  void _removeItem(String taskId, int index) {
    _firestore.collection('users').doc(widget.userId).collection('Ecs').doc(taskId).delete().then((value) {
      setState(() {
        _Items.removeAt(index);
      });
    }).catchError((error) => print("Failed to delete Ec: $error"));
  }

  Widget _buildList() {
    return _Items.isEmpty
        ? Center(
            child: Text(
              'No Ecs yet. Add an Ec!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          )
        : ListView.builder(
            itemCount: _Items.length,
            itemBuilder: (context, index) {
              return _buildItem(_Items[index], index);
            },
          );
  }

  Widget _buildItem(Map<String, dynamic> item, int index) {
    return Dismissible(
      key: Key(item['taskId']),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _removeItem(item['taskId'], index);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ec "${item['task']}" deleted')),
        );
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          title: Text(
            item['task'],
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  void _promptAddItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Extracurricular'),
          content: TextField(
            autofocus: true,
            onSubmitted: (val) {
              Navigator.of(context).pop();
              _addItem(val);
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ecs',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.3, 0.6, 0.9],
            colors: [
              Color(0xff56018D),
              Color(0xff8B139C),
              Colors.pink,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _buildList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _promptAddItem,
        tooltip: 'Add task',
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
      ),
    );
  }
}

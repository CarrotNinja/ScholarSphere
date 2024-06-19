import 'package:flutter/material.dart';

class AwardsPage extends StatefulWidget {
  @override
  _AwardsPageState createState() => _AwardsPageState();
}

class _AwardsPageState extends State<AwardsPage> {
  final List<Map<String, dynamic>> _Items = [];

  void _addItem(String task) {
    if (task.isNotEmpty) {
      setState(() => _Items.add({'task': task, 'completed': false}));
    }
  }

  void _removeItem(int index) {
    setState(() => _Items.removeAt(index));
  }

  void _toggleItem(int index) {
    setState(() {
      _Items[index]['completed'] = !_Items[index]['completed'];
    });
  }

  void _promptAddItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Task'),
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

  Widget _buildItem(Map<String, dynamic> Item, int index) {
  return Dismissible(
    key: Key(Item['task']),
    direction: DismissDirection.endToStart,
    onDismissed: (direction) {
      _removeItem(index);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task "${Item['task']}" deleted')),
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
          Item['task'],
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  );
}

Widget _buildList() {
  return ListView.builder(
    itemCount: _Items.length,
    itemBuilder: (context, index) {
      return _buildItem(_Items[index], index);
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Awards', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [
                    0.3,
                    0.6,
                    0.9
                  ],
                  colors: [
                Color(0xff56018D),
                
                Color(0xff8B139C),
                Colors.pink,
              ]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _Items.isEmpty
              ? Center(
                  child: Text(
                    'No awards yet. Add an award!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                )
              : _buildList(),
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

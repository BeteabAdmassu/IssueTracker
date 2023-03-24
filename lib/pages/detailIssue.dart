import 'package:flutter/material.dart';

class IssueDetails extends StatefulWidget {
  @override
  _IssueDetailsState createState() => _IssueDetailsState();
}

class _IssueDetailsState extends State<IssueDetails> {
  var vote = 0;

  void incVote() {
    setState(() {
      vote++;
    });
  }

  void decVote() {
    setState(() {
      vote--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Issue Details'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Pothole',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://images.unsplash.com/photo-1515162816999-a0c47dc192f7?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80',
                  fit: BoxFit.cover,
                  height: 250,
                ),
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Description',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ac velit eu lectus sollicitudin interdum. Integer id risus consequat, luctus magna nec, dictum risus. Duis pharetra, netus et malesuada fames ac turpis egestas. Donec sit amet ex id justo pretium iaculis ac ut augue. In hac habitasse platea dictumst.',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              '123 Main St, Addis Ababa, ETH',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey[600],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_upward, size: 35, color: Colors.green),
                onPressed: () {
                  incVote();
                },
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                vote.toString(),
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_downward,
                  size: 35,
                  color: Colors.red,
                ),
                onPressed: () {
                  decVote();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

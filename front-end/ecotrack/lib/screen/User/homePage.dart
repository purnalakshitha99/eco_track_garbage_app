import 'dart:convert';
import 'package:ecotrack/ipconfig.dart';
import 'package:ecotrack/screen/Admin/updatePost.dart';
import 'package:ecotrack/screen/User/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:like_button/like_button.dart';


class HomePage extends StatefulWidget {
  final String? token;
  final Map<String, dynamic>? userDetails;

  const HomePage({Key? key, required this.token, required this.userDetails}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map<String, dynamic>? _userDetails;
  late List<Map<String, dynamic>> _notices = [];

  @override
  void initState() {
    super.initState();
    _userDetails = widget.userDetails;
    _fetchNotices();
  }

  Future<void> _fetchNotices() async {
    final response = await http.get(
      Uri.parse('$localhost/notices2'),
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _notices = List<Map<String, dynamic>>.from(data);
      });
    } else {
      print('Failed to fetch notices with status: ${response.statusCode}');
    }
  }

  Future<void> _deleteNotice(int index) async {
    final noticeId = _notices[index]['id'];
    final response = await http.delete(
      Uri.parse('$localhost/notices2/$noticeId'),
      headers: {'Authorization': 'Bearer ${widget.token}'},
    );

    if (response.statusCode == 200) {
      setState(() {
        _notices.removeAt(index);
      });
    } else {
      print('Failed to delete notice with status: ${response.statusCode}');
    }
  }

  void _navigateToUpdatePage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdatePost(token: widget.token, userDetails: widget.userDetails, noticeId: _notices[index]['id']),
      ),
    ).then((_) {
      _fetchNotices(); // Refresh notices after returning from UpdatePost
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello ${_userDetails?['name'] ?? ''}",
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile(token: widget.token, userDetails: widget.userDetails)),
              );
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _notices.length,
        itemBuilder: (BuildContext context, int index) {
          final notice = _notices[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: const CircleAvatar(),
                  title: Text(notice['title'] ?? ''),
                  trailing: PopupMenuButton(
                    icon: const Icon(Icons.more_horiz_rounded),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete),
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'update', // Added update option
                        child: Row(
                          children: [
                            Icon(Icons.update),
                            SizedBox(width: 8),
                            Text('Update'),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'delete') {
                        _deleteNotice(index);
                      } else if (value == 'update') {
                        _navigateToUpdatePage(index); // Navigate to UpdatePost
                      }
                    },
                  ),
                  subtitle: Text(
                    notice['subtitle'] ?? '',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(notice['imagePath'] ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    notice['description'] ?? '',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: LikeButton(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(1),
                            child: Text(
                              notice['date'] ?? '',
                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Text(
                              notice['time'] ?? '',
                              style: TextStyle(color: Colors.black.withOpacity(0.6)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

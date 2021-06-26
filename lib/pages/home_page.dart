import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harperdb_hashnode_hackathon/models/failure_model.dart';
import 'package:harperdb_hashnode_hackathon/models/post_model.dart';
import 'package:harperdb_hashnode_hackathon/pages/single_post_page.dart';
import 'package:harperdb_hashnode_hackathon/repository/schedule_repository.dart';
import 'package:harperdb_hashnode_hackathon/ui/post_row.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Post>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts = ScheduleRepository().getPosts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _refreshPostList() async {
    _futurePosts = ScheduleRepository().getPosts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.title,
            style: GoogleFonts.ubuntu(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                _refreshPostList();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  Icons.sync,
                  size: 26,
                  color: Colors.black87,
                ),
              ),
            ),
          ]),
      body: RefreshIndicator(
        onRefresh: () async {
          _refreshPostList();
        },
        child: FutureBuilder<List<Post>>(
          future: _futurePosts,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final items = snapshot.data!;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return PostRow(post: items[index]);
                },
              );
            } else if (snapshot.hasError) {
              // Show failure error message.
              final failure = snapshot.error as Failure;
              return Center(child: Text(failure.message));
            }
            // Show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SinglePostPage(
                singlePost: new Post(
                    id: "",
                    link: "",
                    platform: "hashnode",
                    postDate: DateTime.now(),
                    text: "",
                    title: ""),
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

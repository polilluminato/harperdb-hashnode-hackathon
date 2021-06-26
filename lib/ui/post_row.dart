import 'package:flutter/material.dart';
import 'package:harperdb_hashnode_hackathon/models/post_model.dart';
import 'package:harperdb_hashnode_hackathon/pages/single_post_page.dart';
import 'package:intl/intl.dart';

class PostRow extends StatelessWidget {
  final Post post;

  const PostRow({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SinglePostPage(
              singlePost: post,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                Text(
                  '${DateFormat('dd').format(post.postDate)}',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${DateFormat('MMM').format(post.postDate)}',
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Image.asset(
                    "assets/logo/${post.platform}.png",
                    width: 24,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 24,
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple[200]!.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${post.title}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      '${post.text}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Text(
                    '${post.link}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

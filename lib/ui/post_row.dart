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
        margin: const EdgeInsets.all(8.0),
        child: ListTile(
          title: Text('${post.title}'),
          subtitle:
              Text('${DateFormat('dd MMMM y @ HH:mm').format(post.postDate)}'),
          leading: Image.asset(
            "assets/logo/${post.platform}.png",
            width: 32.0,
          ),
          trailing: Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}

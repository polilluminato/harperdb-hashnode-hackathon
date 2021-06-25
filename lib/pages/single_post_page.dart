import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:harperdb_hashnode_hackathon/models/post_model.dart';
import 'package:intl/intl.dart';

class SinglePostPage extends StatefulWidget {
  final Post singlePost;

  const SinglePostPage({Key? key, required this.singlePost}) : super(key: key);

  @override
  _SinglePostPageState createState() => _SinglePostPageState();
}

class _SinglePostPageState extends State<SinglePostPage> {
  String _chosenValue = "hashnode";
  List<String> _items = [
    'hashnode',
    'twitter',
    'facebook',
    'linkedin',
    'reddit',
  ];

  Widget _deletePopupDialog(BuildContext context) {
    return new AlertDialog(
      title: Text('Delete Post'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Do you really want to delete this post scheduling?"),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Dismiss'),
        ),
        SizedBox(
          width: 8,
        ),
        TextButton(
          onPressed: () {
            print("Post to Delete");
            Navigator.of(context).pop();
          },
          child: Text(
            'Yes, delete',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    bool _isNewPost = (widget.singlePost.id == 0);

    return Scaffold(
      appBar: AppBar(
        title: Text("Single Post Scheduling"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          _isNewPost
              ? Container()
              : InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _deletePopupDialog(context),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(
                      Icons.delete_forever,
                      size: 26,
                    ),
                  ),
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _isNewPost ? "" : widget.singlePost.title,
                maxLines: 1,
                decoration: InputDecoration(
                  icon: Icon(Icons.edit),
                  hintText: 'Enter the post title',
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              TextFormField(
                initialValue: _isNewPost ? "" : widget.singlePost.link,
                maxLines: 1,
                decoration: InputDecoration(
                  icon: Icon(Icons.link),
                  hintText: 'Enter the post link',
                  labelText: 'Link',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              TextFormField(
                initialValue: _isNewPost ? "" : widget.singlePost.text,
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                  icon: Icon(Icons.share),
                  hintText: 'Enter the text you want to share on social media',
                  labelText: 'Share Text',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              DateTimeField(
                initialValue: widget.singlePost.postDate,
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: 'Publish date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(),
                  ),
                ),
                format: DateFormat("yyyy-MM-dd @ HH:mm"),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: DropdownButton<String>(
                        underline: Container(color: Colors.transparent),
                        value: _isNewPost
                            ? _chosenValue
                            : widget.singlePost.platform,
                        isExpanded: true,
                        style: TextStyle(color: Colors.white),
                        items: _items
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _chosenValue = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:harperdb_hashnode_hackathon/models/post_model.dart';
import 'package:harperdb_hashnode_hackathon/repository/schedule_repository.dart';
import 'package:intl/intl.dart';

class SinglePostPage extends StatefulWidget {
  final Post singlePost;

  const SinglePostPage({Key? key, required this.singlePost}) : super(key: key);

  @override
  _SinglePostPageState createState() => _SinglePostPageState();
}

class _SinglePostPageState extends State<SinglePostPage> {
  String _chosenValue = "hashnode";

  Widget _deletePopupDialog(BuildContext context) {
    return new AlertDialog(
      title: Text(
        'Delete Post',
        style: TextStyle(color: Colors.black),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Do you really want to delete this post scheduling?",
            style: TextStyle(color: Colors.black),
          ),
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
          onPressed: () async {
            print("Post to Delete");

            bool result =
                await ScheduleRepository().removePost(widget.singlePost);

            showToast(result
                ? "Post successfully deleted"
                : "Error on delete, retry.",context: context);

            //Remove the dialog
            Navigator.of(context).pop();

            if (result) {
              //Close the screen
              Navigator.of(context).pop();
            }
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
    bool _isNewPost = widget.singlePost.id.isEmpty;

    final _titleController =
        TextEditingController(text: widget.singlePost.title);
    final _linkController = TextEditingController(text: widget.singlePost.link);
    final _textController = TextEditingController(text: widget.singlePost.text);
    final _postDateController = TextEditingController(
        text:
            DateFormat('yyyy-MM-dd HH:mm').format(widget.singlePost.postDate));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Single Post Scheduling",
          style: GoogleFonts.ubuntu(),
        ),
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
        onPressed: () async {
          widget.singlePost.title = _titleController.text;
          widget.singlePost.link = _linkController.text;
          widget.singlePost.text = _textController.text;
          widget.singlePost.postDate = DateTime.parse(_postDateController.text);

          bool result = _isNewPost
              ? await ScheduleRepository().insertPost(widget.singlePost)
              : await ScheduleRepository().updatePost(widget.singlePost);

          //I'll show a toast with the result
          showToast(
              result ? "Post successfully saved" : "Error on saving, retry.",context:context);
        },
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
                style: TextStyle(color: Colors.black),
                controller: _titleController,
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
                style: TextStyle(color: Colors.black),
                controller: _linkController,
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
                style: TextStyle(color: Colors.black),
                controller: _textController,
                minLines: 5,
                maxLines: 10,
                decoration: InputDecoration(
                  icon: Icon(Icons.message),
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
                style: TextStyle(color: Colors.black),
                controller: _postDateController,
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: 'Publish date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(),
                  ),
                ),
                format: DateFormat("yyyy-MM-dd HH:mm"),
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
                    Icons.share,
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
                        value: widget.singlePost.platform,
                        isExpanded: true,
                        style: TextStyle(color: Colors.black),
                        items: [
                          'hashnode',
                          'twitter',
                          'facebook',
                          'linkedin',
                          'reddit',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          _chosenValue = value.toString();

                          setState(() {
                            widget.singlePost.title = _titleController.text;
                            widget.singlePost.link = _linkController.text;
                            widget.singlePost.text = _textController.text;
                            widget.singlePost.postDate =
                                DateTime.parse(_postDateController.text);
                            widget.singlePost.platform = value.toString();
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

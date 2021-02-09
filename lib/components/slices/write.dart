import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

class Write extends StatefulWidget {
  @override
  _WriteState createState() => _WriteState();
}

class _WriteState extends State<Write> {
  TextEditingController _editingController;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetUserImage(),
          new Expanded(
              flex: 12,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        focusNode: _focusNode,
                        controller: _editingController,
                        decoration: InputDecoration(
                          hintText: 'Write something to share ...',
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLength: 280,
                        cursorColor: Colors.black,
                        inputFormatters: [LengthLimitingTextInputFormatter(280)],
                        maxLines: null,
                        style: GoogleFonts.muli(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w300),
                      ),
                      FlatButton(
                          onPressed: () {},
                          color: Colors.blueAccent,
                          child: Text(
                            "Post",
                            style: GoogleFonts.muli(fontSize: 18.0, color: Colors.white),
                          ))
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class GetUserImage extends StatelessWidget {
  const GetUserImage({
    Key key,
  }) : super(key: key);

  Future<FirebaseUser> _getUserData() async {
    FirebaseUser _user = await FirebaseAuth.instance.currentUser();
    return _user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserData(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (!snapshot.hasData)
          return Expanded(
            flex: 2,
            child: SizedBox(),
          );
        return Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 23.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: snapshot.data.photoUrl,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Expanded(
                      child: VerticalDivider(
                    thickness: 1.2,
                    color: Colors.indigo.shade100,
                  ))
                ],
              ),
            ));
      },
    );
  }
}

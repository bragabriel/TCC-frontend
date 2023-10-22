import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotted/app/widget/appbar_widget.dart';

class EditImagePage extends StatefulWidget {
  const EditImagePage({Key? key}) : super(key: key);

  @override
  _EditImagePageState createState() => _EditImagePageState();
}

class _EditImagePageState extends State<EditImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView( 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 330,
              child: const Text(
                "Atualizar a foto de:",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                width: 330,
                child: GestureDetector(
                  onTap: () async {
                    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

                    if (image == null) return;

                    final location = await getApplicationDocumentsDirectory();
                    final name = basename(image.path);
                    final imageFile = File('${location.path}/$name');
                    final newImage = await File(image.path).copy(imageFile.path);
                    // setState(
                    //   () => user = user.copy(url: newImage.path));
                  },
                  //child: Image.network(user.url!),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 330,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Update',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicture extends StatefulWidget {
  final String userId;
  const ProfilePicture({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  Uint8List? pickedImage;

  @override
  void initState() {
    getProfilePicture();
    super.initState();
  }
  @override
  void didUpdateWidget(ProfilePicture oldWidget) {
    if (oldWidget.userId != widget.userId) {
      getProfilePicture();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onProfileTapped,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
          image: pickedImage!=null ? DecorationImage(
            fit: BoxFit.cover,
            image: Image.memory(
              pickedImage!,
              fit: BoxFit.cover,
            ).image,
          ) : null,
        ),
        child: pickedImage==null ? Center(
          child: Icon(
            Icons.person_rounded,
            color: Colors.black38,
            size: 35,
          ),
        ): null,
      ),
    );
  }

  Future<void> getProfilePicture() async{
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child(widget.userId+'.jpg');

    try{
      final imageBytes = await imageRef.getData();
      if(imageBytes==null) return;  
      setState(() {
        pickedImage = imageBytes;
      });
    }catch(e){
      print("No profile picture found");
    }
  }

  Future<void> onProfileTapped() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image==null) return;
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child(widget.userId+'.jpg');
    final imageBytes = await image.readAsBytes();
    await imageRef.putData(imageBytes);

    setState(() {
      pickedImage = imageBytes;
    });
  }
}
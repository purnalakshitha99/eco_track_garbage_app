import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_picker/gallery_picker.dart';

Future<File?>getImageFromGallery(BuildContext context)async{
  try{
    List<MediaFile>?singleMedia = 
      await GalleryPicker.pickMedia(context: context,singleMedia: true);
      return singleMedia?.first.getFile();
  }catch(e){
    print(e);
  }
}
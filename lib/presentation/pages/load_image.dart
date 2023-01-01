import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pPath;

class LoadImageScreen extends StatefulWidget {
  static const routeName='/load_image';
  const LoadImageScreen({Key? key}):super(key:key);

  @override
  State<LoadImageScreen> createState() => _LoadImageScreenState();
}

class _LoadImageScreenState extends State<LoadImageScreen> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  XFile? image;
  File? imageTerambil;

  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Load Profile Picture from Camer"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        child:Column(
          children: [
            AspectRatio(aspectRatio: 6/4,
            child: controller == null?
                Center(child: Text("Loading Camera....")):
                !controller!.value.isInitialized?Center(child:CircularProgressIndicator()):
                    CameraPreview(controller!)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(onPressed: () async{
                  await getImage();
                  final snackBar = SnackBar(
                    elevation:0,
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    content: AwesomeSnackbarContent(
                      title: 'Yeey!',
                      message: 'Foto berhasil tersimpan',
                      contentType: ContentType.success,
                    ),
                  );
                  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(snackBar);
                },icon: Icon(Icons.save),label: Text("Save to Gallery"),
                    style: ElevatedButton.styleFrom(primary: Colors.purple,onPrimary: Colors.white)
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(30),
              child: imageTerambil==null?Text("No Image Saved"):
                Image.file(imageTerambil!),height:300,
            )
          ],
        )
      ),
    );
  }

  void loadCamera() async {
    cameras = await availableCameras();
    if (cameras!=null) {
      controller = CameraController(cameras![0], ResolutionPreset.max);
      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState((){});
      });
    }
    else {
      print("No camera found");
    }
  }

  Future getImage() async{
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked = await _picker.pickImage(source: ImageSource.camera);
    imageTerambil = File(imagePicked!.path);
    String buttonText = "Ambil Foto";
    setState(() {
      buttonText = "Saving in progress..";
    });
    final appDir  = await pPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imagePicked.path);
    await GallerySaver.saveImage(imagePicked.path, toDcim: true);
  }
}
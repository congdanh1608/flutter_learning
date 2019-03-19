import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning/views/plugins/camera_result.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:permission/permission.dart';
//import 'package:simple_permissions/simple_permissions.dart';

class TakePictureScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const TakePictureScreen({Key key, this.cameras}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TakePictureScreenState();
  }
}

class TakePictureScreenState extends State<TakePictureScreen> {
  CameraController _controller;
  Future<void> _initControllerFuture;

  @override
  initState() {
    super.initState();
    checkPermissions();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FutureBuilder<void>(
          future: _initControllerFuture,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_controller);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        RaisedButton(
          onPressed: () {
            takePicture();
          },
          child: Icon(Icons.camera),
        )
      ],
    );
  }

  checkPermissions() async {
    List<PermissionName> list = new List();
    list.add(PermissionName.Camera);
    List<Permissions> permissions = await Permission.getPermissionsStatus(list);
    if (permissions[0].permissionStatus == PermissionStatus.deny) {
      Permission.openSettings;
    } else if (permissions[0].permissionStatus == PermissionStatus.allow) {
      initCamera();
    } else {
      checkPermissions();
    }

    /* bool result = await SimplePermissions.checkPermission(Permission.Camera);
    if (!result) {
      //request permission
      final res = await SimplePermissions.requestPermission(Permission.Camera);
      if (res == PermissionStatus.deniedNeverAsk) {
        Navigator.pop(context);
      } else {
        checkPermissions();
      }
    } else {
      initCamera();
    }*/
  }

  initCamera() {
    _controller = CameraController(widget.cameras.first, ResolutionPreset.medium);
    _initControllerFuture = _controller.initialize();
  }

  takePicture() async {
    try {
      await _initControllerFuture;
      final path = join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
      await _controller?.takePicture(path);
      if (await File(path).exists()) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayPictureScreen(imagePath: path)));
      }
    } catch (ex) {
      print(ex);
    }
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

convert64BaseToFile({required String base64String,required String fileName, required Function onSuccess})async{
  try{
    String filePath = "";
    await createFolderInAppDocDir("64images").then((value) {
      filePath = path.join(value, fileName);
    });
    Uint8List imageBytes = base64Decode(base64String.substring(base64String.indexOf(',')+1));
    File file = File(filePath);
    file.exists().then((value){
      if(value){

      }
      else{
        file.writeAsBytes(imageBytes);
        onSuccess(filePath);
      }
    });
  }
     catch(e){
    print("FILE ERROR: $e");
     }

}

downloadImage(){

}


Future<String> createFolderInAppDocDir(String folderName) async {
  final Directory? downloadsDir = await getExternalStorageDirectory();
  if(downloadsDir != null){

  }
  final Directory directory = Directory(path.join(downloadsDir!.path,folderName ));
  if (await directory.exists()) {
    return directory.path;
  } else {
    final Directory newDirectory = await directory.create(recursive: true);
    final noMediaPath = path.join(directory.path, '.nomedia');
    File(noMediaPath).create();
    return newDirectory.path;
  }
}

getPermission()async{
  var permission = await Permission.storage.status;
  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  if(permission.isGranted == false){
    if(Platform.isAndroid){
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      int sdkVersion = androidDeviceInfo.version.sdkInt;
      if(sdkVersion >= 30){
        await Permission.audio.request();
        await Permission.photos.request();
        await Permission.videos.request();
      }else if(sdkVersion >= 30 && sdkVersion < 33){
        await Permission.storage.request();
      }else {
        await Permission.storage.request();
      }
    }else{
      permission =  await Permission.storage.request();
    }
  }
}


Future<Response?>download({required String url, required String savePath,required Function onDownloading})async{
  Dio dio = Dio();
  Uri uri = Uri.parse(url);
  File file = File(savePath);
  file.exists().then((value){
    return null;
  });
  final response = dio.downloadUri(uri, savePath, onReceiveProgress: (receivedData,totalByte ){
    onDownloading(receivedData, totalByte);
  });
  return response;
}

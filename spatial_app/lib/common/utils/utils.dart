import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spatial_app/common/extension/map_extension.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/core.dart';
import '../translation/translations.dart';

class Utils {
  Utils._();

  static final bool isAndroid = !isWeb && Platform.isAndroid;
  static final bool isIOS = !isWeb && Platform.isIOS;
  static const bool isWeb = kIsWeb;

  static Future<bool> urlLauncher({
    required String url,
    String? title,
    bool external = false,
  }) async {
    if (url.isEmpty) return false;

    final uri = Uri.parse(url);

    final queryParameters = uri.queryParameters;
    final hasExternal = queryParameters["external"];
    final isExternal = hasExternal == null ? external : hasExternal == "true";

    if(isExternal || isWeb){
      final canLaunch = await canLaunchUrl(uri);
      if (canLaunch) {
        final newQueryParameters = queryParameters.removeKeys(["external", "title"]);
        final newUri = uri.replace(queryParameters: newQueryParameters) ;
        await launchUrl(newUri, mode: LaunchMode.externalApplication);
      } else {
        showErrorSnackBar(LocaleKeys.somethingWentWrong.tr());
        AppLogger.e("Fail to launch URL : $uri");
      }
      return canLaunch;
    }else{
      final title = queryParameters["title"];
      navigator.pushNamed(AppRoutes.webView, queryParameters: {"url" : uri.toString(), "title": title});
      return true;
    }
  }


  ///This method will not work on web platform
  static Future<String?> downloadFile(
      {required String url, required String fileNameWithExtension}) async {
    try {
      //Downloading file using Dio
      Response response = await Dio().get(
        url,
        options: Options(
          //Setting file type
          responseType: ResponseType.bytes,
          //Setting redirect to false
          followRedirects: false,
          //Validating status
          validateStatus: (status) {
            if (status == null) return false;
            //if the status 200 it will return true
            //status  200 means success
            return status == 200;
          },
        ),
      );
      //Getting Temporary Directory to save file
      Directory tempDir = await getTemporaryDirectory();
      //Adding file name to the temporary directory
      String filePath = "${tempDir.path}/$fileNameWithExtension";
      //Creating file object
      File file = File(filePath);
      //Synchronously opening the file
      RandomAccessFile raf = file.openSync(mode: FileMode.write);
      //Synchronously writes from a buffer to the file
      raf.writeFromSync(response.data);
      //Closing the file
      await raf.close();
      //Returning file path
      return filePath;
    } catch (e, s) {
      AppLogger.e("Downloading file failed", error: e, stackTrace: s);
      return null;
    }
  }

  static SnackBar appSnackBar(
    BuildContext context, {
    required String message,
    IconData? icon,
    Color? color,
    int seconds = 4,
    SnackBarAction? action,
  }) {
    final text =
        Text(message, style: const TextStyle(color: AppTheme.whiteColor));

    return SnackBar(
      action: action,
      backgroundColor: color ?? Theme.of(context).cardColor,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: seconds),
      width: MediaQuery.of(context).size.width < 400 ? null : 400,
      shape: const RoundedRectangleBorder(borderRadius: AppTheme.borderRadius),
      content: icon == null
          ? text
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: AppTheme.whiteColor),
                const SizedBox(width: 10),
                Expanded(child: text),
              ],
            ),
    );
  }

  static void showErrorSnackBar(String error, {int seconds = 4}) {
    final currentState = scaffoldKey.currentState;
    if (currentState == null) return;
    currentState.hideCurrentSnackBar();
    currentState.showSnackBar(
      appSnackBar(
        currentState.context,
        message: error,
        icon: Icons.error_rounded,
        color: AppTheme.redColor,
        seconds: seconds,
      ),
    );
  }

  static void showInfoSnackBar(
    String info, {
    int seconds = 4,
    SnackBarAction? action,
  }) {
    final currentState = scaffoldKey.currentState;
    if (currentState == null) return;
    currentState.hideCurrentSnackBar();
    currentState.showSnackBar(
      appSnackBar(currentState.context,
          message: info,
          icon: Icons.info_rounded,
          seconds: seconds,
          action: action,
      ),
    );
  }

  static void hideSnackBar() {
    final currentState = scaffoldKey.currentState;
    if (currentState == null) return;
    currentState.hideCurrentSnackBar();
  }

  static void unfocus() => FocusManager.instance.primaryFocus?.unfocus();

}

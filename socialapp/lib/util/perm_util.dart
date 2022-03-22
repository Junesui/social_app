import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socialapp/util/dialog_util.dart';
import 'package:socialapp/util/toast_util.dart';

/// 权限处理工具
class PermUtil {
  /// 检查权限
  static void check(List<Permission> perms, BuildContext context, {VoidCallback? onGranted}) async {
    // 所有权限已授权标志
    bool isAllGranted = true;
    // 未授权的权限
    List<Permission> notGrantedPerms = [];

    for (var p in perms) {
      if (!await p.status.isGranted) {
        notGrantedPerms.add(p);
        isAllGranted = false;
      }
    }
    if (isAllGranted) {
      // 已授权。执行回调
      onGranted != null ? onGranted() : () {};
    } else {
      PermissionStatus permissionStatus = await requestPerms(notGrantedPerms);
      if (permissionStatus.isGranted || permissionStatus.isLimited) {
        // 授权通过。执行回调
        onGranted != null ? onGranted() : () {};
      } else if (permissionStatus.isDenied) {
        // 授权拒绝。不做处理
      } else if (permissionStatus.isPermanentlyDenied) {
        // 永久拒绝。提示用户打开设置（Android）
        DialogUtil.okCancel(
          context,
          title: "权限申请",
          text: "需要打开权限使用该功能，是否去设置里开启权限？",
          btnOkOnPress: () {
            openAppSettings();
          },
        );
      } else if (permissionStatus.isRestricted) {
        // 限制使用。消息提示（ios）
        ToastUtil.show(msg: "需要打开权限使用该功能");
      } else if (permissionStatus.isLimited) {
        // 有限访问。执行回调（ios）
        onGranted != null ? onGranted() : () {};
      }
    }
  }

  /// 申请权限
  static Future<PermissionStatus> requestPerms(List<Permission> perms) async {
    Map<Permission, PermissionStatus> statuses = await perms.request();
    PermissionStatus currentPermissionStatus = PermissionStatus.granted;
    statuses.forEach((key, status) {
      if (!status.isGranted) {
        currentPermissionStatus = status;
        return;
      }
    });
    return currentPermissionStatus;
  }
}

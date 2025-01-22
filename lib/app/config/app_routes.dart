import 'package:flutter_fire_chat/app/mvvm/model/chat_box_meta_data_model/chat_box_meta_data_model.dart';
import 'package:flutter_fire_chat/app/mvvm/view/auth_views/sign_up_view.dart';
import 'package:flutter_fire_chat/app/mvvm/view/inbox_view/inbox_view.dart';
import 'package:flutter_fire_chat/app/mvvm/view_model/chat_controller/chat_controller.dart';
import 'package:get/get.dart';
import '../mvvm/view/message_view/message_view.dart';
import '../mvvm/view_model/auth_controllers/signup_controller.dart';

abstract class Routes {
  Routes._();

  static const splashView = '/splashView';
  static const signUpView = '/signUpView';
  static const chatView = '/chatView';
  static const inboxView = '/inboxView';


}

abstract class AppPages {
  AppPages._();

  static final routes = <GetPage>[
    GetPage(
        name: Routes.chatView,
        page: () => const ChatView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<ChatController>(() => ChatController());
        })),
    GetPage(
        name: Routes.inboxView,
        page: () => const InboxView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<ChatController>(() => ChatController());
        })),
    GetPage(
        name: Routes.signUpView,
        page: () => const SignUpView(),
        binding: BindingsBuilder(() {
          Get.lazyPut<SignupController>(() => SignupController());
        })),
  ];
}

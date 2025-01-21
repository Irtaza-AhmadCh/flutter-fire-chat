import 'package:flutter_fire_chat/app/mvvm/model/chat_box_meta_data_model/chat_box_meta_data_model.dart';
import 'package:flutter_fire_chat/app/mvvm/view_model/chat_controller/chat_controller.dart';
import 'package:get/get.dart';
import '../mvvm/view/message_view/message_view.dart';

abstract class Routes {
  Routes._();

  static const splashView = '/splashView';
  static const chatView = '/chatView';


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
  ];
}

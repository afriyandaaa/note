import 'package:get/get.dart';

import 'package:note/app/modules/add_note/bindings/add_note_binding.dart';
import 'package:note/app/modules/add_note/views/add_note_view.dart';
import 'package:note/app/modules/edit_note/bindings/edit_note_binding.dart';
import 'package:note/app/modules/edit_note/views/edit_note_view.dart';
import 'package:note/app/modules/home/bindings/home_binding.dart';
import 'package:note/app/modules/home/views/home_view.dart';
import 'package:note/app/modules/login/bindings/login_binding.dart';
import 'package:note/app/modules/login/views/login_view.dart';
import 'package:note/app/modules/resep/bindings/resep_binding.dart';
import 'package:note/app/modules/resep/views/resep_view.dart';
import 'package:note/app/modules/reset_password/bindings/reset_password_binding.dart';
import 'package:note/app/modules/reset_password/views/reset_password_view.dart';
import 'package:note/app/modules/signup/bindings/signup_binding.dart';
import 'package:note/app/modules/signup/views/signup_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.ADD_NOTE,
      page: () => AddNoteView(),
      binding: AddNoteBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_NOTE,
      page: () => EditNoteView(),
      binding: EditNoteBinding(),
    ),
    GetPage(
      name: _Paths.RESEP,
      page: () => ResepView(),
      binding: ResepBinding(),
    ),
  ];
}

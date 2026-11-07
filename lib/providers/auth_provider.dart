import 'package:bus_ticket_register/common/common_functions.dart';
import 'package:bus_ticket_register/models/error_response_model.dart';
import 'package:bus_ticket_register/models/routes_buses_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:bus_ticket_register/models/login_response_model.dart';
import 'package:bus_ticket_register/models/register_body.dart';
import 'package:bus_ticket_register/services/app_exceptions.dart';
import 'package:bus_ticket_register/services/provider_helper_class.dart';
import 'package:bus_ticket_register/services/shared_preference_helper.dart';
import 'package:bus_ticket_register/services/validation_helper.dart';

class AuthProvider extends ChangeNotifier with ProviderHelperClass {
  TextEditingController loginUsernameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController punnyamCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String? errorToast;
  String? userNameValidationMessage;
  String? nameValidationMessage;
  String? emailValidationMessage;
  String? punnyamCodeValidationMessage;
  String? passwordValidationMessage;
  String? confirmPasswordValidationMessage;
  bool isLoginFormValidated = false;
  bool isRegisterFormValidated = false;
  bool isRememberCredentials = true;

  RotesBusesModel? rotebuseresponse;

  Routes? selectedRoute;
  Bus? selectedBus;
  List<Routes> routeList = [];
  List<Routes> allroutesList = [];
  List<Bus> busList = [];
  bool isRoutesBusesLoading = false;

  Future<void> login({Function? onSuccess, Function? onFailure}) async {
    updateLoadState(LoaderState.loading);
    try {
      var res = await serviceConfig.login(
          email: loginUsernameController.text,
          password: loginPasswordController.text,
          routeid: selectedRoute?.id,
          busid: selectedBus?.id);
      if (res.isValue) {
        LoginResponseModel loginResponseModel = res.asValue!.value;
        if (isRememberCredentials) {
          await SharedPreferenceHelper.saveToken(loginResponseModel.accessToken);
        }
        if (onSuccess != null) onSuccess();
      } else {
        final error = res.asError!.error;
        final err = error is ErrorResponseModel
            ? error
            : ErrorResponseModel(errorMessage: 'Login failed');
        userNameValidationMessage = err.fieldErrors['username'];
        passwordValidationMessage = err.fieldErrors['password'];
        errorToast = err.errorMessage ?? 'Login failed';
        if (onFailure != null) onFailure();
      }
    } on AppException catch (e) {
      // 500, timeout, no connection
      errorToast = e.message ?? 'Something went wrong';
      if (onFailure != null) onFailure();
    } finally {
      updateLoadState(LoaderState.loaded);
    }
  }


  Future<void> getRoutesBuses() async {
  final network = await CommonFunctions.checkInternetConnection();
  if (!network) return;
  isRoutesBusesLoading = true;
  notifyListeners();
  try {
    var res = await serviceConfig.getRoutesBuses();
    if (res.isValue) {
      rotebuseresponse = res.asValue!.value;
      updateRotesBusesList(rotebuseresponse);
    } else {
      errorToast = 'Failed to load routes';
    }
  } catch (e) {
    debugPrint('exception in getRoutesBuses: $e');
  } finally {
    isRoutesBusesLoading = false;
    notifyListeners();
  }
}

  void selectRoute(Routes? r) {
    selectedRoute = r;
    busList = r?.buses ?? [];
    selectedBus = null;          // reset bus when route changes
    updateLoginFormState();
  }

  void selectBus(Bus? b) {
    selectedBus = b;
    updateLoginFormState();
  }

  Future<void> register({Function? onSuccess, Function? onFailure}) async {
    updateLoadState(LoaderState.loading);
    RegisterBody registerBody = RegisterBody(
        password: passwordController.text,
        email: emailController.text,
        confirmPassword: confirmPasswordController.text,
        name: nameController.text,
        punnyamCode: punnyamCodeController.text);
    var res = await serviceConfig.register(registerBody);
    if (res.isValue) {
      LoginResponseModel loginResponseModel = res.asValue!.value;
      await SharedPreferenceHelper.saveToken(loginResponseModel.accessToken ?? '');
      if (onSuccess != null) onSuccess();
      updateLoadState(LoaderState.loaded);
    } else {
      errorToast = 'Registration failed';
      if (onFailure != null) onFailure();
      updateLoadState(LoaderState.loaded);
    }
    notifyListeners();
  }

  updateValidationMessages(
      {required ValidationTypes validationType,
      required String validationMessage}) {
    switch (validationType) {
      case ValidationTypes.name:
        if (validationMessage.isNotEmpty) {
          nameValidationMessage = validationMessage;
        } else {
          nameValidationMessage = null;
        }

        break;

      case ValidationTypes.email:
        if (validationMessage.isNotEmpty) {
          emailValidationMessage = validationMessage;
        } else {
          emailValidationMessage = null;
        }
        break;
      case ValidationTypes.punnyamCode:
        if (validationMessage.isNotEmpty) {
          punnyamCodeValidationMessage = validationMessage;
        } else {
          punnyamCodeValidationMessage = null;
        }
        break;
      case ValidationTypes.password:
        if (validationMessage.isNotEmpty) {
          passwordValidationMessage = validationMessage;
        } else {
          passwordValidationMessage = null;
        }
        break;
      case ValidationTypes.confirmPassword:
        if (validationMessage.isNotEmpty) {
          confirmPasswordValidationMessage = validationMessage;
        } else {
          confirmPasswordValidationMessage = null;
        }
        break;
      case ValidationTypes.userName:
        if (validationMessage.isNotEmpty) {
          userNameValidationMessage = validationMessage;
        } else {
          userNameValidationMessage = null;
        }
        break;
    }
    updateLoginFormState();
    updateRegisterFormState();
    notifyListeners();
  }

  updateLoginFormState() {
    if (loginUsernameController.text.isNotEmpty &&
        loginPasswordController.text.isNotEmpty &&
        userNameValidationMessage == null) {
      isLoginFormValidated = true;
    } else {
      isLoginFormValidated = false;
    }
    debugPrint('is login form validated $isLoginFormValidated');
    notifyListeners();
  }

  updateRegisterFormState() {
    if (nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        punnyamCodeController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        nameValidationMessage == null &&
        emailValidationMessage == null &&
        punnyamCodeValidationMessage == null &&
        passwordValidationMessage == null &&
        confirmPasswordValidationMessage == null) {
      isRegisterFormValidated = true;
    } else {
      isRegisterFormValidated = false;
    }
    notifyListeners();
  }

  // Server-side login errors are cleared as soon as the user edits a field.
  clearLoginErrors() {
    userNameValidationMessage = null;
    passwordValidationMessage = null;
    updateLoginFormState();
  }

  updateRememberMeValue(bool value) {
    isRememberCredentials = value;
    notifyListeners();
  }


    updateRotesBusesList(RotesBusesModel? rotebusesResponse) {
    routeList = rotebusesResponse?.routes ?? [];
    allroutesList = rotebusesResponse?.routes ?? [];
    notifyListeners();
  }


  clearValues() {
    nameController.clear();
    emailController.clear();
    punnyamCodeController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    loginUsernameController.clear();
    loginPasswordController.clear();
    nameValidationMessage = null;
    emailValidationMessage = null;
    punnyamCodeValidationMessage = null;
    passwordValidationMessage = null;
    confirmPasswordValidationMessage = null;
    userNameValidationMessage = null;
    notifyListeners();
  }

  @override
  void updateLoadState(LoaderState state) {
    loaderState = state;
    notifyListeners();
  }
}

import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'form_manager.g.dart';

@riverpod
FormManager formManager(FormManagerRef ref) => FormManager();

class FormManager {
  // ------ passowrd rx validatot -------------------
  static final _password = BehaviorSubject<String?>();

  // ------ Confirmpassowrd rx validatot -------------------
  static final BehaviorSubject<String?> _confirmPassowrd =
      BehaviorSubject<String?>();
  final _email = BehaviorSubject<String?>();
  final validateEmail = StreamTransformer<String?, String?>.fromHandlers(
    handleData: (data, sink) {
      if (data == null || data.isEmpty) {
        sink.addError("Please Enter email addres");
      } else {
        isEmail(data)
            ? sink.add(data)
            : sink.addError("Please Enter valid email addres");
      }
    },
  );

  final validatepassowrd = StreamTransformer<String?, String?>.fromHandlers(
    handleData: (data, sink) {
      if (data == null || data.isEmpty) {
        sink.addError("Please Enter passowrd");
      } else {
        if (isValidPassword(data)) {
          sink.add(data);
          if (_confirmPassowrd.hasValue && data != _confirmPassowrd.value) {
            _confirmPassowrd.addError("Password did not match");
          } else {
            _confirmPassowrd.add(data);
          }
        } else {
          sink.addError("Please Enter valid passowrd");
        }
      }
    },
  );
  final validateConfirmpassowrd =
      StreamTransformer<String?, String?>.fromHandlers(
    handleData: (data, sink) {
      if (data == null || data.isEmpty) {
        sink.addError("Please Enter confirm passowrd");
      } else {
        if (_password.value != data) {
          sink.addError("Password did not match");
        } else {
          isValidPassword(data)
              ? sink.add(data)
              : sink.addError("Please Enter valid confirm passowrd");
        }
      }
    },
  );
  Stream<String?> get confirmPassowrd =>
      _confirmPassowrd.stream.transform(validateConfirmpassowrd);

  Stream<String?> get email => _email.stream.transform(validateEmail);
  // ------ check combine stream using rx --------
  Stream<bool> get enableConfirmPassword =>
      Rx.combineLatest([passowrd], (cp) => true);

  String? get gePasswordStr => _password.value;

  String? get getConfirmPasswordStr => _confirmPassowrd.value;

  Sink<String?> get inconfirmPassowrd => _confirmPassowrd.sink;

  // ------ Email rx validatot -------------------\
  Sink<String?> get inEmail => _email.sink;

  Sink<String?> get inpassowrd => _password.sink;

  Stream<String?> get passowrd => _password.stream.transform(validatepassowrd);

  Stream<bool> get submitValid =>
      Rx.combineLatest3(email, confirmPassowrd, passowrd, (e, p, cp) => true);
  void clearConfirmPassword() {
    _confirmPassowrd.sink.add(null);
  }

  static bool isEmail(String email) {
    String? p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password);
  }
}

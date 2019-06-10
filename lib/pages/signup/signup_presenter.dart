import 'package:cnupogo/data/rest_data.dart';
import 'package:cnupogo/models/user.dart';

abstract class SignUpPageContract {
  void onSignUpSuccess(User user);

  void onSignUpError(String error);
}

class SignUpPagePresenter {
  SignUpPageContract _view;
  RestData api = new RestData();

  SignUpPagePresenter(this._view);

  doSignUp(String username, String password) {
    api
        .signup(username, password)
        .then((User user) => _view.onSignUpSuccess(user))
        .catchError((error) => _view.onSignUpError(error));
  }
}

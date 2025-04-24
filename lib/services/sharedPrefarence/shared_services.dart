import 'package:cosmic_numeriics/constant/sharedpref.dart';
import 'package:cosmic_numeriics/model/user_model.dart';

class SharedServices {
  static setUserData(UserModel model) {
    preferences?.setString("UserModel", userModelToJson(model));
  }

  static UserModel getUserData() {
    String jsonString = preferences?.getString("UserModel") ?? "";
    if (jsonString.isNotEmpty) {
      return userModelFromJson(jsonString);
    } else {
      // Return a default UserModel or handle the case accordingly.
      return UserModel();
    }
  }

  static void updateUserData({
    String? name,
    DateTime? dob,
    String? gender,
    String? email,
    String? profilePic,
  }) {
    UserModel currentUser = getUserData();

    if (name != null) currentUser.name = name;
    if (dob != null) currentUser.dob = dob;
    if (gender != null) currentUser.gender = gender;
    if (email != null) currentUser.email = email;
    if (profilePic != null) currentUser.profilePic = profilePic;

    setUserData(currentUser);
  }

  static bool hasUserData() {
    return preferences!.containsKey("UserModel");
  }
}

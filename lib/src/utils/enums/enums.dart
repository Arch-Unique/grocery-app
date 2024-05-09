import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../utils_barrel.dart';

enum PasswordStrength {
  normal,
  weak,
  okay,
  strong,
}

enum FPL {
  email(TextInputType.emailAddress),
  number(TextInputType.number),
  text(TextInputType.text),
  password(TextInputType.visiblePassword),
  multi(TextInputType.multiline, maxLength: 1000, maxLines: 5),
  phone(TextInputType.phone),
  money(TextInputType.number),

  //card details
  cvv(TextInputType.number, maxLength: 4),
  cardNo(TextInputType.number, maxLength: 20),
  dateExpiry(TextInputType.datetime, maxLength: 5);

  final TextInputType textType;
  final int? maxLength, maxLines;

  const FPL(this.textType, {this.maxLength, this.maxLines = 1});
}

enum AuthMode {
  login("Log In", "Login with one following options", "Don't have an account? ",
      "Register here!", "Or Log in with"),
  register("Sign Up", "You can sign up with one following options",
      "Already have an account? ", "Login!", "Or sign up with");

  final String title, desc, after, afterAction, thirdparty;
  const AuthMode(
      this.title, this.desc, this.after, this.afterAction, this.thirdparty);
}

enum ThirdPartyTypes {
  facebook(Logos.facebook_f),
  google(Logos.google),
  apple(Logos.apple);

  final String logo;
  const ThirdPartyTypes(this.logo);
}

enum DashboardMode {
  home("Home", Assets.home2),
  facility("Facilities", Assets.chartOxy7),
  profile("Profile", Assets.profilehome);

  final String title, icon;
  const DashboardMode(this.title, this.icon);
}

enum ProfileActions {
  myprofile("My Profile", Assets.profile11),
  favourites("Favourites", Assets.star77),
  donation("Donations History", Assets.calendar63),
  settings("Settings", Assets.setting44);

  final String title, icon;
  const ProfileActions(this.title, this.icon);
}

enum SettingsAction {
  dynamicCard("Dynamic Card", Assets.dynamiccard),
  changePassword("Change Password", Assets.changepassword);

  final String title, icon;
  const SettingsAction(this.title, this.icon);
}

enum CurrencyIcon {
  usd(FontAwesome.dollar_sign),
  ngn(FontAwesome.naira_sign),
  gbp(FontAwesome.sterling_sign),
  eur(FontAwesome.euro_sign),
  jpy(FontAwesome.yen_sign),
  inr(FontAwesome.indian_rupee_sign);

  final FontAwesomeIconDataSolid icon;
  const CurrencyIcon(this.icon);
}

enum ErrorTypes {
  noInternet(Icons.wifi_tethering_off_rounded, "No Internet Connection",
      "Please check your internet connection and try again"),
  noFacility(Assets.errorfacility, "No Facility Found",
      "Sorry, we couldn't find any matching facilities, Please contact support for assistance and alternatives"),
  noPatient(Icons.pregnant_woman_rounded, "No Patient Found",
      "Oops. no patients found. Please contact support for help"),
  noDonation(Iconsax.empty_wallet, "No Donation Found",
      "You haven't made any donations yet. Why not make a difference today? "),
  serverFailure(Icons.power_off_rounded, "Server Failure",
      "Something bad happened. Please try again later");

  final String title, desc;
  final dynamic icon;
  const ErrorTypes(this.icon, this.title, this.desc);
}

enum PatientCategory {
  all("All"),
  prenatal("Prenatal"),
  antenatal("Antenatal"),
  postpartum("PostPartum"),
  delivery("Delivery");

  final String name;
  const PatientCategory(this.name);
}

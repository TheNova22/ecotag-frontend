import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sih_frontend/screens/settingsScreen/components/settings_button.dart';
import 'package:sih_frontend/screens/settingsScreen/components/settings_title.dart';

class SettingsPage extends StatelessWidget {
  static const routeName = "/SettingsPage";
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // title: Text(
        //   "Settings",
        //   style: TextStyle(color: Color(0xff464646)),
        // ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Color(0xff464646),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SettingsTitle(title: "Account"),
            SettingsButton(
              title: "Edit Details",
              onTap: () {},
              leading: Icon(Icons.keyboard_arrow_right),
            ),
            SettingsButton(
              title: "Change Password",
              onTap: () {},
              leading: Icon(Icons.lock_outline),
            ),
            SettingsButton(
              title: "Log Out",
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.of(context).pop();
                });
              },
              leading: Icon(Icons.logout, color: Colors.red),
            ),
            SettingsTitle(title: "Preferences"),
            SettingsButton(
              title: "Dark Mode",
              onTap: () {},
              leading: Container(
                  child: Switch.adaptive(value: false, onChanged: (val) {})),
            ),
            SettingsButton(
              title: "Notifications",
              onTap: () {},
              leading: Container(
                  child: Switch.adaptive(value: false, onChanged: (val) {})),
            ),
            SettingsButton(
              title: "Text Size",
              onTap: () {},
              leading: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text(
                  "Medium",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SettingsButton(
              title: "Language",
              onTap: () {},
              leading: Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text(
                  "English",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SettingsTitle(
              title: "EcoTag",
            ),
            SettingsButton(
              title: "Help",
              onTap: () {},
              leading: Icon(
                Icons.help_outline,
              ),
            ),
            SettingsButton(
              title: "Contact Us",
              onTap: () {},
              leading: Icon(
                Icons.mail_outline,
              ),
            ),
            SettingsButton(
              title: "About Us",
              onTap: () {},
              leading: Icon(
                Icons.info_outline,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}

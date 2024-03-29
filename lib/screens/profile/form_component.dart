import 'package:closetalk/constants/colors.dart';
import 'package:closetalk/controllers/user_controller.dart';
import 'package:closetalk/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_avatar/random_avatar.dart';

import '../../controllers/device_info.dart';

class FormComponent extends StatefulWidget {
  const FormComponent({super.key});

  @override
  State<FormComponent> createState() => _FormComponentState();
}

class _FormComponentState extends State<FormComponent> {
  final userController = Get.put<UserController>(UserController());
  final avatarList = ['avatar1', 'avatar3', 'avatar3', 'avatar4', 'avatar5'];
  String selectedAvatar = 'avatar1';
  TextEditingController nameController = TextEditingController();
  TextEditingController introductionController = TextEditingController();
  String selectedLang = 'en';
  List<DropdownMenuItem<String>> get langDropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(value: "en", child: Text("English")),
      const DropdownMenuItem(value: "zh", child: Text("Chinese")),
      const DropdownMenuItem(value: "es", child: Text("Spanish")),
    ];
    return menuItems;
  }

  void _changeAvatar(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Choose an Avatar',
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: 250,
            height: 300,
            child: ListView.separated(
              itemCount: avatarList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: RandomAvatar(
                    avatarList[index],
                    height: 50,
                    width: 50,
                  ),
                  onTap: () {
                    setState(() {
                      selectedAvatar = avatarList[index];
                    });
                    Navigator.of(context).pop();
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    nameController.text = userController.currentUser.value.name ?? '';
    introductionController.text =
        userController.currentUser.value.introduction ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    introductionController.dispose();
    super.dispose();
  }

  Future<void> saveUser() async {
    final String deviceID = await getDeviceInfo();
    final User user = User(
      id: deviceID,
      name: nameController.text,
      avatar: selectedAvatar,
      introduction: introductionController.text,
      language: selectedLang,
    );
    await userController.updateUser(user);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: RandomAvatar(
                    selectedAvatar,
                    height: 50,
                    width: 50,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _changeAvatar(context);
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: apnaBlack.withOpacity(0.75),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        TextFormField(
          controller: nameController,
          decoration: InputDecoration(
            // errorText: _validate ? "Value Can't Be Empty" : null,
            isDense: true,
            labelText: 'Name',
            labelStyle: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: introductionController,
          decoration: InputDecoration(
            // errorText: _validate ? "Value Can't Be Empty" : null,
            isDense: true,
            labelText: 'Introduction',
            labelStyle: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 10),
        DropdownButton(
          isExpanded: true,
          value: selectedLang,
          dropdownColor: apnaWhite,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 16,
          ),
          onChanged: (String? newValue) {
            setState(() {
              selectedLang = newValue!;
            });
          },
          items: langDropdownItems,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(apnaMaroon),
          ),
          onPressed: () async {
            // if (nameController.text.isEmpty || introductionController.text.isEmpty) {
            //   setState(() {
            //     _validate = true;
            //   });
            // } else {
            await saveUser();
            Get.offAllNamed('/');
            // }
          },
          child: const Text(
            'Lets Get Started!',
            style: TextStyle(
              color: apnaWhite,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

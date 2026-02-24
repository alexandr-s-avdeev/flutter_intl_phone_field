import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';

void main() => runApp(MaterialApp(home: HomeScreen()));

/// {@template main}
/// HomeScreen widget.
/// {@endtemplate}
class HomeScreen extends StatefulWidget {
  /// {@macro main}
  const HomeScreen({
    super.key, // ignore: unused_element
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// State for widget HomeScreen.
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IntlPhoneField(
            showDropdownIcon: false,

            buildCounter:
                (
                  context, {
                  required currentLength,
                  required isFocused,
                  maxLength,
                }) => null,

            bottomSheetDialogSearchHintText: 'Search Country',
            cursorColor: Colors.black,
            cursorHeight: 15,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffC4C4C4)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffC4C4C4)),
              ),
              contentPadding: EdgeInsets.zero,
              constraints: BoxConstraints(maxHeight: 40),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffC4C4C4)),
              ),
            ),
            languageCode: 'en',
            initialCountryCode: 'US',
            onChanged: (phone) {
              print(phone.completeNumber);
            },
          ),
        ),
      ),
    );
  }
}

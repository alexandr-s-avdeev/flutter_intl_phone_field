import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/countries.dart';
import 'package:flutter_intl_phone_field/helpers.dart';

class PickerDialogStyle {
  final Color? backgroundColor;

  final TextStyle? countryCodeStyle;

  final TextStyle? countryNameStyle;

  final Widget? listTileDivider;

  final EdgeInsets? listTilePadding;

  final EdgeInsets? dialogPadding;

  final EdgeInsets? padding;

  final Color? searchFieldCursorColor;

  final InputDecoration? searchFieldInputDecoration;

  final EdgeInsets? searchFieldPadding;

  final double? width;

  PickerDialogStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.dialogPadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.width,
  });
}

class CountryPickerDialog extends StatefulWidget {
  final List<Country> countryList;
  final Country selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final String searchText;
  final List<Country> filteredCountries;
  final PickerDialogStyle? style;
  final String languageCode;

  final EdgeInsets? dialogPadding;

  final String hintText;

  const CountryPickerDialog({
    Key? key,
    required this.searchText,
    required this.languageCode,
    required this.hintText,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    this.style,
    this.dialogPadding,
  }) : super(key: key);

  @override
  State<CountryPickerDialog> createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _filteredCountries = widget.filteredCountries.toList()
      ..sort(
        (a, b) => a
            .localizedName(widget.languageCode)
            .compareTo(b.localizedName(widget.languageCode)),
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.75,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 15),
          Container(
            height: 5,
            width: 36,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xffD6D6D6)),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: widget.style?.searchFieldPadding ??
                const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              cursorColor: const Color(0xff2E2E2E),
              cursorHeight: 20,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 7, bottom: 9, left: 12),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xffC4C4C4))),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color(0xffC4C4C4), width: 0),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color(0xffC4C4C4))),
                  constraints: BoxConstraints(maxHeight: 40)),
              onChanged: (value) {
                _filteredCountries = widget.countryList.stringSearch(value)
                  ..sort(
                    (a, b) => a
                        .localizedName(widget.languageCode)
                        .compareTo(b.localizedName(widget.languageCode)),
                  );
                if (mounted) setState(() {});
              },
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: _filteredCountries.length,
              itemBuilder: (ctx, index) => ListTile(
                dense: true,
                leading: kIsWeb
                    ? Image.asset(
                        'assets/flags/${_filteredCountries[index].code.toLowerCase()}.png',
                        package: 'flutter_intl_phone_field',
                        width: 32,
                      )
                    : Text(
                        _filteredCountries[index].flag,
                        style: const TextStyle(fontSize: 18),
                      ),
                contentPadding: EdgeInsets.zero,
                minTileHeight: 20,
                title: Text(
                  "${_filteredCountries[index].localizedName(widget.languageCode)} +${_filteredCountries[index].dialCode}",
                  maxLines: 1,
                  style: widget.style?.countryNameStyle ??
                      const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff2E2E2E)),
                ),
                trailing: Text(
                  '',
                  style: widget.style?.countryCodeStyle ??
                      const TextStyle(fontWeight: FontWeight.w700),
                ),
                onTap: () {
                  _selectedCountry = _filteredCountries[index];
                  widget.onCountryChanged(_selectedCountry);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

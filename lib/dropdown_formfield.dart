library dropdown_formfield;

import 'package:flutter/material.dart';

class DropDownFormField extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final dynamic value;
  final List dataSource;
  final String textField;
  final String valueField;
  final Function onChanged;
  final TextStyle titleStyle;
  final TextStyle hintStyle;
  final TextStyle errorStyle;
  final TextStyle dropdownTextStyle;
  final Color dropDownBackgroundColor;
  final Color arrowButtonColor;
  final Color themeHintColor;

  DropDownFormField(
      {FormFieldSetter<dynamic> onSaved,
      FormFieldValidator<dynamic> validator,
      bool autovalidate = false,
      this.titleText = "Title",
      this.titleStyle = const TextStyle(color: Colors.black),
      this.hintText = "Select one option",
      this.hintStyle = const TextStyle(color: Colors.grey),
      this.dropdownTextStyle = const TextStyle(color: Colors.black),
      this.required = false,
      this.errorText = "Please select one option",
      this.errorStyle =
          const TextStyle(color: Colors.red, fontSize: 14.0),
      this.value,
      this.dataSource,
      this.textField,
      this.valueField,
      this.onChanged,
      this.dropDownBackgroundColor = Colors.white,
      this.arrowButtonColor = Colors.white,
      this.themeHintColor = Colors.white})
      : super(
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          builder: (FormFieldState<dynamic> state) {
            return Center(
                child: Theme(
              data: ThemeData(
                  canvasColor: dropDownBackgroundColor,
                  hintColor: state.hasError ? Colors.red : themeHintColor),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    InputDecorator(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                          labelText: titleText,
                          labelStyle: titleStyle,
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<dynamic>(
                          iconEnabledColor: arrowButtonColor,
                          isExpanded: true,
                          hint: Text(
                            hintText,
                            style: hintStyle,
                          ),
                          value: value == '' ? null : value,
                          onChanged: (dynamic newValue) {
                            state.didChange(newValue);
                            onChanged(newValue);
                          },
                          items: dataSource == null ? [] : dataSource.map((item) {
                            return DropdownMenuItem<dynamic>(
                              value: item[valueField],
                              child: Text(
                                item[textField],
                                style: dropdownTextStyle,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: state.hasError ? 5.0 : 0.0),
                    Text(
                      state.hasError ? state.errorText : '',
                      style: errorStyle,
                    ),
                    SizedBox(height: state.hasError ? 10.0 : 0.0),
                  ],
                ),
              ),
            ));
          },
        );
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:md_composer_flutter/ui/pages/forms/mocks.dart';

class FormBuilderExamplePage extends StatelessWidget {
  FormBuilderExamplePage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
        key: _formKey,
        onChanged: () {
          _formKey.currentState?.save();
          print(_formKey.currentState?.value);
        },
        skipDisabled: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(
                  labelText: 'Insert your name here',
                ),
              ),
              FormBuilderFilterChip(
                name: 'filter_chip',
                decoration: const InputDecoration(
                  labelText: 'Select many options',
                ),
                options: [
                  FormBuilderChipOption(value: 'AAA'),
                  FormBuilderChipOption(value: 'BBB'),
                  FormBuilderChipOption(value: 'CCC'),
                ],
              ),
              FormBuilderDateTimePicker(
                name: 'date',
                initialEntryMode: DatePickerEntryMode.calendar,
                initialValue: DateTime.now(),
                inputType: InputType.both,
                decoration: InputDecoration(
                  labelText: 'Appointment Time',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _formKey.currentState!.fields['date']?.didChange(null);
                    },
                  ),
                ),
                initialTime: const TimeOfDay(hour: 8, minute: 0),
                // locale: const Locale.fromSubtags(languageCode: 'fr'),
              ),
              FormBuilderDateRangePicker(
                name: 'date_range',
                firstDate: DateTime(1970),
                lastDate: DateTime(2030),
                decoration: InputDecoration(
                  labelText: 'Date Range',
                  helperText: 'Helper text',
                  hintText: 'Hint text',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _formKey.currentState!.fields['date_range']
                          ?.didChange(null);
                    },
                  ),
                ),
              ),
              FormBuilderSlider(
                name: 'slider',
                min: 0.0,
                max: 10.0,
                initialValue: 5.0,
                divisions: 20,
                activeColor: Theme.of(context).colorScheme.primary,
                inactiveColor: Theme.of(context).colorScheme.secondary,
                decoration: const InputDecoration(
                  labelText: 'Number of things',
                ),
              ),
              FormBuilderRangeSlider(
                name: 'range_slider',
                // validator: FormBuilderValidators.compose([FormBuilderValidators.min(context, 6)]),
                min: 0.0,
                max: 100.0,
                initialValue: const RangeValues(4, 7),
                divisions: 20,
                activeColor: Theme.of(context).colorScheme.primary,
                inactiveColor: Theme.of(context).colorScheme.secondary,
                decoration: const InputDecoration(labelText: 'Price Range'),
              ),
              FormBuilderCheckbox(
                name: 'accept_terms',
                initialValue: false,
                title: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'I have read and agree to the ',
                        style: TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Terms and Conditions',
                        style: TextStyle(color: Colors.blue),
                        // Flutter doesn't allow a button inside a button
                        // https://github.com/flutter/flutter/issues/31437#issuecomment-492411086
                        /*
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print('launch url');
                                  },
                                */
                      ),
                    ],
                  ),
                ),
              ),
              FormBuilderDropdown<String>(
                // autovalidate: true,
                name: 'gender',
                decoration: InputDecoration(
                  labelText: 'Gender',
                ),
                // initialValue: 'Male',
                allowClear: true,
                hint: const Text('Select Gender'),
                items: ['Male', 'Female']
                    .map((gender) => DropdownMenuItem(
                          alignment: AlignmentDirectional.center,
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                valueTransformer: (val) => val?.toString(),
              ),
              FormBuilderRadioGroup<String>(
                decoration: const InputDecoration(
                  labelText: 'My chosen language',
                ),
                initialValue: null,
                name: 'best_language',
                options: ['Dart', 'Kotlin', 'Java', 'Swift', 'Objective-C']
                    .map((lang) => FormBuilderFieldOption(
                          value: lang,
                          child: Text(lang),
                        ))
                    .toList(growable: false),
                controlAffinity: ControlAffinity.trailing,
              ),
              FormBuilderSegmentedControl(
                decoration: const InputDecoration(
                  labelText: 'Movie Rating (Archer)',
                ),
                name: 'movie_rating',
                // initialValue: 1,
                // textStyle: TextStyle(fontWeight: FontWeight.bold),
                options: List.generate(5, (i) => i + 1)
                    .map((number) => FormBuilderFieldOption(
                          value: number,
                          child: Text(
                            number.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ))
                    .toList(),
              ),
              FormBuilderSwitch(
                title: const Text('I Accept the terms and conditions'),
                name: 'accept_terms_switch',
                initialValue: false,
                activeColor: Theme.of(context).colorScheme.primary,
              ),
              FormBuilderCheckboxGroup<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                    labelText: 'The language of my people'),
                name: 'languages',
                // initialValue: const ['Dart'],
                options: const [
                  FormBuilderFieldOption(value: 'Dart'),
                  FormBuilderFieldOption(value: 'Kotlin'),
                  FormBuilderFieldOption(value: 'Java'),
                  FormBuilderFieldOption(value: 'Swift'),
                  FormBuilderFieldOption(value: 'Objective-C'),
                ],
                separator: const VerticalDivider(
                  width: 10,
                  thickness: 5,
                  color: Colors.blue,
                ),
              ),
              FormBuilderFilterChip<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                    labelText: 'The language of my people'),
                name: 'languages_filter',
                selectedColor: Theme.of(context).colorScheme.secondary,
                options: const [
                  FormBuilderChipOption(
                    value: 'Dart',
                    avatar: CircleAvatar(child: Text('D')),
                  ),
                  FormBuilderChipOption(
                    value: 'Kotlin',
                    avatar: CircleAvatar(child: Text('K')),
                  ),
                  FormBuilderChipOption(
                    value: 'Java',
                    avatar: CircleAvatar(child: Text('J')),
                  ),
                  FormBuilderChipOption(
                    value: 'Swift',
                    avatar: CircleAvatar(child: Text('S')),
                  ),
                  FormBuilderChipOption(
                    value: 'Objective-C',
                    avatar: CircleAvatar(child: Text('O')),
                  ),
                ],
              ),
              FormBuilderChoiceChip<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: const InputDecoration(
                    labelText:
                        'Ok, if I had to choose one language, it would be:'),
                name: 'languages_choice',
                initialValue: 'Dart',
                selectedColor: Theme.of(context).colorScheme.secondary,
                options: const [
                  FormBuilderChipOption(
                    value: 'Dart',
                    avatar: CircleAvatar(child: Text('D')),
                  ),
                  FormBuilderChipOption(
                    value: 'Kotlin',
                    avatar: CircleAvatar(child: Text('K')),
                  ),
                  FormBuilderChipOption(
                    value: 'Java',
                    avatar: CircleAvatar(child: Text('J')),
                  ),
                  FormBuilderChipOption(
                    value: 'Swift',
                    avatar: CircleAvatar(child: Text('S')),
                  ),
                  FormBuilderChipOption(
                    value: 'Objective-C',
                    avatar: CircleAvatar(child: Text('O')),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: Text('EXTRA FIELDS'),
              ),
              FormBuilderSearchableDropdown<String>(
                popupProps: const PopupProps.menu(showSearchBox: true),
                dropdownSearchDecoration: const InputDecoration(
                  hintText: 'Search',
                  labelText: 'Search',
                ),
                name: 'searchable_dropdown_offline',
                items: allCountries,
                decoration: const InputDecoration(
                    labelText: 'Searchable Dropdown Offline'),
                filterFn: (country, filter) =>
                    country.toLowerCase().contains(filter.toLowerCase()),
              ),
              FormBuilderColorPickerField(
                name: 'color_picker',
                initialValue: Colors.yellow,
                // readOnly: true,
                colorPickerType: ColorPickerType.materialPicker,
                decoration: const InputDecoration(labelText: 'Color Picker'),
              ),
              FormBuilderTouchSpin(
                decoration: const InputDecoration(labelText: 'TouchSpin'),
                name: 'touch_spin',
                initialValue: 10,
                step: 1,
                iconSize: 48.0,
                addIcon: const Icon(Icons.arrow_right),
                subtractIcon: const Icon(Icons.arrow_left),
              ),
              FormBuilderRatingBar(
                decoration: const InputDecoration(labelText: 'Rating Bar'),
                name: 'rate',
                // enabled: false,
                itemSize: 32.0,
                initialValue: 1.0,
                maxRating: 5.0,
              ),
              FormBuilderChipsInput<Contact>(
                decoration: const InputDecoration(labelText: 'Chips Input'),
                name: 'chips_test',
                maxChips: 5,
                findSuggestions: (String query) {
                  if (query.isNotEmpty) {
                    var lowercaseQuery = query.toLowerCase();
                    return contacts.where((profile) {
                      return profile.name
                              .toLowerCase()
                              .contains(query.toLowerCase()) ||
                          profile.email
                              .toLowerCase()
                              .contains(query.toLowerCase());
                    }).toList(growable: false)
                      ..sort((a, b) => a.name
                          .toLowerCase()
                          .indexOf(lowercaseQuery)
                          .compareTo(
                              b.name.toLowerCase().indexOf(lowercaseQuery)));
                  } else {
                    return const <Contact>[];
                  }
                },
                chipBuilder: (context, state, profile) {
                  return InputChip(
                    key: ObjectKey(profile),
                    label: Text(profile.name),
                    avatar: CircleAvatar(
                      backgroundImage: NetworkImage(profile.imageUrl),
                    ),
                    onDeleted: () => state.deleteChip(profile),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                },
                suggestionBuilder: (context, state, profile) {
                  return ListTile(
                    key: ObjectKey(profile),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(profile.imageUrl),
                    ),
                    title: Text(profile.name),
                    subtitle: Text(profile.email),
                    onTap: () => state.selectSuggestion(profile),
                  );
                },
              ),
              FormBuilderSignaturePad(
                decoration: const InputDecoration(
                  labelText: 'Signature Pad',
                ),
                name: 'signature',
                border: Border.all(color: Colors.green),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState?.save();
                        print('FORM VALUE IS: ${_formKey.currentState?.value}');
                      },
                      child: Text('SAVE'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
                      },
                      child: Text('RESET'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

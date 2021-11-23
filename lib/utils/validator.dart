String? chooseValidator(String validatorField, String? value) {
  switch (validatorField) {
    case 'Name':
      if (value == null || value.isEmpty) return 'Name is required!';
      final RegExp nameExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
      if (nameExp.hasMatch(value)) return 'Please enter a valid name.';
      return null;

    case 'PhoneNumber':
      if (value == null || value.isEmpty) return 'Phone number is required.';
      final RegExp mobileNo = RegExp(
          r'^(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$');
      if (!mobileNo.hasMatch(value)) {
        return 'Please enter a valid phone number.';
      }
      if (value.length != 10) return 'Please enter a valid phone number.';
      return null;
  }
}

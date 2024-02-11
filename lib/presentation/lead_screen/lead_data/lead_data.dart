  import 'package:driver_app/core/utils/formatters.dart';
import 'package:driver_app/presentation/lead_screen/lead_model/lead_model.dart';

final List<Lead> leads = [
    Lead(
      name: 'Lead 1',
      items: 3,
      pickupLocation: 'Downtown Dubai - Dubai - United Arab Emirates',
      dropoffLocation:
          '143 Financial Center Rd - Downtown Dubai - Dubai - United Arab Emirates',
      dateTime: generateRandomDateTime(),
    ),
    Lead(
      name: 'Lead 2',
      items: 4,
      pickupLocation: 'Dubai Marina - Dubai - United Arab Emirates',
      dropoffLocation:
          'Marina Mall Parking - Dubai Marina - Dubai - United Arab Emirates',
      dateTime: generateRandomDateTime(),
    ),
    Lead(
      name: 'Lead 3',
      items: 10,
      pickupLocation:
          '1290 Al Wasl Rd - Umm Suqeim - Umm Suqeim 3 - Dubai - United Arab Emirates',
      dropoffLocation: 'TDM GF 319, Dubai Mall - Dubai - United Arab Emirates',
      dateTime: generateRandomDateTime(),
    ),
  ];

import 'package:fhir/r4.dart';

class SurveyItem {
  SurveyItem.fromItem(this.item, this.response);

  bool get required => item.required_?.value ?? false;
  bool get multipleAnswer => item.repeats?.value ?? false;
  String get linkId => item.linkId ?? '';
  String get text => '${item.prefix ?? ''} ${item.text ?? ''}';
  int get maxLength => item.maxLength?.value ?? 0;
  bool get completed => response?.answer?.isNotEmpty ?? false;

  final QuestionnaireItem item;
  QuestionnaireResponseItem? response;
}

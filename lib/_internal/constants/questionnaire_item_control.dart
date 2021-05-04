import 'package:fhir/r4.dart';

final list = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('list'),
        display: 'List',
      )
    ]));

final table = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('table'),
        display: 'Vertical Answer Table',
      )
    ]));

final htable = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('htable'),
        display: 'Horizontal Answer Table',
      )
    ]));

final gtable = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('gtable'),
        display: 'Group Table',
      )
    ]));

final atable = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('atable'),
        display: 'Answer Table',
      )
    ]));

final header = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('header'),
        display: 'Header',
      )
    ]));

final footer = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('footer'),
        display: 'Footer',
      )
    ]));

final text = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('text'),
        display: '',
      )
    ]));

final inline = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('inline'),
        display: 'In-line',
      )
    ]));

final prompt = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('prompt'),
        display: 'Prompt',
      )
    ]));

final unit = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('unit'),
        display: 'Unit',
      )
    ]));

final lower = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('lower'),
        display: 'Lower-bound',
      )
    ]));

final upper = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('upper'),
        display: 'Upper-bound',
      )
    ]));

final flyover = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('flyover'),
        display: 'Fly-over',
      )
    ]));

final help = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('help'),
        display: 'Help-Button',
      )
    ]));

final question = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('question'),
        display: '',
      )
    ]));

final autocomplete = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('autocomplete'),
        display: 'Auto-complete',
      )
    ]));

final dropDown = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('drop-down'),
        display: 'Drop down',
      )
    ]));

final checkBox = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('check-box'),
        display: 'Check-box',
      )
    ]));

final lookup = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('lookup'),
        display: 'Lookup',
      )
    ]));

final radioButton = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('radio-button'),
        display: 'Radio Button',
      )
    ]));

final slider = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('slider'),
        display: 'Slider',
      )
    ]));

final spinner = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('spinner'),
        display: 'Spinner',
      )
    ]));

final textBox = FhirExtension(
    url: FhirUri(
        'http://hl7.org/fhir/StructureDefinition/questionnaire-itemControl'),
    valueCodeableConcept: CodeableConcept(coding: [
      Coding(
        system: FhirUri('http://hl7.org/fhir/questionnaire-item-control'),
        code: Code('text-box'),
        display: 'Text Box',
      )
    ]));

import 'propert_category_model.dart';

class PropertyRepository {
  List<Map> getAll() => _propertyCategory;

  getProperties(String property) => _propertyCategory
      .map((map) => PropertyCategoryModel.fromJson(map))
      .where((item) => item.property == property)
      .map((item) => item.detail)
      .expand((i) => i)
      .toList();

  getDetails() => _propertyCategory
      .map((map) => PropertyCategoryModel.fromJson(map))
      .map((item) => item.property)
      .toList();

  List _propertyCategory = [
    {
      'property': 'Residential property',
      'alias': 'residential',
      'detail': [
        'Undeveloped land',
        'Duplex',
        'Terrace duplex',
        'Hotels',
        'Apartment',
        'Others'
      ]
    },
    {
      'property': 'Commercial property',
      'alias': 'commercial',
      'detail': ['Office space', 'Retail stores', 'Wareouse', 'Others']
    },
    {
      'property': 'Industrial property',
      'alias': 'industrial',
      'detail': ['Factory', 'Others']
    },
  ];
}

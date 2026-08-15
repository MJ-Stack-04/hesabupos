enum ShopType {
  retail,
  wholesale,
  manufacturing,
  services,
  technology,
  healthcare,
  education,
  hospitality,
  realEstate,
  transportation,
  agriculture,
  construction,
  entertainment,
  other,
}

extension ShopTypeExtension on ShopType {
  String get displayName {
    switch (this) {
      case ShopType.retail:
        return 'Retail';
      case ShopType.wholesale:
        return 'Wholesale';
      case ShopType.manufacturing:
        return 'Manufacturing';
      case ShopType.services:
        return 'Services';
      case ShopType.technology:
        return 'Technology';
      case ShopType.healthcare:
        return 'Healthcare';
      case ShopType.education:
        return 'Education';
      case ShopType.hospitality:
        return 'Hospitality';
      case ShopType.realEstate:
        return 'Real Estate';
      case ShopType.transportation:
        return 'Transportation';
      case ShopType.agriculture:
        return 'Agriculture';
      case ShopType.construction:
        return 'Construction';
      case ShopType.entertainment:
        return 'Entertainment';
      case ShopType.other:
        return 'Other';
    }
  }
  
  String get value {
    switch (this) {
      case ShopType.retail:
        return 'retail';
      case ShopType.wholesale:
        return 'wholesale';
      case ShopType.manufacturing:
        return 'manufacturing';
      case ShopType.services:
        return 'services';
      case ShopType.technology:
        return 'technology';
      case ShopType.healthcare:
        return 'healthcare';
      case ShopType.education:
        return 'education';
      case ShopType.hospitality:
        return 'hospitality';
      case ShopType.realEstate:
        return 'real_estate';
      case ShopType.transportation:
        return 'transportation';
      case ShopType.agriculture:
        return 'agriculture';
      case ShopType.construction:
        return 'construction';
      case ShopType.entertainment:
        return 'entertainment';
      case ShopType.other:
        return 'other';
    }
  }
  
  static ShopType fromValue(String value) {
    switch (value.toLowerCase()) {
      case 'retail':
        return ShopType.retail;
      case 'wholesale':
        return ShopType.wholesale;
      case 'manufacturing':
        return ShopType.manufacturing;
      case 'services':
        return ShopType.services;
      case 'technology':
        return ShopType.technology;
      case 'healthcare':
        return ShopType.healthcare;
      case 'education':
        return ShopType.education;
      case 'hospitality':
        return ShopType.hospitality;
      case 'real_estate':
        return ShopType.realEstate;
      case 'transportation':
        return ShopType.transportation;
      case 'agriculture':
        return ShopType.agriculture;
      case 'construction':
        return ShopType.construction;
      case 'entertainment':
        return ShopType.entertainment;
      default:
        return ShopType.other;
    }
  }
}
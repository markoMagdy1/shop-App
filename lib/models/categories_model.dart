class CategoriesModel{
  bool ? status ;
  CategoriesDataModel ? data ;
  CategoriesModel.fromJson(Map<String,dynamic> json)
  {
    status=json['status'];
    data=CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel{
  int ? current_page ;
  List<Datamodel> data=[] ;
  CategoriesDataModel.fromJson(Map<String,dynamic> json)
  {
    current_page=json['current_page'];
    json['data'].forEach((element){
      data.add(Datamodel.formJson(element));
    });
  }
  
}

class Datamodel{
  int ? id ;
  String ? name ;
  String ? image ;
  Datamodel.formJson(Map<String,dynamic>json)
  {
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}
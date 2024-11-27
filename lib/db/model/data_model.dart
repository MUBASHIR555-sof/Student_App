import 'package:hive/hive.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class studentModel {
  @HiveField(0)
  final String name;

@HiveField(1)
  final String age;

  @HiveField(2)
  final String cls;

  @HiveField(3)
  final String Adress;

  @HiveField(4)
  final String image;

   studentModel({required this.name,required this.age, required this.cls,required this.image,required this.Adress});





  
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 0;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      fields[0] as String,
      fields[2] as String,
      fields[3] as String,
      fields[7] as String,
      (fields[6] as List).cast<String>(),
      fields[5] as String,
      fields[4] as String,
      (fields[8] as Map).cast<String, dynamic>(),
      fields[9] as String,
      fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.brand)
      ..writeByte(3)
      ..write(obj.categoriesText)
      ..writeByte(4)
      ..write(obj.ingredients)
      ..writeByte(5)
      ..write(obj.image_url)
      ..writeByte(6)
      ..write(obj.getPackagingTextList)
      ..writeByte(7)
      ..write(obj.ecoscore)
      ..writeByte(8)
      ..write(obj.nutriments)
      ..writeByte(9)
      ..write(obj.nutriscore)
      ..writeByte(10)
      ..write(obj.barcode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fatorah_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FatorahModelItemAdapter extends TypeAdapter<FatorahModelItem> {
  @override
  final int typeId = 2;

  @override
  FatorahModelItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FatorahModelItem(
      itemTotalPrice: fields[3] as double,
      productName: fields[0] as String?,
      count: fields[2] as double,
      productPrice: fields[1] as double,
      productBuyingPrice: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, FatorahModelItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.productName)
      ..writeByte(1)
      ..write(obj.productPrice)
      ..writeByte(2)
      ..write(obj.count)
      ..writeByte(3)
      ..write(obj.itemTotalPrice)
      ..writeByte(4)
      ..write(obj.productBuyingPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FatorahModelItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

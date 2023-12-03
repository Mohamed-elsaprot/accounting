// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'best_seller.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BestSellerAdapter extends TypeAdapter<BestSeller> {
  @override
  final int typeId = 4;

  @override
  BestSeller read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BestSeller(
      name: fields[0] as String,
      count: fields[1] as double,
      dateTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BestSeller obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.count)
      ..writeByte(2)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BestSellerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fatorah_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FatorahModelAdapter extends TypeAdapter<FatorahModel> {
  @override
  final int typeId = 1;

  @override
  FatorahModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FatorahModel(
      clientPhone: fields[3] as String?,
      createdAt: fields[1] as DateTime,
      fatorahProductsList: (fields[5] as List).cast<FatorahModelItem>(),
      clientName: fields[2] as String?,
      account: fields[4] as String,
      fatorahTotal: fields[0] as double,
    );
  }

  @override
  void write(BinaryWriter writer, FatorahModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.fatorahTotal)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.clientName)
      ..writeByte(3)
      ..write(obj.clientPhone)
      ..writeByte(4)
      ..write(obj.account)
      ..writeByte(5)
      ..write(obj.fatorahProductsList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FatorahModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

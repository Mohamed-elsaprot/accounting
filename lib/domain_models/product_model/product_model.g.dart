// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 0;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      name: fields[0] as String,
      category: fields[1] as String,
      id: fields[2] as String,
      buyingPrice: fields[3] as double,
      sellPrice: fields[4] as double,
      minCount: fields[5] as double,
      packageCount: fields[7] as double,
      packageItemsCount: fields[6] as double,
      count: fields[8] as double,
      availableSale: fields[9] as double,
      storingDate: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.buyingPrice)
      ..writeByte(4)
      ..write(obj.sellPrice)
      ..writeByte(5)
      ..write(obj.minCount)
      ..writeByte(6)
      ..write(obj.packageItemsCount)
      ..writeByte(7)
      ..write(obj.packageCount)
      ..writeByte(8)
      ..write(obj.count)
      ..writeByte(9)
      ..write(obj.availableSale)
      ..writeByte(10)
      ..write(obj.storingDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'cart.dart';

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class CartAdapter extends TypeAdapter<Cart> {
//   @override
//   final int typeId = 0;

//   @override
//   Cart read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return Cart(
//       ISBN_13: fields[0] as String,
//       title: fields[1] as String,
//       imageCoverURL: fields[2] as String,
//       retailPrice: fields[3] as double,
//       quantity: fields[4] as int,
//       cartQuantity: fields[5] as int,
//     );
//   }

//   @override
//   void write(BinaryWriter writer, Cart obj) {
//     writer
//       ..writeByte(6)
//       ..writeByte(0)
//       ..write(obj.ISBN_13)
//       ..writeByte(1)
//       ..write(obj.title)
//       ..writeByte(2)
//       ..write(obj.imageCoverURL)
//       ..writeByte(3)
//       ..write(obj.retailPrice)
//       ..writeByte(4)
//       ..write(obj.quantity)
//       ..writeByte(5)
//       ..write(obj.cartQuantity);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is CartAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }

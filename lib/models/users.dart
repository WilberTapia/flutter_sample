import 'package:flutter/foundation.dart';

class Users {
  int id;
  String username;
  String nombre;
  String apellido;
  String cedula;
  String telefono;
  String email;
  bool changePassword;
  String createdAt;
  String updatedAt;
//  "id": 3,
//     "username": "Wilbertapia",
//     "nombre": "Wilber",
//     "apellido": "Tapia",
//     "cedula": "402-0055445-5 ",
//     "telefono": "829-520-7981 ",
//     "email": "Wtapia425@gmail.com",
//     "changePassword": false,
//     "img": { "type": "Buffer", "data": [] },
//     "createdAt": "2022-06-18T08:37:02.449Z",
//     "updatedAt": "2022-06-24T20:53:51.000Z"
  Users(
    this.id,
    this.username,
    this.nombre,
    this.apellido,
    this.cedula,
    this.telefono,
    this.email,
    this.changePassword,
    this.createdAt,
    this.updatedAt,
  );

  Users.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        nombre = json['nombre'],
        apellido = json['apellido'],
        cedula = json['cedula'],
        telefono = json['telefono'],
        email = json['email'],
        changePassword = json['changePassword'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'nombre': nombre,
        'apellido': apellido,
        'cedula': cedula,
        'telefono': telefono,
        'email': email,
        'changePassword': changePassword,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

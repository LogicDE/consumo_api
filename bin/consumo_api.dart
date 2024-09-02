import 'dart:convert';
import 'package:http/http.dart' as http;
import 'classes/clase_user.dart';

void mostrarUsernameLargos(List<User> usuarios) {
  var filtro = usuarios.where((usuarios) => usuarios.username.length > 6);
  for (var usuario in filtro) {
    print('||||||||||||||||||||||||||||||||||||||||');
    print('ID: ${usuario.id}');
    print('Nombre: ${usuario.name}');
    print('Nombre de usuario: ${usuario.username}');
    print('||||||||||||||||||||||||||||||||||||||||');
  }
}

void conteoBiz(List<User> usuarios) {
  var cuenta =
      usuarios.where((usuario) => usuario.email.endsWith('.biz')).length;
  print('Cant Usuarios con Dominio de Correo Biz: $cuenta');
  print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
}

void main() async {
  //Url donde sacamos los datos
  final urlusuarios = Uri.parse('https://jsonplaceholder.typicode.com/users');
  //Respuesta final que tendra como valor el resultado de las peticione.
  final respuesta = await http.get(urlusuarios);
  print(respuesta);

  if (respuesta.statusCode == 200) {
    List<dynamic> jdata = jsonDecode(respuesta.body);
    List<User> usuarios = jdata.map((json) => User.fromJson(json)).toList();
    for (var usuario in usuarios) {
      print(
          '---------------------------------------------------------------------------');
      print('ID: ${usuario.id}');
      print('Nombre: ${usuario.name}');
      print('Nombre de usuario: ${usuario.username}');
      print('Email: ${usuario.email}');
      print(
          'Dirección: ${usuario.address.street}, ${usuario.address.suite}, ${usuario.address.city}, ${usuario.address.zipcode}');
      print(
          'Geolocalización: Lat ${usuario.address.geo.lat}, Lng ${usuario.address.geo.lng}');
      print('Teléfono: ${usuario.phone}');
      print('Sitio web: ${usuario.website}');
      print(
          'Compañía: ${usuario.company.name}, ${usuario.company.catchPhrase}, ${usuario.company.bs}');
      print(
          '-------------------------------------------------------------------------');
    }
    mostrarUsernameLargos(usuarios);
    conteoBiz(usuarios);
  } else {
    print('Error en obtener infor, respuesta: ${respuesta.statusCode} ');
  }
}

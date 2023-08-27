import 'package:equatable/equatable.dart';

//Modelo para el token de acceso
class Token extends Equatable {
  const Token(
      this.accessToken, this.refreshToken, this.expiresIn, this.tokenType);

  final String accessToken;
  final String refreshToken;
  final String expiresIn;
  final String tokenType;

  @override
  List<Object> get props => [accessToken, refreshToken, expiresIn, tokenType];

  static const empty = Token('-', '-', '-', '-');
}

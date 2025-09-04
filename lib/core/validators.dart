
String? requiredField(String? value) =>
    value == null || value.isEmpty ? "Campo obrigatório" : null;

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) return "Informe o e-mail";
  if (!value.contains('@')) return "E-mail inválido";
  return null;
}

String? minLen(int len, String? value) {
  if (value == null || value.isEmpty) return "Campo obrigatório";
  if (value.length < len) return "Mínimo de $len caracteres";
  return null;
}

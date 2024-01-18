double tamanhoBoxLogin(int tamanhoErro, bool eLogin) {
  double tamanho = 0.0;
  const double boxLogin = 280;
  const double boxLoginErro = 25;
  const double boxSignup = 340;
  const double boxSignupErro = 20;

  if (eLogin) {
    tamanho = boxLogin;

    if (tamanhoErro > 0) tamanho += boxLoginErro;

    if (tamanhoErro > 21) tamanho += boxLoginErro;
  } else {
    tamanho = boxSignup;

    if (tamanhoErro > 0) tamanho += boxSignupErro;

    if (tamanhoErro > 30) tamanho += boxSignupErro;

    if (tamanhoErro > 200) tamanho += boxSignupErro * 2;

    if (tamanhoErro > 210) tamanho += boxSignupErro;

    if (tamanhoErro > 250) tamanho += boxSignupErro;
  }

  if (tamanhoErro > 0 && !eLogin) tamanho += boxSignupErro;

  if (tamanhoErro > 60) tamanho += boxSignupErro;

  return tamanho;
}

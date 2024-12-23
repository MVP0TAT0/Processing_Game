//Função de saltar proveniente de: https://www.youtube.com/watch?v=8uCXGcWK4BA


class Ecobot {
  float x, y;

  int vel;            //Velocidade do movimento

  int alturaSalto;    //Distância do salto
  float ySalto;       //Valor y do topo da distância do salto

  boolean andarEsquerda;
  boolean andarDireita;
  boolean aSaltar;
  boolean aCair;
  
  //Hitbox do Ecobot
  float left,right,top,bottom;

  Ecobot(float _x, float _y) {
    rectMode(CENTER);
    x = _x;
    y = _y;

    andarEsquerda = false;
    andarDireita = false;
    aSaltar = false;
    aCair = false;
    vel = 3;
    alturaSalto = 100;
    ySalto = y - alturaSalto;
    
    //Hitbox Ecobot
    left = x - 25/2;
    right = x + 25/2;
    top = y - 50/2;
    bottom = y + 50/2;
  }

  void desenha() {

    // Corpo
    fill(255,0,0);
    rect(x, y, 25, 50, 10);
  }

  void mover() {
    if (andarDireita == true) {
      x += vel;
    }
    if (andarEsquerda == true) {
      x -= vel;
    }
    
    //Atualizar Ecobot
    left = x - 25/2;
    right = x + 25/2;
    top = y - 50/2;
    bottom = y + 50/2;
  }

  void salto() {
    if (aSaltar == true) {
      y -= 5;
    }
  }

  void cair() {
    if (aCair == true) {
      y += 5;
    }
  }

  void topoSalto() {
    //Parar de saltar ao chegar ao topo do salto
    if (y <= ySalto){
      aSaltar=false;
      aCair=true;
    }
  }
  
  void aterrar() {
    if (y >= height - 50/2){
      aCair=false;
      y = height - 50/2;
    }
  }
}

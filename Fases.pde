// Variáveis Botões
int bx = 500;
int by = 500;
int ba = 80;
int bl = 300;
color bColor = color(40, 155, 0);

// Menu Principal
void MenuPrincipal() {

  // Imagem de fundo
  Background = loadImage("background.png");
  image(Background, 500, 500);

  // Título do jogo
  textAlign(CENTER);
  fill(0);
  textSize(115);
  text("EcoBot", width/2, height/2-200);
  textSize(38);
  text("O ÚLTIMO GUARDIÃO", width/2, height/2-150);

  // Botão "Jogar"
  noStroke();
  rectMode(CENTER);
  fill(bColor);
  rect(bx, by+50, bl, ba, 25);
  fill(255);
  textSize(40);
  text("Jogar", bx, by+63);

  // Botão "Como jogar"
  fill(bColor);
  rect(bx, by+150, bl, ba, 25);
  fill(255);
  textSize(40);
  text("Selecionar nível", bx, by+163);

  // Botão "Sair"
  fill(bColor);
  rect(bx, by+250, bl, ba, 25);
  fill(255);
  textSize(40);
  text("Como jogar", bx, by+263);

  // Verificar se o cursor está em cima dos botões para mudar o seu ícone
  if (mouseX >= bx - bl / 2 && mouseX <= bx + bl / 2 && mouseY >= by + 50 - ba / 2 && mouseY <= by + 50 + ba / 2 ||
    mouseX >= bx - bl / 2 && mouseX <= bx + bl / 2 && mouseY >= by + 150 - ba / 2 && mouseY <= by + 150 + ba / 2 ||
    mouseX >= bx - bl / 2 && mouseX <= bx + bl / 2 && mouseY >= by + 250 - ba / 2 && mouseY <= by + 250 + ba / 2) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }

  // Mudar o botão ao dar hover
  // Botão "Jogar"
  if (mouseX >= bx - bl / 2 && mouseX <= bx + bl / 2 && mouseY >= by + 50 - ba / 2 && mouseY <= by + 50 + ba / 2) {
    stroke(bColor);
    strokeWeight(3);
    fill(255);
    rect(bx, by+50, bl, ba, 25);
    fill(bColor);
    textSize(40);
    text("Jogar", bx, by+63);
    if (mousePressed) {
      fase = 2;
    }
  }

  // Botão "Selecionar nível"
  if (mouseX >= bx - bl / 2 && mouseX <= bx + bl / 2 && mouseY >= by + 150 - ba / 2 && mouseY <= by + 150 + ba / 2) {
    stroke(bColor);
    strokeWeight(3);
    fill(255);
    rect(bx, by+150, bl, ba, 25);
    fill(bColor);
    textSize(40);
    text("Selecionar nível", bx, by+163);
    if (mousePressed) {
      fase = 12;
    }
  }

  // Botão "Como Jogar"
  if (mouseX >= bx - bl / 2 && mouseX <= bx + bl / 2 && mouseY >= by + 250 - ba / 2 && mouseY <= by + 250 + ba / 2) {
    stroke(bColor);
    strokeWeight(3);
    fill(255);
    rect(bx, by+250, bl, ba, 25);
    fill(bColor);
    textSize(40);
    text("Como jogar", bx, by+263);
    if (mousePressed) {
      fase = 1;
    }
  }
}



// Jogo

boolean[] lixoColecionado = {false, false, false};  // Array Boolean com os 3 índices do lixo false

float efeitoOverdriveTempo = 0;
boolean efeitoOverdriveAtivo = false;

// Nível 1
void Nivel1() {

  noStroke();
  background(135, 206, 235);
  cursor(ARROW);

  // Desenhar nuvens
  desenharNuvem(150, 200);
  desenharNuvem(300, 70);
  desenharNuvem(600, 150);
  desenharNuvem(850, 250);
  desenharNuvem(380, 180);


  // Energia
  energia();

  // Funções Ecobot
  Ecobot.desenha();
  Ecobot.mover();
  Ecobot.salto();
  Ecobot.cair();
  Ecobot.topoSalto();
  Ecobot.cairPlataforma(plataformaArray1);


  // Desenhar e verificar colisões com os lixos
  for (int i = 0; i < 3; i++) {
    if (lixoArray1[i] != null) {  // Verificar se o lixo ainda existe (Se o lixo não for null)
      lixoArray1[i].desenhaLixo();  // Se o lixo ainda existir, desenha-o

      if (lixoArray1[i].colisaoLixo(Ecobot)) {  // Se houver colisão do Ecobot com o lixo...
        lixoArray1[i] = null;  // ...remove o lixo
        lixoColecionado[i] = true;  // ...marca o lixo como colecionado no índice correspondente
        energia -= 10;  // ...perde energia
        println("Colisão com lixo no índice " + i);
      }
    }
  }

  // Desenhar e verificar colisões com as bolas de energia
  for (int i = 0; i < e1; i++) {
    if (bolaEnergiaArray1[i] != null) {  // Verificar se a bola ainda existe (Se não for null)
      bolaEnergiaArray1[i].desenhaBolaEnergia();  // Se não for null, desenha

      if (bolaEnergiaArray1[i].colisaoBolaEnergia(Ecobot)) {  // Se houver colisão do Ecobot com a bola...
        bolaEnergiaArray1[i] = null;  // ...reemove a bola
        energia += 35;               // ...aumenta a energia do jogador
        println("Colisão com bola de energia no índice " + i);
      }
    }
  }


  // Lixos colecionados
  textAlign(RIGHT);
  fill(255);
  text("Lixo colecionado", width-30, 70);

  // Desenhar as imagens de lixo no canto superior direito
  for (int i = 0; i < 3; i++) {
    if (lixoColecionado[i]) {
      image(lixoCor, width - 210 + i * 40, 110, 33.5, 43.5); // Exibir lixo colecionado
    } else {
      image(lixoPreto, width - 210 + i * 40, 110, 33.5, 43.5); // Exibir lixo não colecionado
    }
  }

  // Verificar se os lixos todos foram colecionados
  boolean todosLixos = true;

  for (int i = 0; i < 3; i++) {
    if (!lixoColecionado[i]) {    // Se detetar algum dos lixos com lixoColecionado = false...
      todosLixos = false;  // Então marca todosLixos = false
      break;
    }
  }


  if (todosLixos) {  // Mudar de nível se apanhar os 3 lixos
    fase = 3; //Fase Nivel1_Concluido
  } else if (energia <= 0) {
    fase = 4; //Fase Nivel1_Falhado
  }

  // Troncos
  for (int i = 0; i < t1; i++) {
    troncoArray1[i].desenha();
    troncoArray1[i].colisaoTronco(Ecobot);
  }

  // Plataformas
  for (int i = 0; i < n1; i++) {
    plataformaArray1[i].desenha();
    plataformaArray1[i].colisao(Ecobot);
  }
}



// Nível 1 - Concluído
void Nivel1_Concluido() {

  // Fundo semi-transparente
  fill(255, 255, 255, 20);
  rect(width / 2, height / 2, 600, 400, 50);
  fill(0);
  textAlign(CENTER);
  text("Nível 1 concluído!", width / 2, height / 2 - 100);

  // Determinar se o cursor está sobre o botão
  boolean Hover = mouseX >= bx - bl / 2 && mouseX <= bx + bl / 2 &&
    mouseY >= by + 50 - ba / 2 && mouseY <= by + 50 + ba / 2;

  // Desenhar o botão
  if (Hover) {
    textSize(40);
    cursor(HAND);
    stroke(bColor);
    strokeWeight(3);
    fill(255);
    rect(bx, by + 50, bl, ba, 25);
    fill(bColor);
    text("Próximo nível", bx, by + 63);
  } else {
    textSize(40);
    cursor(ARROW);
    noStroke();
    fill(bColor);
    rect(bx, by + 50, bl, ba, 25);
    fill(255);
    text("Próximo nível", bx, by + 63);
  }

  if (mousePressed && Hover) {
    resetNivel1(); // Reiniciar o estado do nível 1
    fase = 5; // Nivel 2
  }

  noStroke();
}

void Nivel1_Falhado() {

  // Fundo semi-transparente
  fill(255, 255, 255, 20);
  rect(width / 2, height / 2, 600, 400, 50);
  fill(0);
  textAlign(CENTER);
  text("O Ecobot ficou sem energia!", width / 2, height / 2 - 100);

  // Determinar se o cursor está sobre o botão
  boolean hover = mouseX >= bx - bl / 2 && mouseX <= bx + bl / 2 &&
    mouseY >= by + 50 - ba / 2 && mouseY <= by + 50 + ba / 2;

  // Desenhar o botão
  if (hover) {
    textSize(40);
    cursor(HAND);
    stroke(bColor);
    strokeWeight(3);
    fill(255);
    rect(bx, by + 50, bl, ba, 25);
    fill(bColor);
    text("Repetir nível", bx, by + 63);
  } else {
    textSize(40);
    cursor(ARROW);
    noStroke();
    fill(bColor);
    rect(bx, by + 50, bl, ba, 25);
    fill(255);
    text("Repetir nível", bx, by + 63);
  }

  if (mousePressed && hover) {
    resetNivel1(); // Reiniciar o estado do nível 1
    fase = 2; // Nivel 1
  }

  noStroke();
}

void Nivel2() {

  noStroke();
  background(135, 206, 235);
  cursor(ARROW);

  // Desenhar nuvens
  desenharNuvem(150, 200);
  desenharNuvem(300, 70);
  desenharNuvem(600, 150);
  desenharNuvem(850, 250);
  desenharNuvem(380, 180);

  // Energia
  energia();

  // Funções Ecobot
  Ecobot.desenha();
  Ecobot.mover();
  Ecobot.salto();
  Ecobot.cair();
  Ecobot.topoSalto();
  Ecobot.cairPlataforma(plataformaArray2);

  // Overdrive
  if (Overdrive1 != null) {
    Overdrive1.desenhaOverdrive();
    Overdrive1.aplicarEfeito(Ecobot);
  }

  // Lixo
  for (int i = 0; i < 3; i++) {
    if (lixoArray2[i] != null) {
      lixoArray2[i].desenhaLixo();

      if (lixoArray2[i].colisaoLixo(Ecobot)) {
        lixoArray2[i] = null;
        lixoColecionado[i] = true;
        energia -= 10;
        println("Colisão com lixo no índice " + i);
      }
    }
  }

  // Bolas energia
  for (int i = 0; i < e2; i++) {
    if (bolaEnergiaArray2[i] != null) {
      bolaEnergiaArray2[i].desenhaBolaEnergia();

      if (bolaEnergiaArray2[i].colisaoBolaEnergia(Ecobot)) {
        bolaEnergiaArray2[i] = null;
        energia += 35;
        println("Colisão com bola de energia no índice " + i);
      }
    }
  }

  // Lixos colecionados
  textAlign(RIGHT);
  fill(255);
  text("Lixo colecionado", width-30, 70);

  // Lixo score
  for (int i = 0; i < 3; i++) {
    if (lixoColecionado[i]) {
      image(lixoCor, width - 210 + i * 40, 110, 33.5, 43.5);
    } else {
      image(lixoPreto, width - 210 + i * 40, 110, 33.5, 43.5);
    }
  }

  boolean todosLixos = true;

  for (int i = 0; i < 3; i++) {
    if (!lixoColecionado[i]) {
      todosLixos = false;
      break;
    }
  }

  if (todosLixos) {
    fase = 6; //Nivel 2_concluido
  }

  // Troncos
  for (int i = 0; i < t2; i++) {
    troncoArray2[i].desenha();
    troncoArray2[i].colisaoTronco(Ecobot);
  }

  // Plataformas
  for (int i = 0; i < n2; i++) {
    plataformaArray2[i].desenha();
    plataformaArray2[i].colisao(Ecobot);
  }
}

// Nivel 2 - Concluído
void Nivel2_Concluido() {

  // Fundo semi-transparente
  fill(255, 255, 255, 20);
  rect(width / 2, height / 2, 600, 400, 50);
  fill(0);
  textAlign(CENTER);
  text("Nível 2 concluído!", width / 2, height / 2 - 100);

  // Determinar se o cursor está sobre o botão
  boolean hover = mouseX >= bx - bl / 2 && mouseX <= bx + bl / 2 &&
    mouseY >= by + 50 - ba / 2 && mouseY <= by + 50 + ba / 2;

  // Desenhar o botão
  if (hover) {
    textSize(40);
    cursor(HAND);
    stroke(bColor);
    strokeWeight(3);
    fill(255);
    rect(bx, by + 50, bl, ba, 25);
    fill(bColor);
    text("Próximo nível", bx, by + 63);
  } else {
    textSize(40);
    cursor(ARROW);
    noStroke();
    fill(bColor);
    rect(bx, by + 50, bl, ba, 25);
    fill(255);
    text("Próximo nível", bx, by + 63);
  }

  // Verificar clique no botão
  if (mousePressed && hover) {
    resetNivel2(); // Reiniciar o estado do nível 2
    fase = 8; // Nivel 3
  }

  noStroke();
}

void Nivel2_Falhado() {

  // Fundo
  fill(255, 255, 255, 20);
  rect(width / 2, height / 2, 600, 400, 50);
  fill(0);
  textAlign(CENTER);
  text("O Ecobot ficou sem energia!", width / 2, height / 2 - 100);

  // Verificar se o cursor está sobre o botão
  boolean hover = mouseX >= bx - bl / 2 && mouseX <= bx + bl / 2 &&
    mouseY >= by + 50 - ba / 2 && mouseY <= by + 50 + ba / 2;

  // Desenhar o botão
  if (hover) {
    textSize(40);
    cursor(HAND);
    stroke(bColor);
    strokeWeight(3);
    fill(255);
    rect(bx, by + 50, bl, ba, 25);
    fill(bColor);
    text("Repetir nível", bx, by + 63);
  } else {
    textSize(40);
    cursor(ARROW);
    noStroke();
    fill(bColor);
    rect(bx, by + 50, bl, ba, 25);
    fill(255);
    text("Repetir nível", bx, by + 63);
  }

  // Verificar clique no botão
  if (mousePressed && hover) {
    resetNivel2(); // Reiniciar o estado do nível 2
    fase = 5; // Nivel 2
  }

  noStroke();
}

void Nivel3() {
  noStroke();
  background(135, 206, 235);
  cursor(ARROW);

  // Desenhar nuvens
  desenharNuvem(150, 200);
  desenharNuvem(300, 70);
  desenharNuvem(600, 150);
  desenharNuvem(850, 250);
  desenharNuvem(380, 180);

  // Energia
  energia();

  // Funções Ecobot
  Ecobot.desenha();
  Ecobot.mover();
  Ecobot.salto();
  Ecobot.cair();
  Ecobot.topoSalto();
  Ecobot.cairPlataforma(plataformaArray3);

  // Funções Redbot
  Redbot1.desenha();
  Redbot1.mover();
  Redbot1.colisao(Ecobot);

  // Funções Redbot
  Redbot2.desenha();
  Redbot2.mover();
  Redbot2.colisao(Ecobot);

  // Lixos
  for (int i = 0; i < 3; i++) {
    if (lixoArray3[i] != null) {
      lixoArray3[i].desenhaLixo();

      if (lixoArray3[i].colisaoLixo(Ecobot)) {
        lixoArray3[i] = null;
        lixoColecionado[i] = true;
        energia -= 10;
        println("Colisão com lixo no índice " + i);
      }
    }
  }

  // Bolas de energia
  for (int i = 0; i < e3; i++) {
    if (bolaEnergiaArray3[i] != null) {
      bolaEnergiaArray3[i].desenhaBolaEnergia();

      if (bolaEnergiaArray3[i].colisaoBolaEnergia(Ecobot)) {
        bolaEnergiaArray3[i] = null;
        energia += 35;
        println("Colisão com bola de energia no índice " + i);
      }
    }
  }

  // Overdrive
  if (Overdrive2 != null) {
    Overdrive2.desenhaOverdrive();
    Overdrive2.aplicarEfeito(Ecobot);
  }

  // Lixos colecionados
  textAlign(RIGHT);
  fill(255);
  text("Lixo colecionado", width-30, 70);

  // Lixos score
  for (int i = 0; i < 3; i++) {
    if (lixoColecionado[i]) {
      image(lixoCor, width - 210 + i * 40, 110, 33.5, 43.5); // Exibir lixo coletado (verde)
    } else {
      image(lixoPreto, width - 210 + i * 40, 110, 33.5, 43.5); // Exibir lixo não coletado (preto)
    }
  }

  boolean todosLixos = true;

  for (int i = 0; i < 3; i++) {
    if (!lixoColecionado[i]) {
      todosLixos = false;
      break;
    }
  }

  if (todosLixos) {
    fase = 11; // Vitória
  }

  // Troncos
  for (int i = 0; i < t3; i++) {
    troncoArray3[i].desenha();
    troncoArray3[i].colisaoTronco(Ecobot);
  }

  // Plataformas
  for (int i = 0; i < n3; i++) {
    plataformaArray3[i].desenha();
    plataformaArray3[i].colisao(Ecobot);
  }
}

// Nivel 3 - Concluído
void Nivel3_Concluido() {

  // Fundo semi-transparente
  fill(255, 255, 255, 20);
  rect(width / 2, height / 2, 600, 400, 50);
  fill(0);
  textAlign(CENTER);
  text("Nível 3 concluído!", width / 2, height / 2 - 100);

  // Determinar se o cursor está sobre o botão
  boolean hover = mouseX >= bx - bl / 2 && mouseX <= bx + bl / 2 &&
    mouseY >= by + 50 - ba / 2 && mouseY <= by + 50 + ba / 2;

  // Desenhar o botão
  if (hover) {
    textSize(40);
    cursor(HAND);
    stroke(bColor);
    strokeWeight(3);
    fill(255);
    rect(bx, by + 50, bl, ba, 25);
    fill(bColor);
    text("Vitória!", bx, by + 63);
  } else {
    textSize(40);
    cursor(ARROW);
    noStroke();
    fill(bColor);
    rect(bx, by + 50, bl, ba, 25);
    fill(255);
    text("Vitória!", bx, by + 63);
  }

  // Verificar clique no botão
  if (mousePressed && hover) {
    resetNivel3(); // Reiniciar o estado do nível 3
    fase = 11; // Vitória
  }

  noStroke();
}

void Nivel3_Falhado() {

  // Fundo
  fill(255, 255, 255, 20);
  rect(width / 2, height / 2, 600, 400, 50);
  fill(0);
  textAlign(CENTER);
  text("O Ecobot ficou sem energia!", width / 2, height / 2 - 100);

  // Verificar se o cursor está sobre o botão
  boolean hover = mouseX >= bx - bl / 2 && mouseX <= bx + bl / 2 &&
    mouseY >= by + 50 - ba / 2 && mouseY <= by + 50 + ba / 2;

  // Desenhar o botão
  if (hover) {
    textSize(40);
    cursor(HAND);
    stroke(bColor);
    strokeWeight(3);
    fill(255);
    rect(bx, by + 50, bl, ba, 25);
    fill(bColor);
    text("Repetir nível", bx, by + 63);
  } else {
    textSize(40);
    cursor(ARROW);
    noStroke();
    fill(bColor);
    rect(bx, by + 50, bl, ba, 25);
    fill(255);
    text("Repetir nível", bx, by + 63);
  }

  // Verificar clique no botão
  if (mousePressed && hover) {
    resetNivel3(); // Reiniciar o estado do nível 3
    fase = 8; // Nivel 3
  }

  noStroke();
}


// Menu "Como jogar"
void ComoJogar() {

  // Imagem de fundo
  ComoJogar = loadImage("ComoJogar.png");
  image(ComoJogar, 500, 500);

  // Botão "Voltar"
  noStroke();
  fill(155, 40, 0);
  rect(bx-350, by+380, 200, 60, 25);
  fill(255);
  textSize(30);
  text("Voltar", bx-350, by+390);

  // Clicar dentro do botão
  if (mouseX >= bx - 350 - 100 && mouseX <= bx - 350 + 100 &&
    mouseY >= by + 380 - 30 && mouseY <= by + 380 + 30) {
    cursor(HAND);
    noStroke();
    fill(255);
    stroke(155, 40, 0);
    rect(bx-350, by+380, 200, 60, 25);
    fill(155, 40, 0);
    textSize(30);
    text("Voltar", bx-350, by+390);
    if (mousePressed) {
      fase = 0;
    }
  } else {
    cursor(ARROW);
  }
}

// Menu Selecionar Nível
void Selecionar_Nivel() {

  // Imagem de fundo
  Background = loadImage("background.png");
  image(Background, 500, 500);

  // "Selecione o nível"
  noStroke();
  fill(0);
  textSize(60);
  text("Selecione o nível", bx, by-250);

  //Botão Voltar
  fill(155, 40, 0);
  rect(bx, height-100, bl-50, ba, 25);
  fill(255);
  textSize(40);
  text("Voltar", bx, height-85);

  //Botão Nível 1
  noStroke();
  rectMode(CENTER);
  fill(bColor);
  rect(bx-300, by, bl-50, ba, 25);
  fill(255);
  textSize(40);
  text("Nível 1", bx - 300, by+13);

  //Botão Nível 2
  noStroke();
  rectMode(CENTER);
  fill(bColor);
  rect(bx, by, bl-50, ba, 25);
  fill(255);
  textSize(40);
  text("Nível 2", bx, by+13);

  //Botão Nível 3
  noStroke();
  rectMode(CENTER);
  fill(bColor);
  rect(bx+300, by, bl-50, ba, 25);
  fill(255);
  textSize(40);
  text("Nível 3", bx+300, by+13);

  // Verificar se o cursor está em cima dos butões
  if (mouseX >= bx - (bl-50) / 2 && mouseX <= bx + (bl-50) / 2 && mouseY >= height-100 - ba / 2 && mouseY <= height-100 + ba / 2 ||
    mouseX >= bx - 300 - (bl-50) / 2 && mouseX <= bx - 300 + (bl-50) / 2 && mouseY >= by - ba / 2 && mouseY <= by + ba / 2 ||
    mouseX >= bx - (bl-50) / 2 && mouseX <= bx + (bl-50) / 2 && mouseY >= by - ba / 2 && mouseY <= by + ba / 2 ||
    mouseX >= bx + 300 - (bl-50) / 2 && mouseX <= bx + 300 + (bl-50) / 2 && mouseY >= by - ba / 2 && mouseY <= by + ba / 2)
    cursor(HAND);
  else
    cursor(ARROW);

  if (mouseX >= bx - (bl-50) / 2 && mouseX <= bx + (bl-50) / 2 && mouseY >= height-100 - ba / 2 && mouseY <= height-100 + ba / 2) {
    //Botão Voltar
    fill(255);
    stroke(155, 0, 0);
    rect(bx, height-100, bl-50, ba, 25);
    fill(155, 0, 0);
    textSize(40);
    text("Voltar", bx, height-85);
    if (mousePressed) {
      fase = 0;
    }
  }

  if (mouseX >= bx - 300 - (bl-50) / 2 && mouseX <= bx - 300 + (bl-50) / 2 && mouseY >= by - ba / 2 && mouseY <= by + ba / 2) {
    //Botão Nivel 1
    fill(255);
    stroke(bColor);
    rect(bx-300, by, bl-50, ba, 25);
    fill(bColor);
    textSize(40);
    text("Nível 1", bx - 300, by+13);
    if (mousePressed) {
      fase = 2;
    }
  }

  if (mouseX >= bx - (bl-50) / 2 && mouseX <= bx + (bl-50) / 2 && mouseY >= by - ba / 2 && mouseY <= by + ba / 2) {
    //Botão Nivel 2
    fill(255);
    stroke(bColor);
    rect(bx, by, bl-50, ba, 25);
    fill(bColor);
    textSize(40);
    text("Nível 2", bx, by+13);
    if (mousePressed) {
      fase = 5;
    }
  }

  if (mouseX >= bx + 300 - (bl-50) / 2 && mouseX <= bx + 300 + (bl-50) / 2 && mouseY >= by - ba / 2 && mouseY <= by + ba / 2) {
    //Botão Nivel 2
    fill(255);
    stroke(bColor);
    rect(bx+300, by, bl-50, ba, 25);
    fill(bColor);
    textSize(40);
    text("Nível 3", bx+300, by+13);
    if (mousePressed) {
      fase = 8;
    }
  }
}

void Vitoria() {
  Vitoria = loadImage("Vitoria.png");
  image(Vitoria, 500, 500);
}

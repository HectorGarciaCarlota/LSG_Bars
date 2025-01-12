CREATE DATABASE IF NOT EXISTS Proj02UF2;

USE Proj02UF2;

DROP TABLE IF EXISTS client;

CREATE TABLE IF NOT EXISTS client(
DNI_client Varchar(9) not null,
es_major enum('V','F') not null default 'F',
CONSTRAINT PK_dni_client PRIMARY KEY (dni_client),
CONSTRAINT FK1_dni_client FOREIGN KEY(dni_client) REFERENCES Persona(DNI) ON DELETE CASCADE ON UPDATE CASCADE
);

DROP TABLE IF EXISTS client_taula;

CREATE TABLE IF NOT EXISTS client_taula(
id_client_taula int auto_increment,
DNI_client Varchar(9) not null,
numero_taula int check (numero_taula>=0),
id_bar int not null check (id_bar>=0),
es_fumador enum('V','F') not null default 'F',
data_hora_arribada datetime, 
data_hora_sortida datetime,
ha_pagat bool,
CONSTRAINT PK_id_client_taula PRIMARY KEY (id_client_taula),
CONSTRAINT FK2_DNI_client FOREIGN KEY (DNI_client) REFERENCES Client(DNI_client) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK1_Numero_Taula FOREIGN KEY (numero_taula) REFERENCES Taula(numero_taula) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK1_id_bar FOREIGN KEY (numero_taula) REFERENCES Bar(Id_bar) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS comanda_tapes;

CREATE TABLE IF NOT EXISTS comanda_tapes(
id_Tapa int not null check (id_tapa>=0),
id_Bar int not null check (id_bar>=0),
id_client_taula int not null check (id_client_taula>=0),
data_client_taula datetime,
quantitat int check (quantitat>=0),
CONSTRAINT PK1_comanda_tapes PRIMARY KEY (id_tapa, id_bar, id_client_taula),
CONSTRAINT FK1_id_tapa FOREIGN KEY (id_tapa) REFERENCES Carta_Tapes(id_Tapa) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK1_id_bar FOREIGN KEY (id_Bar) REFERENCES Carta_Tapes(id_Bar) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK2_id_client_taula FOREIGN KEY (id_client_taula) REFERENCES Client_Taula(id_client_taula) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS Carta_tapes;

CREATE TABLE IF NOT EXISTS carta_tapes(
id_Tapa int check (id_tapa>=0),
id_Bar int check (id_bar>=0), 
Cost int check (cost>=0),
PVP FLOAT(5,2) check (PVP>=0),
CONSTRAINT PK1_carta_tapes PRIMARY KEY (id_tapa, id_bar),
CONSTRAINT FK1_id_tapa FOREIGN KEY (id_tapa) REFERENCES Tapa(id_tapa) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK2_id_bar FOREIGN KEY (id_bar) REFERENCES Bar(id_bar) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Comanda_Begudes;
 
CREATE TABLE IF NOT EXISTS Comanda_Begudes(
id_beguda int check (id_beguda>=0),
id_bar int check (id_bar>=0),
id_client_taula int check (id_client_taula>=0),
data_hora_comanda datetime,
quantitat FLOAT(5,2) check (quantitat>=0),
CONSTRAINT PK1_id_beguda PRIMARY KEY (id_beguda, id_bar, id_client_taula),
CONSTRAINT FK1_id_beguda FOREIGN KEY (id_beguda) REFERENCES Carta_begudes(id_beguda) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK1_id_bar FOREIGN KEY (id_bar) REFERENCES Carta_begudes(id_bar) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK2_id_client_taula FOREIGN KEY (id_client_taula) REFERENCES Client_taula(id_client_taula) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Carta_Begudes;

CREATE TABLE IF NOT EXISTS Carta_Begudes(
id_Beguda int check (id_beguda>=0),
id_bar int check (id_bar>=0),
cost int check (cost>=0),
PVP int check (PVP>=0),
CONSTRAINT PK1_carta_begudes PRIMARY KEY (id_Beguda, id_bar),
CONSTRAINT FK1_id_beguda FOREIGN KEY (id_Beguda) REFERENCES Beguda(id_Beguda) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK2_id_bar FOREIGN KEY (id_bar) REFERENCES Bar(Id_bar) ON UPDATE CASCADE ON DELETE CASCADE
);
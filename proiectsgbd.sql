create table ANGAJAT(
id_angajat numeric(5) constraint cheie_angj_ primary key,
prenume varchar2(25),
nume varchar2(25) constraint null_numel_  not null,
email char(30) unique,
telefon varchar(11),
data_angajare date default sysdate,
salariu numeric(5) constraint null_sal not null,
constraint id_ang check(id_angajat>0)
);

alter table angajat
rename column prenume to nume_;
alter table angajat
rename column nume to prenume;
alter table angajat
rename column nume_ to nume;

create table DIRECTOR(
id_angajat numeric(5),
ani_vechime numeric(2), 
constraint id_angajat_dir primary key(id_angajat),
constraint id_angajat_dir_fk foreign key(id_angajat) references ANGAJAT(id_angajat), 
constraint null_dir check(id_angajat>0)
);

create table PROFESOR(
id_angajat numeric(5),
calificare char(25),
constraint id_angajat_prof primary key(id_angajat),
constraint id_angajat_prof_fk foreign key(id_angajat) references ANGAJAT(id_angajat), 
constraint null_prof check(id_angajat>0)
);
create table INGRIJITOR(
id_angajat numeric(5),
ore_pe_zi numeric(2), 
constraint id_angajat_ing primary key(id_angajat),
constraint id_angajat_ing_fk foreign key(id_angajat) references ANGAJAT(id_angajat), 
constraint null_ing check(id_angajat>0)
);

create table ELEV(
id_elev numeric(5) constraint cheie_elev_ primary key,
id_taxa numeric(5) ,
prenume varchar2(25) constraint null_prenumeelev_  not null,
nume varchar2(25) constraint null_numeelev_  not null,
email char(25) unique,
telefon char(11),
initiala_tatalui char(1),
medie_finala number(5,2),
 FOREIGN KEY (id_taxa) REFERENCES TAXA(id_taxa)
);

alter table elev
rename column prenume to nume_;
alter table elev
rename column nume to prenume;
alter table elev
rename column nume_ to nume;

create table TAXA(
id_taxa numeric(5) constraint cheie_taxa_ primary key,
suma numeric(5) constraint null_sumataxa_  not null,
nr_discipline numeric(1)  constraint null_nrdiscipline_  not null
);

create table DISCIPLINA(
id_disciplina  numeric(5) constraint cheie_disciplina_ primary key,
nume_disciplina varchar2(25) constraint null_numedisciplina_  not null,
mod_notare char(13) check(mod_notare in ('Nota', 'Admis/respins')),
numar_prezente numeric(2)
);


create table INSTRUMENT(
id_instrument numeric(5) constraint cheie_instrument_ primary key,
nume_instrument varchar2(25) constraint null_numeinstr_  not null,
pret numeric(5)
);


create table LOCATIE(
id_locatie numeric(5) constraint cheie_loc primary key,
id_tara numeric(5)  ,
strada varchar2(25) constraint null_strada_  not null,
tip_locatie varchar2(25) check(tip_locatie in ('Rurala', 'Urbana')),
localitate varchar2(25) constraint null_local_  not null,
 FOREIGN KEY (id_tara) REFERENCES TARA(id_tara)
);

create table TARA(
id_tara numeric(5) constraint cheie_tara primary key ,
nume_tara varchar2(25) constraint null_numetara_  not null,
limba_vorbita varchar2(25) constraint null_limbavorbita_  not null
);

create table EVENIMENT(
id_eveniment numeric(5) constraint cheie_event primary key,
id_locatie numeric(5),
data_eveniment date default sysdate,
tip_eveniment varchar2(25) check(tip_eveniment in ('Spectacol', 'Expozitie', 'Concurs')),
 FOREIGN KEY (id_locatie) REFERENCES LOCATIE(id_locatie)
);


create table SALA(
id_sala numeric(5) constraint cheie_sala primary key,
nume_sala varchar2(25) constraint null_numesala_  not null,
dimensiune numeric(3),
capacitate numeric(3)
);

create table CURS(
id_curs numeric(5) constraint cheie_curs primary key,
id_sala numeric(5),
id_disciplina numeric(5),
nume_curs varchar2(25) constraint null_numecurs_  not null,
zi_saptamana varchar2(25) constraint null_sapt_  not null,
ora_inceput char(7),
ora_sfarsit char(7),
foreign key (id_curs) references curs(id_curs),
foreign key (id_disciplina) references disciplina(id_disciplina),
constraint id_curs check(id_curs>0)
);


--tabele asociative
create table NECESITA(
  id_disciplina numeric(5),
  id_instrument numeric(5),
  primary key(id_disciplina, id_instrument),
  foreign key(id_disciplina) references disciplina(id_disciplina) on delete CASCADE,
  foreign key(id_instrument) references instrument(id_instrument) on delete CASCADE
);
create table CURATA(
  id_angajat numeric(5),
  id_sala numeric(5),
  primary key(id_angajat, id_sala),
  foreign key(id_angajat) references angajat(id_angajat) on delete CASCADE,
  foreign key(id_sala) references sala(id_sala) on delete CASCADE,
  timp_curatare numeric(3)
  );
create table PREDA(
  id_angajat numeric(5),
  id_elev numeric(5),
  id_disciplina numeric(5),
  primary key(id_angajat, id_elev, id_disciplina),
  foreign key(id_disciplina) references disciplina(id_disciplina) on delete CASCADE,
  foreign key(id_angajat) references angajat(id_angajat) on delete CASCADE,
  foreign key(id_elev) references elev(id_elev) on delete CASCADE
);

--SECVENTE
create sequence id_elevului
start with 100
increment by 1
nocycle
nocache;
 

create sequence id_curs
start with 100
increment by 1
nocycle
nocache;
 
create sequence id_sala
start with 100
increment by 1
nocycle
nocache;
 

create sequence id_event
start with 100
increment by 1
nocycle
nocache;
 

create sequence id_tara
start with 100
increment by 1
nocycle
nocache;
 

create sequence id_loc
start with 100
increment by 1
nocycle
nocache;
 
--INSERTURI
insert into elev
values (id_elevului.nextval, 100, 'Tiberiu','Manole','tiberiuman@gmail.com', '07055529401', 'N', 9);
insert into elev
values (id_elevului.nextval, 101, 'Adrian','Serban','serbanadrian@gmail.com', '07555587994', 'A', 10);
insert into elev
values (id_elevului.nextval, 100, 'Rica','Morosanu  ','ricamoro@gmail.com', '07855565321', 'S', 10);
insert into elev
values (id_elevului.nextval,102, 'Gogu','Stancu ','stancugogu33@gmail.com', '07055586081', 'E', 10);
insert into elev
values (id_elevului.nextval, 100, 'Felix','Bucur','felixbuc@gmail.com', '07555534282', 'A', 9);
insert into elev
values (id_elevului.nextval,101, 'Ionut','Balcescu','balcescuionutt2@gmail.com', '07055529372', 'O', 9);
insert into elev
values (id_elevului.nextval,100, 'Varujan','Olinescu ','olinescuvar111@gmail.com', '07115557787', 'R', 10);
insert into elev
values (id_elevului.nextval,100, 'Laurentiu','Pirvulescu','parvulesculaur@gmail.com', '07115552165', 'F', 10);
insert into elev
values (id_elevului.nextval, 104,'Emilian','Iagar ','emilianiagar01@gmail.com', '07255533755', 'G', 9.5);
insert into elev
values (id_elevului.nextval,100, 'Flaviu','Cosmescu','cosmescuflaviu@gmail.com', '07055530186', 'V', 10);
insert into elev

values (id_elevului.nextval, 100 ,'Alexandra','Ciurea',' ciuryale17@gmail.com', '07055588788', 'R', 10);
insert into elev
values (id_elevului.nextval, 101,'Irina','Moscovici','irinamosc@gmail.com', '07855563519', 'D', 8);
insert into elev
values (id_elevului.nextval, 102,'Florica','Filipescu','floricafili@gmail.com', '07255556319', 'F', 9.5);
insert into elev
values (id_elevului.nextval, 101,'Lenuta','Hurgoi','lenutahurgiu45@gmail.com', '07115556317', 'I', 9.5);
insert into elev
values (id_elevului.nextval, 100,'Daciana','Ionita','dacianaionita@gmail.com', '07855513286', 'G', 10);
insert into elev
values (id_elevului.nextval,100, 'Stela','Stanasila ','stelastana12@gmail.com', '07455514896', 'P', 9.5);
insert into elev
values (id_elevului.nextval,101, 'Beatrice','Calinescu','beatricecali@gmail.com', '07115556391', 'C', 10);
insert into elev
values (id_elevului.nextval,101, 'Gabriella','Stoica ','stoicagabi3@gmail.com', '07055555751', 'I', 10);
insert into elev
values (id_elevului.nextval,103, 'Costela','Predoiu ','predoiucostela@gmail.com', '0705558827', 'P', 9.5);

insert into elev
values (id_elevului.nextval,100, 'Simona','Costin',' simonacosti19@gmail.com', '07855595062', 'A', 10);
insert into elev
values (id_elevului.nextval,101, 'Ruxandra','Voiculet','ruxivoiculet@gmail.com', '07055553666', 'D', 8);
insert into elev
values (id_elevului.nextval,103, 'Lenuta','Lupul','lupulenuta@gmail.com','07055524738' , 'C', 10);
insert into elev
values (id_elevului.nextval,100, 'Ariana','Bucsa','bucsaariana@gmail.com', '07115555434', 'F', 9.5);
insert into elev
values (id_elevului.nextval,100, 'Ioana','Enache','enacheioana34@gmail.com', '07115555881', 'P', 9.5);
insert into elev
values (id_elevului.nextval,101, 'Lina','Vaduva ',' vaduvlinax@gmail.com', '07115553984', 'L', 10);
insert into elev
values (id_elevului.nextval,101, 'Angela','Popescu','angelapope12@gmail.com', '07055563113' , 'F', 9.5);
insert into elev
values (id_elevului.nextval, 100,'Livia','Iagar ','liviaiagar@gmail.com', '07055539270', 'O', 7);
insert into elev
values (id_elevului.nextval,102, 'Adrianna','Ioveanu ','ioveadriana22@gmail.com', '07655554026', 'G', 10);
insert into elev
values (id_elevului.nextval,100, 'Regina','Caragiale','caragialeregina@gmail.com', '07655589108', 'C', 10);
insert into elev
values (id_elevului.nextval,100, 'Virginia','Lazar ','lazarvirginia@gmail.com', '07055596459', 'D', 9.5);
insert into elev
values (id_elevului.nextval,102, 'Serghei','Moscovici ','sergheiimosco@gmail.com', '07115556530', 'G', 10);

insert into elev
values (id_elevului.nextval,100, 'Boian','Ungur',' ungurkurtos@gmail.com', '07055513677', 'T', 10);
insert into elev
values (id_elevului.nextval,101, 'Eftemie','Costiniu','costieftemie@gmail.com', '07115554077', 'P', 8);
insert into elev
values (id_elevului.nextval,100, 'Ionut','Catana','ionutkatan@gmail.com','07055598247' , 'M', 10);
insert into elev
values (id_elevului.nextval,101, 'Flavius','Antonescu','flaviusanton7@gmail.com', '07255598014', 'A', 10);
insert into elev
values (id_elevului.nextval, 102,'Dragoslav','Muresanu','muresanudrago@gmail.com', '07115554691', 'E', 9.5);
insert into elev
values (id_elevului.nextval,100, 'Vlad','Romanescu ','romanescuvlad55@gmail.com', '07115551531', 'B', 7);
insert into elev
values (id_elevului.nextval, 100,'Diana','Diaconescu','dianadia@gmail.com', '07055512690' , 'D', 10);
insert into elev
values (id_elevului.nextval,101, 'Calin','Costache ','catacostache14@gmail.com', '07855544705', 'C', 9.5);
insert into elev
values (id_elevului.nextval,102, 'Cristinel','Giurescu ','giurescucristi@gmail.com', '07755514868', 'D', 7);
insert into elev
values (id_elevului.nextval,101, 'Marius','Randa ','randamarius78@gmail.com', '07655592679', 'R', 10);
insert into elev
values (id_elevului.nextval,100, 'Ionel','Cozma ','cozmaionel@gmail.com', '07115555027', 'V', 10);
insert into elev
values (id_elevului.nextval,100, 'Catalin','Lacatus ','lacacantaretul@gmail.com', '07055528353', 'H', 10);

insert into elev
values (id_elevului.nextval,101, 'Denis','Stefan',' stefandenis@gmail.com', '07455598464', 'A', 9.5);
insert into elev
values (id_elevului.nextval,100, 'Andrei','Sofei','sofikandrei@gmail.com', '07255587161', 'E', 10);
insert into elev
values (id_elevului.nextval,100, 'Tudor ','Enache ','enachetudor56@gmail.com','07555596547' , 'I', 10);
insert into elev
values (id_elevului.nextval,103, 'Petru','Popa','popapetru22@gmail.com', '07055564782', 'N', 10);
insert into elev
values (id_elevului.nextval,100,'Bodgan','Cutov','cutovbogdann@gmail.com', '07115554728', 'A', 10);
insert into elev
values (id_elevului.nextval,101, 'Vasile','Proca  ','procavasi007@gmail.com', '07055571791', 'D', 9.5);
insert into elev
values (id_elevului.nextval,103, 'Ionache','Enescu ','enescuionache@gmail.com', '07115558529' , 'N', 10);
insert into elev
values (id_elevului.nextval,100, 'Tereza','Tomoiaga ','terezatomoioaga@gmail.com', '07055593227' , 'I', 10);
insert into elev
values (id_elevului.nextval,101, 'Ecaterina','Balcescu ','balcescueca@gmail.com', '07555556975', 'T', 9.5);
insert into elev
values (id_elevului.nextval,100, 'Simona ','Popescu  ','popescusimo90@gmail.com', '07355565381', 'C', 7);
insert into elev
values (id_elevului.nextval,100, 'Victoria','Pirvu  ','parvuvictoria@gmail.com', '07115559118', 'M', 10);
insert into elev
values (id_elevului.nextval,100, 'Felicia','Dinescu ','feliciadinescu1@gmail.com', '07055531556', 'G', 9.5);

insert into elev
values (id_elevului.nextval, 103, 'Stefania ','Brihac ',' stefibrih@gmail.com', '07115551388', 'V', 10);
insert into elev
values (id_elevului.nextval,102, 'Floarea ','Torje ',' torjefloarea6@gmail.com', '07055590574', 'S', 10);
insert into elev
values (id_elevului.nextval,102, 'Denisa ','Stirbei  ','stirbeidenisa@gmail.com','07115559194' , 'M', 9.5);
insert into elev
values (id_elevului.nextval,100, 'Daria ','Popa','popadaria@gmail.com', '07055558715', 'N', 9.5);
insert into elev
values (id_elevului.nextval, 101,'Bogdana ','Goga ','gogabogda112@gmail.com', '07755553738', 'C', 7);
insert into elev
values (id_elevului.nextval,100, 'Olivia','Moscovici  ','oliviamosco@gmail.com', '07115555878', 'R', 9.5);
insert into elev
values (id_elevului.nextval,100, 'Iona','Iacobescu  ','iacobescuiona03@gmail.com', '07755527353' , 'M', 10);
insert into elev
values (id_elevului.nextval,100, 'Imanuela','Tilea ','tileaimanuela@gmail.com', '07655519306' , 'D', 10);
insert into elev
values (id_elevului.nextval,101, 'Eugenia','Rebreanu  ','rebreanueug@gmail.com', '07455510080', 'G', 9.5);
insert into elev
values (id_elevului.nextval,102, 'Alexandra ','Iacobescu',' iacobescualex@gmail.com', '07055565773' , 'C', 10);
insert into elev
values (id_elevului.nextval,100, 'Raluca','Mihai ','ralumihai@gmail.com', '07115555474', 'F', 7);
insert into elev
values (id_elevului.nextval,100, 'Andreea','Popescu ','popescuandreea@gmail.com', '07055558138', 'C', 10);


insert into elev
values (id_elevului.nextval,102, 'Antanasia ','Varias ','anastasiav@gmail.com', '07055544642', 'E', 9.5);
insert into elev
values (id_elevului.nextval,100, 'Teofila ','Raducioiu ',' reducioiuteo90@gmail.com', '07255572002', 'L', 8);
insert into elev
values (id_elevului.nextval,100,'Victoria ',' Gherea  ','vitoriagherea@gmail.com','07115559145' , 'H', 9.5);
insert into elev
values (id_elevului.nextval,101, 'Virgil','Ghezzo','ghezzovirgil77@gmail.com', '07115557718', 'N', 10);
insert into elev
values (id_elevului.nextval,100, 'Gheorghe ','Vasiliu ','djvasili123@gmail.com', '07115559404', 'B', 9.5);
insert into elev
values (id_elevului.nextval,100, 'Iulian','Lupu  ','iulianwolf@gmail.com', '07115559652', 'G', 10);
insert into elev
values (id_elevului.nextval,101, 'Alexandru','Patrascoiu  ','patrasalex@gmail.com', '07855552068' , 'I', 10);
insert into elev
values (id_elevului.nextval, 101,'Artur','Presecan ','arturprescan30@gmail.com', '07755520618' , 'M', 9.5);
insert into elev
values (id_elevului.nextval,100, 'Horia','Ilica  ',' ilicahoria@gmail.com', '07655578139', 'E', 9);
insert into elev
values (id_elevului.nextval,100, 'Paul ','Costiniu',' costiniupaul4@gmail.com', '07115551520' , 'R', 8);
insert into elev
values (id_elevului.nextval,100, 'Eduard','Calinescu ','calinescued@gmail.com', '07055544396', 'D', 9.5);
insert into elev
values (id_elevului.nextval,100, 'Stan','Vlaicu ','vlaicustan1@gmail.com', '07855549963', 'M', 10);
insert into elev
values (id_elevului.nextval,102, 'Serban','Chitu  ','chituserban@gmail.com', '07755538938', 'V', 10);
insert into elev
values (id_elevului.nextval,101, 'Ivan','Goian  ','goianivan3@gmail.com', '07055576137' , 'N', 9.5);
insert into elev
values (id_elevului.nextval,101, 'Vasile','Rosetti ','rosettivasile23@gmail.com', '07115552480' , 'L', 10);

    
insert into taxa 
values(100, 500, 1);
insert into taxa
values(101, 650, 2);
insert into taxa
values(102, 850, 3);
insert into taxa
values(103, 1000, 4);
insert into taxa
values(104, 1200, 5);

insert into disciplina
values (100, 'Pictura', 'Nota', 9);
insert into disciplina
values (101, 'Grafica', 'Nota', 10);
insert into disciplina
values (102, 'Iconografie', 'Admis/respins', 7);
insert into disciplina
values (103, 'Dans modern', 'Admis/respins', 8);
insert into disciplina
values (104, 'Sculptura', 'Admis/respins', 7);
insert into disciplina
values (105, 'Chitara', 'Nota', 10);
insert into disciplina
values (106, 'Saxofon', 'Admis/respins', 8);
insert into disciplina
values (107, 'Vioara', 'Nota', 9);
insert into disciplina
values (108, 'Tobe', 'Admis/respins', 8);
insert into disciplina
values (109, 'Acordeon', 'Admis/respins', 8);
insert into disciplina
values (110, 'Chitara bass', 'Nota', 10);
insert into disciplina
values (111, 'Pian', 'Nota', 9);
insert into disciplina
values (112, 'Canto muzica usoara', 'Nota', 9);
insert into disciplina
values (113, 'Canto muzica populara', 'Nota', 9);
insert into disciplina
values (114, 'Teatru', 'Admis/respins', 7);

insert into instrument
values (100, 'Pensula', 5);
insert into instrument
values (101, 'Paleta culori', 10);
insert into instrument
values (102, 'Culori acrilice', 20);
insert into instrument
values (103, 'Culori tempera', 20);
insert into instrument
values (104, 'Panza', 25);
insert into instrument
values (105, 'Creion', 2);
insert into instrument
values (106, 'Guma de sters', 2);
insert into instrument
values (107, 'Bloc desen', 15);
insert into instrument
values (108, 'Lut', 12);
insert into instrument
values (109, 'Unelte sculptura', 20);
insert into instrument
values (110, 'Chitara acustica', 600);
insert into instrument
values (111, 'Saxofon', 1900);
insert into instrument
values (112, 'Vioara', 300);
insert into instrument
values (113, 'Tobe', 2500);
insert into instrument
values (114, 'Bete tobe', 30);
insert into instrument
values (115, 'Acordeon', 12000);
insert into instrument
values (116, 'Chitara bass', 900);
insert into instrument
values (117, 'Pian', 20000);
insert into instrument
values (118, 'Microfon', 250);
insert into instrument
values (119, 'Costume', 1000);

insert into tara
values(id_tara.nextval,'Moldova', 'Romana' );
insert into tara
values(id_tara.nextval,'Ungaria', 'Maghiara' );
insert into tara
values(id_tara.nextval,'Bulgaria', 'Bulgara' );
insert into tara
values(id_tara.nextval,'Franta', 'Franceza' );
insert into tara
values(id_tara.nextval,'Romania', 'Romana' );


insert into locatie
values(id_loc.nextval, 100, 'Mitropolit Varlaam','Urbana', 'Chisinau' );
insert into locatie
values(id_loc.nextval, 101, 'Szent Istvan ter 1','Urbana', 'Budapesta' );
insert into locatie
values(id_loc.nextval, 100, 'Mihail Kogalniceanu','Urbana', 'Chisinau' );
insert into locatie
values(id_loc.nextval, 104, '1 Decembrie 1918','Urbana', 'Targu-Jiu' );
insert into locatie
values(id_loc.nextval, 104, 'Al. Odobescu','Rurala', 'Sadu' );
insert into locatie
values(id_loc.nextval, 103, '6 Rue du Conseil','Urbana', 'Colmar' );
insert into locatie
values(id_loc.nextval, 102, '5 Dyakon Ignatiy','Urbana', 'Sofia' );
insert into locatie
values(id_loc.nextval, 102, 'Aleksander Nevski','Urbana', 'Sofia' );
insert into locatie
values(id_loc.nextval, 104, 'Strada Eroilor','Urbana', 'Novaci' );
insert into locatie
values(id_loc.nextval, 101, 'Duna korzo','Urbana', 'Szentendre' );

insert into angajat
values(100,'Simion', 'Trelles', 'simitrelles@gmail.com', '07755510473', to_date('01-04-2017', 'dd-mm-yyyy'), 2500 );
insert into angajat
values(101,'Simona ', 'Kiritescu', 'simonakiri@gmail.com', '07655586543', to_date('03-04-2017', 'dd-mm-yyyy'), 2550 );
insert into angajat
values(102,'Virginia ', 'Nica ', 'nicavirginia@gmail.com', '07055520221', to_date('03-04-2017', 'dd-mm-yyyy'), 2600 );
insert into angajat
values(103,'Cosmina ', 'Ungureanu ', 'cosminaungur@gmail.com', '07055519310', to_date('03-04-2017', 'dd-mm-yyyy'), 1700 );
insert into angajat
values(104,'Lenuta ', 'Cojocaru ', 'lenutacojocaru2@gmail.com', '07755512839', to_date('01-04-2016', 'dd-mm-yyyy'), 2600 );
insert into angajat
values(105,'Loredana ', 'Ene ', 'loreenegene@gmail.com', '07055583733', to_date('01-04-2017', 'dd-mm-yyyy'), 3000 );
insert into angajat
values(106,'Angelica ', 'Olinescu  ', 'oliangelica1@gmail.com', '07255579354', to_date('01-04-2017', 'dd-mm-yyyy'), 2700 );
insert into angajat
values(107,'Niculai ', 'Ciobanu ', 'ciobanicu@gmail.com', '07115558355', to_date('03-04-2017', 'dd-mm-yyyy'), 1600 );
insert into angajat
values(108,'Florina ', 'Tatarescu ', 'flotitatar@gmail.com', '07355579306', to_date('01-04-2017', 'dd-mm-yyyy'), 2500 );
insert into angajat
values(109,'Teodora ', 'Stanasila ', 'teostani@gmail.com', '07055516415', to_date('01-04-2017', 'dd-mm-yyyy'), 2600 );
insert into angajat
values(110,'Monica', 'Nanciu', 'moninanciu@gmail.com', '07115559693', to_date('01-04-2016', 'dd-mm-yyyy'), 3100 );

insert into angajat
values(111,'Corina ', 'Parnescu', 'parnescucorina@gmail.com', '07455548343', to_date('03-04-2016', 'dd-mm-yyyy'), 3500 );
insert into angajat
values(112,'Laura  ', 'Popa ', 'popalaura2@gmail.com', '07115557155', to_date('03-04-2017', 'dd-mm-yyyy'), 1700 );
insert into angajat
values(113,'Eliza ', 'Preda ', 'elizzapreda@gmail.com', '07055570110', to_date('03-04-2017', 'dd-mm-yyyy'), 3000 );
insert into angajat
values(114,'Olivia  ', 'Cosovei', 'cosolivia@gmail.com', '07455575492', to_date('05-04-2017', 'dd-mm-yyyy'), 2600 );
insert into angajat
values(115,'Alex ', 'Paler', 'paleralex@gmail.com', '07555548449', to_date('01-04-2016', 'dd-mm-yyyy'), 3200 );
insert into angajat
values(116,'Traian', 'Filip', 'filiptraian@gmail.com', '07055577393', to_date('01-04-2017', 'dd-mm-yyyy'), 3000 );
insert into angajat
values(117,'Nic  ', 'Moldovan   ', 'moldonic@gmail.com', '07055542493', to_date('03-04-2017', 'dd-mm-yyyy'), 1600 );
insert into angajat
values(118,'Marcel  ', 'Marin  ', 'marinmarcel5@gmail.com', '07455535229', to_date('03-04-2016', 'dd-mm-yyyy'), 2950 );

insert into angajat
values(122,'Gabriela ', 'Vaduva', 'gabivaduva@gmail.com', '07855530231', to_date('05-04-2017', 'dd-mm-yyyy'), 1700 );

insert into angajat
values(124,'Florenta ', 'Cretu', 'cretuflorenta@gmail.com', '07115554859', to_date('03-04-2017', 'dd-mm-yyyy'), 1600 );


insert into eveniment
values(id_event.nextval, 101 , to_date('11-09-2017', 'dd-mm-yyyy'), 'Spectacol');
insert into eveniment
values(id_event.nextval, 104 , to_date('07-09-2018', 'dd-mm-yyyy'), 'Expozitie');
insert into eveniment
values(id_event.nextval, 106 , to_date('22-11-2017', 'dd-mm-yyyy'), 'Concurs');
insert into eveniment
values(id_event.nextval, 105 , to_date('10-05-2019', 'dd-mm-yyyy'), 'Spectacol');
insert into eveniment
values(id_event.nextval, 102 , to_date('01-08-2017', 'dd-mm-yyyy'), 'Expozitie');
insert into eveniment
values(id_event.nextval, 108 , to_date('16-10-2019', 'dd-mm-yyyy'), 'Spectacol');
insert into eveniment
values(id_event.nextval, 103 , to_date('25-09-2017', 'dd-mm-yyyy'), 'Concurs');
insert into eveniment
values(id_event.nextval, 107 , to_date('08-03-2018', 'dd-mm-yyyy'), 'Expozitie');
insert into eveniment
values(id_event.nextval, 100 , to_date('12-03-2020', 'dd-mm-yyyy'), 'Spectacol');
insert into eveniment
values(id_event.nextval, 109 , to_date('19-07-2017', 'dd-mm-yyyy'), 'Concurs');

insert into sala
values(id_sala.nextval, 'A1', 50, 15);
insert into sala
values(id_sala.nextval, 'A2', 40, 13);
insert into sala
values(id_sala.nextval, 'A3', 45, 14);
insert into sala
values(id_sala.nextval, 'A4', 50, 15);
insert into sala
values(id_sala.nextval, 'B1', 80, 25);
insert into sala
values(id_sala.nextval, 'B2', 40, 13);
insert into sala
values(id_sala.nextval, 'B3', 80, 25);
insert into sala
values(id_sala.nextval, 'B4', 50, 15);
insert into sala
values(id_sala.nextval, 'C1', 45, 14);
insert into sala
values(id_sala.nextval, 'C2', 40, 13);
insert into sala
values(id_sala.nextval, 'C3', 40, 13);
insert into sala
values(id_sala.nextval, 'C4', 80, 25);
insert into curs
values(id_curs.nextval, 100, 100, 'Pictura1', 'luni','12:30','14:30' );
insert into curs
values(id_curs.nextval, 101, 100, 'Pictura2', 'miercuri','12:30','14:30' );
insert into curs
values(id_curs.nextval, 103, 101, 'Grafica', 'luni','14:30','16:30' );
insert into curs
values(id_curs.nextval, 107, 102, 'Iconografie', 'miercuri','14:30','16:30' );
insert into curs
values(id_curs.nextval, 106, 103, 'Dans modern', 'joi','12:30','14:30' );
insert into curs
values(id_curs.nextval, 109, 104, 'Sculptura', 'miercuri','16:30','18:30' );

insert into curs
values(id_curs.nextval, 110, 105, 'Chitara1', 'marti','10:30','12:30' );
insert into curs
values(id_curs.nextval, 109, 105, 'Chitara2', 'joi','14:30','16:30' );
insert into curs
values(id_curs.nextval, 111, 105, 'Chitara3', 'vineri','10:30','12:30' );
insert into curs
values(id_curs.nextval, 102, 106, 'Saxofon', 'vineri','12:30','14:30' );
insert into curs

values(id_curs.nextval, 104, 107, 'Vioara', 'joi','08:30','10:30' );
insert into curs
values(id_curs.nextval, 105, 107, 'Vioara2', 'joi','16:30','18:30' );

insert into curs
values(id_curs.nextval, 108, 108, 'Tobe', 'marti','08:30','10:30' );
insert into curs
values(id_curs.nextval, 110, 109, 'Acordeon', 'luni','08:30','10:30');
insert into curs
values(id_curs.nextval, 103, 110, 'Chitara bass', 'luni','10:30','12:30' );
insert into curs
values(id_curs.nextval, 105, 111, 'Pian', 'miercuri','10:30','12:30' );
insert into curs
values(id_curs.nextval, 106, 112, 'Canto m. usoara', 'joi','10:30','12:30' );
insert into curs
values(id_curs.nextval, 108, 113, 'Canto m. populara 1', 'miercuri','08:30','10:30' );
insert into curs
values(id_curs.nextval, 102, 114, 'Teatru', 'vineri','14:30','16:30' );
insert into curs
values(id_curs.nextval, 101, 113, 'Canto m. populara 2', 'vineri','16:30','18:30' );

--INSERT IN TABELE ASOCIATIVE
--pt pictura
insert into necesita
values(100, 100);
insert into necesita
values(100, 101);
insert into necesita
values(100, 102);
insert into necesita
values(100, 103);
insert into necesita
values(100, 104);
insert into necesita
values(100, 105);
insert into necesita
values(100, 106);
--pt grafica
insert into necesita
values(101, 105);
insert into necesita
values(101, 106);
insert into necesita
values(101, 107);
--pt iconografie
insert into necesita
values(102, 100);
insert into necesita
values(102, 101);
insert into necesita
values(102, 102);
insert into necesita
values(102, 103);
insert into necesita
values(102, 104);
insert into necesita
values(102, 105);
insert into necesita
values(102, 106);
--pt sculptura
insert into necesita
values(104, 108);
insert into necesita
values(104, 109);
--pt chitara
insert into necesita
values(105, 110);
--pt saxofon
insert into necesita
values(106, 111);
--pt vioara
insert into necesita
values(107, 112);
--tobe
insert into necesita
values(108, 113);
insert into necesita
values(108, 114);
--acordeon
insert into necesita
values(109, 115);
--bass
insert into necesita
values(110, 116);
--pian
insert into necesita
values(111, 117);
--m usoara
insert into necesita
values(112, 118);
--m populara
insert into necesita
values(113, 118);
--teatru
insert into necesita
values(114, 119);

--Insert in tabelul curata

insert into curata
values(103,101,1);
insert into curata
values(103,102,1);
insert into curata
values(107,103,1);
insert into curata
values(107,104,1);
insert into curata
values(103,104,1);
insert into curata
values(112,105,1);
insert into curata
values(112,106,1);
insert into curata
values(117,106,1);
insert into curata
values(117,107,1);
insert into curata
values(117,108,1);
insert into curata
values(122,109,1);
insert into curata
values(122,110,1);
insert into curata
values(124,111,1);

--prof 100 preda chitara urmatorilor elevi
insert into preda
values(100, 100, 105);
insert into preda
values(100, 101, 105);
insert into preda
values(100, 102, 105);
insert into preda
values(100, 103, 105);
insert into preda
values(100, 104, 105);
insert into preda
values(100, 105, 105);
insert into preda
values(100, 106, 105);
insert into preda
values(100, 107, 105);
insert into preda
values(100, 108, 105);
insert into preda
values(100, 109, 105);
insert into preda
values(100, 110, 105);
insert into preda
values(100, 111, 105);
insert into preda
values(100, 112, 105);
insert into preda
values(100, 113, 105);
insert into preda
values(100, 114, 105);
insert into preda
values(100, 115, 105);
insert into preda
values(100, 116, 105);
insert into preda
values(100, 144, 105);
--prof 101 preda pictura elevilor:
insert into preda
values(101, 117, 100);
insert into preda
values(101, 118, 100);
insert into preda
values(101, 119, 100);
insert into preda
values(101, 120, 100);
insert into preda
values(101, 121, 100);
insert into preda
values(101, 122, 100);
insert into preda
values(101, 123, 100);
insert into preda
values(101, 124, 100);
insert into preda
values(101, 125, 100);
insert into preda
values(101, 126, 100);
insert into preda
values(101, 133, 100);
--prof 101 preda grafica
insert into preda
values(101, 127, 101);
insert into preda
values(101, 128, 101);
insert into preda
values(101, 129, 101);
insert into preda
values(101, 130, 101);
insert into preda
values(101, 131, 101);
insert into preda
values(101, 132, 101);
insert into preda
values(101, 134, 101);
--prof 101 preda iconografie
insert into preda
values(101, 135, 101);
insert into preda
values(101, 136, 101);
insert into preda
values(101, 137, 101);
insert into preda
values(101, 138, 101);
insert into preda
values(101, 139, 101);
--prof 102 preda chitara
insert into preda
values(102, 140, 105);
insert into preda
values(102, 141, 105);
insert into preda
values(102, 143, 105);
insert into preda
values(102, 145, 105);
insert into preda
values(102, 146, 105);
insert into preda
values(102, 147, 105);
--prof 104 preda saxofon
insert into preda
values(104, 148, 106);
insert into preda
values(104, 149, 106);
insert into preda
values(104, 150, 106);
insert into preda
values(104, 151, 106);
insert into preda
values(104, 152, 106);
insert into preda
values(104, 153, 106);
--prof 105 preda pictura
insert into preda
values(105, 154, 100);
insert into preda
values(105, 155, 100);
insert into preda
values(105, 156, 100);
insert into preda
values(105, 157, 100);
insert into preda
values(105, 158, 100);

--prof 106 preda chitara
insert into preda
values(106, 159, 105);
insert into preda
values(106, 160, 105);
insert into preda
values(106, 161, 105);
insert into preda
values(106, 162, 105);
insert into preda
values(106, 163, 105);
--prof 108 preda vioara
insert into preda
values(108, 164, 107);
insert into preda
values(108, 165, 107);
insert into preda
values(108, 166, 107);
insert into preda
values(108, 167, 107);
--prof 109 preda tobe
insert into preda
values(109, 168, 108);
insert into preda
values(109, 169, 108);
insert into preda
values(109, 170, 108);
insert into preda
values(109, 171, 108);
--prof 109 preda acordeon
insert into preda
values(109, 172, 109);
insert into preda
values(109, 173, 109);
insert into preda
values(109, 174, 109);
insert into preda
values(109, 175, 109);
--prof 110 preda vioara 
insert into preda
values(110, 176, 107);
insert into preda
values(110, 177, 107);
insert into preda
values(110, 178, 107);
--prof 110 preda chitara bass
insert into preda
values(110, 179, 110);
insert into preda
values(110, 180, 110);
insert into preda
values(110, 181, 110);
insert into preda
values(110, 149, 110);
--prof 113 preda dans modern
insert into preda
values(113, 101, 103);
insert into preda
values(113, 103, 103);
insert into preda
values(113, 105, 103);
insert into preda
values(113, 139, 103);
insert into preda
values(113, 146, 103);
insert into preda
values(113, 148, 103);
insert into preda
values(113, 149, 103);
insert into preda
values(113, 151, 103);
insert into preda
values(113, 155, 103);
--prof 114 preda sculptura
insert into preda
values(114, 108, 103);
insert into preda
values(114, 111, 103);
insert into preda
values(114, 112, 103);
insert into preda
values(114, 121, 103);
insert into preda
values(114, 135, 103);
insert into preda
values(114, 138, 103);
insert into preda
values(114, 139, 103);
insert into preda
values(114, 140, 103);
insert into preda
values(114, 146, 103);
--prof 115 preda pian
insert into preda
values(115, 103, 111);
insert into preda
values(115, 108, 111);
insert into preda
values(115, 112, 111);
insert into preda
values(115, 118, 111);
insert into preda
values(115, 121, 111);
insert into preda
values(115, 127, 111);
insert into preda
values(115, 130, 111);
insert into preda
values(115, 134, 111);
insert into preda
values(115, 135, 111);
--prof 115 preda canto muzica usoara
insert into preda
values(115, 108, 112);
insert into preda
values(115, 113, 112);
insert into preda
values(115, 116, 112);
insert into preda
values(115, 167, 112);
insert into preda
values(115, 170, 112);
insert into preda
values(115, 173, 112);
insert into preda
values(115, 174, 112);
insert into preda
values(115, 179, 112);
insert into preda
values(115, 180, 112);
--prof 115 preda canto muzica populara
insert into preda
values(115, 117, 113);
insert into preda
values(115, 118, 113);
insert into preda
values(115, 120, 113);

insert into preda
values(115, 155, 113);
insert into preda
values(115, 156, 113);
insert into preda
values(115, 157, 113);
insert into preda
values(115, 159, 113);
insert into preda
values(115, 163, 113);
insert into preda
values(115, 164, 113);
--prof 116 preda canto muzica populara
insert into preda
values(116, 142, 113);
insert into preda
values(116, 143, 113);
insert into preda
values(116, 146, 113);
insert into preda
values(116, 121, 113);
insert into preda
values(116, 124, 113);
insert into preda
values(116, 125, 113);
insert into preda
values(116, 127, 113);
insert into preda
values(116, 130, 113);
insert into preda
values(116, 132, 113);
--prof 118 preda teatru
insert into preda
values(118, 149, 114);
insert into preda
values(118, 143, 114);
insert into preda
values(118, 155, 114);
insert into preda
values(118, 156, 114);
insert into preda
values(118, 157, 114);
insert into preda
values(118, 164, 114);
insert into preda
values(118, 167, 114);
insert into preda
values(118, 179, 114);
insert into preda
values(118, 181, 114);
insert into preda
values(118, 108, 114);


--INSERT IN SUBENTITATI
insert into director
values(111, 2);

insert into ingrijitor
values(117, 3);
insert into ingrijitor
values(112, 2);
insert into ingrijitor
values(103, 3);
insert into ingrijitor
values(107, 2);
insert into ingrijitor
values(122, 3);
insert into ingrijitor
values(124, 2);

insert into profesor
values(100,'Muzica');
insert into profesor
values(101,'Pictura/grafica');
insert into profesor
values(102,'Muzica');
insert into profesor
values(104,'Muzica');--
insert into profesor
values(105,'Pictura/grafica');
insert into profesor
values(106,'Muzica');
insert into profesor
values(108,'Muzica');--
insert into profesor
values(109,'Muzica');
insert into profesor
values(110,'Muzica');
insert into profesor
values(113,'Dans');----
insert into profesor
values(114,'Pictura/grafica');
insert into profesor
values(115,'Muzica');
insert into profesor
values(116,'Muzica');
insert into profesor
values(118,'Teatru');--

--EX 6 subprogram stocat cu 2 tipuri de colectii: tablou imbricat si vector
--s-a creat o eroare la distribuirea elevilor la taxa. Sa se afiseze numele complet al 
--elevilor care trebuie sa plateasca o taxa cu id-ul dat ca parametru intr-o 
--procedura.

CREATE OR REPLACE  TYPE numeFam IS VARRAY(100) OF VARCHAR(20);
CREATE OR REPLACE 
    PROCEDURE eroare(v_taxa IN taxa.id_taxa%TYPE)
IS
    TYPE tabel is TABLE of VARCHAR(100);
    nume numeFam:= numeFam();
    tabel1 tabel:= tabel();
BEGIN
    select e.nume || ' ' || e.prenume
    bulk collect into nume
    from elev e, taxa t
    where e.id_taxa = t.id_taxa
    and t.id_taxa = v_taxa;

    FOR i IN nume.FIRST..nume.LAST LOOP
    tabel1.extend();
    tabel1(i):= 'Eroare in distribuirea elevului ' || nume(i) || ' la taxa.';
    END LOOP;
    FOR i IN tabel1.FIRST..tabel1.LAST LOOP
    DBMS_OUTPUT.PUT_LINE( tabel1(i) || ' ');
	END LOOP;
   
END eroare;
/
--BEGIN
--    eroare(102);
--END;
--/

--EX 7 subprogram stocat cu un cursor
--sa se afiseze cate ore dureaza curatenia intr-o sala dupa un curs intr-o zi data, 
--impreuna cu numele ingrijitorului si sa i se mareasca salariul cu 4%.

CREATE OR REPLACE 
    PROCEDURE curatenie(v_zi_curatare  curs.zi_saptamana%TYPE)
IS
    v_timp_curatare  curata.timp_curatare%TYPE;
    v_nume_sala sala.nume_sala%TYPE;
    v_nume_ingrijitor VARCHAR(50);
    v_id_ingrijitor angajat.id_angajat%TYPE;
   CURSOR c IS
    SELECT c.timp_curatare, s.nume_sala, a.nume || ' ' || a.prenume, a.id_angajat
    FROM   curata c, sala s, curs cs, angajat a
    WHERE cs.zi_saptamana = v_zi_curatare
    AND c.id_sala = s.id_sala
    AND s.id_sala = cs.id_sala
    AND a.id_angajat = c.id_angajat;
BEGIN
   OPEN c;
    LOOP 
    FETCH c INTO v_timp_curatare, v_nume_sala, v_nume_ingrijitor, v_id_ingrijitor;
    EXIT WHEN c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('In sala ' || v_nume_sala || ', ingrijitorului ' || v_nume_ingrijitor || ' ii ia ' || v_timp_curatare || ' ora sa faca curatenie.');
        update angajat
        set salariu = salariu + salariu *0.05
        where id_angajat = v_id_ingrijitor;
    END LOOP;
    CLOSE c;
END curatenie;
/


BEGIN
    curatenie('luni');
END;
/
--EX 8 –functie pe 3 tabele
--cate evenimente se intampla intr-o tara data ca parametru, si sa le amane cu o ----luna

CREATE OR REPLACE  TYPE eventuriPutine IS VARRAY(100) OF VARCHAR(20);


CREATE OR REPLACE
FUNCTION event(v_nume_tara IN tara.nume_tara%TYPE)
RETURN NUMBER 
IS
    eventuri NUMBER(2);
    eventuri1 eventuriPutine:= eventuriPutine();
BEGIN
    select count(*)
    into eventuri
    from eveniment e, locatie l, tara t
    where e.id_locatie = l.id_locatie
    and l.id_tara = t.id_tara
    and t.nume_tara = v_nume_tara;
    
    select id_eveniment 
    bulk collect into eventuri1
    from eveniment e, locatie l, tara t
    where e.id_locatie = l.id_locatie
    and l.id_tara = t.id_tara
    and t.nume_tara = v_nume_tara;

    FOR i IN eventuri1.FIRST..eventuri1.LAST LOOP
        update eveniment
        SET data_eveniment = ADD_MONTHS( data_eveniment, 1 )
        WHERE id_eveniment = eventuri1(i);
    END LOOP;
    return eventuri;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000,'Nu exista tari cu numele dat');
    WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20001,'Exista mai multe tari cu numele dat');
    WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
END event;
/


BEGIN
    DBMS_OUTPUT.PUT_LINE('In tara data se desfasoara ' || event('Mongolia') || ' evenimente.');
END;
/
--EX 9 procedura pe 5 tabele
--elevi care studiaza discipline ce necesita instrumente mai ieftine decat un 
--instrument dat
CREATE OR REPLACE
PROCEDURE elevi(v_instrument IN instrument.nume_instrument%TYPE) 
IS
    copii NUMBER(3);
    pret_limita NUMBER(5);
BEGIN

    select pret
    into pret_limita
    from instrument
    where nume_instrument = v_instrument;
    
    select count(*)
    into copii
    from elev e, preda p, disciplina d, necesita n, instrument i
    where e.id_elev = p.id_elev
    and p.id_disciplina = d.id_disciplina
    and d.id_disciplina = n.id_disciplina
    and n.id_instrument = i.id_instrument
    and i.pret < pret_limita;
    
    dbms_output.put_line(copii || ''); 
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20000,'Nu exista instrumente cu numele dat');
   WHEN TOO_MANY_ROWS THEN
        RAISE_APPLICATION_ERROR(-20001,'Exista mai multe instrumente cu numele dat');
    WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
END elevi;
/


BEGIN
    elevi('Culori acrilice');
END;
/



--EX 10 trigger pe comanda

CREATE OR REPLACE TRIGGER program_elevi
    BEFORE INSERT OR UPDATE OR DELETE ON elev
BEGIN
    IF (TO_CHAR(SYSDATE,'D') = 1) OR (TO_CHAR(SYSDATE,'D') = 7) OR (TO_CHAR(SYSDATE,'HH24') NOT BETWEEN 18 AND 8)
    THEN
        RAISE_APPLICATION_ERROR(-20001,'Tabelul nu poate fi actualizat in afara programului');
    END IF;
END;
/

--EX 11 – trigger pe linie

CREATE OR REPLACE TRIGGER marireTaxa
    BEFORE UPDATE OF suma ON taxa
    FOR EACH ROW
BEGIN
    IF (:NEW.suma > :OLD.suma) 
        THEN RAISE_APPLICATION_ERROR(-20002,'Nu este permisa marirea sumei taxelor');
    END IF;
END;
/

--EX 12- trigger LMD 

CREATE TABLE tabelInfo
    (utilizator VARCHAR2(30),
    nume_bd    VARCHAR2(50),
    eveniment VARCHAR2(20),
    nume_obiect VARCHAR2(30),
    data           DATE);
    
CREATE OR REPLACE TRIGGER info
AFTER CREATE OR DROP OR ALTER ON SCHEMA
BEGIN
    INSERT INTO tabelInfo
        VALUES (SYS.LOGIN_USER, SYS.DATABASE_NAME, SYS.SYSEVENT, SYS.DICTIONARY_OBJ_NAME, SYSDATE);
END;
/
--EX 13- pachet simplu
CREATE OR REPLACE PACKAGE pachet AS 
    TYPE numeFam IS VARRAY(100) OF VARCHAR(20);
    PROCEDURE eroare(v_taxa IN taxa.id_taxa%TYPE);
    PROCEDURE curatenie(v_zi_curatare  curs.zi_saptamana%TYPE);
    TYPE eventuriPutine IS VARRAY(100) OF VARCHAR(20);
    FUNCTION event(v_nume_tara IN tara.nume_tara%TYPE)
        RETURN NUMBER;
    PROCEDURE elevi(v_instrument IN instrument.nume_instrument%TYPE);

END pachet;
/
CREATE OR REPLACE PACKAGE BODY pachet AS 
        PROCEDURE eroare(v_taxa IN taxa.id_taxa%TYPE)
    IS
        TYPE tabel is TABLE of VARCHAR(100);
        nume numeFam:= numeFam();
        tabel1 tabel:= tabel();
    BEGIN
        select e.nume || ' ' || e.prenume
        bulk collect into nume
        from elev e, taxa t
        where e.id_taxa = t.id_taxa
        and t.id_taxa = v_taxa;
    
        FOR i IN nume.FIRST..nume.LAST LOOP
        tabel1.extend();
        tabel1(i):= 'Eroare in distribuirea elevului ' || nume(i) || ' la taxa.';
        END LOOP;
        FOR i IN tabel1.FIRST..tabel1.LAST LOOP
        DBMS_OUTPUT.PUT_LINE( tabel1(i) || ' ');
        END LOOP;
       
    END eroare;

    
        PROCEDURE curatenie(v_zi_curatare  curs.zi_saptamana%TYPE)
    IS
        v_timp_curatare  curata.timp_curatare%TYPE;
        v_nume_sala sala.nume_sala%TYPE;
        v_nume_ingrijitor VARCHAR(50);
        v_id_ingrijitor angajat.id_angajat%TYPE;
       CURSOR c IS
        SELECT c.timp_curatare, s.nume_sala, a.nume || ' ' || a.prenume, a.id_angajat
        FROM   curata c, sala s, curs cs, angajat a
        WHERE cs.zi_saptamana = v_zi_curatare
        AND c.id_sala = s.id_sala
        AND s.id_sala = cs.id_sala
        AND a.id_angajat = c.id_angajat;
    BEGIN
       OPEN c;
        LOOP 
        FETCH c INTO v_timp_curatare, v_nume_sala, v_nume_ingrijitor, v_id_ingrijitor;
        EXIT WHEN c%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('In sala ' || v_nume_sala || ', ingrijitorului ' || v_nume_ingrijitor || ' ii ia ' || v_timp_curatare || ' ora sa faca curatenie.');
            update angajat
            set salariu = salariu + salariu *0.05
            where id_angajat = v_id_ingrijitor;
        END LOOP;
        CLOSE c;
    END curatenie;



    FUNCTION event(v_nume_tara IN tara.nume_tara%TYPE)
    RETURN NUMBER 
    IS
        eventuri NUMBER(2);
        eventuri1 eventuriPutine:= eventuriPutine();
    BEGIN
        select count(*)
        into eventuri
        from eveniment e, locatie l, tara t
        where e.id_locatie = l.id_locatie
        and l.id_tara = t.id_tara
        and t.nume_tara = v_nume_tara;
        
        select id_eveniment 
        bulk collect into eventuri1
        from eveniment e, locatie l, tara t
        where e.id_locatie = l.id_locatie
        and l.id_tara = t.id_tara
        and t.nume_tara = v_nume_tara;
    
        FOR i IN eventuri1.FIRST..eventuri1.LAST LOOP
            update eveniment
            SET data_eveniment = ADD_MONTHS( data_eveniment, 1 )
            WHERE id_eveniment = eventuri1(i);
        END LOOP;
        return eventuri;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20000,'Nu exista tari cu numele dat');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20001,'Exista mai multe tari cu numele dat');
        WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
    END event;
    
    PROCEDURE elevi(v_instrument IN instrument.nume_instrument%TYPE) 
    IS
        copii NUMBER(3);
        pret_limita NUMBER(5);
    BEGIN
    
        select pret
        into pret_limita
        from instrument
        where nume_instrument = v_instrument;
        
        select count(*)
        into copii
        from elev e, preda p, disciplina d, necesita n, instrument i
        where e.id_elev = p.id_elev
        and p.id_disciplina = d.id_disciplina
        and d.id_disciplina = n.id_disciplina
        and n.id_instrument = i.id_instrument
        and i.pret < pret_limita;
        
        dbms_output.put_line(copii || ''); 
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20000,'Nu exista instrumente cu numele dat');
       WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20001,'Exista mai multe instrumente cu numele dat');
        WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
    END elevi;
END pachet; 
/ 



BEGIN
pachet.eroare(102);
pachet.curatenie('luni');
DBMS_OUTPUT.PUT_LINE('In tara data se desfasoara ' || pachet.event('Romania') || ' evenimente.');
pachet.elevi('Culori acrilice');
END;
/


--exercitiul 14
   
CREATE OR REPLACE PACKAGE pachet2 AS 

    TYPE medii_sortate IS RECORD
        (nume_complet VARCHAR(50),
        mail elev.email%TYPE,
        medie elev.medie_finala%TYPE);
    TYPE tabel_medii_sortate IS TABLE OF medii_sortate;
    PROCEDURE sortare;
    v_tabel_medii_sortate tabel_medii_sortate;
    FUNCTION medie_medii
        RETURN NUMBER;
    PROCEDURE voucher;
END pachet2;
/


CREATE OR REPLACE PACKAGE BODY pachet2 AS 
    --sorteaza elevii dupa medie, de la cea mai mare la cea mai mica
    PROCEDURE sortare
    IS
    BEGIN
    select nume || ' '  || initiala_tatalui || ' ' || prenume, email, medie_finala
    bulk collect into v_tabel_medii_sortate
    from elev
    order by medie_finala desc;
    for i in v_tabel_medii_sortate.first .. v_tabel_medii_sortate.last loop
    dbms_output.put_line( v_tabel_medii_sortate(i).nume_complet);
    end loop;
    END sortare;
    --face media primilor 30 elevi
    FUNCTION medie_medii
    RETURN NUMBER
    IS
    medie_temp NUMBER(4);
    BEGIN
    medie_temp:=0;
    sortare;
    for i in 1..40 loop
    medie_temp:= medie_temp + v_tabel_medii_sortate(i).medie;
    end loop;
    
    
    RETURN medie_temp/40;
    END medie_medii;
    
    
-- in functie de medie, se trimite pe mailul elevilor un voucher de Craciun 

    PROCEDURE voucher
    IS
    TYPE distribuire_vouchere is TABLE of VARCHAR(200);
    distribuire distribuire_vouchere:=distribuire_vouchere();
    valoare_voucher NUMBER(4);
    BEGIN
    sortare;
    for i in v_tabel_medii_sortate.first .. v_tabel_medii_sortate.last loop
        distribuire.extend();
        if v_tabel_medii_sortate(i).medie = 10 then valoare_voucher := 100;
        elsif v_tabel_medii_sortate(i).medie > 9 and v_tabel_medii_sortate(i).medie < 10 then valoare_voucher := 90;
        elsif v_tabel_medii_sortate(i).medie > 8 and v_tabel_medii_sortate(i).medie < 9 then valoare_voucher := 80;
        else valoare_voucher :=70;
        end if;
    distribuire(i) := to_char('Elevului ' || v_tabel_medii_sortate(i).nume_complet || ' un voucher pe eMAG in valoare de ' || valoare_voucher); 
    end loop;
    
   for i in distribuire.first .. distribuire.last loop
   dbms_output.put_line(distribuire(i));
   end loop;
    END voucher;
    
END pachet2;
/





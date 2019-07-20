/*- - - - - - - - CRIAÇÃO DAS TABELAS - - - - - - - - -*/

create table projeto (numero int, nome varchar(20), localizacao varchar(20));
create table empregado (rg char(7), nome varchar(30), cpf char(11), depto int, rg_supervisor char(7), salario float, dat_init_sal date); 
create table departamento(numero int , nome varchar(30), rg_gerente char(7));
create table dependente(codigo int, rg_responsavel char(7), nome_dependente varchar(20),nascimento date, relacao varchar(10), sexo char(1)); 
create table empregado_projeto (codigo int, rg_empregado char(7), numero_projeto int, horas int);
create table departamento_projeto (codigo int, numero_depto int, numero_projeto int); 
create table historico_salario (rg char(7), dat_ini_sal date, dat_fim_sal date, salario float);

alter table projeto drop localizacao;
alter table projeto add localidade varchar(20);
alter table projeto add logico boolean;

alter table empregado add funcao varchar(20);
alter table empregado rename column nome to nome_completo;
alter table empregado drop dat_init_sal;

alter table departamento add descricao_departamento varchar(10);
alter table departamento add data_criacao date;
alter table departamento rename column nome to nome_departamento;
alter table departamento drop data_criacao;

create table aluno (codigo int, nome varchar(30));
alter table aluno alter column codigo type float, alter column nome type varchar(30);
drop table aluno;

alter table historico_salario drop dat_ini_sal;
alter table historico_salario add salario_total_anual float; 
alter table historico_salario rename column salario to salario_mensal;

alter table empregado_projeto add funcao varchar(10);
alter table empregado_projeto add data_inicio date;
alter table empregado_projeto add data_fim date;

alter table departamento_projeto add demanda_de_funcionarios int;
alter table departamento_projeto add horas_destinadas int;
alter table departamento_projeto rename column codigo to numero;

/*- - - - - - - - INSERTS - - - - - - - - -*/

insert into empregado_projeto (codigo, rg_empregado, numero_projeto, horas) 
	values (1, '2020', 5, 10), 
		   (2, '2020', 10, 25), 
		   (3, '3030', 5, 35), 
		   (4, '4040', 20, 50), 
		   (5, '5050', 20, 35), 
		   (6, '8080', 5, 70);

insert into dependente (codigo, rg_responsavel, nome_dependente, nascimento, relacao, sexo) 
	values (1, '1010', 'Jorge', '1986/12/27', 'Filho', 'M'), 
		   (2, '1010', 'Luiz', '1979-11-18', 'Filho', 'M'), 
		   (3, '2020', 'Fernanda Carla', '1969-02-14', 'Cônjuge', 'F'), 
		   (4, '2020', 'Ângelo', '1995-02-10', 'Filho', 'M'), 
		   (5, '3030', 'André', '1990-05-01', 'Filho', 'M'), 
		   (6, '8080', 'Ana Maria', '1980-06-30', 'Cônjuge', 'F'), 
		   (7, '8080', 'Karla Cristina', '1999-08-25', 'Filha', 'F');

alter table empregado add dat_ini_sal date;
insert into empregado (rg, nome_completo, cpf, depto, rg_supervisor, salario, dat_ini_sal) 
	values ('1010', 'João Luiz', '11111', 1, NULL, 6000.00, '2011-05-01'), 
		   ('2020', 'Fernanda', '22222', 1, '1010', 5500.00, '2008-12-01'), 
		   ('3030' ,'Ricardo', '33333', 2, '2020', 2300.00, '2009-08-01'), 
		   ('4040', 'Jorge', '44444', 2, '3030', 3200.00, '2010-10-01'), 
		   ('5050', 'Renata', '55555', 2, '3030', 1300.00, '2012-02-01'), 
		   ('6060', 'Luiz Renato', '66666', 3, '2020', 3000.00, '2012-05-01'), 
		   ('7070', 'LuizFernando', '77777', 3, '6060', 2000.00, '2008-08-01'), 
		   ('8080', 'João Antonio', '88888', 1, '2020', 3950.00, '2010-07-01');

alter table historico_salario add dat_ini_sal date;
insert into historico_salario (rg, dat_ini_sal, dat_fim_sal, salario_mensal) 
	values ('1010', '2010/01/01', '2010/11/30', 2000.00), 
		   ('1010', '2010/12/01', '2011/04/30', 4000.00), 
		   ('2020', '2007/05/01', '2007/12/31', 2500.00), 
		   ('2020', '2008/01/01', '2010/11/30', 4000.00), 
		   ('4040', '2008/08/01', '2009/10/31', 1500.00), 
		   ('4040', '2009/11/01', '2010/09/30', 2500.00), 
		   ('4040', '2010/10/01', '2012/10/31', 3500.00), 
		   ('7070', '2008/01/01', '2008/07/31', 1000.00);

insert into departamento (numero, nome_departamento, rg_gerente) 
	values (1, 'Contabilidade', '1010'), 
		   (2, 'Engenharia Civil', '3030'), 
		   (3, 'Engenharia Mecânica', '2020'), 
		   (4, 'Industrial', NULL);

insert into departamento_projeto (numero, numero_depto, numero_projeto) 
	values (1, 2, 5), 
		   (2, 3, 10), 
		   (3, 2, 20);

insert into projeto (numero, nome, localidade) 
	values (5, 'Financeiro', 'São Paulo'), 
		   (10, 'Motor', 'Rio Claro'), 
		   (20, 'Prédio Central', 'Campinas'), 
		   (25, 'Águas Limpas', 'Vitória');
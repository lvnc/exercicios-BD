/*- - - - - - - - CRIAÇÃO DAS RELAÇÕES DAS TABELAS - - - - - - - - -*/

alter table projeto add primary key(nome);
alter table empregado add primary key (cpf);
alter table departamento add primary key (numero);
alter table dependente add primary key (nome_dependente);
alter table departamento_projeto add primary key (numero);
/*alter table empregado_projeto add primary key (rg_empregado);*/
/*existem dois rg_empregado com o mesmo valor*/

alter table projeto drop constraint projeto_pkey;
alter table projeto add primary key(numero);
alter table empregado drop constraint empregado_pkey;
alter table empregado add primary key(rg);
alter table dependente drop constraint dependente_pkey;
alter table dependente add primary key(codigo);
alter table empregado_projeto add primary key(codigo);

alter table historico_salario add foreign key (rg) references empregado(rg);
alter table dependente add foreign key (rg_responsavel) references empregado(rg);
alter table empregado add foreign key (depto) references departamento (numero);
alter table empregado add foreign key (rg_supervisor) references empregado(rg);
alter table departamento add foreign key (rg_gerente) references empregado(rg); 
alter table departamento_projeto add foreign key (numero_depto) references departamento(numero);
alter table departamento_projeto add foreign key (numero_projeto) references projeto(numero);
alter table empregado_projeto add foreign key (rg_empregado) references empregado(rg);
alter table empregado_projeto add foreign key (numero_projeto) references projeto(numero);

/*- - - - - - - - - - - - - - - - -*/


select relacao from dependente group by relacao;
select sexo from dependente group by sexo;
select sexo, count(sexo) from dependente group by sexo;
select max(salario) from empregado;
select min(salario) from empregado;
select sum(salario) from empregado;
select depto, sum(salario) as "Soma dos Salários" from empregado group by depto;
select avg(salario) as "Média", sum(salario) as "Soma", max(salario) as "Maior", min(salario) as "Menor", stddev(salario) as "Desvio Padrão" from empregado;

select rg_responsavel, count(relacao) from dependente group by rg_responsavel;
select rg, count(numero_projeto) from empregado
inner join empregado_projeto on (empregado.rg = empregado_projeto.rg_empregado) group by rg;
select rg, sum(horas) as "Horas com projetos" from empregado
inner join empregado_projeto on (empregado.rg = empregado_projeto.rg_empregado)
group by rg order by sum(horas) desc;
select depto, count (rg) as "Quantidade de funcionários" from empregado group by depto;
select depto, count (rg) as "Quantidade de funcionários" from empregado group by depto having count(rg)>=2;
select depto, sum(salario) as "Soma dos Salários" from empregado group by depto having sum(salario)>6000;

select nome_completo from empregado where rg in (select rg_gerente from departamento);
select nome_completo from empregado where rg in (select rg from historico_salario);
select nome_completo from empregado where rg not in (select rg from historico_salario);
select*from empregado where salario < (select avg(salario_mensal) from historico_salario);
select*from empregado where salario > (select min(salario_mensal)+1000 from historico_salario) and salario < (select avg(salario_mensal)+1000 from historico_salario);
select nome_completo, count(numero_projeto) as "Numero de Projetos" from empregado
inner join empregado_projeto on (empregado.rg = empregado_projeto.rg_empregado) 
where rg in (select rg_gerente from departamento) group by nome_completo;
select nome_completo from empregado 
where salario < (select avg(salario_mensal)+stddev(salario_mensal) from historico_salario) 
and salario > (select avg(salario_mensal)-stddev(salario_mensal) from historico_salario);
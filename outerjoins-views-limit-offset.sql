/*- - - - - - - - EXERCÍCIOS OUTER JOINS, SELF JOINS, VIEWS, LIMIT, OFFSET - - - - - - - - -*/


select e1.rg, e1.nome_completo as gerente, e2.rg, e2.nome_completo as gerenciado
	from empregado as e1 inner join empregado as e2 on (e1.rg = e2.rg_supervisor);
 

create view rg_nome_sal_2000_3500 as select rg, nome_completo from empregado where salario >= 2000 and salario <= 3500;

select*from rg_nome_sal_2000_3500;

create view dependentes_relacao as select relacao from dependente group by relacao;

select*from dependentes_relacao;

create view dependentes_sexo as select sexo from dependente group by sexo;

select*from dependentes_sexo;

create view funcionario_qtd_projetos as select rg, count(numero_projeto) from empregado
	inner join empregado_projeto on (empregado.rg = empregado_projeto.rg_empregado) group by rg;

select*from funcionario_qtd_projetos;

create view soma_salarios as select sum(salario) as "Soma salarios" from empregado;

select*from soma_salarios;

create view funcionarios_tres_maiores_salarios as select*from empregado order by salario desc Limit 3;

select*from funcionarios_tres_maiores_salarios;

create view rg_cpf_nome_sem_supervisor as select rg, cpf, rg_supervisor, nome_completo from empregado where rg_supervisor is NULL;

select*from rg_cpf_nome_sem_supervisor;

create view funcionarios_registro_hist_sal as select*from empregado where empregado.rg in (select rg from historico_salario);

select*from funcionarios_registro_hist_sal;

/*renomeei pois tinham 2 colunas com o nome “numero” e nao funcionaria o create view*/

alter table departamento_projeto rename column numero to codigo;

create view correspond_departamento_projeto as select*from departamento_projeto right outer join projeto on (departamento_projeto.numero_projeto = projeto.numero);

select*from correspond_departamento_projeto;

 

select*from projeto left outer join departamento_projeto
	on (projeto.numero = departamento_projeto.numero_projeto);

 

select nome_completo, numero_projeto from empregado
	left outer join empregado_projeto
	on (empregado.rg = empregado_projeto.rg_empregado);

 

select nome_completo as "Nome Empregado", numero_projeto as "Numero Projeto" , nome as "Projeto" from empregado
	left outer join empregado_projeto
	on (empregado.rg = empregado_projeto.rg_empregado)
	left outer join projeto
	on (empregado_projeto.numero_projeto = projeto.numero);

 

select nome_completo, historico_salario.dat_ini_sal, dat_fim_sal, salario_mensal from empregado
	left outer join historico_salario
	on (empregado.rg = historico_salario.rg)
	where empregado.rg not in (select rg from historico_salario);

 

select nome_completo, sum(horas) as "Horas" from empregado
	left outer join empregado_projeto
	on (empregado.rg = empregado_projeto.rg_empregado)
	group by nome_completo
	order by "Horas" desc;

 

select nome_completo as "Funcionário", nome as "Projeto", horas as "Horas Trabalhadas"
	from empregado
	inner join empregado_projeto
	on (empregado.rg = empregado_projeto.rg_empregado)
	left outer join projeto
	on (empregado_projeto.numero_projeto = projeto.numero)
	where nome = 'Financeiro';

 

select nome_completo, depto, nome_departamento, historico_salario.dat_ini_sal, dat_fim_sal, salario_mensal from empregado
	left outer join departamento on (empregado.depto = departamento.numero)
	left outer join historico_salario on (empregado.rg = historico_salario.rg)
	where empregado.rg in (select rg from historico_salario);

 

select nome_completo, depto, nome_departamento, historico_salario.dat_ini_sal, dat_fim_sal, salario_mensal from empregado
	left outer join departamento on (empregado.depto = departamento.numero)
	left outer join historico_salario on (empregado.rg = historico_salario.rg)
	order by salario_mensal desc;
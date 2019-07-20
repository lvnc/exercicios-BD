
select nome, localidade from projeto where localidade = 'Vitória';
select nome, localidade, numero from projeto where numero >= 5 and numero <25;
select*from empregado where rg_supervisor = '2020' and salario > 2800;
select numero, nome from projeto where numero > 5 and numero < 20;
alter table projeto rename column nome to nome_projeto;
select numero, nome_projeto from projeto where numero >= 5 and numero <=20;
alter table projeto rename column nome_projeto to "Nome do projeto"; 
select concat("Nome do projeto", '-', localidade) "Nome e localidade do Projeto" from projeto;
select nome_completo, salario, (salario*1.1) "Salario +10%" from empregado;
select nome_completo, (salario+500) "Salario R$500" from empregado; 
select nome_completo, (salario/2) "Parcela 13o" from empregado; 
select nome_completo, salario, (salario-1000) "Salario reduzido" from empregado; 
select nome_completo, salario, (salario*salario+5*salario-100/100) "Salario novo" from empregado; 
select*from departamento where rg_gerente is NULL or nome_departamento = 'Contabilidade'; 
select*from departamento where numero > 1 and rg_gerente is not NULL; 
select*from dependente where rg_responsavel != '1010' and sexo = 'F';
select*from dependente where rg_responsavel = '2020' or rg_responsavel = '8080';
select*from dependente where rg_responsavel = '1010' and nome_dependente = 'Jorge'; 
select*from dependente where nascimento > '01-01-1986' and sexo = 'F';
select nome_completo, age(current_date, dat_ini_sal) as "Tempo" from empregado;

select*from dependente where nome_dependente like 'A%';
select*from dependente where nome_dependente like '_a%';
select*from dependente where nome_dependente like '%e';
select*from dependente where nome_dependente like '%n%';
select*from dependente where nome_dependente like '%an%';
select*from empregado where nome_completo like '%Luiz%';
select*from empregado where nome_completo like '%Luiz%' and salario > 2500;
select*from empregado where nome_completo like '%Luiz%' and salario > 2600 and rg_supervisor is not NULL;
select*from empregado where nome_completo like '_____';
select*from empregado where nome_completo ilike 'j_____%';
select*from projeto where "Nome do projeto" like '_____' or "Nome do projeto" like 'P%';
select*from projeto where "Nome do projeto" like '_____' or "Nome do projeto" ilike '%c%';
select*from projeto where "Nome do projeto" like '_____' and "Nome do projeto" ilike '%a%' and localidade not like '%São%';

select codigo, nome_dependente, relacao from dependente order by nome_dependente;

select*from projeto order by localidade;

select*from projeto order by "Nome do projeto", localidade;

select*from dependente order by rg_responsavel desc, nome_dependente desc;

select*from empregado where salario > 2500 order by salario desc, depto desc;

select "Nome do projeto", numero_projeto from departamento_projeto inner join projeto on (departamento_projeto.numero_projeto = projeto.numero);
select nome_completo as "Nome completo", "Nome do projeto" from empregado_projeto 
	inner join projeto on (empregado_projeto.numero_projeto = projeto.numero)
	inner join empregado on (empregado_projeto.rg_empregado = empregado.rg);

select nome_completo as "Funcionário", "Nome do projeto" as "Projeto", horas as "Horas trabalhadas" from empregado
	inner join empregado_projeto on (empregado.rg = empregado_projeto.rg_empregado)
	inner join projeto on (empregado_projeto.numero_projeto = projeto.numero);

select codigo as "Codigo do Dependente", nome_completo as "Nome do empregado", nome_dependente as "Nome do dependente", relacao as "Relacao" from empregado
	inner join dependente on (empregado.rg = dependente.rg_responsavel)
	order by nome_completo;

select nome_completo, historico_salario.dat_ini_sal, dat_fim_sal, salario from empregado
	inner join historico_salario on (empregado.rg = historico_salario.rg);

select nome_completo as "Funcionário", "Nome do projeto" as "Projeto", horas as "Horas trabalhadas" from empregado
	inner join empregado_projeto on (empregado.rg = empregado_projeto.rg_empregado)
	inner join projeto on (empregado_projeto.numero_projeto = projeto.numero)
	where "Nome do projeto" = 'Financeiro';

select nome_completo as "Funcionário", historico_salario.dat_ini_sal as "Inicio Salário", dat_fim_sal as "Fim Salário", salario as "Salário", nome_departamento as "Departamento" from empregado
	inner join historico_salario on (empregado.rg = historico_salario.rg)
	inner join departamento on (empregado.depto = departamento.numero);

select nome_completo as "Funcionário", historico_salario.dat_ini_sal as "Inicio Salário", dat_fim_sal as "Fim Salário", salario as "Salário", nome_departamento as "Departamento" from empregado
	inner join historico_salario on (empregado.rg = historico_salario.rg)
	inner join departamento on (empregado.depto = departamento.numero)
	where salario > 2500 order by salario desc;

select nome_completo as "Funcionário", historico_salario.dat_ini_sal as "Inicio Salário", dat_fim_sal as "Fim Salário", salario as "Salário", nome_departamento as "Departamento", "Nome do projeto" as "Projeto" from empregado
	inner join historico_salario on (empregado.rg = historico_salario.rg)
	inner join departamento on (empregado.depto = departamento.numero)
	inner join empregado_projeto on (empregado.rg = empregado_projeto.rg_empregado)
	inner join projeto on (empregado_projeto.numero_projeto = projeto.numero)
	where salario > 2000 order by salario desc;

select nome_completo as "Funcionário", historico_salario.dat_ini_sal as "Inicio Salário", dat_fim_sal as "Fim Salário", salario as "Salário", nome_departamento as "Departamento", "Nome do projeto" as "Projeto" from empregado
	inner join historico_salario on (empregado.rg = historico_salario.rg)
	inner join departamento on (empregado.depto = departamento.numero)
	inner join empregado_projeto on (empregado.rg = empregado_projeto.rg_empregado)
	inner join projeto on (empregado_projeto.numero_projeto = projeto.numero)
	inner join dependente on (empregado.rg = dependente.rg_responsavel)
	where salario > 2000 and salario < 4000 and sexo = 'F'
	order by salario desc;
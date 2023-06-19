use Employees;

-- рассчитать фозраст сотрудника на текущую дату
select name, surname, floor(DATEDIFF(day, bdate, GETDATE()) / 365) as 'возраст' from employee

-- показать сотрудника с наименьшим окладом
select * from employee
inner join position on employee.position_id = position.id
where position.salary = (
	select min(salary) as 'наименьший оклад' from employee
	inner join position on employee.position_id = position.id
	)

-- показать людей, возраст которых выше 25
select name, surname, DATEDIFF(year, bdate, GETDATE()) as 'возраст' from employee
where DATEDIFF(year, bdate, GETDATE()) > 25

-- рассчитать полную зп, сотрудников с учетом премий по мес€цам
select employee.name, employee.surname, work.[month], (position.salary + position.salary*work.prize_pers/100) as 'зп' from employee
inner join position on employee.position_id = position.id
inner join work on employee.id = work.employee_id

-- показать ср зп в фирме
select avg(position.salary + position.salary*work.prize_pers/100) as 'средн€€ зп' from employee
inner join position on employee.position_id = position.id
inner join work on employee.id = work.employee_id

-- выбрать сотрудников за сент€брь 2011 г, полна€ зп которых не превышает 25000 р
select employee.name, employee.surname, work.[month], work.[year], (position.salary + position.salary*work.prize_pers/100) as 'зп' from employee
inner join position on employee.position_id = position.id
inner join work on employee.id = work.employee_id
where (position.salary + position.salary*work.prize_pers/100) < 25000 and work.[month] like 'сен%' and work.[year] = 2011

-- рассчитать общую сумму денег, котора€ была выплачена сотрудникам в окт€бре 2011 г
select sum(position.salary + position.salary*work.prize_pers/100) as 'зп' from employee
inner join position on employee.position_id = position.id
inner join work on employee.id = work.employee_id
where work.[month] like 'окт%' and work.[year] = 2011

-- вставка данных
insert work 
values 
(1, 'но€брь', 2011, 75),
(2, 'но€брь', 2011, 100),
(3, 'но€брь', 2011, 100),
(4, 'но€брь', 2011, 50)

select * from work

-- кол-во премий больше или равно 75
select count(prize_pers) as 'кол-во премий больше или равно 75' from work
where prize_pers >= 75

-- ћы избегаем дублировани€ данных. ќклад зависит от должности, а не от сотрудника. Ќарушение 3 норм формы
use Employees;

-- ���������� ������� ���������� �� ������� ����
select name, surname, floor(DATEDIFF(day, bdate, GETDATE()) / 365) as '�������' from employee

-- �������� ���������� � ���������� �������
select * from employee
inner join position on employee.position_id = position.id
where position.salary = (
	select min(salary) as '���������� �����' from employee
	inner join position on employee.position_id = position.id
	)

-- �������� �����, ������� ������� ���� 25
select name, surname, DATEDIFF(year, bdate, GETDATE()) as '�������' from employee
where DATEDIFF(year, bdate, GETDATE()) > 25

-- ���������� ������ ��, ����������� � ������ ������ �� �������
select employee.name, employee.surname, work.[month], (position.salary + position.salary*work.prize_pers/100) as '��' from employee
inner join position on employee.position_id = position.id
inner join work on employee.id = work.employee_id

-- �������� �� �� � �����
select avg(position.salary + position.salary*work.prize_pers/100) as '������� ��' from employee
inner join position on employee.position_id = position.id
inner join work on employee.id = work.employee_id

-- ������� ����������� �� �������� 2011 �, ������ �� ������� �� ��������� 25000 �
select employee.name, employee.surname, work.[month], work.[year], (position.salary + position.salary*work.prize_pers/100) as '��' from employee
inner join position on employee.position_id = position.id
inner join work on employee.id = work.employee_id
where (position.salary + position.salary*work.prize_pers/100) < 25000 and work.[month] like '���%' and work.[year] = 2011

-- ���������� ����� ����� �����, ������� ���� ��������� ����������� � ������� 2011 �
select sum(position.salary + position.salary*work.prize_pers/100) as '��' from employee
inner join position on employee.position_id = position.id
inner join work on employee.id = work.employee_id
where work.[month] like '���%' and work.[year] = 2011

-- ������� ������
insert work 
values 
(1, '������', 2011, 75),
(2, '������', 2011, 100),
(3, '������', 2011, 100),
(4, '������', 2011, 50)

select * from work

-- ���-�� ������ ������ ��� ����� 75
select count(prize_pers) as '���-�� ������ ������ ��� ����� 75' from work
where prize_pers >= 75

-- �� �������� ������������ ������. ����� ������� �� ���������, � �� �� ����������. ��������� 3 ���� �����
use Lib;

-- 1 общее кол-во книг в библиотеке
select sum(book_count) - (select sum(book_count_taken) - sum(book_count_returned) from [order]) as 'кол-во книг в библиотеке' from supply

--select * from supply

-- 2 число книг в библиотеке стоимостью больше 500 рублей
select count(id) as 'кол-во книг > 500 руб.' from book
where price > 500 

--select * from book



-- 3 число книг от поставщика ООО "Новая книга" с годом издания выше 2006 г
select count(distinct book.[name]) as 'число книг от поставщика ООО "Новая книга" с годом издания выше 2006 г.' from supplier
inner join supply on supply.supplier_id = supplier.id 
inner join book on book.id = supply.book_id
where supplier.name like 'ООО "Нов%' and book.pub_year > 2006

--select * from supplier
--select * from supply
--select * from book



-- 4 кол-во задолжников на текущую дату
select count(distinct client_card_id) as 'кол-во задолжников на текущую дату' from [order]
where datediff(day, order_date, getdate()) > 31 and book_count_returned != book_count_taken

--select 
--client_card_id, 
--sum(book_count_taken) as 'кол-во взятых книг', 
--sum(book_count_returned) as 'кол-во возвращенных книг' 
--from [order]
--group by client_card_id



-- 5 каких книг выдано больше всего
select 
book.[name] as 'книга', 
sum(book_count_taken) as 'кол-во взятых книг'
from [order]
inner join book on book.id = book_id
group by book.[name]
having sum(book_count_taken) = (select max(sum_book_count_taken)
								from (select 
									book.[name] as book_name, 
									sum(book_count_taken) as sum_book_count_taken
									from [order]
									inner join book on book.id = book_id
									group by book.[name]) as selected)

--select 
--book.[name], 
--sum(book_count_taken) as 'кол-во взятых книг', 
--sum(book_count_returned) as 'кол-во возвращенных книг' 
--from [order]
--inner join book on book.id = book_id
--group by book.[name]



-- 6 каких книг выдано меньше всего
select 
book.[name] as 'книга', 
sum(book_count_taken) as 'кол-во взятых книг'
from [order]
inner join book on book.id = book_id
group by book.[name]
having sum(book_count_taken) = (select min(sum_book_count_taken)
								from (select 
									book.[name] as book_name, 
									sum(book_count_taken) as sum_book_count_taken
									from [order]
									inner join book on book.id = book_id
									group by book.[name]) as selected)

--select 
--book.[name], 
--sum(book_count_taken) as 'кол-во взятых книг', 
--sum(book_count_returned) as 'кол-во возвращенных книг' 
--from [order]
--inner join book on book.id = book_id
--group by book.[name]



-- 7 показать сколько книг выдано клиентам
select sum(book_count_taken) - sum(book_count_returned) as 'всего книг выдано клиентам' from [order]

--select 
--book.[name], 
--sum(book_count_taken) as 'кол-во взятых книг', 
--sum(book_count_returned) as 'кол-во возвращенных книг' 
--from [order]
--inner join book on book.id = book_id
--group by book.[name]



-- 8 показать все данные клиентов у которых нет задолжностей
select 
client_card.series_number, 
(client_card.surname + ' ' + client_card.[name] + ' ' + client_card.midname) as 'ФИО',
client_card.b_date,
client_card.address_reg
from client_card
left join [order] on client_card.series_number = [order].client_card_id
left join book on book.id = [order].book_id
where [order].book_count_taken = [order].book_count_returned or [order].book_count_taken is null

--select 
--client_card.series_number, 
--(client_card.surname + ' ' + client_card.[name] + ' ' + client_card.midname) as 'ФИО', 
--book.[name] as 'книга',
--[order].book_count_taken,
--[order].book_count_returned
--from client_card
--left join [order] on client_card.series_number = [order].client_card_id
--left join book on book.id = [order].book_id
--where [order].book_count_taken = [order].book_count_returned or [order].book_count_taken is null



-- 9 штрафы должников на текущую дату
select 
client_card_id,
sum(book_count_diff) as 'кол-во долгов',
sum(order_days) as 'кол-во просроч дней',
sum(debt) as 'штраф (руб.)'
from (select 
	client_card_id, 
	(book_count_taken - book_count_returned) as book_count_diff,
	datediff(day, order_date, getdate()) - 31 as order_days,
	iif(
	(datediff(day, order_date, getdate()) - 31)<5, 
	(datediff(day, order_date, getdate()) - 31)*5, 
	(datediff(day, order_date, getdate()) - 31)*8) as debt
	from [order]
	where datediff(day, order_date, getdate()) > 31 and (book_count_taken - book_count_returned) != 0) as selected
group by client_card_id


select 
client_card_id, 
(book_count_taken - book_count_returned) as 'кол-во долгов',
book_count_taken as 'кол-во взятых книг', 
book_count_returned as 'кол-во возвращенных книг',
order_date as 'дата получения',
datediff(day, order_date, getdate()) - 31 as 'кол-во просроч дней',
iif(
(datediff(day, order_date, getdate()) - 31)<5, 
(datediff(day, order_date, getdate()) - 31)*5, 
(datediff(day, order_date, getdate()) - 31)*8) as 'штраф (руб.)'
from [order]
where datediff(day, order_date, getdate()) > 31 and (book_count_taken - book_count_returned) != 0
order by client_card_id
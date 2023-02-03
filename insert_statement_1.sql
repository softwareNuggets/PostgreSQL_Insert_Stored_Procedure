--drop table employee
--drop procedure employee_insert
create table if not exists employee(
	emp_id 			int 		not null PRIMARY KEY,
	first_name 		varchar(30) not null,
	last_name		varchar(30) not null,
	is_active		boolean 	DEFAULT 'true',
	create_date		TIMESTAMP 	DEFAULT NOW(),
	update_date 	TIMESTAMP
)

CREATE OR REPLACE PROCEDURE employee_insert
(
	p_emp_id		int,
	p_first_name	varchar(30),
	p_last_name		varchar(30)
) 
AS $$
BEGIN

	-- parameter validation
	if p_emp_id is NULL then
		RAISE EXCEPTION 'emp_id must have a value';
	end if;
	
	if p_first_name is NULL then
		RAISE EXCEPTION 'first_name must have a value';
	end if;
	
	if p_last_name is NULL then
		RAISE EXCEPTION 'last_name must have a value';
	end if;
	
	insert into employee(emp_id, first_name, last_name)
	values(p_emp_id, p_first_name, p_last_name);

END;
$$ LANGUAGE plpgsql;

call employee_insert(1,'software','nuggets')

select * from employee
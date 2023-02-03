--drop table employee_v2
--drop procedure employee_v2_insert
create table if not exists employee_v2(
	emp_id 			serial 		not null PRIMARY KEY,
	first_name 		varchar(30) not null,
	last_name		varchar(30) not null,
	is_active		boolean 	DEFAULT 'true',
	create_date		TIMESTAMP 	DEFAULT NOW(),
	update_date 	TIMESTAMP
)

CREATE OR REPLACE PROCEDURE employee_v2_insert
(
	p_first_name	varchar(30),
	p_last_name		varchar(30),
	OUT rv_emp_id 	INTEGER
) 
AS $$
BEGIN

	-- parameter validation
	if p_first_name is NULL then
		RAISE EXCEPTION 'first_name must have a value';
	end if;
	
	if p_last_name is NULL then
		RAISE EXCEPTION 'last_name must have a value';
	end if;
	
	insert into employee_v2(first_name, last_name)
	values(p_first_name, p_last_name)
	RETURNING emp_id INTO rv_emp_id;

END;
$$ LANGUAGE plpgsql;

do
$$
declare
	v_emp_id integer;
begin
	call employee_v2_insert('sql','programmer', v_emp_id);
	raise notice 'Emp_id = %', v_emp_id;
end;
$$


select *
from employee_v2


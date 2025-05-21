drop table if exists flights;
create table flights(
cust_id INT,
flight_id varchar(20),
origin varchar(20),
destination varchar(20)
);

insert into flights(cust_id, flight_id, origin, destination)
values (1,'sg1234','delhi','hyd'),
		(1,'sg3476','kochi', 'manglore'),
		(1,'6986','hyd','kochi'),
		(2,'68749','mumbai','varanasi'),
		(2,'sg5723','varanasi','delhi');
select *,
first_value(origin) over(partition by cust_id) as p 
from flights;
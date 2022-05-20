create schema if not exists warehouse.bronze with (location = 's3a://bronze/');

drop table if exists warehouse.bronze.employee;

create table warehouse.bronze.employee (
   employee_id integer not null,
   employee_name varchar not null
)
with (
   format = 'parquet'
);

insert into warehouse.bronze.employee (employee_id, employee_name) values (1, 'john doe');
insert into warehouse.bronze.employee (employee_id, employee_name) values (2, 'jane doe');
insert into warehouse.bronze.employee (employee_id, employee_name) values (3, 'joe doe');
insert into warehouse.bronze.employee (employee_id, employee_name) values (4, 'james doe');

select * from warehouse.bronze.employee;

-- the warehouse.bronze.ny_taxis_feb is created from Spark with this script
-- df=spark.read.parquet("/home/data/stage/nyc/fhvhv_tripdata_2022-02.parquet")
-- df.writeTo("warehouse.bronze.ny_taxis_feb").create()

select 
	hour(pickup_datetime),
	sum(trip_miles),
	sum(trip_time),
	sum(base_passenger_fare)
from warehouse.bronze.ny_taxis_feb group by 1 order by 1;

select count(*) from warehouse.bronze.employee;


create index idx_customer_last_names on sales.customers(last_name);
create index idx_customer_state on sales.customers(state);
create index idx_customer_country on sales.customers(country);


create index idx_orders_order_date on sales.orders(order_date);
create index idx_orders_total_amount on sales.orders(total_amount);
create index idx_orders_customer_id on sales.orders(customer_id);

create index idx_order_items_order_id on sales.order_items(order_id);
create index idx_order_items_product_id on sales.order_items(product_id);

create index idx_products_name on sales.products(name);
create index idx_products_price on sales.products(price);

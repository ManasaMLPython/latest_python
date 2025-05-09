drop index if exists sales.idx_customer_last_names;
drop index if exists sales.idx_customer_state;
drop index if exists sales.idx_customer_country;


drop index if exists sales.idx_orders_order_date;
drop index if exists sales.idx_orders_total_amount;
drop index if exists sales.idx_orders_customer_id;

drop index if exists sales.idx_order_items_order_id;
drop index if exists sales.idx_order_items_product_id;

drop index if exists sales.idx_products_name;
drop index if exists sales.idx_products_price;

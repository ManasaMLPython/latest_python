from faker import Faker
import random
import pandas as pd
from datetime import datetime

# Initialize Faker
faker = Faker()

def generate_insert_statement(table_name, data_dict):
    columns = ', '.join(data_dict.keys())
    values = []
    for val in data_dict.values():
        if isinstance(val, str):
            # Double up single quotes for SQL escaping
            escaped_val = val.replace("'", "''")
            values.append(f"'{escaped_val}'")
        elif isinstance(val, (int, float)):
            values.append(str(val))
        elif isinstance(val, datetime):
            values.append(f"'{val.strftime('%Y-%m-%d %H:%M:%S')}'")
        elif val is None:
            values.append('NULL')
        else:
            values.append(f"'{str(val)}'")
    values_str = ', '.join(values)
    return f"INSERT INTO sales.{table_name} ({columns}) VALUES ({values_str});"

def write_inserts_to_file(filename, statements):
    with open(filename, 'w', encoding='utf-8') as f:
        f.write('BEGIN;\n\n')
        for stmt in statements:
            f.write(stmt + '\n')
        f.write('\nCOMMIT;')

# Create synthetic data for products
def create_products(n=100):
    products = []
    for i in range(1, n + 1):
        product = {
            'product_id': i,
            'name': faker.word().capitalize(),
            'description': faker.text()[:200],
            'price': round(random.uniform(5, 500), 2),
            'stock_quantity': random.randint(1, 1000),
            'created_at': faker.date_time_this_decade(),
            'updated_at': faker.date_time_this_decade()
        }
        products.append(product)
    return products

# Create synthetic data for customers
def create_customers(n=500):
    customers = []
    for i in range(1, n + 1):
        customers.append({
            'customer_id': i,
            'first_name': faker.first_name(),
            'last_name': faker.last_name(),
            'email': faker.unique.email(),
            'phone': faker.phone_number()[:20],
            'address_line1': faker.street_address(),
            'address_line2': faker.secondary_address() if random.random() > 0.3 else None,
            'city': faker.city(),
            'state': faker.state(),
            'postal_code': faker.postcode(),
            'country': faker.country(),
            'created_at': faker.date_time_this_decade()
        })
    return customers

# Create synthetic data for orders
def create_orders(n=1000, customer_ids=[]):
    orders = []
    for i in range(1, n + 1):
        orders.append({
            'order_id': i,
            'customer_id': random.choice(customer_ids),
            'order_date': faker.date_time_this_year(),
            'status': random.choice(['pending', 'shipped', 'delivered', 'cancelled']),
            'total_amount': 0,  # Will be updated later
            'shipping_address_line1': faker.street_address(),
            'shipping_address_line2': faker.secondary_address() if random.random() > 0.3 else None,
            'shipping_city': faker.city(),
            'shipping_state': faker.state(),
            'shipping_postal_code': faker.postcode(),
            'shipping_country': faker.country()
        })
    return orders

# Create synthetic data for order items
def create_order_items(orders, product_ids=[]):
    order_items = []
    item_id = 1
    
    for order in orders:
        order_total = 0
        num_items = random.randint(2, 5)
        for _ in range(num_items):
            quantity = random.randint(1, 10)
            unit_price = round(random.uniform(5, 500), 2)
            subtotal = round(quantity * unit_price, 2)
            order_items.append({
                'order_item_id': item_id,
                'order_id': order['order_id'],
                'product_id': random.choice(product_ids),
                'quantity': quantity,
                'unit_price': unit_price,
                'subtotal': subtotal
            })
            order_total += subtotal
            item_id += 1
        # Update order total amount
        order['total_amount'] = round(order_total, 2)
    
    return order_items

# Generate data
products = create_products()
customers = create_customers()
orders = create_orders(customer_ids=[c['customer_id'] for c in customers])
order_items = create_order_items(orders, product_ids=[p['product_id'] for p in products])

# Generate SQL statements
sql_statements = []

# Add statements for each table
for product in products:
    sql_statements.append(generate_insert_statement('products', product))

for customer in customers:
    sql_statements.append(generate_insert_statement('customers', customer))

for order in orders:
    sql_statements.append(generate_insert_statement('orders', order))

for item in order_items:
    sql_statements.append(generate_insert_statement('order_items', item))

# Write to file
write_inserts_to_file('sales_data_insert.sql', sql_statements)

########################################################
# Sample Stephen's blueprint of endpoints
########################################################
from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db
from backend.ml_models.model01 import predict

stephen = Blueprint('stephen', __name__)

# Add a new client
@stephen.route('/clients', methods=['POST'])
def add_new_client():
    # Collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    name = the_data['name']
    age = the_data['age']
    gender = the_data['gender']
    contact = the_data['contact']
    dietary_preferences = the_data['dietary_preferences']
    health_goal = the_data['health_goal']
    dietary_restrictions = the_data['dietary_restrictions']
    user_id = the_data['user_id']

    # Constructing the query
    column_values = [name, age, gender, contact, dietary_preferences, health_goal, dietary_restrictions, user_id]
    def quote_if_string(val):
        quote_char = "'" if isinstance(val, str) else ""
        return f'{quote_char}{val}{quote_char}'
    column_values_string = ", ".join(quote_if_string(c) for c in column_values)
    query = f"""
    INSERT INTO Clients 
    (name, age, gender, contact, dietary_preferences, health_goal, dietary_restrictions, user_id) 
    VALUES ({column_values_string})
            """
    current_app.logger.info(query)

    # Executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Client added successfully!'

# Add a new food log entry
@stephen.route('/food_logs', methods=['POST'])
def add_food_log():
    # Collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    date = the_data['date']
    meal_type = the_data['meal_type']
    comments = the_data['comments']
    food_items = the_data['food_items']
    calories = the_data['calories']
    client_id = the_data['client_id']

    # Constructing the query
    column_values = [date, meal_type, comments, food_items, calories, client_id]
    def quote_if_string(val):
        quote_char = "'" if isinstance(val, str) else ""
        return f'{quote_char}{val}{quote_char}'
    column_values_string = ", ".join(quote_if_string(c) for c in column_values)
    query = f"""
    INSERT INTO Food_Log 
    (date, meal_type, comments, food_items, calories, client_id) 
    VALUES ({column_values_string})
            """
    current_app.logger.info(query)

    # Executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Food log entry added successfully!'

# Retrieve all clients
@stephen.route('/viewclients', methods=['GET'])
def get_all_clients():
    cursor = db.get_db().cursor()
    the_query = '''
        SELECT client_id, name, age, gender, contact, health_goal, dietary_preferences, health_goal, dietary_restrictions
        FROM Clients
    '''
    cursor.execute(the_query)
    the_data = cursor.fetchall()
    print(the_data)
    return jsonify(the_data)

# Delete a client
@stephen.route('/delete', methods=['DELETE'])
def delete_client():

    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    client_id = the_data['client_id']
    
    # Constructing the query
    query = f"""
    DELETE FROM Clients WHERE client_id = {client_id}
            """
    current_app.logger.info(query)

    # Executing the delete statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Client deleted successfully!'

# Update a client's information
@stephen.route('/update_client', methods=['PUT'])
def update_client():
    # Collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    client_id = the_data['client_id']
    name = the_data['name']
    age = the_data['age']
    gender = the_data['gender']
    contact = the_data['contact']
    dietary_preferences = the_data['dietary_preferences']
    health_goal = the_data['health_goal']
    dietary_restrictions = the_data['dietary_restrictions']
    user_id = the_data['user_id']

    # Log the data types
    current_app.logger.info(f"client_id: {type(client_id)}, name: {type(name)}, age: {type(age)}, gender: {type(gender)}, contact: {type(contact)}, dietary_preferences: {type(dietary_preferences)}, health_goal: {type(health_goal)}, dietary_restrictions: {type(dietary_restrictions)}, user_id: {type(user_id)}")

    # Constructing the parameterized query
    query = """
    UPDATE Clients
    SET client_id = %s,
        name = %s, 
        age = %s, 
        gender = %s,
        contact = %s, 
        dietary_preferences = %s, 
        health_goal = %s, 
        dietary_restrictions = %s, 
        user_id = %s
    WHERE client_id = %s
    """
    current_app.logger.info(query)

    # Executing and committing the update statement
    cursor = db.get_db().cursor()
    cursor.execute(query, (client_id, name, age, gender, 
                           contact, dietary_preferences, health_goal, dietary_restrictions, user_id, client_id))
    db.get_db().commit()

    return 'Client updated successfully!'

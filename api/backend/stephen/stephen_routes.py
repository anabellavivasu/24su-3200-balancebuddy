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
    goal = the_data['goal']
    dietary_preferences = the_data['dietary_preferences']

    # Constructing the query
    column_values = [name, age, gender, goal, dietary_preferences]
    def quote_if_string(val):
        quote_char = "'" if isinstance(val, str) else ""
        return f'{quote_char}{val}{quote_char}'
    column_values_string = ", ".join(quote_if_string(c) for c in column_values)
    query = f"""
    INSERT INTO Clients 
    (name, age, gender, goal, dietary_preferences) 
    VALUES ({column_values_string})
            """
    current_app.logger.info(query)

    # Executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Client added successfully!'

# Add a new food log entry
@stephen.route('/food_log', methods=['POST'])
def add_food_log():
    # Collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    client_id = the_data['client_id']
    food_item = the_data['food_item']
    calories = the_data['calories']
    meal_time = the_data['meal_time']

    # Constructing the query
    column_values = [client_id, food_item, calories, meal_time]
    def quote_if_string(val):
        quote_char = "'" if isinstance(val, str) else ""
        return f'{quote_char}{val}{quote_char}'
    column_values_string = ", ".join(quote_if_string(c) for c in column_values)
    query = f"""
    INSERT INTO Food_Log 
    (client_id, food_item, calories, meal_time) 
    VALUES ({column_values_string})
            """
    current_app.logger.info(query)

    # Executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Food log entry added successfully!'

# View all clients
@stephen.route('/clients', methods=['GET'])
def get_all_clients():
    cursor = db.get_db().cursor()
    the_query = '''
        SELECT client_id, name, age, gender, goal, dietary_preferences
        FROM Clients
    '''
    cursor.execute(the_query)
    the_data = cursor.fetchall()
    return jsonify(the_data)

# Delete a client
@stephen.route('/clients/delete', methods=['DELETE'])
def delete_client():
    # Collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variable
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


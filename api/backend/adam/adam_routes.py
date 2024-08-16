########################################################
# Sample Adam's blueprint of endpoints
########################################################
from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db
from backend.ml_models.model01 import predict

adam = Blueprint('adam', __name__)

# Retrieve Food Log
@adam.route('/viewfoodlog', methods=['GET'])
def get_foodlog():
    cursor = db.get_db().cursor()

    # Constructing the query
    the_query = f"""
        SELECT food_log_id, date, meal_type, comments, food_items, calories
        FROM Food_Log
        """

    # Executing the statement
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    the_data = cursor.fetchall()
    print(the_data)

    return jsonify(the_data)

# Add a new food log entry
@adam.route('/food_logs', methods=['POST'])
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

# Retrieve Exercise Log
@adam.route('/viewexerciselog', methods=['GET'])
def get_exerciselog():
    cursor = db.get_db().cursor()

    # Constructing the query
    the_query = f"""
        SELECT exercise_id, breaths_per_minute, BMI, weight, height, max_HR
        FROM Exercise_Info
        """

    # Executing the statement
    cursor = db.get_db().cursor()
    cursor.execute(the_query)
    the_data = cursor.fetchall()
    print(the_data)
    
    return jsonify(the_data)

# Add a new exercise entry
@adam.route('/exercises', methods=['POST'])
def add_exercise():
    # Collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    user_id = the_data['user_id']
    breaths_per_minute = the_data['breaths_per_minute']
    BMI = the_data['BMI']
    weight = the_data['weight']
    height = the_data['height']
    max_HR = the_data['max_HR']
    exercise_pages = the_data['exercise_pages']

    # Constructing the query
    column_values = [user_id, breaths_per_minute, BMI, weight, height, max_HR, exercise_pages]
    def quote_if_string(val):
        quote_char = "'" if isinstance(val, str) else ""
        return f'{quote_char}{val}{quote_char}'
    column_values_string = ", ".join(quote_if_string(c) for c in column_values)
    query = f"""
    INSERT INTO Exercise_Info
    (user_id, breaths_per_minute, BMI, weight, height, max_HR, exercise_pages) 
    VALUES ({column_values_string})
            """
    current_app.logger.info(query)

    # Executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Exercise Log entry added successfully!'


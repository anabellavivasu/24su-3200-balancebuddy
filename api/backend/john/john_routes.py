########################################################
# Sample John's blueprint of endpoints
########################################################
from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db
from backend.ml_models.model01 import predict

john = Blueprint('john', __name__)

# Add a new campaign
@john.route('/campaigns', methods=['POST'])
def add_new_campaign():
    # Collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    campaign_id = the_data['campaign_id']
    name = the_data['name']
    budget = the_data['budget']
    start_date = the_data['start_date']
    end_date = the_data['end_date']
    description = the_data['description']

    # Constructing the query
    column_values = [campaign_id, name, budget, start_date, end_date, description]
    def quote_if_string(val):
        quote_char = "'" if isinstance(val, str) else ""
        return f'{quote_char}{val}{quote_char}'
    column_values_string = ", ".join(quote_if_string(c) for c in column_values)
    query = f"""
    INSERT INTO Campaign 
    (campaign_id, name, budget, start_date, end_date, description) 
    VALUES ({column_values_string})
            """
    current_app.logger.info(query)

    # Executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Campaign added successfully!'


# Add a new market research entry
@john.research('/market_research', methods=['POST'])
def add_market_research():
    # Collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    research_id = the_data['research_id']
    trends = the_data['trends']
    competition = the_data['competition']
    findings = the_data['findings']

    # Constructing the query
    column_values = [research_id, trends, competition, findings]
    def quote_if_string(val):
        quote_char = "'" if isinstance(val, str) else ""
        return f'{quote_char}{val}{quote_char}'
    column_values_string = ", ".join(quote_if_string(c) for c in column_values)
    query = f"""
    INSERT INTO Market_research 
    (research_id, trends, competition, findings) 
    VALUES ({column_values_string})
            """
    current_app.logger.info(query)

    # Executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Market research entry added successfully!'


# Retrieve all campaigns
@john.route('/campaigns', methods=['GET'])
def get_all_campaigns():
    cursor = db.get_db().cursor()
    the_query = '''
        SELECT campaign_id, name, budget, start_date, end_date, description
        FROM Campaign
    '''
    cursor.execute(the_query)
    the_data = cursor.fetchall()
    return jsonify(the_data)


# Delete a campaign
@john.route('/campaings/<int:campaign_id>', methods=['DELETE'])
def delete_campaign(campaign_id):
    # Constructing the query
    query = f"""
    DELETE FROM Campaign WHERE campaign_id = {campaign_id}
            """
    current_app.logger.info(query)

    # Executing the delete statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Campaign deleted successfully!'


# Update a campaign's information
@john.route('/campaigns/<int:campaign_id>', methods=['PUT'])
def update_campaign(campaign_id):
    # Collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    name = the_data.get('name')
    budget = the_data.get('budget')
    start_date = the_data.get('start_date')
    end_date = the_data.get('end_date')
    description = the_data.get('description')

    # Constructing the query
    update_values = []
    if name:
        update_values.append(f"name = '{name}'")
    if budget:
        update_values.append(f"budget = {budget}")
    if start_date:
        update_values.append(f"start_date = '{start_date}'")
    if end_date:
        update_values.append(f"end_date = '{end_date}'")
    if description:
        update_values.append(f"description = '{description}'")
    
    update_values_string = ", ".join(update_values)
    query = f"""
    UPDATE Campaigns 
    SET {update_values_string}
    WHERE campaign_id = {campaign_id}
            """
    current_app.logger.info(query)

    # Executing and committing the update statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Campaign updated successfully!'

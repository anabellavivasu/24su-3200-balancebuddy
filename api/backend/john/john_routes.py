########################################################
# Sample John's blueprint of endpoints
########################################################
from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db
from backend.ml_models.model01 import predict

john = Blueprint('john', __name__)

# Enter a new ad
@john.route('/ads', methods=['POST'])
def add_new_ad():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    # extracting the variable
    image_url = the_data['image_url']
    start_date = the_data['start_date']
    end_date = the_data['end_date']
    name = the_data['name']
    budget = the_data['budget']
    caption = the_data['caption']
    advertiser_id = the_data['advertiser_id']

    # Constructing the query
    column_values = [image_url, start_date, end_date, name, budget, caption, advertiser_id]
    def quote_if_string(val):
        quote_char = "'" if isinstance(val, str) else ""
        return f'{quote_char}{val}{quote_char}'
    column_values_string = ", ".join(quote_if_string(c) 
                       for c in column_values)
    query = f"""
    insert into Ads 
    (image_url, 
    start_date, 
    end_date, 
    name, 
    budget,
    caption,
    advertiser_id) values ({column_values_string})
            """
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# Delete ad
@john.route('/delete', methods = ['DELETE'])
def delete_ad():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    ad_id = the_data['ad_id']
    
    # Constructing the query
    query = f"""
    DELETE FROM Ads WHERE ad_id = {ad_id}
            """
    current_app.logger.info(query)

    # Executing the delete statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Ad deleted successfully!'

# Update an ad's information
@john.route('/update_ad', methods=['PUT'])
def update_ad():
    # Collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    ad_id = the_data['ad_id']
    image_url = the_data['image_url']
    start_date = the_data['start_date']
    end_date = the_data['end_date']
    name = the_data['name']
    budget = the_data['budget']
    caption = the_data['caption']
    advertiser_id = the_data['advertiser_id']

    # Log the data types
    current_app.logger.info(f"ad_id: {type(ad_id)}, image_url: {type(image_url)}, start_date: {type(start_date)}, end_date: {type(end_date)}, name: {type(name)}, budget: {type(budget)}, caption: {type(caption)}, advertiser_id: {type(advertiser_id)}")

    # Constructing the parameterized query
    query = """
    UPDATE Ads
    SET ad_id = %s,
        image_url = %s, 
        start_date = %s, 
        end_date = %s,
        name = %s, 
        budget = %s, 
        caption = %s, 
        advertiser_id = %s
    WHERE ad_id = %s
    """
    current_app.logger.info(query)

    # Executing and committing the update statement
    cursor = db.get_db().cursor()
    cursor.execute(query, (ad_id, image_url, start_date, end_date, name, budget, caption, advertiser_id, ad_id))
    db.get_db().commit()

    return 'Ad updated successfully!'

# Add a new market research entry
@john.route('/market_research', methods=['POST'])
def add_market_research():
    # Collecting data from the request object
    the_data = request.json
    current_app.logger.info(the_data)

    # Extracting the variables
    findings = the_data['findings']
    trends = the_data['trends']
    competition = the_data['competition']
    advertiser_id = the_data['advertiser_id']

    # Constructing the query
    column_values = [findings, trends, competition, advertiser_id]
    def quote_if_string(val):
        quote_char = "'" if isinstance(val, str) else ""
        return f'{quote_char}{val}{quote_char}'
    column_values_string = ", ".join(quote_if_string(c) for c in column_values)
    query = f"""
    INSERT INTO Market_Research 
    (findings, trends, competition, advertiser_id) 
    VALUES ({column_values_string})
            """
    current_app.logger.info(query)

    # Executing and committing the insert statement
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return 'Market research entry added successfully!'



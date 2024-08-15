from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db
from backend.ml_models.model01 import predict

livefit = Blueprint('livefit', __name__)

# enter a new audience
@livefit.route('/audiences', methods=['POST'])
def add_new_audience():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    name = the_data['name']
    location = the_data['location']
    interest = the_data['interest']
    age_range = the_data['age_range']
    budget = the_data['budget']

    # Constructing the query
    column_values = [name, location, interest, age_range,
                    budget]
    def quote_if_string(val):
        quote_char = "'" if isinstance(val, str) else ""
        return f'{quote_char}{val}{quote_char}'
    column_values_string = ", ".join(quote_if_string(c) 
                       for c in column_values)
    query = f"""
    insert into Audiences 
    (name, 
    location, 
    interest, 
    age_range, 
    budget) values ({column_values_string})
            """
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# enter a new ad
@livefit.route('/ads', methods=['POST'])
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

# view engagement 
@livefit.route('/livefit', methods=['GET'])
def get_all_engagement():
    cursor = db.get_db().cursor()
    the_query = '''
        SELECT engagement_id, feedback, count, ad_id
        FROM Engagement
        GROUP BY ad_id, engagement_id 
    '''
    cursor.execute(the_query)
    theData = cursor.fetchall()
    print(theData)
    return jsonify(theData)

# delete ad
@livefit.route('/delete', methods = ['DELETE'])
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
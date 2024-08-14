########################################################
# Sample LiveFit's blueprint of endpoints
########################################################
from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db
from backend.ml_models.model01 import predict

livefit = Blueprint('livefit', __name__)

# enter a new audience
@livefit.route('/livefit', methods=['POST'])
def add_new_audience():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    name = the_data['audience_name']
    location = the_data['audience_location']
    interest = the_data['audience_interest']
    age_range = the_data['audience_age_range']
    budget = the_data['audience_budget']

    # Constructing the query
    query = 'insert into audience (audience_name, audience_location, audience_interest, audience_age_range, audience_budget) values ("'
    query += name + '", "'
    query += location + '", "'
    query += interest + '", '
    query += age_range + '", '
    query += str(budget) + ')'
    current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# enter a new ad
@livefit.route('/livefit', methods=['POST'])
def add_new_add():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    #extracting the variable
    image_url = the_data['ad_image_url']
    start_date = the_data['ad_start_date']
    end_date = the_data['ad_end_date']
    name = the_data['ad_name']
    budget = the_data['ad_budget']
    caption = the_data['ad_caption']
    advertiser_id = the_data['ad_advertiser_id']

    # Constructing the query
    query = 'insert into ad (ad_image_url, ad_start_date, ad_end_date, ad_name, ad_budget, ad_caption, ad_advertiser_id) values ("'
    query += image_url + '", "'
    query += start_date + '", "'
    query += end_date + '", '
    query += name + '", '
    query += budget + '", '
    query += caption + '", '
    query += str(advertiser_id) + ')'
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
        GROUP BY ad_id 
    '''
    cursor.execute(the_query)
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

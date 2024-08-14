########################################################
# Sample John blueprint of endpoints
########################################################
from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db
from backend.ml_models.model01 import predict

john = Blueprint('john', __name__)

@john.route('/john', methods=['GET'])
def get_all_john():
    cursor = db.get_db().cursor()
    the_query = '''
        SELECT research_id, findings, trends, competition, advertiser_id
        FROM Market_Research
    '''
    cursor.execute(the_query)
    theData = cursor.fetchall()
    the_response = make_response(theData)
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response
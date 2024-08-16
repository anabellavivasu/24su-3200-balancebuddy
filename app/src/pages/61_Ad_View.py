import logging
logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Add a New Ad")

with st.form("Create a New Ad"):
    advertisement_image_url = st.text_input("Input Ad Image URL:")
    advertisement_start_date = st.text_input("Input a Start Date (YYYY/MM/DD):")
    advertisement_end_date = st.text_input("Input an End Date (YYYY/MM/DD):")
    advertisement_name = st.text_input("Input an Ad Name:")
    advertisement_budget = st.number_input("Input a Budget for your Ad:")
    advertisement_caption = st.text_input("Input a Caption:")
    advertisement_advertiser_id = st.number_input("Input your ID:")

    submitted = st.form_submit_button("Submit")

if submitted:
    data = {}
    data['image_url'] = advertisement_image_url
    data['start_date'] = advertisement_start_date
    data['end_date'] = advertisement_end_date
    data['name'] = advertisement_name
    data['budget'] = advertisement_budget
    data['caption'] = advertisement_caption
    st.write(data)

    requests.post('http://api:4000/j/ads', json=data)

st.write("# Update an Ad")
st.write("## Inpute new info for fields you want to change. For the rest, input same info.")

with st.form("Update an Ad"):
    advertisement_id = st.text_input("Input the Ad's ID:")
    advertisement_image_url = st.text_input("Update Ad Image URL:")
    advertisement_start_date = st.text_input("Update Start Date (YYYY/MM/DD):")
    advertisement_end_date = st.text_input("Update End Date (YYYY/MM/DD):")
    advertisement_name = st.text_input("Update Ad Name:")
    advertisement_budget = st.number_input("Update Budget:")
    advertisement_caption = st.text_input("Update Caption:")
    advertisement_advertiser_id = st.number_input("Input your ID to confirm:")

    submitted = st.form_submit_button("Submit")

if submitted:
    data = {}
    data['ad_id'] = advertisement_id
    data['image_url'] = advertisement_image_url
    data['start_date'] = advertisement_start_date
    data['end_date'] = advertisement_end_date
    data['name'] = advertisement_name
    data['budget'] = advertisement_budget
    data['caption'] = advertisement_caption
    data['advertiser_id'] = advertisement_advertiser_id
    st.write(data)

    requests.put('http://api:4000/j/update_ad', json=data)

st.write("# Delete an Ad")
st.write("## Note: This Action cannot be Reversed")

with st.form("Delete an Ad"):
    advertisement_id = st.text_input("Input Ad Id:")

    submitted = st.form_submit_button("Delete Ad")

if submitted:
    data = {}
    data['ad_id'] = advertisement_id
    st.write('Ad Deleted')

    requests.delete('http://api:4000/j/delete', json=data)
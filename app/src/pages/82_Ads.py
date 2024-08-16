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
    advertisement_advertiser_id = st.number_input("Input your Advertiser ID:")

    submitted = st.form_submit_button("Submit")

if submitted:
    data = {}
    data['image_url'] = advertisement_image_url
    data['start_date'] = advertisement_start_date
    data['end_date'] = advertisement_end_date
    data['name'] = advertisement_name
    data['budget'] = advertisement_budget
    data['caption'] = advertisement_caption
    data['advertiser_id'] = advertisement_advertiser_id

    response = requests.post('http://api:4000/l/ads', json=data)

    if response.status_code == 200:
        st.success("Ad added successfully!")
    else:
        st.error("Failed to add ad.")

st.write("# Delete an Ad")
st.write("## Note: This Action cannot be Reversed")

with st.form("Delete an Ad"):
    advertisement_id = st.text_input("Input Ad Id:")

    submitted = st.form_submit_button("Delete Ad")

if submitted:
    data = {}
    data['ad_id'] = advertisement_id

    response = requests.delete('http://api:4000/l/delete', json=data)

    if response.status_code == 200:
        st.success("Ad deleted successfully!")
    else:
        st.error("Failed to delete ad.")
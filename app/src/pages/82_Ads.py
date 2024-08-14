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
    advertisement_start_date = st.text_input("Input a Start Date:")
    advertisement_start_date = st.text_input("Input an End Date:")
    advertisement_name = st.text_input("Input an Ad Name:")
    advertisement_budget = st.number_input("Input a Budget for your Ad:")
    advertisement_caption = st.text_input("Input a Caption:")
    advertisement_advertiser_id = st.number_input("Input your Advertiser ID:")

    submitted = st.form_submit_button("Submit")

if submitted:
    data = {}
    data['ad_image_url'] = advertisement_image_url
    data['ad_start_date'] = advertisement_start_date
    data['ad_end_date'] = advertisement_start_date
    data['ad_name'] = advertisement_name
    data['ad_budget'] = advertisement_budget
    data['ad_caption'] = advertisement_caption
    data['ad_advertiser_id'] = advertisement_advertiser_id
    st.write(data)

    requests.post('http://api:4000/p/product', json=data)

import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Add a New Audience")

with st.form("Create a New Audience"):
    aud_name = st.text_input("Input New Audience Name:")
    aud_location = st.text_input("Input a Location:")
    aud_interest = st.text_input("Input an Audience Interest Keyword:")
    aud_age = st.number_input("Input an Audience Age:")
    aud_budget = st.number_input("Input a Budget for your Audience:")

    submitted = st.form_submit_button("Submit")

if submitted:
    data = {}
    data['name'] = aud_name
    data['location'] = aud_location
    data['interest'] = aud_interest
    data['age_range'] = aud_age
    data['budget'] = aud_budget

    response = requests.post('http://api:4000/l/audiences', json=data)

    if response.status_code == 200:
        st.success("Audience added successfully!")
    else:
        st.error("Failed to add Audience.")
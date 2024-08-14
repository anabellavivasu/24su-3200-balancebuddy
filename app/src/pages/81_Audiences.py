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
    data['audience_name'] = aud_name
    data['audience_location'] = aud_location
    data['audience_interest'] = aud_interest
    data['audience_age'] = aud_age
    data['audience_budget'] = aud_budget
    st.write(data)

    requests.post('http://api:4000/p/product', json=data)
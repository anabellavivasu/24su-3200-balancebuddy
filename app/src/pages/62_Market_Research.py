import logging
logger = logging.getLogger(__name__)
import pandas as pd
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# Add a New Market Research Entry")

with st.form("Create Market Research Entry"):
    market_research_findings = st.text_input("Input your Findings:")
    market_research_trends = st.text_input("Input Trend Analysis:")
    market_research_competition = st.text_input("Input Competition Analysis:")
    advertisement_advertiser_id = st.number_input("Input Advertiser ID:")

    submitted = st.form_submit_button("Submit")

if submitted:
    data = {}
    data['findings'] = market_research_findings
    data['trends'] = market_research_trends
    data['competition'] = market_research_competition
    data['advertiser_id'] = advertisement_advertiser_id
    st.write(data)

    requests.post('http://api:4000/j/market_research', json=data)
import logging
logger = logging.getLogger(__name__)
import streamlit as st
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks
import requests

# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

st.write("# View Engagement")

# get the engagement from the balancebuddy data
engagement = requests.get('http://api:4000/l/livefit').json()
try: 
    st.dataframe(engagement)
except:
    st.write("Could not connect to database to get engagement")
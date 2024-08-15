import logging
logger = logging.getLogger(__name__)
import streamlit as st
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks
import requests

# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

# set the header of the page
st.header('Engagement Data')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}.")

# get the engagement from the balancebuddy data
with st.echo(code_location='above'):
    engagement = requests.get('http://api:4000/l/livefit').json()
    try: 
        st.dataframe(engagement)
    except:
        st.write("Could not connect to database to get engagement")
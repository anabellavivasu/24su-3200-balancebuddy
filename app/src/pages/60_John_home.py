import logging
import streamlit as st
from modules.nav import SideBarLinks

logger = logging.getLogger(__name__)

st.set_page_config(layout='wide')

# Show appropriate sidebar links for the role of the currently logged-in user
SideBarLinks()

st.title(f"Welcome, John.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('View All Campaigns', type='primary', use_container_width=True):
    st.switch_page('pages/61_Campaign_View.py')

if st.button('Add a New Campaign', type='primary', use_container_width=True):
    st.switch_page('pages/61_Campaign_View.py')

if st.button('Update Campaign Info', type='primary', use_container_width=True):
    st.switch_page('pages/61_Campaign_View.py')

if st.button('Delete a Campaign', type='primary', use_container_width=True):
    st.switch_page('pages/61_Campaign_View.py')

if st.button('Add a New Market Research', type='primary', use_container_width=True):
    st.switch_page('pages/62_Market_Research.py')

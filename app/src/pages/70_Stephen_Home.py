import logging
import streamlit as st
from modules.nav import SideBarLinks

logger = logging.getLogger(__name__)

st.set_page_config(layout='wide')

# Show appropriate sidebar links for the role of the currently logged-in user
SideBarLinks()

st.title(f"Welcome, Stephen.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('Clients', type='primary', use_container_width=True):
    st.switch_page('pages/71_Clients.py')

if st.button('Food Logs', type='primary', use_container_width=True):
    st.switch_page('pages/72_FoodLogs.py')

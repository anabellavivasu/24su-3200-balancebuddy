import logging
import streamlit as st
from modules.nav import SideBarLinks

logger = logging.getLogger(__name__)

st.set_page_config(layout='wide')

# Show appropriate sidebar links for the role of the currently logged-in user
SideBarLinks()

st.title(f"Welcome, Adam.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('Food Log', type='primary', use_container_width=True):
    st.switch_page('pages/41_Food_Log.py')

if st.button('Exercise Log', type='primary', use_container_width=True):
    st.switch_page('pages/42_Exercise_Log.py')


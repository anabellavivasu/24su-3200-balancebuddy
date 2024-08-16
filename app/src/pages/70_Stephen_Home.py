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

if st.button('View All Clients', type='primary', use_container_width=True):
    st.switch_page('pages/71_Clients_View.py')

if st.button('Add a New Client', type='primary', use_container_width=True):
    st.switch_page('pages/72_Clients_Add.py')

if st.button('Update Client Info', type='primary', use_container_width=True):
    st.switch_page('pages/73_Clients_Update.py')

if st.button('Delete a Client', type='primary', use_container_width=True):
    st.switch_page('pages/74_Clients_Delete.py')

if st.button('Add a New Food Log', type='primary', use_container_width=True):
    st.switch_page('pages/75_FoodLogs_Add.py')

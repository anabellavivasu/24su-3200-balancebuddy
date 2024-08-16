import logging
logger = logging.getLogger(__name__)
import streamlit as st
from modules.nav import SideBarLinks

SideBarLinks()

st.set_page_config(layout='wide')

st.title(f"Welcome Stephen, {st.session_state['first_name']}.")
st.write("### What would you like to do today?")

if st.button('View All Clients', type='primary', use_container_width=True):
    st.switch_page('pages/clients_view.py')

if st.button('Add New Client', type='primary', use_container_width=True):
    st.switch_page('pages/clients_add.py')

if st.button('Update Client', type='primary', use_container_width=True):
    st.switch_page('pages/clients_update.py')

if st.button('Delete Client', type='primary', use_container_width=True):
    st.switch_page('pages/clients_delete.py')

if st.button('Add New Food Log', type='primary', use_container_width=True):
    st.switch_page('pages/food_logs_add.py')

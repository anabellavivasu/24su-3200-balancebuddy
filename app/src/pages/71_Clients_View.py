import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

logger = logging.getLogger(__name__)

SideBarLinks()

st.write("# View All Clients")

try:
    clients = requests.get('http://api:4000/stephen/clients').json()
    st.dataframe(clients)
except Exception as e:
    st.write("Could not retrieve clients. Please check the API connection.")
    logger.error(f"Error retrieving clients: {e}")

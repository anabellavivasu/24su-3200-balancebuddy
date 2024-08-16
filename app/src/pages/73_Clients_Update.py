import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

logger = logging.getLogger(__name__)

st.set_page_config(layout='wide')

SideBarLinks()

st.title('Update Client Information')

client_id = st.text_input("Enter Client ID:")

with st.form("Update Client Info"):
    client_name = st.text_input("Input Updated Client Name:")
    client_age = st.number_input("Input Updated Client Age:", min_value=0, max_value=120, step=1)
    client_gender = st.selectbox("Select Updated Client Gender:", options=["Male", "Female", "Other"])
    client_goal = st.text_input("Input Updated Client Goal:")
    client_dietary_preferences = st.text_input("Input Updated Dietary Preferences:")

    submitted = st.form_submit_button("Update")

if submitted:
    data = {
        'name': client_name,
        'age': client_age,
        'gender': client_gender,
        'goal': client_goal,
        'dietary_preferences': client_dietary_preferences
    }
    try:
        response = requests.put(f'http://api:4000/stephen/clients/{client_id}', json=data)
        st.write("Client updated successfully!" if response.ok else "Failed to update client.")
    except Exception as e:
        st.write("Could not connect to the API to update the client.")
        logger.error(f"Error updating client: {e}")

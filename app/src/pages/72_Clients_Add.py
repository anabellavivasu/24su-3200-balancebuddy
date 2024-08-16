import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

logger = logging.getLogger(__name__)

SideBarLinks()

st.write("# Add a New Client")

with st.form("Create a New Client"):
    client_name = st.text_input("Input Client Name:")
    client_age = st.number_input("Input Client Age:", min_value=0, max_value=120, step=1)
    client_gender = st.selectbox("Select Client Gender:", options=["Male", "Female", "Other"])
    client_goal = st.text_input("Input Client Goal:")
    client_dietary_preferences = st.text_input("Input Dietary Preferences:")

    submitted = st.form_submit_button("Submit")

if submitted:
    data = {
        'name': client_name,
        'age': client_age,
        'gender': client_gender,
        'goal': client_goal,
        'dietary_preferences': client_dietary_preferences
    }
    try:
        response = requests.post('http://api:4000/stephen/clients', json=data)
        st.write("Client added successfully!" if response.ok else "Failed to add client.")
    except Exception as e:
        st.write("Could not connect to the API to add the client.")
        logger.error(f"Error adding client: {e}")

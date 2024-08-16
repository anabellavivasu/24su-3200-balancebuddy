import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

logger = logging.getLogger(__name__)

SideBarLinks()

st.write("# Add a New Food Log Entry")

with st.form("Create a New Food Log"):
    client_id = st.text_input("Input Client ID:")
    food_item = st.text_input("Input Food Item:")
    calories = st.number_input("Input Calories:", min_value=0)
    meal_time = st.text_input("Input Meal Time:")

    submitted = st.form_submit_button("Submit")

if submitted:
    data = {
        'client_id': client_id,
        'food_item': food_item,
        'calories': calories,
        'meal_time': meal_time
    }
    try:
        response = requests.post('http://api:4000/stephen/food_log', json=data)
        st.write("Food log entry added successfully!" if response.ok else "Failed to add food log entry.")
    except Exception as e:
        st.write("Could not connect to the API to add the food log entry.")
        logger.error(f"Error adding food log entry: {e}")

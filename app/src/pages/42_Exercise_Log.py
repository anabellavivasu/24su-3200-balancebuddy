import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Set up the page layout
st.set_page_config(layout='wide')
logger = logging.getLogger(__name__)

# Display the sidebar links
SideBarLinks()

# View All Exercises
st.write('# View Exercise Log')
if st.button("Load Exercise Log"):
    response = requests.get('http://api:4000/a/viewexerciselog').json()
    try: 
        st.dataframe(response)
    except:
        st.write("Could not connect to database to get engagement")

st.write('# Add a New Exercise Log Entry')

# Add an Exercise Entry
with st.form("Create a New Exercise Log"):
    el_user_id = st.text_input("Input your User ID:")
    el_breaths_per_minute = st.number_input("Input Breaths per Minute:")
    el_BMI = st.number_input("Input BMI:")
    el_weight = st.number_input("Input Weight:")
    el_height = st.number_input("Input Height:")
    el_max_HR = st.number_input("Input Max HR:")
    el_exercise_pages = st.text_input("Input Comments:")

    submitted = st.form_submit_button("Submit")

if submitted:
    data = {}
    data['user_id'] = el_user_id
    data['breaths_per_minute'] = el_breaths_per_minute
    data['BMI'] = el_BMI
    data['weight'] = el_weight
    data['height'] = el_height
    data['max_HR'] = el_max_HR
    data['exercise_pages'] = el_exercise_pages

    response = requests.post('http://api:4000/a/exercises', json=data)

    if response.status_code == 200:
        st.success("Exercise Log added successfully!")
    else:
        st.error("Failed to add Exercise Log.")
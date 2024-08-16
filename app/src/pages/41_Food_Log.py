import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Set up the page layout
st.set_page_config(layout='wide')
logger = logging.getLogger(__name__)

# Display the sidebar links
SideBarLinks()

# View All Food Logs
st.write('# View Food Log')
if st.button("Load Food Log"):
    response = requests.get('http://api:4000/a/viewfoodlog').json()
    try: 
        st.dataframe(response)
    except:
        st.write("Could not connect to database to get engagement")

st.write('# Add a New Food Log Entry')

# Add a Food Log Entry
with st.form("Create a New Food Log"):
    fl_date = st.text_input("Input Date (YYYY/MM/DD):")
    fl_meal_type = st.text_input("Input Meal Type:")
    fl_comments = st.text_input("Input Comments:")
    fl_food_items = st.text_input("Input Food Items:")
    fl_calories = st.number_input("Input Calories:", min_value=0)
    fl_client_id = st.text_input("Input your User ID to Confirm:")

    submitted = st.form_submit_button("Submit")

if submitted:
    data = {}
    data['date'] = fl_date
    data['meal_type'] = fl_meal_type
    data['comments'] = fl_comments
    data['food_items'] = fl_food_items
    data['calories'] = fl_calories
    data['client_id'] = fl_client_id

    response = requests.post('http://api:4000/a/food_logs', json=data)

    if response.status_code == 200:
        st.success("Food Log added successfully!")
    else:
        st.error("Failed to add Food Log.")



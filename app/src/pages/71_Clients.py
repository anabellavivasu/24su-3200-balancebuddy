import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Set up the page layout
st.set_page_config(layout='wide')
logger = logging.getLogger(__name__)

# Display the sidebar links
SideBarLinks()

# Page title
st.title("Client Management")

# Section 1: Add a New Client
st.write("### Add a New Client")
with st.form("add_client_form"):
    client_name = st.text_input("Client Name")
    client_age = st.number_input("Client Age", min_value=1)
    client_gender = st.selectbox("Client Gender", ["Male", "Female", "Other"])
    client_goal = st.text_input("Client Goal")
    client_dietary_preferences = st.text_input("Dietary Preferences")

    submit_client = st.form_submit_button("Add Client")
    
if submit_client:
    data = {
        'name': client_name,
        'age': client_age,
        'gender': client_gender,
        'goal': client_goal,
        'dietary_preferences': client_dietary_preferences
    }
    response = requests.post('http://api:4000/clients', json=data)
    if response.status_code == 200:
        st.success("Client added successfully!")
    else:
        st.error("Failed to add client.")

# Section 2: View All Clients
st.write("### View All Clients")
if st.button("Load Clients"):
    response = requests.get('http://api:4000/clients')
    if response.status_code == 200:
        clients = response.json()
        if clients:
            st.write(clients)
        else:
            st.write("No clients found.")
    else:
        st.error("Failed to load clients.")

# Section 3: Update a Client
st.write("### Update a Client")
with st.form("update_client_form"):
    client_id = st.text_input("Client ID")
    client_name = st.text_input("Updated Client Name")
    client_age = st.number_input("Updated Client Age", min_value=1)
    client_gender = st.selectbox("Updated Client Gender", ["Male", "Female", "Other"])
    client_goal = st.text_input("Updated Client Goal")
    client_dietary_preferences = st.text_input("Updated Dietary Preferences")

    submit_update = st.form_submit_button("Update Client")
    
if submit_update:
    data = {
        'name': client_name,
        'age': client_age,
        'gender': client_gender,
        'goal': client_goal,
        'dietary_preferences': client_dietary_preferences
    }
    response = requests.put(f'http://api:4000/clients/{client_id}', json=data)
    if response.status_code == 200:
        st.success("Client updated successfully!")
    else:
        st.error("Failed to update client.")

# Section 4: Delete a Client
st.write("### Delete a Client")
with st.form("delete_client_form"):
    client_id = st.text_input("Client ID to Delete")

    submit_delete = st.form_submit_button("Delete Client")
    
if submit_delete:
    data = {'client_id': client_id}
    response = requests.delete(f'http://api:4000/clients/delete', json=data)
    if response.status_code == 200:
        st.success("Client deleted successfully!")
    else:
        st.error("Failed to delete client.")

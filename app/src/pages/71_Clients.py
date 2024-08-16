import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

# Set up the page layout
st.set_page_config(layout='wide')
logger = logging.getLogger(__name__)

# Display the sidebar links
SideBarLinks()

# Section 1: Add a New Client
st.write("# Add a New Client")
with st.form("add_client_form"):
    client_name = st.text_input("Client Name: ")
    client_age = st.number_input("Client Age: ", min_value=1)
    client_gender = st.selectbox("Client Gender: ", ["Male", "Female", "Other"])
    client_contact = st.text_input("Client Contact Num:")
    client_dietary_preferences = st.text_input("Dietary Preferences: ")
    client_health_goal = st.text_input("Client Goal:")
    client_dietary_restrictions = st.text_input("Dietary Restrictions: ")
    client_user_id = st.number_input("Client's User ID: ")

    submit_client = st.form_submit_button("Add Client")
    
if submit_client:
    data = {}
    data['name'] = client_name
    data['age'] = client_age
    data['gender'] = client_gender
    data['contact'] = client_contact
    data['dietary_preferences'] = client_dietary_preferences
    data['health_goal'] = client_health_goal
    data['dietary_restrictions'] = client_dietary_restrictions
    data['user_id'] = client_user_id
    
    response = requests.post('http://api:4000/s/clients', json=data)

    if response.status_code == 200:
        st.success("Client added successfully!")
    else:
        st.error("Failed to add client.")

# Section 2: View All Clients
st.write("# View All Clients")
if st.button("Load Clients"):
    response = requests.get('http://api:4000/s/viewclients').json()
    try: 
        st.dataframe(response)
    except:
        st.write("Could not connect to database to get engagement")

# Section 3: Update a Client
st.write("# Update a Client")
st.write("## Inpute new info for fields you want to change. For the rest, input same info.")
with st.form("update_client_form"):
    client_id = st.text_input("Input the Client's ID: ")
    client_name = st.text_input("Updated Client Name: ")
    client_age = st.number_input("Updated Client Age: ", min_value=1)
    client_gender = st.selectbox("Updated Client Gender: ", ["Male", "Female", "Other"])
    client_contact = st.text_input("Updated Client Contact Num: ")
    client_dietary_preferences = st.text_input("Updated Dietary Preferences: ")
    client_health_goal = st.text_input("Updated Client Goal: ")
    client_dietary_restrictions = st.text_input("Updated Dietary Restrictions: ")
    client_user_id = st.number_input("Input Client's User ID to Confirm: ")

    submit_update = st.form_submit_button("Update Client")
    
if submit_update:
    data = {}
    data['client_id'] = client_id
    data['name'] = client_name
    data['age'] = client_age
    data['gender'] = client_gender
    data['contact'] = client_contact
    data['dietary_preferences'] = client_dietary_preferences
    data['health_goal'] = client_health_goal
    data['dietary_restrictions'] = client_dietary_restrictions
    data['user_id'] = client_user_id

    response = requests.put('http://api:4000/s/update_client', json=data)
    
    if response.status_code == 200:
        st.success("Client updated successfully!")
    else:
        st.error("Failed to update client.")

# Section 4: Delete a Client
st.write("# Delete a Client")
st.write("## Note: This Action cannot be Reversed")
with st.form("delete_client_form"):
    client_id = st.text_input("Input Client ID: ")

    submit_delete = st.form_submit_button("Delete Client")
    
if submit_delete:
    data = {}
    data['client_id'] = client_id
    response = requests.delete(f'http://api:4000/s/delete', json=data)
    if response.status_code == 200:
        st.success("Client deleted successfully!")
    else:
        st.error("Failed to delete client.")

import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

logger = logging.getLogger(__name__)

st.set_page_config(layout='wide')

SideBarLinks()

st.title('Delete a Client')
st.write("## Note: This action cannot be reversed!")

client_id = st.text_input("Input Client ID to Delete:")

if st.button("Delete Client"):
    data = {'client_id': client_id}
    try:
        response = requests.delete(f'http://api:4000/stephen/clients/delete', json=data)
        st.write("Client deleted successfully!" if response.ok else "Failed to delete client.")
    except Exception as e:
        st.write("Could not connect to the API to delete the client.")
        logger.error(f"Error deleting client: {e}")

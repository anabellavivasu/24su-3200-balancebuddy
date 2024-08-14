import logging
logger = logging.getLogger(__name__)
import streamlit as st
import requests
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# More API Access Examples")

st.write("## Creating a New Product")

with st.form("Create a New Product"):
    prod_name = st.text_input("Input New Product Name:")
    prod_descr = st.text_area("Description:")
    prod_category = st.text_input("Category:")
    list_price = st.number_input("List Price:")

    submitted = st.form_submit_button("Submit")

if submitted:
    data = {}
    data['product_name'] = prod_name
    data['product_description'] = prod_descr
    data['product_category'] = prod_category
    data['product_price'] = list_price
    st.write(data)

    requests.post('http://api:4000/p/product', json=data)


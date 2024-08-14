import streamlit as st
from streamlit_extras.app_logo import add_logo
from modules.nav import SideBarLinks

SideBarLinks()

st.write("# About BalanceBuddy")

st.markdown (
    """
    Our project, Balance Buddy, aims to develop a comprehensive fitness and nutrition tracker application 
    tailored for health-conscious individuals, fitness enthusiasts, professional trainers, and health companies. 
    """
        )

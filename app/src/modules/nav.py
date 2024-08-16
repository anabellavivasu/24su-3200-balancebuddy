# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

import streamlit as st

#### ------------------------ General ------------------------
def HomeNav():
    st.sidebar.page_link("Home.py", label="Home", icon='🏠')

def AboutPageNav():
    st.sidebar.page_link("pages/30_About.py", label="About", icon="🧠")

## ------------------------ Role of Marketing Director John ------------------------
def JohnHomeNav():
    st.sidebar.page_link("pages/60_John_home.py", label="John Home", icon='🏠')

def AdsJohn():
    st.sidebar.page_link("pages/61_Ad_View.py", label="Ads", icon='📝')

def MarketResearchJohn():
    st.sidebar.page_link("pages/62_Market_Research.py", label="Market Research", icon='📈')

## ------------------------ Role of Student Adam ------------------------
def AdamHomeNav():
    st.sidebar.page_link("pages/40_Adam_Home.py", label="Adam Home", icon='🏠')

def FoodLogAdam():
    st.sidebar.page_link("pages/41_Food_Log.py", label="Food Log", icon='🍏')

def ExerciseLogAdam():
    st.sidebar.page_link("pages/42_Exercise_Log.py", label="Exercise Log", icon='💪')

## ------------------------ Role of Nutritionist Stephen ------------------------
def StephenHomeNav():
    st.sidebar.page_link("pages/70_Stephen_Home.py", label="Stephen Home", icon='🏠')

def Clients():
    st.sidebar.page_link("pages/71_Clients.py", label="Clients", icon='💼')

def FoodLogs():
    st.sidebar.page_link("pages/72_FoodLogs.py", label="Food Logs", icon='🍏')

## ------------------------ Role of Advertiser ------------------------
def AdvertiserHomeNav():
    st.sidebar.page_link("pages/80_Livefit_Home.py", label="Advertiser Home", icon='🏠')

def Audiences():
    st.sidebar.page_link("pages/81_Audiences.py", label="Create Audience", icon='👥')

def Ads():
    st.sidebar.page_link("pages/82_Ads.py", label="Create/Delete Ad", icon='📝')

def Engagement():
    st.sidebar.page_link("pages/83_Engagement.py", label="View Engagement", icon='📈')

# --------------------------------Links Function -----------------------------------------------
def SideBarLinks(show_home=False):
    """
    This function handles adding links to the sidebar of the app based upon the logged-in user's role, which was put in the streamlit session_state object when logging in. 
    """    

    # add a logo to the sidebar always
    st.sidebar.image("assets/logo.png", width=150, use_column_width=True)

    # If there is no logged in user, redirect to the Home (Landing) page
    if 'authenticated' not in st.session_state:
        st.session_state.authenticated = False
        st.switch_page('Home.py')
        
    if show_home:
        # Show the Home page link (the landing page)
        HomeNav()

    # Show the other page navigators depending on the users' role.
    if st.session_state["authenticated"]:

        # Show John functions if the user is a Marketing Director.
        if st.session_state['role'] == 'marketing_director':
            JohnHomeNav()
            AdsJohn()
            MarketResearchJohn()     

        # Show Adam functions if the user is a Student.
        if st.session_state['role'] == 'student':
            AdamHomeNav()
            FoodLogAdam()
            ExerciseLogAdam()

        # Show Stephen functions if the user is a Nutritionist.
        if st.session_state['role'] == 'nutritionist':
            StephenHomeNav()
            Clients()
            FoodLogs() 

        # Show Livefit functions if the user is an Advertiser.
        if st.session_state['role'] == 'advertiser':
            AdvertiserHomeNav()
            Audiences()
            Ads()
            Engagement()       

    # Always show the About page at the bottom of the list of links
    AboutPageNav()

    if st.session_state["authenticated"]:
        # Always show a logout button if there is a logged in user
        if st.sidebar.button("Logout"):
            del st.session_state['role']
            del st.session_state['authenticated']
            st.switch_page('Home.py')


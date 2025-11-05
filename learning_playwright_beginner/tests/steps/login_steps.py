# Import required decorators from behave for step definitions
from behave import given, when, then
# Import Playwright's sync API components for browser automation
from playwright.sync_api import Page, expect

@given('the user on the login page')
def step_impl(context):
    """
    First step that runs when the scenario starts.
    Sets up the browser page and navigates to the login page.
    
    Args:
        context: Behave context object that shares state between steps
    """
    # Create a new browser page if one doesn't exist
    # context.browser is provided by behave-playwright fixture
    if not hasattr(context, 'page'):
        context.page = context.browser.new_page()
    
    # Navigate to the application's login page
    # TODO: Update URL to match your application's login page
    context.page.goto('http://localhost:3000')
    
    # Verify that we've landed on the login page by checking the page title
    # TODO: Update the title to match your application's login page title
    expect(context.page).to_have_title("Login")

@when('user enters {username} and {password}')
def step_impl(context, username, password):
    """
    Fills in the login form with provided credentials.
    
    Args:
        context: Behave context object
        username: Username from the Examples table in feature file
        password: Password from the Examples table in feature file
    """
    # Fill in the username field
    # TODO: Update selector to match your username input field
    context.page.fill('#login-username]', username)
    
    # Fill in the password field
    # TODO: Update selector to match your password input field
    context.page.fill('[name="password"]', password)

@when('clicks on the login button')
def step_impl(context):
    """
    Clicks the login button to submit the form.
    
    Args:
        context: Behave context object
    """
    # Click the login/submit button
    # TODO: Update selector to match your login button
    context.page.click('button[type="submit"]')

@then('user should be logged in successfully')
def step_impl(context):
    """
    Verifies that the login was successful by checking for:
    1. Presence of user profile element
    2. Correct URL after redirect
    
    Args:
        context: Behave context object
    """
    # Verify that user profile element is visible after login
    # TODO: Update selector to match your user profile element
    expect(context.page.locator('.user-profile')).to_be_visible()
    
    # Verify we're redirected to the dashboard/home page
    # TODO: Update URL to match your application's dashboard page
    expect(context.page).to_have_url("http://localhost:3000/dashboard")
    
import os
from flask import Flask, render_template, request, redirect, url_for
import subprocess

app = Flask(__name__)

# Define the folders and script paths
SEND_FOLDER = os.path.join(os.getcwd(), "sent_messages")
RECEIVE_FOLDER = os.path.join(os.getcwd(), "recived_messages")
refresh_script = os.path.join(os.getcwd(), "receiveMessages.au3")
send_script = os.path.join(os.getcwd(), "sendMessage.au3")
full_refresh_script = os.path.join(os.getcwd(), "fullRefresh.au3")
script_running = False
status_script = os.path.join(os.getcwd(), "updateStatus.au3")

def run_autoit_script(script_path, dm_number=None):
    global script_running
    
    # Check if a script is already running
    if script_running:
        print("A script is already running. Please wait until it finishes.")
        return

    # Set the lock
    script_running = True
    try:
        command = ["C:\\Program Files (x86)\\AutoIt3\\AutoIt3.exe", script_path]
        if dm_number is not None:
            command.append(str(dm_number))  # Pass the DM number as a string

        subprocess.run(command, check=True)
    finally:
        # Release the lock once the script finishes
        script_running = False

@app.route('/')
def index():
    # Check if the "received messages" folder is empty
    if not any(os.listdir(RECEIVE_FOLDER)):
        # Run the full refresh script if the folder is empty
        run_autoit_script(full_refresh_script)

    dm_number = request.args.get('dm', '1')  # Default to DM 1 if no DM is selected
    dm_content = ""

    # Load the selected DM's messages
    file_path = os.path.join(RECEIVE_FOLDER, f"{dm_number}.txt")
    if os.path.exists(file_path):
        with open(file_path, 'r', encoding='utf-8') as f:
            dm_content = f.read()

    return render_template('index.html', dm_number=dm_number, dm_content=dm_content)

@app.route('/refresh', methods=['POST'])
def refresh():
    dm_number = request.form.get('dm', '1')  # Default to DM 1 if not provided
    
    # Clear DM message file only
    file_path = os.path.join(RECEIVE_FOLDER, f"{dm_number}.txt")
    if os.path.exists(file_path):
        os.remove(file_path)
    
    # Run the refresh script when the refresh button is clicked
    run_autoit_script(refresh_script, dm_number)
    
    return redirect(url_for('index', dm=dm_number))  # Redirect back to the same DM view

@app.route('/refresh-full', methods=['POST'])
def refreshFull():
    # Clear all received message files
    for i in range(1, 10):
        file_path = os.path.join(RECEIVE_FOLDER, f"{i}.txt")
        if os.path.exists(file_path):
            os.remove(file_path)
    # Run the refresh script when the refresh button is clicked
    run_autoit_script(full_refresh_script)
    return redirect(url_for('index'))

@app.route('/send', methods=['POST'])
def send_message():
    # Get the message and the DM number from the form
    text_data = request.form['text_data']
    dm_number = request.form['dm_number']
    print(dm_number)
    # Clear DM message file and previous send files
    og_DM = os.path.join(RECEIVE_FOLDER, f"{dm_number}.txt")
    first_DM = os.path.join(RECEIVE_FOLDER, f"1.txt")
    if os.path.exists(og_DM):
        os.remove(og_DM)
    if os.path.exists(first_DM):
        os.remove(first_DM)
        
    for i in range(9):
        file_path = os.path.join(SEND_FOLDER, f"{i}.txt")
        if os.path.exists(file_path):
            os.remove(file_path)
    
    # Save the message to the corresponding file
    file_path = os.path.join(SEND_FOLDER, f"{dm_number}.txt")
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(text_data)

    # Run the send AutoIt script with the current DM number
    run_autoit_script(send_script)  # Pass the dm_number here

    # Run the refresh script to update received messages
    run_autoit_script(refresh_script, 1)

    return redirect(url_for('index', dm=1))

@app.route('/update-status', methods=['POST'])
def update_status():
    # Get the status text from the form
    status_text = request.form['status_text']
    
    # Save the status as a .txt file
    file_path = os.path.join(os.getcwd(), "status.txt")
    with open(file_path, 'w', encoding='utf-8') as f:
        f.write(status_text)
    
    # Run the AutoIt script to update the status
    run_autoit_script(status_script)
    
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)

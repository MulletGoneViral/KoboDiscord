from flask import Flask, render_template, request, redirect, url_for, send_file
import os
import subprocess

app = Flask(__name__)

# Define the folder to save the text files
SEND_FOLDER = os.path.join(os.getcwd(), "saved_files")
RECIVE_FOLDER = os.path.join(os.getcwd(), "recived_messages")
if not os.path.exists(SEND_FOLDER):
    os.makedirs(SEND_FOLDER)
if not os.path.exists(RECIVE_FOLDER):
    os.makedirs(RECIVE_FOLDER)
    
# Define paths to the AutoIt scripts
refresh = r"C:\path\to\KoboDiscord\receiveMessages.au3"
send = r"C:\path\to\KoboDiscord\sendMessage.au3"

def run_autoit_script(script_path):
    """Run the AutoIt script using AutoIt executable."""
    subprocess.run(["C:\\Program Files (x86)\\AutoIt3\\AutoIt3.exe", script_path], check=True)

@app.route('/')
def index():
    # Get the name of the file if it exists (only one file should be in the folder)
    files = [f for f in os.listdir(SEND_FOLDER) if f.endswith('.txt')]
    file_name = files[0] if files else None
    return render_template('index.html', file_name=file_name)

@app.route('/refresh')
def refresh():
    """Run the 'on start' AutoIt script again."""
    for i in range(9):
        file_path = os.path.join(os.getcwd(), "recived_messages", f"{i}.txt")  # Convert i to a string
        if os.path.exists(file_path):  # Check if the file exists before removing it
            os.remove(file_path)
        else:
            print(f"File not found: {file_path}")
    run_autoit_script(refresh)
    return redirect(url_for('index'))

@app.route('/save', methods=['POST'])
def save_file():
    # Get the text from the form input
    text_data = request.form['text_data']
    file_name = request.form['file_name']

    # Remove any existing files in the folder
    for old_file in os.listdir(SEND_FOLDER):
        old_file_path = os.path.join(SEND_FOLDER, old_file)
        if os.path.isfile(old_file_path):
            os.remove(old_file_path)

    # Save the new file
    file_path = os.path.join(SEND_FOLDER, f"{file_name}.txt")
    with open(file_path, "w") as file:
        file.write(text_data)
        
    # Run send script when a file is saved
    run_autoit_script(send)

    return redirect(url_for('index'))

@app.route('/<path:req_path>')
def dir_listing(req_path):
    BASE_DIR = r'path\to\KoboDiscord'
    abs_path = os.path.join(BASE_DIR, req_path)

    # Render 404
    if not os.path.exists(abs_path):
        return render_template('404.html')

    # Check if path is a file and serve
    if os.path.isfile(abs_path):
        return send_file(abs_path)

    # Show directory contents
    files = os.listdir(abs_path)
    return render_template('files.html', files=files)


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000, debug=True)

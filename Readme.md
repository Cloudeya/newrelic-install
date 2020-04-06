## MindHug Marketing Site

### Development

- Install [Homebrew](https://brew.sh/) on your local machine.

- Install Python3 if you haven't already, then verify the installation.
```bash
brew install python3 && python3 --version
```

- Install virtualEnv so you can isolate Python environments.
```bash
sudo pip3 install virtualenv
```

- Go to your MindHug directory (**yours might be different!**) and create virtualenv with python 3.
```bash
cd ~/projects/MindHug && virtualenv venv -p python3
```

- Activate virtualenv.
```bash
# Activate
source venv/bin/activate

# Exit venv with the following command
deactivate
```

- Install project's dependencies.
```bash
pip3 install -r requirements.txt
```

- Run app.
```bash
python3 main.py
```

* Site is served here: `http://127.0.0.1:8080`

### Production Deployment (Google App Engine)

`https://console.cloud.google.com/home/dashboard?project=mindhug-marketing-site`

- Click the shell icon 'Activate Cloud Shell' in the top right

- Type in the shell at the bottom of the window:
```bash
cd MindHug
gcloud app deploy app.yml --project mindhug-marketing-site
```

### License

The script is published under [BSD 3-Clause License](license.txt).

### Copyright

(c) 2020 [MindHug Ltd](https://www.mindhug.io).

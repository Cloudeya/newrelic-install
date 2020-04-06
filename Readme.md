## MindHug Marketing Site
We help find what works best for their happiness and wellbeing. We do this by harnessing the familiarity of community and the power of digital.

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

#Site is served here: **http://127.0.0.1:8080**
```


### Production Deployment (Google App Engine)

- Install Google Cloud SDK
```bash
brew cask install google-cloud-sdk
```

- Follow the setup and deployment guide [here](https://cloud.google.com/sdk/docs/quickstart-macos)

- Deploy the app
```bash
gcloud app deploy app.yml --project mindhug-marketing-site
```

### License

The script is published under [BSD 3-Clause License](license.txt).

### Copyright

(c) 2020 [MindHug Ltd](https://www.mindhug.io).

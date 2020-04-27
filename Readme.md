## MindHug Marketing Site
We help find what works best for their happiness and wellbeing. We do this by harnessing the familiarity of community and the power of digital.

### 🧱 Development

- Install [Homebrew](https://brew.sh/) on your local machine.

- Install Python3 if you haven't already, then verify the installation
```bash
brew install python3 && python3 --version
```

- Pipenv Workflow
```bash
brew install pipenv

# Install from Pipevn
pipenv install

# Add a new package

pipenv install <package>

# Check outdate packages
pipenv update --outdated

# Update installed packages
pipenv update

# Update a specific package
pipenv update <pkg>
```

- Install virtualEnv so you can isolate Python environments
```bash
sudo pip3 install virtualenv
```

- Go to your MindHug directory (**yours might be different!**) and create virtualenv with python 3
```bash
cd ~/projects/MindHug && virtualenv venv -p python3
```

- Activate virtualenv
```bash
# Activate
source venv/bin/activate

# Exit venv with the following command
deactivate
```

- Dockerize the app
```bash
make build
```

- Launch a development instance
```bash
make dev
```

- Deploy image to GCP Container Storage
```bash
make deploy
```

- Clean up after yourself!
```bash
make clean
```

### 🚀 Development, Testing, Staging, and Production Strategy

[Google Cloud Build](https://cloud.google.com/cloud-build) handles our pipelines, and as such, pushing or merging into the `master` branch will initiate deployment to live site. **DON'T DO IT WITHOUT PERMISSION!**

Remember to check out the `dev` branch on your local machine, work exclusively in there and push your changes to the project repository. Then, ask [Finbarrs](https://github.com/0xnu) to review your changes or PR (Pull Request), so he can merge it into the `qa` branch for our QA Tester(s). We'll use the `staging` branch to demo our work to internal stakeholders before making them live to end-users.


### 🤵 Authors

- **Rajveer Beerda** _aka rajveerbeerda_ - _Main Developer_ - [rajveerbeerda](https://github.com/rajveerbeerda)
- **Finbarrs Oketunji** _aka 0xnu_ - _Main Developer_ - [0xnu](https://github.com/0xnu)
- **Manmeet Sethi** _aka ManmeetSethi_ - _Main Developer_ - [ManmeetSethi](https://github.com/ManmeetSethi)

### 🖋 License

The script is published under [BSD 3-Clause License](license.txt).

### 🤝 Copyright

(c) 2020 [MindHug Ltd](https://www.mindhug.io).

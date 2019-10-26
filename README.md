# MLB 2018 Standings Roku channel
Displays 2018 team standings, separated by dvision and league


## Setup
### Quick
Download the prepackaged relase on github and install as normal on a Roku device
### Full

1. install ukor: `npm i -g @willowtreeapps/ukor`
2. run `ukor make` to make all flavors
3. install the desired {flavor}.zip located in `/build` directory through the development interface

4. (optional) install with ukor
   - make a `ukor.local.yaml` and add your own roku like the example below
   - run `ukor install {flavor} {rokuName}`
```
rokus: 
  premiere:
    serial: 'SERIAL123456'
    auth: 
      user: 'rokudev'
      pass: 'yourpassword'
```

## Flavors
- main: 
  - base flavor, use by default
- debug:
  - adds the TrackerTask for the Advanced Layout Editor
- test:
  - includes the Roku UnitTestFramework and a few unit tests.
  - see section below
## Tests
install the `test` flavor, then send a POST to launch the tests: 
- `curl -d http://{ip}:8060/launch/dev?RunTests=true -Method POST`
- check the telnet out put on port 8085 of the Roku device to view the results
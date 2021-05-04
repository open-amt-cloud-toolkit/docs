--8<-- "References/abbreviations.md"
# Quickstart - Bundle KVM Control

This document shows how to:

- Run the KVM control in development enviroment
- Create a bundle for KVM control
- Add bundle to a sample HTML file 

## Prerequisites

In order to deploy and make changes, the following tools and application has to be installed on your development machine

- [Git](https://git-scm.com/)
- [Visual Studio Code](https://code.visualstudio.com/) or any other IDE 
- [Node.js](https://nodejs.org/)
- [Chrome* Browser](https://www.google.com/chrome)
- [MPS Server with an AMT Device Connected](../../../Docker/dockerLocal/)


## Download and Install UI Toolkit

1. Open a Terminal (Linux) or Command Prompt (Windows) and navigate to a directory of your choice for development.

2. Clone the UI Toolkit Repository.
	```
	git clone https://github.com/open-amt-cloud-toolkit/ui-toolkit --branch v1.3.0
	```

3. Change to the `ui-toolkit` directory.
	```
	cd ui_toolkit
	```

4. Install the dependencies.
	```
	npm install
	```

## Run in Development Environment

To add and test new changes before bundling the control, use a webpack dev server.

1. Start the server.
	```
	npm start
	```

2. Open a Chrome* browser and navigate to the following link to see changes.
	```
	http://localhost:8080/kvm.htm?deviceId=[AMT-Device-GUID]&mpsServer=https://[MPS-Server-IP-Address]:3000
	```

	!!! note
		By default, the webpack dev server runs on port 8080. If port 8080 is already in use, webpack automatically runs on the next immediate available port.


## Create Bundle

1. To bundle, navigate to the `ui-toolkit` directory in a Terminal (Linux) or Command Prompt (Windows).

2. Remove or rename the existing *kvm.core.min.js*  in the `ui-toolkit/dist/` directory before building.

3. Build the bundle.
	```
	npm run build
	```

	A new *kvm.core.min.js* will be created in the `ui-toolkit/dist/` directory.

	!!! note
		To bundle the KVM control without node_modules, run the following build command instead.
		```
		npm run built-ext
		```
		The bundle generated using the build-ext command can be used in react apps as an independent control


## Add to Sample HTML Page

1. Add the following code snippet to *sampleKVM.htm* in the `ui-toolkit/src/sample/` directory using an editor of your choice.

	```
	<body>
	  <div id="kvm"></div>
	  <script src="../../dist/kvm.core.min.js" crossorigin></script>
	</body>
	```

2. In a Terminal (Linux) or Command Prompt (Windows), navigate to the `ui-toolkit` directory.

3. Serve the HTML page.
	```
	npx serve
	```

4. Open a new Chrome* browser and navigate to the following URL:
	```
	http://localhost:5000/src/sample/sampleKVM.htm?deviceId=[AMT-Device-GUID]&mpsServer=https://[MPS-Server-IP-Address]:3000
	```

You will see errors in the following scenarios: 

- UI-toolkit was not downloaded and installed into your react app
- MPS Server is not running
- MPS Server is running but the device is not connected


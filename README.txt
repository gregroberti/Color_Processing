1) Download and Install Processing IDE:
https://processing.org/download/

2) Download Slider Pro:

	Choice 1: Clone the master branch:
		- Download and Install Git for Windows (or your git client of choice):
				https://git-for-windows.github.io/
		- Type the following into Git Bash:
			git clone https://github.com/gregroberti/Slider-Pro.git

	Choice 2: Download and extract the zip file:
		https://github.com/gregroberti/Slider-Pro/archive/master.zip
	

3) Compile and Upload RGB_X_Arduino.ino to one of your chips:
- Open ~\Color_Processing\RGB_X_Arduino\RGB_X_Arduino.ino
- Compile (to ensure no errors exist)
- Upload (to one of your chips)

4) Open Slider Pro:
- Open ~\Color_Processing\RGB_X_Processing\RGB_X_Processing.pde

5) Set your COM Port (default is "COM5"):
- Update the following line in RGB_X_Processing.pde:
  String com_port = "COM5";
  
6) Run Slider Pro:
- Click Run button (play)


Links for quick reference:
  - Download Git for Windows:
	https://git-for-windows.github.io/

  - Download Processing:
	https://processing.org/download/

  - Color_Processing Git Website:
	https://github.com/gregroberti/Slider-Pro

  - Slider Pro:
	http://osm.codes/web/slider-pro/
<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!--
    Winhweel.js pins and sound example by Douglas McKechie @ www.dougtesting.net
    See website for tutorials and other documentation.

    The MIT License (MIT)

    Copyright (c) 2018 Douglas McKechie

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

    ============================================================================
    Note:
        Tick Sound was recorded by DeepFrozenApps and was downloaded from http://soundbible.com/2044-Tick.html
        It has an attribution 3.0 licence.
-->
<html>
    <head>
    	<!-- <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> -->
    	
        <title>Launch Roulette</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <link rel="stylesheet" href="./CSS/main.css" type="text/css" />
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
        <script type="text/javascript" src="./JS/Winwheel.js"></script>
        <script type="text/javascript" src="./JS/LaunchRoulette.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/latest/TweenMax.min.js"></script>
    </head>
	<body>
		<div align="center">
			<br />
			<table cellpadding="0" cellspacing="0" border="0">
				<tr>
					<td>
						<div class="power_controls">
							<br /> <br />
							<table class="power" cellpadding="10" cellspacing="0">
								<tr>
									<th align="center">Power</th>
								</tr>
								<tr>
									<td width="78" align="center" id="pw3"
										onClick="powerSelected(3);">High</td>
								</tr>
								<tr>
									<td align="center" id="pw2" onClick="powerSelected(2);">Med</td>
								</tr>
								<tr>
									<td align="center" id="pw1" onClick="powerSelected(1);">Low</td>
								</tr>
							</table>
							<br /> <img id="spin_button" src="spin_off.png" alt="Spin"
								onClick="startSpin();" /> <br />
							<br /> &nbsp;&nbsp;<a href="#"
								onClick="resetWheel(); return false;">Play Again</a><br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(reset)
						</div>
					</td>
					<td width="438" height="582" class="the_wheel" align="center"
						valign="center">
						<canvas id="canvas" width="434" height="434">
	                            <p style="color: white" align="center">Sorry, your browser doesn't support canvas. Please try another.</p>
	                        </canvas>
					</td>
				</tr>
			</table>
		</div>
		<div align="center">
			<table id="btnTable" style="width: 50vw; height: 8vh;">
				<colgroup>
					<col style="width: 80%">
					<col style="width: 20%">
				</colgroup>
				<tr>
					<td><input type="text" id="addItemInput" class="input"></td>
					<td><button type="button" class="btn btn-primary" onclick="addItem()">추가</button></td>
					
				</tr>
			</table>
		</div>
	</body>

	<script>
		// Create new wheel object specifying the parameters at creation time.
// 		let segments = [ {
// 			'fillStyle' : '#eae56f',
// 			'text' : '찜닭'
// 		}, {
// 			'fillStyle' : '#89f26e',
// 			'text' : '지하식당'
// 		}, {
// 			'fillStyle' : '#7de6ef',
// 			'text' : '밀면'
// 		}, ]
		
		let segments = [];
	
		for (i = 0; i < segments.length; i++) {
			segments[i].fillStyle = "#"
					+ Math.round(Math.random() * 0xffffff).toString(16);
		};
	
		let numSegments = segments.length;
		let outerRadius = 212;
		let textFontSize = 28;
		let animation = {
			'type' : 'spinToStop',
			'duration' : 15,
			'spins' : 1000,
			'callbackFinished' : alertPrize,
			'callbackSound' : playSound, // Function to call when the tick sound is to be triggered.
			'soundTrigger' : 'pin' // Specify pins are to trigger the sound, the other option is 'segment'.
		};
		let pins = {
			'number' : 16
		};
	
		let theWheel = new Winwheel({
			'numSegments' : numSegments, // Specify number of segments.
			'outerRadius' : 212, // Set outer radius so wheel fits inside the background.
			'textFontSize' : 28, // Set font size as desired.
			'segments' : segments, // Define segments including colour and text.
			'animation' : animation, // Specify the animation to use.
			'pins' : pins
		// Number of pins. They space evenly around the wheel.
		});
	
		// -----------------------------------------------------------------
		// This function is called when the segment under the prize pointer changes
		// we can play a small tick sound here like you would expect on real prizewheels.
		// -----------------------------------------------------------------
		let audio = new Audio('tick.mp3'); // Create audio object and load tick.mp3 file.
	
		function playSound() {
			// Stop and rewind the sound if it already happens to be playing.
			audio.pause();
			audio.currentTime = 0;
	
			// Play the sound.
			audio.play();
		}
	
		// -------------------------------------------------------
		// Called when the spin animation has finished by the callback feature of the wheel because I specified callback in the parameters
		// note the indicated segment is passed in as a parmeter as 99% of the time you will want to know this to inform the user of their prize.
		// -------------------------------------------------------
		function alertPrize(indicatedSegment) {
			// Do basic alert of the segment text.
			// You would probably want to do something more interesting with this information.
			alert(indicatedSegment.text);
		}
	
		// =======================================================================================================================
		// Code below for the power controls etc which is entirely optional. You can spin the wheel simply by
		// calling theWheel.startAnimation();
		// =======================================================================================================================
		let wheelPower = 0;
		let wheelSpinning = false;
	
		// -------------------------------------------------------
		// Function to handle the onClick on the power buttons.
		// -------------------------------------------------------
		function powerSelected(powerLevel) {
			// Ensure that power can't be changed while wheel is spinning.
			if (wheelSpinning == false) {
				// Reset all to grey incase this is not the first time the user has selected the power.
				document.getElementById('pw1').className = "";
				document.getElementById('pw2').className = "";
				document.getElementById('pw3').className = "";
	
				// Now light up all cells below-and-including the one selected by changing the class.
				if (powerLevel >= 1) {
					document.getElementById('pw1').className = "pw1";
				}
	
				if (powerLevel >= 2) {
					document.getElementById('pw2').className = "pw2";
				}
	
				if (powerLevel >= 3) {
					document.getElementById('pw3').className = "pw3";
				}
	
				// Set wheelPower var used when spin button is clicked.
				wheelPower = powerLevel;
	
				// Light up the spin button by changing it's source image and adding a clickable class to it.
				document.getElementById('spin_button').src = "spin_on.png";
				document.getElementById('spin_button').className = "clickable";
			}
		}
	
		// -------------------------------------------------------
		// Click handler for spin button.
		// -------------------------------------------------------
		function startSpin() {
			// Ensure that spinning can't be clicked again while already running.
			if (wheelSpinning == false) {
				// Based on the power level selected adjust the number of spins for the wheel, the more times is has
				// to rotate with the duration of the animation the quicker the wheel spins.
				if (wheelPower == 1) {
					theWheel.animation.spins = 3;
				} else if (wheelPower == 2) {
					theWheel.animation.spins = 8;
				} else if (wheelPower == 3) {
					theWheel.animation.spins = 15;
				}
	
				// Disable the spin button so can't click again while wheel is spinning.
				document.getElementById('spin_button').src = "spin_off.png";
				document.getElementById('spin_button').className = "";
	
				// Begin the spin animation by calling startAnimation on the wheel object.
				theWheel.startAnimation();
	
				// Set to true so that power can't be changed and spin button re-enabled during
				// the current animation. The user will have to reset before spinning again.
				wheelSpinning = true;
			}
		}
	
		// -------------------------------------------------------
		// Function for reset button.
		// -------------------------------------------------------
		function resetWheel() {
			theWheel.stopAnimation(false); // Stop the animation, false as param so does not call callback function.
			theWheel.rotationAngle = 0; // Re-set the wheel angle to 0 degrees.
			theWheel.draw(); // Call draw to render changes to the wheel.
	
			//document.getElementById('pw1').className = "";  // Remove all colours from the power level indicators.
			//document.getElementById('pw2').className = "";
			//document.getElementById('pw3').className = "";
	
			wheelSpinning = false; // Reset to false to power buttons and spin can be clicked again.
	
			// ì¤í ë²í¼ íì±í
			document.getElementById('spin_button').src = "spin_on.png";
			document.getElementById('spin_button').className = "clickable";
		}
	</script>
</html>

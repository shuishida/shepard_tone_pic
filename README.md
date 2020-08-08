# Shepard Tone Generator for PIC

Playing Shepard Tone on a PIC microcontroller.
There are three assembly code, each to be written into a PIC16F628A microcontroller.

- `tone_generator.asm`: code for the PIC that generates the Shepard Tone
- `tone_display.asm`: code for the PIC that displays the track number
- `track_selector.asm`: code for the PIC that selects the track number

For more details and explanations, please refer to [this article](https://medium.com/tech-to-inspire/how-counting-in-binary-numbers-can-cause-auditory-illusions-4f01646e09bd).

The program expects the following circuit:
![Circuit](https://raw.githubusercontent.com/shuishida/shepard_tone_pic/master/circuit.png)
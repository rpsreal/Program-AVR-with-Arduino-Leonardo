# Program-AVR-with-Arduino-Leonardo
Program AVR with Arduino Leonardo in Linux

You can use arduino Leonardo to program AVR microcontrolers. Follow these steps:
1º - Execute the file 'setup.sh'. Write 'sudo sh setup.sh' in the terminal.
2º - Open 'leonardoISP.ino' with Arduino IDE.
3º - Upload the file to Arduino Leonardo
4º - Conect the microcontroler to leonardo:

microcontroler AVR    Arduino Leonardo:
  slave reset                 10
    MOSI                     ICSP 4
    MISO                     ICSP 1
    SCK                      ICSP 3

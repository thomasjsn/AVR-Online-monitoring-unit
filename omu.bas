'--------------------------------------------------------------
'                   Thomas Jensen | stdout.no
'--------------------------------------------------------------
'  file: AVR_OMU
'  date: 30/07/2006
'--------------------------------------------------------------
$regfile = "attiny2313.dat"
$crystal = 8000000
$baud = 9600
Config Portb = Input
Config Portd.5 = Input
Config Portd.6 = Input
Config Porta.0 = Input
Config Porta.1 = Input
Config Portd.2 = Output
Config Portd.3 = Output
Config Portd.4 = Output
Config Watchdog = 1024

'inn
'PB0: Sikringsfeil
'PB1: Spenningsfeil
'PB2: Serverfeil
'PB3: Overtemp
'PB4: Vifte
'PB5: Modul feil
'PB6: Dør
'PB7: Mute
'PD5: Belysning
'PD6: Lys
'PA0: Sub
'PA1: Aux

'ut
'PD0: Rx
'PD1: Tx
'PD2: Lifesignal
'PD3: RS485
'PD4: Link activity

Dim Lifesignal As Integer , Life As Integer
Dim Inn1 As Integer , Inn2 As Integer , Inn3 As Integer
Dim Inn4 As Integer , Inn5 As Integer , Inn6 As Integer
Dim Inn7 As Integer , Inn8 As Integer , Inn9 As Integer
Dim Inn10 As Integer , Inn11 As Integer , Inn12 As Integer

Portd.3 = 1
Print "omu"

Start Watchdog

Main:
'send off signal
If Inn1 = 1 Then
   Portd.3 = 1                                              'fuse
   Print "fuse 0"
   End If
If Inn2 = 1 Then
   Portd.3 = 1                                              'supply
   Print "volt 0"
   End If
If Inn3 = 1 Then
   Portd.3 = 1                                              'server
   Print "host 0"
   End If
If Inn4 = 1 Then
   Portd.3 = 1                                              'temp
   Print "temp 0"
   End If
If Inn5 = 1 Then
   Portd.3 = 1                                              'fan
   Print "fan 0"
   End If
If Inn6 = 1 Then
   Portd.3 = 1                                              'module
   Print "unit 0"
   End If
If Inn7 = 1 Then
   Portd.3 = 1                                              'door
   Print "door 0"
   End If
If Inn8 = 1 Then
   Portd.3 = 1                                              'mute
   Print "mute 0"
   End If
If Inn9 = 1 Then
   Portd.3 = 1                                              'ill
   Print "ill 0"
   End If
If Inn10 = 1 Then
   Portd.3 = 1                                              'light
   Print "lamp 0"
   End If
If Inn11 = 1 Then
   Portd.3 = 1                                              'sub
   Print "sub 0"
   End If
If Inn12 = 1 Then
   Portd.3 = 1                                              'aux
   Print "aux 0"
   End If

'send om signal
If Pinb.0 = 0 Then
   If Inn1 = 0 Then
      Portd.3 = 1
      Print "fuse 1"                                        'fuse
      End If
   Inn1 = 40
   End If
If Pinb.1 = 0 Then
   If Inn2 = 0 Then
      Portd.3 = 1
      Print "volt 1"                                        'supply
      End If
   Inn2 = 40
   End If
If Pinb.2 = 0 Then
   If Inn3 = 0 Then
      Portd.3 = 1
      Print "host 1"                                        'server
      End If
   Inn3 = 40
   End If
If Pinb.3 = 0 Then
   If Inn4 = 0 Then
      Portd.3 = 1
      Print "temp 1"                                        'temp
      End If
   Inn4 = 40
   End If
If Pinb.4 = 0 Then
   If Inn5 = 0 Then
      Portd.3 = 1
      Print "fan 1"                                         'fan
      End If
   Inn5 = 40
   End If
If Pinb.5 = 0 Then
   If Inn6 = 0 Then
      Portd.3 = 1
      Print "unit 1"                                        'module
      End If
   Inn6 = 40
   End If
If Pinb.6 = 0 Then
   If Inn7 = 0 Then
      Portd.3 = 1
      Print "door 1"                                        'door
      End If
   Inn7 = 40
   End If
If Pinb.7 = 0 Then
   If Inn8 = 0 Then
      Portd.3 = 1
      Print "mute 1"                                        'mute
      End If
   Inn8 = 40
   End If
If Pind.5 = 0 Then
   If Inn9 = 0 Then
      Portd.3 = 1
      Print "ill 1"                                         'ill
      End If
   Inn9 = 40
   End If
If Pind.6 = 0 Then
   If Inn10 = 0 Then
      Portd.3 = 1
      Print "lamp 1"                                        'light
      End If
   Inn10 = 40
   End If
If Pina.0 = 0 Then
   If Inn11 = 0 Then
      Portd.3 = 1
      Print "sub 1"                                         'sub
      End If
   Inn11 = 40
   End If
If Pina.1 = 0 Then
   If Inn12 = 0 Then
      Portd.3 = 1
      Print "aux 1"                                         'aux
      End If
   Inn12 = 40
   End If

'set input counters
If Inn1 > 0 Then Inn1 = Inn1 - 1
If Inn2 > 0 Then Inn2 = Inn2 - 1
If Inn3 > 0 Then Inn3 = Inn3 - 1
If Inn4 > 0 Then Inn4 = Inn4 - 1
If Inn5 > 0 Then Inn5 = Inn5 - 1
If Inn6 > 0 Then Inn6 = Inn6 - 1
If Inn7 > 0 Then Inn7 = Inn7 - 1
If Inn8 > 0 Then Inn8 = Inn8 - 1
If Inn9 > 0 Then Inn9 = Inn9 - 1
If Inn10 > 0 Then Inn10 = Inn10 - 1
If Inn11 > 0 Then Inn11 = Inn11 - 1
If Inn12 > 0 Then Inn12 = Inn12 - 1

'lifestring
If Life > 0 Then Life = Life - 1
If Life = 0 Then
   Portd.3 = 1
   Print "omu"
   Life = 3000
   End If

'lifesignal
If Lifesignal > 0 Then Lifesignal = Lifesignal - 1
If Lifesignal = 5 Then Portd.2 = 1
If Lifesignal = 0 Then
   Portd.2 = 0
   Lifesignal = 21
   End If

'loop cycle
Reset Watchdog
Portd.4 = Portd.3
Waitms 100
Portd.3 = 0
Portd.4 = 0
Goto Main

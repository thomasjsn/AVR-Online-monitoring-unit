'--------------------------------------------------------------
'                   Thomas Jensen | stdout.no
'--------------------------------------------------------------
'  file: AVR_OMU_v.1.1
'  date: 16/04/2007
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
'PB0: In 1
'PB1: In 2
'PB2: In 3
'PB3: In 4
'PB4: In 5
'PB5: In 6
'PB6: In 7
'PB7: In 8
'PD5: In 9
'PD6: In 10
'PA0: In 11
'PA1: In 12 *

'ut
'PD2: Lifesignal
'PD3: RS485 send
'PD4: Link activity

'serial
'PD0: Rx
'PD1: Tx

Dim Lifesignal As Byte , Life As Integer , Send As String * 15
Dim Inn(11) As Byte , A As Byte , A2 As String * 1

Const Id = "001"
Life = 200
Lifesignal = 21

Portd.2 = 1
Portd.4 = 1

Waitms 4000

Portd.3 = 1
Send = Id + ":s:00:1:"
Print Send ; Checksum(send)

Waitms 1000
Portd.2 = 0
Portd.4 = 0
Start Watchdog

Do
'send off signal
For A = 1 To 11
   If Inn(a) = 1 Then
      Portd.3 = 1
      A2 = Str(a)
      If Len(a2) < 2 Then A2 = "0" + A2
      Send = Id + ":i:" + A2 + ":0:"
      Print Send ; Checksum(send)
      End If
Next A

'send on signal
If Pinb.0 = 0 Then
   If Inn(1) = 0 Then
   Portd.3 = 1
   Send = Id + ":i:01:1:"
   Print Send ; Checksum(send)
   End If
   Inn(1) = 30
End If

If Pinb.1 = 0 Then
   If Inn(2) = 0 Then
   Portd.3 = 1
   Send = Id + ":i:02:1:"
   Print Send ; Checksum(send)
   End If
   Inn(2) = 30
End If

If Pinb.2 = 0 Then
   If Inn(3) = 0 Then
   Portd.3 = 1
   Send = Id + ":i:03:1:"
   Print Send ; Checksum(send)
   End If
   Inn(3) = 30
End If

If Pinb.3 = 0 Then
   If Inn(4) = 0 Then
   Portd.3 = 1
   Send = Id + ":i:04:1:"
   Print Send ; Checksum(send)
   End If
   Inn(4) = 30
End If

If Pinb.4 = 0 Then
   If Inn(5) = 0 Then
   Portd.3 = 1
   Send = Id + ":i:05:1:"
   Print Send ; Checksum(send)
   End If
   Inn(5) = 30
End If

If Pinb.5 = 0 Then
   If Inn(6) = 0 Then
   Portd.3 = 1
   Send = Id + ":i:06:1:"
   Print Send ; Checksum(send)
   End If
   Inn(6) = 30
End If

If Pinb.6 = 0 Then
   If Inn(7) = 0 Then
   Portd.3 = 1
   Send = Id + ":i:07:1:"
   Print Send ; Checksum(send)
   End If
   Inn(7) = 30
End If

If Pinb.7 = 0 Then
   If Inn(8) = 0 Then
   Portd.3 = 1
   Send = Id + ":i:08:1:"
   Print Send ; Checksum(send)
   End If
   Inn(8) = 30
End If

If Pind.5 = 0 Then
   If Inn(9) = 0 Then
   Portd.3 = 1
   Send = Id + ":i:09:1:"
   Print Send ; Checksum(send)
   End If
   Inn(9) = 30
End If                                                      '

If Pind.6 = 0 Then
   If Inn(10) = 0 Then
   Portd.3 = 1
   Send = Id + ":i:10:1:"
   Print Send ; Checksum(send)
   End If
   Inn(10) = 30
End If

If Pina.0 = 0 Then
   If Inn(11) = 0 Then
   Portd.3 = 1
   Send = Id + ":i:11:1:"
   Print Send ; Checksum(send)
   End If
   Inn(11) = 30
End If

'set input counters
For A = 1 To 11
   If Inn(a) > 0 Then Decr Inn(a)
Next A

'lifestring
If Life > 0 Then Decr Life
If Life = 0 Then
   Portd.3 = 1
   Send = Id + ":s:01:1:"
   Print Send ; Checksum(send)
   Life = 200
   End If

'lifesignal
If Lifesignal > 0 Then Decr Lifesignal
If Lifesignal = 5 Then Portd.2 = 1
If Lifesignal = 0 Then
   Portd.2 = 0
   Lifesignal = 21
   End If

'loop cycle
Reset Watchdog
Portd.4 = Portd.3
Portd.3 = 0
Waitms 100
Portd.4 = 0
Loop
End

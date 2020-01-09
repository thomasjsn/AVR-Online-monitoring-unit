'--------------------------------------------------------------
'                   Thomas Jensen | stdout.no
'--------------------------------------------------------------
'  file: AVR_OMU_v.2.0
'  date: 25/09/2008
'  prot: 1.1
'--------------------------------------------------------------
$regfile = "m8def.dat"
$crystal = 8000000
$baud = 9600
Config Portb.0 = Output
Config Portb.1 = Output
Config Portb.2 = Input
Config Portb.3 = Input
Config Portb.4 = Input
Config Portb.5 = Input
Config Portc = Input
Config Portd.3 = Input
Config Portd.4 = Input
Config Portd.5 = Input
Config Portd.6 = Input
Config Portd.7 = Input

'inn
'PC0: In 1
'PC1: In 2
'PC2: In 3
'PC3: In 4
'PC4: In 5
'PC5: In 6
'PD3: In 7
'PD4: In 8
'PD5: In 9
'PD6: In 10
'PD7: In 11
'PB2: In 12
'PB3: In 13
'PB4: In 14
'PB5: In 15

'ut
'PB0: Lifesignal
'PB1: Link activity

'serial
'PD0: Rx
'PD1: Tx

Dim Lifesignal As Integer , Life As Integer , Send As String * 15
Dim Inn(15) As Integer , A As Byte , A2 As String * 1
Dim Serialcharwaiting As Byte , Serialchar As Byte
Dim Comminput As String * 15 , Input_nr As String * 3
Dim Input_com As String * 1 , Input_ut As String * 2
Dim Led As Byte

Const Id = "001"
Life = 2000

Waitms 5000

Top:

Serialcharwaiting = Ischarwaiting()

If Serialcharwaiting = 1 Then
   Serialchar = Inkey()
      Goto Myroutine
   End If

Goto Main

Myroutine:
Select Case Serialchar
Case 48                                                     '0
Goto Set_value
End Select

Main:
'input send off signal
For A = 1 To 15
   If Inn(a) = 1 Then
      Led = 103
      A2 = Str(a)
      If Len(a2) < 2 Then A2 = "0" + A2
      Send = Id + ":i:" + A2 + ":0:"
      Print Send ; Checksum(send)
      End If
Next A

'send on signal
If Pinc.0 = 0 Then                                          'input 1
   If Inn(1) = 0 Then
   Led = 103
   Send = Id + ":i:01:1:"
   Print Send ; Checksum(send)
   End If
   Inn(1) = 3000
End If

If Pinc.1 = 0 Then                                          'input 2
   If Inn(2) = 0 Then
   Led = 103
   Send = Id + ":i:02:1:"
   Print Send ; Checksum(send)
   End If
   Inn(2) = 3000
End If

If Pinc.2 = 0 Then                                          'input 3
   If Inn(3) = 0 Then
   Led = 103
   Send = Id + ":i:03:1:"
   Print Send ; Checksum(send)
   End If
   Inn(3) = 3000
End If

If Pinc.3 = 0 Then                                          'input 4
   If Inn(4) = 0 Then
   Led = 103
   Send = Id + ":i:04:1:"
   Print Send ; Checksum(send)
   End If
   Inn(4) = 3000
End If

If Pinc.4 = 0 Then                                          'input 5
   If Inn(5) = 0 Then
   Led = 103
   Send = Id + ":i:05:1:"
   Print Send ; Checksum(send)
   End If
   Inn(5) = 3000
End If

If Pinc.5 = 0 Then                                          'input 6
   If Inn(6) = 0 Then
   Led = 103
   Send = Id + ":i:06:1:"
   Print Send ; Checksum(send)
   End If
   Inn(6) = 3000
End If

If Pind.3 = 0 Then                                          'input 7
   If Inn(7) = 0 Then
   Led = 103
   Send = Id + ":i:07:1:"
   Print Send ; Checksum(send)
   End If
   Inn(7) = 3000
End If

If Pind.4 = 0 Then                                          'input 8
   If Inn(8) = 0 Then
   Led = 103
   Send = Id + ":i:08:1:"
   Print Send ; Checksum(send)
   End If
   Inn(8) = 3000
End If

If Pind.5 = 0 Then                                          'input 9
   If Inn(9) = 0 Then
   Led = 103
   Send = Id + ":i:09:1:"
   Print Send ; Checksum(send)
   End If
   Inn(9) = 3000
End If

If Pind.6 = 0 Then                                          'input 10
   If Inn(10) = 0 Then
   Led = 103
   Send = Id + ":i:10:1:"
   Print Send ; Checksum(send)
   End If
   Inn(10) = 3000
End If

If Pind.7 = 0 Then                                          'input 11
   If Inn(11) = 0 Then
   Led = 103
   Send = Id + ":i:11:1:"
   Print Send ; Checksum(send)
   End If
   Inn(11) = 3000
End If

If Pinb.2 = 0 Then                                          'input 12
   If Inn(12) = 0 Then
   Led = 103
   Send = Id + ":i:12:1:"
   Print Send ; Checksum(send)
   End If
   Inn(12) = 3000
End If

If Pinb.3 = 0 Then                                          'input 13
   If Inn(13) = 0 Then
   Led = 103
   Send = Id + ":i:13:1:"
   Print Send ; Checksum(send)
   End If
   Inn(13) = 3000
End If

If Pinb.4 = 0 Then                                          'input 14
   If Inn(14) = 0 Then
   Led = 103
   Send = Id + ":i:14:1:"
   Print Send ; Checksum(send)
   End If
   Inn(14) = 3000
End If

If Pinb.5 = 0 Then                                          'input 15
   If Inn(15) = 0 Then
   Led = 103
   Send = Id + ":i:15:1:"
   Print Send ; Checksum(send)
   End If
   Inn(15) = 3000
End If                                                      '

'set input counters
For A = 1 To 15
   If Inn(a) > 0 Then Decr Inn(a)
Next A

'led timer
If Led > 0 Then Decr Led
If Led = 100 Then Portb.1 = 1
If Led = 0 Then Portb.1 = 0

'lifestring
If Life > 0 Then Decr Life
If Life = 0 Then
   Led = 103
   Send = Id + ":s:01:1:"
   Print Send ; Checksum(send)
   Life = 20000
   End If

'lifesignal
If Lifesignal > 0 Then Decr Lifesignal
If Lifesignal = 500 Then Portb.0 = 1
If Lifesignal = 0 Then
   Portb.0 = 0
   Lifesignal = 2100
   End If

'loop cycle
Waitms 1
Goto Top
End

Set_value:
Input Comminput Noecho                                      'read serialport

Input_nr = Left(comminput , 3)                              'id check
Input_com = Mid(comminput , 5 , 1)                          'command check
Input_ut = Mid(comminput , 7 , 2)                           'output nr check

If Input_com = "i" And Input_nr = Id Then
Select Case Input_ut

Case "01"
If Inn(1) = 0 Then Inn(1) = 2 Else Inn(1) = 0               'status input 1
Case "02"
If Inn(2) = 0 Then Inn(2) = 2 Else Inn(2) = 0               'status input 2
Case "03"
If Inn(3) = 0 Then Inn(3) = 2 Else Inn(3) = 0               'status input 3
Case "04"
If Inn(4) = 0 Then Inn(4) = 2 Else Inn(4) = 0               'status input 4
Case "05"
If Inn(5) = 0 Then Inn(5) = 2 Else Inn(5) = 0               'status input 5
Case "06"
If Inn(6) = 0 Then Inn(6) = 2 Else Inn(6) = 0               'status input 6
Case "07"
If Inn(7) = 0 Then Inn(7) = 2 Else Inn(7) = 0               'status input 7
Case "08"
If Inn(8) = 0 Then Inn(8) = 2 Else Inn(8) = 0               'status input 8
Case "09"
If Inn(9) = 0 Then Inn(9) = 2 Else Inn(9) = 0               'status input 9
Case "10"
If Inn(10) = 0 Then Inn(10) = 2 Else Inn(10) = 0            'status input 10
Case "11"
If Inn(11) = 0 Then Inn(11) = 2 Else Inn(11) = 0            'status input 11
Case "12"
If Inn(12) = 0 Then Inn(12) = 2 Else Inn(12) = 0            'status input 12
Case "13"
If Inn(13) = 0 Then Inn(13) = 2 Else Inn(13) = 0            'status input 13
Case "14"
If Inn(14) = 0 Then Inn(14) = 2 Else Inn(14) = 0            'status input 14
Case "15"
If Inn(15) = 0 Then Inn(15) = 2 Else Inn(15) = 0            'status input 15

End Select

End If
Goto Main
End

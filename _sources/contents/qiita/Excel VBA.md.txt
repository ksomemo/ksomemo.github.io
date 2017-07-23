英語で書いたまとめと基本的な文法など

* Visual Basic for Applications
* programming language

## Excel
* book
* sheet
* cell

These are objects in VBA.

## Object
Objects have properties and methods.

## Enviroment
### OS
Windows 7

### version
Excel 2013

## VBE
VBE is Visual Basic Editor. How do I use this editor?

### Development Menu
1. Open Excel's options. Select File menu and then click Options.
2. Select the Ribbon settings. (Customize Ribbon)
3. Check the Development checkbox.

Accept your changes until you return to the Ribbon. You should now see the development tab.

## 標準モジュールの追加
[挿入]-[標準モジュール]

## file extensions
* bas
* frm
* cls
* ctl
* pag
* dob
* dsr
* vb

```vb
Attribute VB_Name = "Module1"
Option Explicit
' 変数宣言の強制

' ユーザー定義型
Type user
    name As String
    birthDateTime As Date
    birthDate As Date
    birthTime As Date
End Type


Sub Main()
    ' comment
    Debug.Print "Open imediate window."

    ' 数値
    Dim int_val As Integer
    Dim long_val As Long
    Dim single_val As Single
    Dim double_val As Double
    Debug.Print "init: " & int_val & long_val & single_val & double_val
    
    int_val = 5
    long_val = 6000
    single_val = 0.71
    double_val = 8.2
    Debug.Print Format(int_val, "Currency")
    Debug.Print Format(long_val, "Fixed")
    Debug.Print Format(long_val, "Standard")
    Debug.Print Format(single_val, "Percent")
    Debug.Print Format(0, "Yes/No")
    Debug.Print Format(1, "Yes/No")
    Debug.Print Format(0, "True/False")
    Debug.Print Format(2, "True/False")
    Debug.Print Format(0, "On/Off")
    Debug.Print Format(-1, "On/Off")
    'printf -> http://www.freevbcode.com/ShowCode.asp?ID=5014

    Debug.Print "5 + 2 = " & (int_val + 2)
    Debug.Print "5 - 2 = " & (int_val - 2)
    Debug.Print "5 * 2 = " & (int_val * 2)
    Debug.Print "-5 * -2 = " & (-int_val * -2)
    Debug.Print "5 / 2 = " & (int_val / 2)
    Debug.Print "5 \ 2 = " & (int_val \ 2)
    Debug.Print "5 mod 2 = " & (int_val Mod 2)
    Debug.Print "5 ^ 2 = " & (int_val ^ 2)
    
    ' Boolean
    Dim bool_f As Boolean
    Dim bool_t As Boolean
    Debug.Print "init: " & bool_t

    bool_f = False
    bool_t = True
    Debug.Print "False And False is " & (bool_f And bool_f)
    Debug.Print "False And True  is " & (bool_f And bool_t)
    Debug.Print "True  And False is " & (bool_t And bool_f)
    Debug.Print "True  And True  is " & (bool_t And bool_t)
    
    Debug.Print "False Or False is " & (bool_f Or bool_f)
    Debug.Print "False Or True  is " & (bool_f Or bool_t)
    Debug.Print "True  Or False is " & (bool_t Or bool_f)
    Debug.Print "True  Or True  is " & (bool_t Or bool_t)
    
    Debug.Print "Not True  is " & (Not bool_t)
    Debug.Print "Not False is " & (Not bool_f)
    
    Debug.Print "int_val = long_val is " & (int_val = long_val)
    Debug.Print "int_val <> long_val is " & (int_val <> long_val)
    Debug.Print "single_val >= double_val is " & (single_val >= double_val)
    Debug.Print "single_val <= double_val is " & (int_val <= double_val)
    Debug.Print "int_val = int_val is " & (int_val = int_val)
    Debug.Print "Not False is " & (Not bool_f)
    Debug.Print "Not False is " & (Not bool_f)
    Debug.Print "Not False is " & (Not bool_f)
    Debug.Print "Not False is " & (Not bool_f)
    
    If False Then
        Debug.Print "If"
    ElseIf False Then
        Debug.Print "ElseIf"
    Else
        Debug.Print "Else"
    End If

    ' 文字列型
    Dim hello As String
    Dim world As String
    Dim refVal As String
    Debug.Print "init: [" & hello & "]"
    
    hello = "Hello"
    world = "World"
    refVal = "refVal"
    MySubMsgBox hello, world, refVal
    Debug.Print world
    Debug.Print refVal
    Debug.Print MyFuncLen(hello)
    Debug.Print MyFuncLen(hello, 2)
    ExitInSub
    Debug.Print ExitInFunction
    Debug.Print RecursiveFactorial(4)
    
    ' 配列
    Dim fixary(2) As String
    fixary(0) = "ab"
    fixary(1) = "cd"
    Dim joined As String
    joined = Join(fixary, ",")
    Debug.Print joined
    
    ' Loop
    Dim varary() As String
    varary = Split(joined, ",")
    varary(2) = "gh"
    Dim str As Variant
    For Each str In varary
        Debug.Print str
    Next str
    Dim idx As Integer
    For idx = 0 To UBound(varary) Step 2
        Debug.Print idx & ":" & varary(idx)
    Next idx
    
    Dim i As Integer
    Do
        i = i + 1
        Debug.Print "do statement while:" & i
    Loop While False
    Do
        i = i + 1
        Debug.Print "do statement until:" & i
    Loop Until True
    Do While i < 4
        i = i + 1
        Debug.Print "do while statement:" & i
    Loop
    Do Until i = 1
        i = i - 1
        Debug.Print "do until statement:" & i
    Loop
    
    ' 日付型
    Dim date_val As Date
    Debug.Print "init: " & date_val
    
    Dim my As user
    Debug.Print "my.name type: " & TypeName(my.name)
    Debug.Print "my.birthDateTime type: " & TypeName(my.birthDateTime)
    ' Debug.Print "my type: " & TypeName(my)
    ' パブリックオブジェクトモジュール?
    
    my.name = "my name"
    my.birthDateTime = #11/12/2014 1:02:03 AM#
    my.birthDate = #11/12/2014#
    my.birthTime = #1:02:03 AM#
    date_val = #1:24:35 PM#
    Debug.Print "DateTime: " & my.birthDateTime
    Debug.Print "Date: " & my.birthDate
    Debug.Print "AM Time: " & my.birthTime
    Debug.Print "PM Time: " & date_val
    Debug.Print vbCrLf & Chr(13) & Chr(10)

    my.birthDateTime = "2014/12/11 01:02:03 AM"
    my.birthDate = "2014/12/11"
    my.birthTime = "1:02:03 AM"
    date_val = "01:24:35 PM"
    Debug.Print "DateTime: " & my.birthDateTime
    Debug.Print "Date: " & my.birthDate
    Debug.Print "AM Time: " & my.birthTime
    Debug.Print "PM Time: " & date_val

    Debug.Print "my.birthDateTime(from str) type: " & TypeName(my.birthDateTime)
    Debug.Print "DateTime(from str) type: " & TypeName("2014/12/11 01:02:03 AM")
    Debug.Print "DateTime(from str) type(Casted): " & TypeName(CDate("2014/12/11 01:02:03 AM"))
    Debug.Print "DateTime(from str) isDate: " & IsDate("2014/12/11 01:02:03 AM")
    Debug.Print "DateTime(from str) isDate(Casted): " & IsDate(CDate("2014/12/11 01:02:03 AM"))

End Sub

' no return value
Sub MySubMsgBox(ByVal str1 As String, ByVal str2 As String, refVal As String)
    refVal = "参照渡し"
    str2 = str2 & "!"
    MsgBox str1 & "_" & str2
End Sub

Sub ExitInSub()
    Debug.Print "Before Exit Sub"
    Exit Sub
    Debug.Print "After Exit Sub"
End Sub

' exists return value
Function MyFuncLen(ByVal str As String, Optional ByVal opt As Integer) As Integer
    MyFuncLen = Len(str) + opt
End Function

Function ExitInFunction() As String
    ExitInFunction = "Before Exit Function"
    Exit Function
    ExitInFunction = "After Exit Function"
End Function

Function RecursiveFactorial(ByVal num As Integer) As Integer
    If num <= 0 Then
        RecursiveFactorial = 1
    Else
        RecursiveFactorial = num * RecursiveFactorial(num - 1)
    End If
End Function
```

```vb
VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Class1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
```


```vb
VERSION 5.00
Begin {xxxxxx} UserForm1 
   Caption         =   "UserForm1"
   ClientHeight    =   3180
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   4710
   OleObjectBlob   =   "UserForm1.frx":0000
   StartUpPosition =   1  'オーナー フォームの中央
End
Attribute VB_Name = "UserForm1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
```

## Processing Cell
```vb
Sub Main()
    ' select sheet
    Worksheets("Sheet1").Range("A1").Value = "a1"
    
    ' selected sheet
    Range("A2").Value = "a2"
    Cells(3, 1).Value = "a3"
    Cells(3, 1).Offset(1, 1).Value = "b4"
    
    ' cells
    Range("A5", "B6").Value = "a5 to b6"
    Range("A7:C8").Value = "a7 to c8"
    
    ' row, column
    Range("9:9").Value = "row9"
    ' Range("D:D").Value = "col D"
    Range("B9").Clear
    Range("A10").Value = "A10"
    
    ' with
    Dim ary As Variant
    Dim str As Variant
    ary = Array("C1-red", "D1-blue", "E1-green", "F1-other")
    For Each str In ary
        Dim c As Range
        Dim posColor As Variant
        posColor = Split(str, "-")
        Set c = Range(posColor(0))
        With c
            .Value = posColor(0)
            With .Font
                .Bold = True
                .Size = 16
            End With
            .Interior.color = color(c:=posColor(1))
        End With
    Next str
    
    ' named arguments
    Range("A9").Delete shift:=xlShiftUp
            
    ' dialog box
    btnVal = MsgBox("すべてのセルを初期化しますか？" _
        , vbOKCancel, "セルの初期化")
    If btnVal = vbOK Then
        Cells.Clear
    End If
        
End Sub

Function color(ByVal c As String) As Long
    Select Case c
    Case "red"
        color = vbRed
    Case "blue"
        color = vbBlue
    Case "green"
        color = vbGreen
    Case Else
        color = vbWhite
    End Select
End Function
```

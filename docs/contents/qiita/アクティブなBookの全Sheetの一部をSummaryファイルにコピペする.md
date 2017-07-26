# アクティブなBookの全Sheetの一部をSummaryファイルにコピペする
* セル結合されているので仕方なくコピペマクロ
* フォーマットは固定されているので、特定セルを対象とする

```vbnet

Sub MacroSheets()
  Debug.Print "--------start--------"
  Dim s As Object
  Dim uu As Range
  Dim name As Range
  Dim executed As Boolean
  executed = False

  For Each s In Sheets
    Set uu = s.Range("C9")
    Set name = s.Range("B9")
    Debug.Print s.Name & "(" & name.Value & ")'s UU is " & uu.Value
    If uu.Value >= 5000 Then
        Debug.Print "--------copy and paste--------"
        s.Activate
        MacroPaste
        executed = True
    End If
  Next s
  Debug.Print "--------end--------"
  If Not executed Then
    MsgBox "対象なし"
  End If
End Sub
```

```vbnet

Sub MacroCopy()
    Range("B9:L12").Select
    Selection.Copy
End Sub
```

```vbnet
Sub MacroPaste()
    MacroCopy
    Dim i As Integer

    For i = 1 To 2500
        Dim address As String
        Dim c As Range
        Dim v As Variant

        address = "B" & (4 * i)
        Set c = Workbooks("summary.xlsx").Worksheets("target").Range(address)
        v = c.Value

        If Len(Trim(v)) = 0 Then
            Debug.Print "val is empyt. address:" & address
            ' paste
            c.PasteSpecial
            Exit For
        Else
            'Debug.Print v
        End If
    Next i
End Sub
```


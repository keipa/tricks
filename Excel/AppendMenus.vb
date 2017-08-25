Sub AppendMenus()
Dim c As Range
For Each c In Selection
If c.Value <> "" Then
    c.Value = Left(c.Value, 3) & "-" & Right(c.Value, 3)
End If
Next
End Sub

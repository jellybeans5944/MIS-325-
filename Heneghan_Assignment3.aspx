
Partial Class MIS_325_Homework_HW3_Heneghan_Assignment3
    Inherits System.Web.UI.Page

    'Global Variable Declarations 
    Public Shared gdecTotalCalories As Decimal
    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        txtOutput.Text = Nothing
        gdecTotalCalories = 0

        'variable declarations 
        Dim intaddDinnerOption, intDrinkOption As Integer  'radiobutton list variables 
        Dim intToppingSelect, intSelectDinner, intExerciseSelect As Integer 'integrs for checkbox lists 
        Dim intMaxLunchCal As Integer = 1500 'max calories per meal 
        Dim intDailyMaxCal As Integer = 3000 'max daily calories 
        Dim intBreakfeastCalories As Integer = 500

        'error cheking for toppings list 
        If chkToppings.SelectedIndex <= 0 Then
            txtOutput.Text = "Please select at least one topping"
            Exit Sub
        End If

        'error checking for dinner sleection 
        If RblDinnerList.SelectedIndex = -1 Then
            txtOutput.Text = "Please select at least one dinner item"
            Exit Sub
        End If

        'error checking for additional dinner options (radio button list)
        If addDinnerList.SelectedIndex = -1 Then
            txtOutput.Text = "Please select an option from the additional dinner menu"
            Exit Sub
        End If

        'error cheching for exercise list 
        If ExerciseList.SelectedIndex = -1 Then
            txtOutput.Text = "Please indicate if you exercised today"
            Exit Sub
        End If

        'error chekcing for drink list (radio button list) 
        If DrinkList.SelectedIndex = -1 Then
            txtOutput.Text = "Please select a drink"
            Exit Sub
        End If

        'Variables for radiobutton lists 
        intaddDinnerOption = addDinnerList.SelectedValue
        intDrinkOption = DrinkList.SelectedValue
        intSelectDinner = RblDinnerList.SelectedValue

        Dim strToppingsList As String = Nothing
        'For each loop for Salad toppings list (Lunch)
        If chkToppings.SelectedIndex > -1 Then
            Dim DinnerToppings As ListItem
            For Each DinnerToppings In chkToppings.Items
                If DinnerToppings.Selected = True Then
                    strToppingsList &= DinnerToppings.Text & ","
                    intToppingSelect += DinnerToppings.Value
                End If
                If gdecTotalCalories > intMaxLunchCal Then
                    Image1.ImageUrl = "warning.jpg"
                End If
            Next
        End If

        Dim strExerciseList As String = Nothing
        'for each loop for exercise list 
        If ExerciseList.SelectedIndex > -1 Then
            Dim ExerciseSelection As ListItem
            For Each ExerciseSelection In ExerciseList.Items
                If ExerciseSelection.Selected = True Then
                    strExerciseList &= ExerciseSelection.Text & ","
                    intExerciseSelect += ExerciseSelection.Value
                End If
            Next
        End If

        'Calculation for total calories 
        gdecTotalCalories = intToppingSelect + intSelectDinner + intaddDinnerOption - intExerciseSelect + intDrinkOption + intBreakfeastCalories

        'Select case for dinner options 
        'Response.Write(gdecTotalCalories & ", " & intToppingSelect & ", " & intSelectDinner & ", " & intaddDinnerOption & ", " & intExerciseSelect & ", " & intDrinkOption & ", " & intBreakfeastCalories) 'show in upper left hand corner what the value is 'testing values
        Select Case gdecTotalCalories
            Case 2000 To 2500
                txtOutput.Text = "Well under goal!" & vbNewLine & vbNewLine
            Case 2501 To 2700
                txtOutput.Text &= "Met Goal, congragulations!" & vbNewLine & vbNewLine
            Case 2701 To 2999
                txtOutput.Text &= "Close to exceeeding daily limit but met goal!" & vbNewLine & vbNewLine
            Case Is > 3000
                Image1.ImageUrl = "warning.jpg"
                txtOutput.Text &= "Be careful next time, you went over your daily limit." & vbNewLine & vbNewLine
        End Select

        txtOutput.Text &= "Breakfeast: " & "Latte & Scone " & intBreakfeastCalories.ToString & vbNewLine & "Lunnch: " & strToppingsList & " " & intToppingSelect & vbNewLine & "Dinner: " & RblDinnerList.SelectedItem.Text & " " & intSelectDinner & vbNewLine & "Add Dinner Option: " & addDinnerList.SelectedItem.Text & " " & intaddDinnerOption & vbNewLine & "Drink: " & DrinkList.SelectedItem.Text & " " & intDrinkOption & vbNewLine & "Calories Burned: " & intExerciseSelect & vbNewLine & "Total Calories: " & gdecTotalCalories.ToString

        Page.MaintainScrollPositionOnPostBack = True

    End Sub

    Protected Sub ClearButton1_Click(sender As Object, e As EventArgs) Handles ClearButton1.Click
        chkToppings.Text = Nothing
        Image1.ImageUrl = Nothing
        txtOutput.Text = Nothing
    End Sub


    Protected Sub ClearButton2_Click(sender As Object, e As EventArgs) Handles ClearButton2.Click
        chkToppings.Text = Nothing
        Image1.ImageUrl = Nothing
        RblDinnerList.Text = Nothing
        Image2.ImageUrl = Nothing
        txtOutput.Text = Nothing
    End Sub

    Protected Sub ClearButton3_Click(sender As Object, e As EventArgs) Handles ClearButton3.Click
        chkToppings.Text = Nothing
        Image1.ImageUrl = Nothing
        RblDinnerList.Text = Nothing
        Image2.ImageUrl = Nothing
        ExerciseList.Text = Nothing
        txtOutput.Text = Nothing
    End Sub




End Class

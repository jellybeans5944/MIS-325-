
Partial Class MIS_325_Homework_HW2_Assignment2
    Inherits System.Web.UI.Page

    'Declaration of Global variables 
    Public Shared gdecSalesPrice As Decimal
    Public Shared gintSalesQuotes, gintWRX, gintBRZ, gintLagacy, gintOutback, gintSTI As Integer

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        'local variable declaration
        'msrp is the price of he car without taxes and features 
        Dim decComission, decSalesTax As Decimal
        Dim intMSRP, intPaintType As Integer

        'error checking for radio button list 1
        If RadioButtonList1.SelectedIndex = -1 Then  'this means if nothing was selected 
            txtOutput1.Text = "Please select a car type" & vbNewLine
            Exit Sub 'ends the program 
        End If

        'error checking for radio button list 2
        If RadioButtonList2.SelectedIndex = -1 Then  'this means if nothing was selected 
            txtOutput1.Text = "Please select a paint type" & vbNewLine
            Exit Sub 'ends the program 
        End If

        'error checking for radio button list 3
        If RadioButtonList3.SelectedIndex = -1 Then  'this means if nothing was selected 
            txtOutput1.Text = "Please select a paint color" & vbNewLine
            Exit Sub 'ends the program 
        End If

        'State taxes list 
        If StatesList.SelectedIndex <= 0 Then
            txtOutput1.Text = "Please Select a State" & vbNewLine
            Exit Sub
        End If

        'Variables for radio buttopn lists and dropdown lists
        intMSRP = RadioButtonList1.SelectedValue
        intPaintType = RadioButtonList2.SelectedValue
        decSalesTax = StatesList.SelectedValue * RadioButtonList1.SelectedValue

        'Sales Price calculation 
        gdecSalesPrice = intMSRP + intPaintType + decSalesTax

        'Calculating comission 
        decComission = intMSRP * 0.01 '1 percent comission  

        'if the person is not a member ask them 
        If chkVIP.Checked = True Then
            decComission = intMSRP * 0.015 '1.5% comission 
        End If
        If chkVIP.Checked = False Then
            txtOutput1.Text = "Was the sales rep a VIP member? " & vbNewLine & vbNewLine
        End If

        'checking if the customer has a warrranty 
        If chkWarranty.Checked = True Then
            gdecSalesPrice += 500 'will add 500 to total price 
        End If
        If chkWarranty.Checked = False Then
            txtOutput1.Text &= "Would you like to add a warranty to your purchase? " & vbNewLine & vbNewLine
        End If

        'case for sales quotes running totals 
        Select Case RadioButtonList1.SelectedItem.Text
            Case "WRX"
                gintWRX += 1
            Case "BRZ"
                gintBRZ += 1
            Case "Legacy"
                gintLagacy += 1
            Case "Outback"
                gintOutback += 1
            Case "STI"
                gintSTI += 1
        End Select


        'Output for calculations, comission, and car details 
        txtOutput1.Text &= "Sales Price: " & gdecSalesPrice.ToString("c2") & vbNewLine & "Comission: " & decComission.ToString("c2") & vbNewLine & vbNewLine & "Car Type: " & RadioButtonList1.SelectedItem.Text & vbNewLine & "Selected Special Paint: " & RadioButtonList2.SelectedItem.Text & vbNewLine & "Car Color: " & RadioButtonList3.SelectedItem.Text & vbNewLine & vbNewLine & "WRX Sales: " & gintWRX.ToString & vbNewLine & "BRZ Sales " & gintBRZ.ToString & vbNewLine & "Lagacy Sales: " & gintLagacy.ToString & vbNewLine & "Outback Sales: " & gintOutback.ToString & vbNewLine & "STI Sales: " & gintSTI.ToString & vbNewLine


    End Sub

End Class

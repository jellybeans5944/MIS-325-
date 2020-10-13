
Partial Class MIS_325_Homework_Assignment1
    Inherits System.Web.UI.Page

    'Declaring variables for running totals (global) (# of items) 
    Public Shared gintMagazines, gintBooks, gintToys As Integer
    Public Shared decgrandTotal, decCount As Decimal

    'Variables for Running total for Pre-tax Revenue (global) 
    Public Shared decMagazines, decBooks, decToys As Decimal

    Protected Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click

        'Variable Declaration 
        Dim decQuantity, decPrice, decTax, decTotal, decSubTotal As Decimal

        'error check data entry/assign values from webpage to variables 
        If txtBox1.Text = Nothing OrElse IsNumeric(txtBox1.Text) = False Then
            TxtOutput1.Text = "Please enter numeric values for price and quantity"
        Else
            decQuantity = Convert.ToDecimal(txtBox1.Text)
        End If

        If txtBox2.Text = Nothing OrElse IsNumeric(txtBox2.Text) = False Then
            TxtOutput1.Text = "Please enter numeric values for price and quantity"
            Exit Sub
        Else
            decPrice = Convert.ToDecimal(txtBox2.Text)
        End If

        'Calculating tax 
        decTax = (decQuantity * decPrice) * 0.095

        'Calcualting transcation total (for a single transaction) 
        decTotal = (decQuantity * decPrice) + decTax

        'Calculating Sub total 
        decSubTotal = decQuantity * decPrice

        'error checking for radio button list 
        If RadioButtonList2.SelectedIndex = -1 Then  'this means if nothing was selected 
            TxtOutput1.Text = "Please select a product type"
            Exit Sub 'ends the program 
        End If

        'Cases for photos 
        Select Case RadioButtonList2.SelectedItem.Text
            Case "Magazine(s)"
                Image1.ImageUrl = "Magazine(s).jpg"
            Case "Book(s)"
                Image1.ImageUrl = "Book(s).jpg"
            Case "Toy(s)"
                Image1.ImageUrl = "Toy(s).jpg"
        End Select

        'Cases for # of units sold 
        Select Case RadioButtonList2.SelectedItem.Text
            Case "Magazine(s)"
                decMagazines += decSubTotal
                gintMagazines += decQuantity
            Case "Book(s)"
                decBooks += decSubTotal
                gintBooks += decQuantity
            Case "Toy(s)"
                decToys += decSubTotal
                gintToys += decQuantity
        End Select


        'Output for the first output box 
        txtBox3.Text = decSubTotal.ToString("c2") & vbNewLine & vbNewLine
        TxtOutput1.Text = "Grand Total " & decTotal.ToString("c2") & vbNewLine 'total includes tax 

        'Output for second textbox
        txtOutput2.Text = "Magazine(s) Revenue " & decMagazines.ToString("c2") & vbNewLine & "Items Sold " & gintMagazines.ToString & vbNewLine & vbNewLine & "Toy(s) Revenue " & decToys.ToString("c2") & vbNewLine & "Items Sold " & gintToys.ToString & vbNewLine & vbNewLine & "Book(s) Revenue " & decBooks.ToString("c2") & vbNewLine & "items Sold " & gintBooks.ToString
    End Sub

    'When the clear button is clicked the options are set to nothing 
    Protected Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        RadioButtonList2.Text = Nothing
        txtBox1.Text = Nothing
        txtBox2.Text = Nothing
        txtBox3.Text = Nothing
        TxtOutput1.Text = Nothing
        Image1.ImageUrl = Nothing
    End Sub

End Class

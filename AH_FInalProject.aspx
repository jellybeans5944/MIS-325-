Imports System.Data
Imports System.Data.SqlClient
Partial Class MIS_325_Homework_HeneghanFinalProject_AH_FInalProject
    Inherits System.Web.UI.Page

#Region "Declarations and SQL String"

    Public Shared con As New SqlConnection("Data Source=cb-ot-devst04.ad.wsu.edu;Initial Catalog = MF03angelica.heneghan; Persist Security Info=TRUE; User ID = angelica.heneghan; Password = 3c41c257")
    'variables 
    Dim decTotalTax, decTaxRate, decOrderCost, decDrinkCost, decSizeOfOrderCost, decGrandTotal As Decimal

    'Data table Variables dt = data table, g = globlal vriable 
    Public Shared gdtCoffeeTransactons As New DataTable
    Public Shared gdtLoyaltyMembers As New DataTable
    Public Shared gdtInventory As New DataTable
    Public Shared gdtUpdateOneMember As New DataTable

    'Data Adapters da = Data Adapter 
    Public Shared gdaCoffeeTransactions As New SqlDataAdapter("SELECT * FROM CafeBeanTransactions", con)

    Public Shared gdaLoyaltyMembers As New SqlDataAdapter("SELECT * FROM CafeBeanLoyaltyMember", con)
    Public Shared gdaInventory As New SqlDataAdapter("SELECT * FROM CafeBeanInventory", con)
    Public Shared gdaUpdateMember As New SqlDataAdapter("SELECT * FROM CafeBeanLoyaltyMember WHERE CustomerID = @p1", con)
    Public Shared gdaInventoryItems As New SqlDataAdapter("SELECT * FROM CafeBeanInventory WHERE ItemID = @p1", con)


    'Command Builders 
    Public Shared cbCoffeeTransactions As New SqlCommandBuilder(gdaCoffeeTransactions)
    Public Shared cbLoyaltyMember As New SqlCommandBuilder(gdaLoyaltyMembers)
    Public Shared cbInventory As New SqlCommandBuilder(gdaInventory)
    Public Shared cbUPdateMember As New SqlCommandBuilder(gdaUpdateMember)
    Public Shared cbInventoryItems As New SqlCommandBuilder(gdaInventoryItems)

    'Additional Data Adapters


#End Region

#Region "Refresh DDL"

    Private Sub RefreshTransactionDDL()
    End Sub
    Private Sub RefreshMemberDDL()
        If gdtLoyaltyMembers.Rows.Count > 0 Then
            gdtLoyaltyMembers.Clear()
        End If

        Try
            gdaLoyaltyMembers.Fill(gdtLoyaltyMembers)
            With DlLoyaltyMember
                .DataSource = gdtLoyaltyMembers
                .DataValueField = "CustomerID"
                .DataTextField = "CustomerName"
                .DataBind()
            End With
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

        Try
            gdaLoyaltyMembers.Fill(gdtLoyaltyMembers)
            With dlUpdateOneLoyaltyMem
                .DataSource = gdtLoyaltyMembers
                .DataValueField = "CustomerID"
                .DataTextField = "CustomerName"
                .DataBind()
            End With
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub
#End Region

#Region "Init Procedure"
    Private Sub MIS_325_Homework_HeneghanFinalProject_AH_FInalProject_Init(sender As Object, e As EventArgs) Handles Me.Init

        MultiView1.ActiveViewIndex = -1

        'Procedure 1 (Coffee Bean Tranactions Table) 
        If gdtCoffeeTransactons.Rows.Count > 0 Then
            gdtCoffeeTransactons.Clear()
        End If

        Try
            gdaCoffeeTransactions.Fill(gdtCoffeeTransactons)

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

        'Procedure 2 (Loyalty Member table / Loyalty Drop Down List)
        If gdtLoyaltyMembers.Rows.Count > 0 Then
            gdtLoyaltyMembers.Clear()
        End If

        Try
            gdaLoyaltyMembers.Fill(gdtLoyaltyMembers)
            With DlLoyaltyMember
                .DataSource = gdtLoyaltyMembers
                .DataValueField = "CustomerID"
                .DataTextField = "CustomerName"
                .DataBind()
                .Items.Insert(0, "Select A Loyalty Member")
            End With
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

        Try
            gdaLoyaltyMembers.Fill(gdtLoyaltyMembers)
            With dlUpdateOneLoyaltyMem
                .DataSource = gdtLoyaltyMembers
                .DataValueField = "CustomerID"
                .DataTextField = "CustomerName"
                .DataBind()
            End With
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

        'Procedure 3 (Inventory table)
        If gdtInventory.Rows.Count > 0 Then
            gdtInventory.Clear()
        End If


        Try
            gdaInventory.Fill(gdtInventory)
            With DropDownList1
                .DataSource = gdtInventory
                .DataValueField = "ItemID"
                .DataTextField = "ItemName"
                .DataBind()
            End With

        Catch ex As Exception

        End Try
    End Sub

#End Region

#Region "Calculations/Error Checking"

    Protected Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click

        'error checking for Loyalty member 
        If DlLoyaltyMember.SelectedIndex <= 0 Then
            Response.Write("Please Select a loyalty member")
        End If

        'error checking for cost of drink
        If TextBox3.Text = -1 Then
            txtOutput1.Text = "Please Enter the drink cost"
        End If


        'Select Case for inventroy rbl
        Select Case RadioButtonList2.SelectedValue
            Case 0
                Call IncreaseInventoryTotals()
            Case 1
                Call DecreaseInventoryTotals()
        End Select

        'Assigning a value for Cost of drink textbox 
        decDrinkCost = Convert.ToDecimal(TextBox3.Text)

        'Calcualtions 
        decTaxRate = 0.65
        decTotalTax = decDrinkCost * decTaxRate
        decGrandTotal = decTotalTax + decDrinkCost

        'update Transaction 
        Dim dr As DataRow = gdtCoffeeTransactons.NewRow 'creating new row 
        dr("CoffeeOrdered") = TextBox43.Text
        dr("CustomerName") = DlLoyaltyMember.SelectedItem.Text
        dr("OrderSize") = TextBox44.Text
        dr("OrderDate") = TextBox46.Text
        dr("OrderTime") = TextBox45.Text
        dr("OrderCost") = decGrandTotal

        Try
            gdtCoffeeTransactons.Rows.Add(dr)
            gdaCoffeeTransactions.Update(gdtCoffeeTransactons)

            GridView1.DataSource = gdtCoffeeTransactons
            GridView1.DataBind()

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

        'Output 
        txtOutput1.Text = "Drink Cost: " & decDrinkCost & vbNewLine & "Taxes: " & decTotalTax & vbNewLine & "Grand Total " & decGrandTotal & vbNewLine

    End Sub

#End Region

#Region "Procedures for updating table displays"

    'Transaction Table 
    Protected Sub UpdateTransactiontblDisplay()
        If gdtCoffeeTransactons.Rows.Count > 0 Then
            gdtCoffeeTransactons.Rows.Clear()
        End If

        GridView1.DataSource = Nothing
        GridView1.DataBind()

        Try
            gdaCoffeeTransactions.Fill(gdtCoffeeTransactons)
            GridView1.DataSource = gdtCoffeeTransactons
            GridView1.DataBind()

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    'Loyalty Member Table 
    Protected Sub UpdateLoyaltyMembertblDisplay()
        If gdtLoyaltyMembers.Rows.Count > 0 Then
            gdtLoyaltyMembers.Rows.Clear()
        End If

        GridView2.DataSource = Nothing
        GridView2.DataBind()

        Try
            gdaLoyaltyMembers.Fill(gdtLoyaltyMembers)
            GridView2.DataSource = gdtLoyaltyMembers
            GridView2.DataBind()

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    'RadiobuttonList for inventroy 

    'Update Inventory 
    Protected Sub UpdateInventoryTbltblDisplay()
        If gdtInventory.Rows.Count > 0 Then
            gdtInventory.Rows.Clear()
        End If

        GridView4.DataSource = Nothing
        GridView4.DataBind()

        Try
            gdaInventory.Fill(gdtInventory)
            GridView4.DataSource = gdtInventory
            GridView4.DataBind()

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

#End Region

#Region "Procedures for updating table totals"

    'Transaction Total 
    Protected Sub TransactionTotals()
        Dim commandTransactionTotals As New SqlCommand("Update CafeBeanTransactions SET CoffeeOrdered += @p1, OrderSize = @p2, OrderDate += @p3, OrderTime += @p4, OrderCost += @p5", con)

        With commandTransactionTotals.Parameters
            .Clear()
            .AddWithValue("@p1", TextBox43.Text)
            .AddWithValue("@p2", TextBox44.Text)
            .AddWithValue("@p3", TextBox46.Text)
            .AddWithValue("@p4", TextBox45.Text)
            .AddWithValue("@p5", (TextBox3.Text))
        End With
    End Sub
    Protected Sub IncreaseInventoryTotals()
        Dim commandUpdateInventoryTotals As New SqlCommand("UPDATE CafeBeanInventory SET NumberInStock += @p1", con)

        With commandUpdateInventoryTotals.Parameters
            .Clear()
            .AddWithValue("@p1", Convert.ToDecimal(TextBox42.Text))

        End With

        Try
            If con.State = ConnectionState.Closed Then con.Open()
            commandUpdateInventoryTotals.ExecuteNonQuery()
        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
            con.Close()
        End Try

    End Sub

    Protected Sub DecreaseInventoryTotals()
        Dim commandUpdateInventoryTotals2 As New SqlCommand("UPDATE CafeBeanInventory SET NumberInStock -= @p1, ", con)

        With commandUpdateInventoryTotals2.Parameters
            .Clear()
            .AddWithValue("@p1", Convert.ToDecimal(TextBox42.Text))

        End With

        Try
            If con.State = ConnectionState.Closed Then con.Open()
            commandUpdateInventoryTotals2.ExecuteNonQuery()
        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
            con.Close()
        End Try
    End Sub

    'loyalty member
    Protected Sub LoyaltyMemberTotals()
        Dim commandLoyaltyMemberTotals As New SqlCommand("UPDATE CafeBeanLoyaltyMember SET NumPurchases += 1, SalesRevenue += @p1 WHERE CustomerID = @p2", con)

        With commandLoyaltyMemberTotals.Parameters
            .Clear()
            .AddWithValue("@p1", Convert.ToDecimal(TextBox3.Text))
            .AddWithValue("@p2", DlLoyaltyMember.SelectedItem.Text)

        End With

        Try
            If con.State = ConnectionState.Closed Then con.Open()
            commandLoyaltyMemberTotals.ExecuteNonQuery()
        Catch ex As Exception
            Response.Write(ex.Message)
        Finally
            con.Close()
        End Try
    End Sub
#End Region

#Region "Updating/Adding single Tbles to DLs"

    'Dl updating a loyalty member
    Protected Sub dlUpdateOneLoyaltyMem_SelectedIndexChanged(sender As Object, e As EventArgs) Handles dlUpdateOneLoyaltyMem.SelectedIndexChanged

        'Clear Prior Data 
        If dlUpdateOneLoyaltyMem.SelectedIndex = -1 Then Exit Sub

        'Place coluumns of data into textboxes 
        If gdtUpdateOneMember.Rows.Count > 0 Then gdtUpdateOneMember.Rows.Clear()

        With gdaUpdateMember.SelectCommand.Parameters
            .Clear()
            .AddWithValue("@p1", dlUpdateOneLoyaltyMem.SelectedValue)
        End With

        Try
            gdaUpdateMember.Fill(gdtUpdateOneMember)
            With gdtUpdateOneMember.Rows(0)
                TextBox4.Text = .Item("CustomerName")
                TextBox5.Text = .Item("Email")
                TextBox6.Text = .Item("Phone")
                TextBox7.Text = .Item("NumPurchases")
                TextBox8.Text = .Item("SalesRevenue")
                TextBox9.Text = .Item("LastPurchase")
                TextBox10.Text = .Item("LastPurchaseTime")
            End With
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    'Button to update Loyalty Members 
    Protected Sub Button3_Click(sender As Object, e As EventArgs) Handles Button3.Click

        With gdtUpdateOneMember.Rows(0)
            .Item("CustomerName") = TextBox4.Text
            .Item("Email") = TextBox5.Text
            .Item("Phone") = TextBox6.Text
            .Item("NumPurchases") = TextBox7.Text
            .Item("SalesRevenue") = TextBox8.Text
            .Item("LastPurchase") = TextBox9.Text
            .Item("LastPurchaseTime") = TextBox10.Text
        End With

        Try
            gdaLoyaltyMembers.Update(gdtUpdateOneMember)

            GridView2.DataSource = gdtUpdateOneMember
            GridView2.DataBind()

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    'DL for Updating Inventory
    Protected Sub DropDownList1_SelectedIndexChanged(sender As Object, e As EventArgs) Handles DropDownList1.SelectedIndexChanged
        'Clear Prior Data 
        If DropDownList1.SelectedIndex = -1 Then Exit Sub

        'Place coluumns of data into textboxes 
        If gdtInventory.Rows.Count > 0 Then gdtInventory.Rows.Clear()

        With gdaInventoryItems.SelectCommand.Parameters
            .Clear()
            .AddWithValue("@p1", DropDownList1.SelectedValue)
        End With

        Try
            gdaInventoryItems.Fill(gdtInventory)
            With gdtInventory.Rows(0)
                TextBox42.Text = .Item("NumberInStock")
            End With
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub

    'update button 
    Protected Sub Button9_Click(sender As Object, e As EventArgs) Handles Button9.Click
        With gdtInventory.Rows(0)
            .Item("NumberInStock") = TextBox42.Text

        End With

        Try
            gdaInventory.Update(gdtInventory)

            GridView4.DataSource = gdtInventory
            GridView4.DataBind()

        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
    End Sub


#End Region

#Region "Add A New Member"
    Protected Sub Button7_Click(sender As Object, e As EventArgs) Handles Button7.Click

        Dim CheckMemberTbl As New DataTable
        Dim daCheckMemberTbl As New SqlDataAdapter("SELECT * FROM CafeBeanLoyaltyMember", con)
        Dim cbCheckMember As New SqlCommandBuilder(daCheckMemberTbl)

        daCheckMemberTbl.FillSchema(CheckMemberTbl, SchemaType.Mapped)

        'Error Checking Textboxes 
        If TextBox11.Text = Nothing OrElse TextBox12.Text = Nothing OrElse TextBox13.Text = Nothing OrElse TextBox14.Text = Nothing OrElse TextBox15.Text = Nothing OrElse TextBox16.Text = Nothing OrElse TextBox17.Text = Nothing Then
            Response.Write("Enter New Member Information")
            Exit Sub
        End If

        Dim dr As DataRow = CheckMemberTbl.NewRow
        dr.Item("CustomerName") = TextBox11.Text
        dr.Item("Email") = TextBox12.Text
        dr.Item("Phone") = TextBox13.Text
        dr.Item("NumPurchases") = TextBox14.Text
        dr.Item("SalesRevenue") = TextBox15.Text
        dr.Item("LastPurchase") = TextBox16.Text
        dr.Item("LastPurchaseTime") = TextBox17.Text

        CheckMemberTbl.Rows.Add(dr)
        Try
            daCheckMemberTbl.Update(CheckMemberTbl)

            GridView3.DataSource = CheckMemberTbl
            GridView3.DataBind()
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try

        'update member table display
        Call UpdateLoyaltyMembertblDisplay()
        'update dropdownlist 
        Call RefreshMemberDDL()

    End Sub
#End Region

#Region "Clear Buttons"

    '1st clear button 
    Protected Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        TextBox43.Text = Nothing
        TextBox44.Text = Nothing
        TextBox45.Text = Nothing
        TextBox46.Text = Nothing
        TextBox3.Text = Nothing
        txtOutput1.Text = Nothing
    End Sub

    '2nd clear button 
    Protected Sub Button4_Click(sender As Object, e As EventArgs) Handles Button4.Click
        dlUpdateOneLoyaltyMem.SelectedIndex = -1
        TextBox4.Text = Nothing
        TextBox5.Text = Nothing
        TextBox6.Text = Nothing
        TextBox7.Text = Nothing
        TextBox8.Text = Nothing
        TextBox9.Text = Nothing
        TextBox10.Text = Nothing
    End Sub

    '3rd clear button 
    Protected Sub Button8_Click(sender As Object, e As EventArgs) Handles Button8.Click
        TextBox11.Text = Nothing
        TextBox12.Text = Nothing
        TextBox13.Text = Nothing
        TextBox14.Text = Nothing
        TextBox15.Text = Nothing
        TextBox16.Text = Nothing
        TextBox17.Text = Nothing
    End Sub

    '4th clear button 
    Protected Sub Button10_Click(sender As Object, e As EventArgs) Handles Button10.Click
        RadioButtonList2.SelectedIndex = -1
        'Calendar1.SelectedDate = Nothing
        DropDownList1.SelectedValue = -1
        TextBox42.Text = Nothing
    End Sub
#End Region

#Region "Multi Views"
    Protected Sub LinkButton1_Click(sender As Object, e As EventArgs) Handles LinkButton1.Click
        MultiView1.ActiveViewIndex = 0
    End Sub
    Protected Sub LinkButton4_Click(sender As Object, e As EventArgs) Handles LinkButton4.Click
        MultiView1.ActiveViewIndex = 1
    End Sub
    Protected Sub LinkButton3_Click(sender As Object, e As EventArgs) Handles LinkButton3.Click
        MultiView1.ActiveViewIndex = 2
    End Sub
    Protected Sub LinkButton2_Click(sender As Object, e As EventArgs) Handles LinkButton2.Click
        MultiView1.ActiveViewIndex = 3
    End Sub
#End Region

End Class
